Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjmBv0ZyHzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 01:15:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7VFDO4V035774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 11:15:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cpkvgugtn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 11:14:57 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 16:14:54 +0100
Subject: Re: [PATCH RFC] Interface to set SPRN_TIDR
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
References: <20170830023856.GC26152@us.ibm.com>
 <1504076904.4670.20.camel@neuling.org> <20170830233208.GC20351@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>, npiggin@gmail.com
From: felix <felix@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 17:14:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170830233208.GC20351@us.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9cfefb69-3a3f-a4df-2ba1-cbcf13e1fadc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/08/2017 01:32, Sukadev Bhattiprolu wrote:
> Michael Neuling [mikey@neuling.org] wrote:
>> Suka,
>>
>> Please CC Christophe who as an alternative way of doing this. We ned to get
>> agreement across all users of TIDR/AS_notify...
> Mikey,
>
> Thanks. There is overlap between the two patches. I will send a patch on
> top of Christophe's for the interfaces to assign/clear the TIDR value and
> clear the thread->tidr during arch_dup_task_struct(). I will also drop the
> CONFIG_VAS check since its not only for VAS.
>
> Christophe, can you let me know of any other comments on this patch?
>
> Suka
Suka,

I am seconding Christophe on this matter. I think that your patch now 
fulfills the CAPI use case requirements, with one exception: CAPI does 
not restrict assigning a thread id to the current task. Please find a 
few minor questions below.

Philippe

>> His patch is here:
>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.ozlabs.org_pipermail_linuxppc-2Ddev_2017-2DAugust_161582.html&d=DwIFAw&c=jf_iaSHvJObTbx-siA1ZOg&r=KC0fX9VGJYXlSiH9qN2ZONDbh8vUCZFX8GUhF3rHAvg&m=XQenBfWewOBjWopgf1Fh2UAVGnlzq766MNuzx7jYfuA&s=07WOVTh9f_4IBZfCJes4lvc7LWenBlqVfAXIXxL2QH4&e=
>>
>> Mikey
>>
>> On Tue, 2017-08-29 at 19:38 -0700, Sukadev Bhattiprolu wrote:
>>> We need the SPRN_TIDR to be set for use with fast thread-wakeup
>>> (core-to-core wakeup) in VAS. Each user thread that has a receive
>>> window setup and expects to be notified when a sender issues a paste
>>> needs to have a unique SPRN_TIDR value.
>>>
>>> The SPRN_TIDR value only needs to unique within the process but for
>>> now we use a globally unique thread id as described below.
>>>
>>> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>>> ---
>>> Changelog[v2]
>>> 	- Michael Ellerman: Use an interface to assign TIDR so it is
>>> 	  assigned to only threads that need it; move assignment to
>>> 	  restore_sprs(). Drop lint from rebase;
>>>
>>>
>>>   arch/powerpc/include/asm/processor.h |  4 ++
>>>   arch/powerpc/include/asm/switch_to.h |  3 ++
>>>   arch/powerpc/kernel/process.c        | 97
>>> ++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 104 insertions(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/processor.h
>>> b/arch/powerpc/include/asm/processor.h
>>> index fab7ff8..bf6ba63 100644
>>> --- a/arch/powerpc/include/asm/processor.h
>>> +++ b/arch/powerpc/include/asm/processor.h
>>> @@ -232,6 +232,10 @@ struct debug_reg {
>>>   struct thread_struct {
>>>   	unsigned long	ksp;		/* Kernel stack pointer */
>>>
>>> +#ifdef CONFIG_PPC_VAS
>>> +	unsigned long	tidr;
>>> +#endif
>>> +
>>>   #ifdef CONFIG_PPC64
>>>   	unsigned long	ksp_vsid;
>>>   #endif
>>> diff --git a/arch/powerpc/include/asm/switch_to.h
>>> b/arch/powerpc/include/asm/switch_to.h
>>> index 17c8380..4962455 100644
>>> --- a/arch/powerpc/include/asm/switch_to.h
>>> +++ b/arch/powerpc/include/asm/switch_to.h
>>> @@ -91,4 +91,7 @@ static inline void clear_task_ebb(struct task_struct *t)
>>>   #endif
>>>   }
>>>
>>> +extern void set_thread_tidr(struct task_struct *t);
>>> +extern void clear_thread_tidr(struct task_struct *t);
>>> +
>>>   #endif /* _ASM_POWERPC_SWITCH_TO_H */
>>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>>> index 1f0fd36..13abb22 100644
>>> --- a/arch/powerpc/kernel/process.c
>>> +++ b/arch/powerpc/kernel/process.c
>>> @@ -1132,6 +1132,10 @@ static inline void restore_sprs(struct thread_struct
>>> *old_thread,
>>>   			mtspr(SPRN_TAR, new_thread->tar);
>>>   	}
>>>   #endif
>>> +#ifdef CONFIG_PPC_VAS
>>> +	if (old_thread->tidr != new_thread->tidr)
>>> +		mtspr(SPRN_TIDR, new_thread->tidr);
>>> +#endif
>>>   }
>>>
>>>   #ifdef CONFIG_PPC_BOOK3S_64
>>> @@ -1446,9 +1450,97 @@ void flush_thread(void)
>>>   #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>>>   }
>>>
>>> +#ifdef CONFIG_PPC_VAS
>>> +static DEFINE_SPINLOCK(vas_thread_id_lock);
>>> +static DEFINE_IDA(vas_thread_ida);
>>> +
>>> +/*
>>> + * We need to assign an unique thread id to each thread in a process. This
>>> + * thread id is intended to be used with the Fast Thread-wakeup (aka Core-
>>> + * to-core wakeup) mechanism being implemented on top of Virtual Accelerator
>>> + * Switchboard (VAS).
>>> + *
>>> + * To get a unique thread-id per process we could simply use task_pid_nr()
>>> + * but the problem is that task_pid_nr() is not yet available for the thread
>>> + * when copy_thread() is called. Fixing that would require changing more
>>> + * intrusive arch-neutral code in code path in copy_process()?.
>>> + *
>>> + * Further, to assign unique thread ids within each process, we need an
>>> + * atomic field (or an IDR) in task_struct, which again intrudes into the
>>> + * arch-neutral code.
>>> + *
>>> + * So try to assign globally unique thraed ids for now.
>>> + *
>>> + * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
>>> + * 	 For now, only threads that expect to be notified by the VAS
>>> + * 	 hardware need a TIDR value and we assign values > 0 for those.
>>> + */
>>> +#define MAX_THREAD_CONTEXT	((1 << 15) - 2)
Why are you excluding ((1 << 15) - 1)?
>>> +static int assign_thread_tidr(void)
>>> +{
>>> +	int index;
>>> +	int err;
>>> +
>>> +again:
>>> +	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
>>> +		return -ENOMEM;
>>> +
>>> +	spin_lock(&vas_thread_id_lock);
>>> +	err = ida_get_new_above(&vas_thread_ida, 1, &index);
Why are you excluding 1?
>>> +	spin_unlock(&vas_thread_id_lock);
>>> +
>>> +	if (err == -EAGAIN)
>>> +		goto again;
>>> +	else if (err)
>>> +		return err;
>>> +
>>> +	if (index > MAX_THREAD_CONTEXT) {
>>> +		spin_lock(&vas_thread_id_lock);
>>> +		ida_remove(&vas_thread_ida, index);
>>> +		spin_unlock(&vas_thread_id_lock);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	return index;
>>> +}
>>> +
>>> +static void free_thread_tidr(int id)
>>> +{
>>> +	spin_lock(&vas_thread_id_lock);
>>> +	ida_remove(&vas_thread_ida, id);
>>> +	spin_unlock(&vas_thread_id_lock);
>>> +}
>>> +
>>> +void clear_thread_tidr(struct task_struct *t)
>>> +{
>>> +	if (t->thread.tidr) {
>>> +		free_thread_tidr(t->thread.tidr);
>>> +		t->thread.tidr = 0;
>>> +		mtspr(SPRN_TIDR, 0);
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * Assign an unique thread id for this thread and set it in the
>>> + * thread structure. For now, we need this interface only for
>>> + * the current task.
>>> + */
>>> +void set_thread_tidr(struct task_struct *t)
>>> +{
>>> +	WARN_ON(t != current);
CAPI does not have this restriction. It should be possible to assign a 
thread id to an arbitrary task.
>>> +	t->thread.tidr = assign_thread_tidr();
>>> +	mtspr(SPRN_TIDR, t->thread.tidr);
>>> +}
>>> +
>>> +#endif /* CONFIG_PPC_VAS */
>>> +
>>> +
>>>   void
>>>   release_thread(struct task_struct *t)
>>>   {
>>> +#ifdef CONFIG_PPC_VAS
>>> +	clear_thread_tidr(t);
>>> +#endif
>>>   }
>>>
>>>   /*
>>> @@ -1474,6 +1566,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct
>>> task_struct *src)
>>>
>>>   	clear_task_ebb(dst);
>>>
>>> +	dst->thread.tidr = 0;
>>> +
>>>   	return 0;
>>>   }
>>>
>>> @@ -1584,6 +1678,9 @@ int copy_thread(unsigned long clone_flags, unsigned long
>>> usp,
>>>   #endif
>>>
>>>   	setup_ksp_vsid(p, sp);
>>> +#ifdef CONFIG_PPC_VAS
>>> +	p->thread.tidr = 0;
>>> +#endif
>>>
>>>   #ifdef CONFIG_PPC64
>>>   	if (cpu_has_feature(CPU_FTR_DSCR)) {
