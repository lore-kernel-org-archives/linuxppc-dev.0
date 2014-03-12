Return-Path: <christoffer.dall@linaro.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9ED72C00B1
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2014 10:21:32 +1100 (EST)
Received: by mail-pb0-f47.google.com with SMTP id up15so216522pbc.6
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2014 16:21:30 -0700 (PDT)
Date: Wed, 12 Mar 2014 16:21:27 -0700
From: Christoffer Dall <christoffer.dall@linaro.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 10/52] arm, kvm: Fix CPU hotplug callback registration
Message-ID: <20140312232127.GC24808@cbox>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
 <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
Cc: ego@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 walken@google.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, mingo@kernel.org, marc.zyngier@arm.com,
 paulmck@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, rusty@rustcorp.com.au, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, oleg@redhat.com,
 tj@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2014 at 02:05:38AM +0530, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();
> 
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
> 
> Instead, the correct and race-free way of performing the callback
> registration is:
> 
> 	cpu_notifier_register_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_notifier_register_done();
> 
> 
> Fix the kvm code in arm by using this latter form of callback registration.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: kvm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/arm/kvm/arm.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index bd18bb8..f0e50a0 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -1051,21 +1051,26 @@ int kvm_arch_init(void *opaque)
>  		}
>  	}
>  
> +	cpu_notifier_register_begin();
> +
>  	err = init_hyp_mode();
>  	if (err)
>  		goto out_err;
>  
> -	err = register_cpu_notifier(&hyp_init_cpu_nb);
> +	err = __register_cpu_notifier(&hyp_init_cpu_nb);
>  	if (err) {
>  		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
>  		goto out_err;
>  	}
>  
> +	cpu_notifier_register_done();
> +
>  	hyp_cpu_pm_init();
>  
>  	kvm_coproc_table_init();
>  	return 0;
>  out_err:
> +	cpu_notifier_register_done();
>  	return err;
>  }
>  
> 

Just so we're clear, the existing code was simply racy as not prone to
deadlocks, right?

This makes it clear that the test above for compatible CPUs can be quite
easily evaded by using CPU hotplug, but we don't really have a good
solution for handling that yet...  Hmmm, grumble grumble, I guess if you
hotplug unsupported CPUs on a KVM/ARM system for now, stuff will break.

In any case:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
