Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8FC1DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 14:58:20 +1000 (EST)
Message-Id: <A62DFD0C-387A-4833-B266-99DB1B09E101@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <14228.1213850120@neuling.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX 
Date: Wed, 18 Jun 2008 23:58:11 -0500
References: <20080618004734.0B72E70296@localhost.localdomain>
	<5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org>
	<14228.1213850120@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 11:35 PM, Michael Neuling wrote:

> In message <5AEB0769-1394-4924-803D- 
> C40CAF685519@kernel.crashing.org> you wrote
> :
>>>
>>>
>>> Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
>>> ===================================================================
>>> --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
>>> +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
>>> @@ -78,6 +78,7 @@ extern long kernel_thread(int (*fn)(void
>>> /* Lazy FPU handling on uni-processor */
>>> extern struct task_struct *last_task_used_math;
>>> extern struct task_struct *last_task_used_altivec;
>>> +extern struct task_struct *last_task_used_vsx;
>>> extern struct task_struct *last_task_used_spe;
>>>
>>> #ifdef CONFIG_PPC32
>>> @@ -136,8 +137,13 @@ typedef struct {
>>> 	unsigned long seg;
>>> } mm_segment_t;
>>>
>>> +#ifdef CONFIG_VSX
>>> +#define TS_FPR(i) fpvsr.fp[i].fpr
>>> +#define TS_FPRSTART fpvsr.fp
>>> +#else
>>> #define TS_FPR(i) fpr[i]
>>> #define TS_FPRSTART fpr
>>> +#endif
>>>
>>> struct thread_struct {
>>> 	unsigned long	ksp;		/* Kernel stack pointer */
>>> @@ -155,8 +161,19 @@ struct thread_struct {
>>> 	unsigned long	dbcr0;		/* debug control register values */
>>> 	unsigned long	dbcr1;
>>> #endif
>>> +#ifdef CONFIG_VSX
>>> +	/* First 32 VSX registers (overlap with fpr[32]) */
>>> +	union {
>>> +		struct {
>>> +			double fpr;
>>> +			double vsrlow;
>>> +		} fp[32];
>>> +		vector128	vsr[32];

how about:

	union {
		struct {
			double fp;
			double vsrlow;
		} fpr;
		vector128 v;
	} fpvsr[32];

>>>
>>> +	} fpvsr __attribute__((aligned(16)));
>>
>> Do we really need a union here?  what would happen if you just  
>> changed
>> the type of fpr[32] from double to vector if #CONFIG_VSX?
>>
>> I really dont like the union and think we can just make the storage
>> look opaque which is the key.  I doubt we every really care about
>> using fpr[] as a double in the kernel.
>
> I did something similar to this for the first cut of this patch, but  
> it
> made the code accessing this structure much less readable.

really, what code is that?

- k
