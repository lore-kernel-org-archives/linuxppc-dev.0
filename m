Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkZh5PDYzDrFn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:30:04 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB61U1Pk070217
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 20:30:02 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275jgpm0qc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 20:30:01 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 11:29:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 393A52BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:29:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB61Tltv47054952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:29:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB61Tj1b012394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:29:46 +1100
Subject: Re: [PATCH v8 3/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
To: Boqun Feng <boqun.feng@gmail.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161206012315.GD18164@tardis.cn.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 09:30:02 +0800
MIME-Version: 1.0
In-Reply-To: <20161206012315.GD18164@tardis.cn.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <f37d62a6-f745-8f21-d5ea-ceeb5aef64dc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/12/6 09:23, Boqun Feng 写道:
> On Mon, Dec 05, 2016 at 10:19:23AM -0500, Pan Xinhui wrote:
>> Add two corresponding helper functions to support pv-qspinlock.
>>
>> For normal use, __spin_yield_cpu will confer current vcpu slices to the
>> target vcpu(say, a lock holder). If target vcpu is not specified or it
>> is in running state, such conferging to lpar happens or not depends.
>>
>> Because hcall itself will introduce latency and a little overhead. And we
>> do NOT want to suffer any latency on some cases, e.g. in interrupt handler.
>> The second parameter *confer* can indicate such case.
>>
>> __spin_wake_cpu is simpiler, it will wake up one vcpu regardless of its
>> current vcpu state.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/spinlock.h |  4 +++
>>  arch/powerpc/lib/locks.c            | 59 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
>> index 954099e..6426bd5 100644
>> --- a/arch/powerpc/include/asm/spinlock.h
>> +++ b/arch/powerpc/include/asm/spinlock.h
>> @@ -64,9 +64,13 @@ static inline bool vcpu_is_preempted(int cpu)
>>  /* We only yield to the hypervisor if we are in shared processor mode */
>>  #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
>>  extern void __spin_yield(arch_spinlock_t *lock);
>> +extern void __spin_yield_cpu(int cpu, int confer);
>> +extern void __spin_wake_cpu(int cpu);
>>  extern void __rw_yield(arch_rwlock_t *lock);
>>  #else /* SPLPAR */
>>  #define __spin_yield(x)        barrier()
>> +#define __spin_yield_cpu(x, y) barrier()
>> +#define __spin_wake_cpu(x) barrier()
>>  #define __rw_yield(x)  barrier()
>>  #define SHARED_PROCESSOR       0
>>  #endif
>> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
>> index 6574626..bd872c9 100644
>> --- a/arch/powerpc/lib/locks.c
>> +++ b/arch/powerpc/lib/locks.c
>> @@ -23,6 +23,65 @@
>>  #include <asm/hvcall.h>
>>  #include <asm/smp.h>
>>
>> +/*
>> + * confer our slices to a specified cpu and return. If it is in running state
>> + * or cpu is -1, then we will check confer. If confer is NULL, we will return
>> + * otherwise we confer our slices to lpar.
>> + */
>> +void __spin_yield_cpu(int cpu, int confer)
>> +{
>> +	unsigned int holder_cpu = cpu, yield_count;
>
> As I said at:
>
> https://marc.info/?l=linux-kernel&m=147455748619343&w=2
>
> @holder_cpu is not necessary and doesn't help anything.
>
>> +
>> +	if (cpu == -1)
>> +		goto yield_to_lpar;
>> +
>> +	BUG_ON(holder_cpu >= nr_cpu_ids);
>> +	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
>> +
>> +	/* if cpu is running, confer slices to lpar conditionally*/
>> +	if ((yield_count & 1) == 0)
>> +		goto yield_to_lpar;
>> +
>> +	plpar_hcall_norets(H_CONFER,
>> +		get_hard_smp_processor_id(holder_cpu), yield_count);
>> +	return;
>> +
>> +yield_to_lpar:
>> +	if (confer)
>> +		plpar_hcall_norets(H_CONFER, -1, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(__spin_yield_cpu);
>> +
>> +void __spin_wake_cpu(int cpu)
>> +{
>> +	unsigned int holder_cpu = cpu;
>
> And it's even wrong to call the parameter of _wake_cpu() a holder_cpu,
> because it's not the current lock holder.
>
oh, its name is really misleading.

thanks

> Regards,
> Boqun
>
>> +
>> +	BUG_ON(holder_cpu >= nr_cpu_ids);
>> +	/*
>> +	 * NOTE: we should always do this hcall regardless of
>> +	 * the yield_count of the holder_cpu.
>> +	 * as thers might be a case like below;
>> +	 *	CPU 1			CPU 2
>> +	 *				yielded = true
>> +	 * if (yielded)
>> +	 *	__spin_wake_cpu()
>> +	 *				__spin_yield_cpu()
>> +	 *
>> +	 * So we might lose a wake if we check the yield_count and
>> +	 * return directly if the holder_cpu is running.
>> +	 * IOW. do NOT code like below.
>> +	 *	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
>> +	 *	if ((yield_count & 1) == 0)
>> +	 *		return;
>> +	 *
>> +	 * a PROD hcall marks the target_cpu proded, which cause the next cede
>> +	 * or confer called on the target_cpu invalid.
>> +	 */
>> +	plpar_hcall_norets(H_PROD,
>> +		get_hard_smp_processor_id(holder_cpu));
>> +}
>> +EXPORT_SYMBOL_GPL(__spin_wake_cpu);
>> +
>>  #ifndef CONFIG_QUEUED_SPINLOCKS
>>  void __spin_yield(arch_spinlock_t *lock)
>>  {
>> --
>> 2.4.11
>>
