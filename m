Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com
 [IPv6:2607:f8b0:400d:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AD0F2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:21:11 +1000 (EST)
Received: by mail-qc0-f178.google.com with SMTP id c11so8047989qcv.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 01:21:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <51CAA46B.70500@redhat.com>
Date: Wed, 26 Jun 2013 10:20:59 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 28/45] KVM: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203036.16593.50377.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625203036.16593.50377.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Gleb Natapov <gleb@redhat.com>, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, vincent.guittot@linaro.org, kvm@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 25/06/2013 22:30, Srivatsa S. Bhat ha scritto:
> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
> offline, while invoking from atomic context.
> 
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  virt/kvm/kvm_main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 302681c..5bbfa30 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -174,7 +174,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>  
>  	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
>  
> -	me = get_cpu();
> +	me = get_online_cpus_atomic();
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		kvm_make_request(req, vcpu);
>  		cpu = vcpu->cpu;
> @@ -192,7 +192,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>  		smp_call_function_many(cpus, ack_flush, NULL, 1);
>  	else
>  		called = false;
> -	put_cpu();
> +	put_online_cpus_atomic();
>  	free_cpumask_var(cpus);
>  	return called;
>  }
> @@ -1707,11 +1707,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>  		++vcpu->stat.halt_wakeup;
>  	}
>  
> -	me = get_cpu();
> +	me = get_online_cpus_atomic();
>  	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
>  		if (kvm_arch_vcpu_should_kick(vcpu))
>  			smp_send_reschedule(cpu);
> -	put_cpu();
> +	put_online_cpus_atomic();
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
>  #endif /* !CONFIG_S390 */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
