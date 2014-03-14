Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A77DD2C00F7
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 16:43:54 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 14 Mar 2014 15:43:49 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 650613578054
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 16:43:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2E5hUIi7536994
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 16:43:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2E5hg7v031728
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 16:43:43 +1100
Message-ID: <53229701.8050405@linux.vnet.ibm.com>
Date: Fri, 14 Mar 2014 11:13:29 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v3 10/52] arm, kvm: Fix CPU hotplug callback registration
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
 <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
 <20140312232127.GC24808@cbox>
In-Reply-To: <20140312232127.GC24808@cbox>
Content-Type: text/plain; charset=ISO-8859-1
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

On 03/13/2014 04:51 AM, Christoffer Dall wrote:
> On Tue, Mar 11, 2014 at 02:05:38AM +0530, Srivatsa S. Bhat wrote:
>> Subsystems that want to register CPU hotplug callbacks, as well as perform
>> initialization for the CPUs that are already online, often do it as shown
>> below:
>>
>> 	get_online_cpus();
>>
>> 	for_each_online_cpu(cpu)
>> 		init_cpu(cpu);
>>
>> 	register_cpu_notifier(&foobar_cpu_notifier);
>>
>> 	put_online_cpus();
>>
>> This is wrong, since it is prone to ABBA deadlocks involving the
>> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
>> with CPU hotplug operations).
>>
>> Instead, the correct and race-free way of performing the callback
>> registration is:
>>
>> 	cpu_notifier_register_begin();
>>
>> 	for_each_online_cpu(cpu)
>> 		init_cpu(cpu);
>>
>> 	/* Note the use of the double underscored version of the API */
>> 	__register_cpu_notifier(&foobar_cpu_notifier);
>>
>> 	cpu_notifier_register_done();
>>
>>
>> Fix the kvm code in arm by using this latter form of callback registration.
>>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Gleb Natapov <gleb@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: kvm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
>>
>>  arch/arm/kvm/arm.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index bd18bb8..f0e50a0 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -1051,21 +1051,26 @@ int kvm_arch_init(void *opaque)
>>  		}
>>  	}
>>  
>> +	cpu_notifier_register_begin();
>> +
>>  	err = init_hyp_mode();
>>  	if (err)
>>  		goto out_err;
>>  
>> -	err = register_cpu_notifier(&hyp_init_cpu_nb);
>> +	err = __register_cpu_notifier(&hyp_init_cpu_nb);
>>  	if (err) {
>>  		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
>>  		goto out_err;
>>  	}
>>  
>> +	cpu_notifier_register_done();
>> +
>>  	hyp_cpu_pm_init();
>>  
>>  	kvm_coproc_table_init();
>>  	return 0;
>>  out_err:
>> +	cpu_notifier_register_done();
>>  	return err;
>>  }
>>  
>>
> 
> Just so we're clear, the existing code was simply racy as not prone to
> deadlocks, right?
> 
> This makes it clear that the test above for compatible CPUs can be quite
> easily evaded by using CPU hotplug, but we don't really have a good
> solution for handling that yet...  Hmmm, grumble grumble, I guess if you
> hotplug unsupported CPUs on a KVM/ARM system for now, stuff will break.
> 

In this particular case, there was no deadlock possibility, rather the
existing code had insufficient synchronization against CPU hotplug.

init_hyp_mode() would invoke cpu_init_hyp_mode() on currently online CPUs
using on_each_cpu(). If a CPU came online after this point and before calling
register_cpu_notifier(), that CPU would remain uninitialized because this
subsystem would miss the hot-online event. This patch fixes this bug and
also uses the new synchronization method (instead of get/put_online_cpus())
to ensure that we don't deadlock with CPU hotplug.

> In any case:
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 

Thanks a lot!

Regards,
Srivatsa S. Bhat
