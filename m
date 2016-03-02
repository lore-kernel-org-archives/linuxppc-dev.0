Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FD841A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 15:29:13 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 89862140662
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 15:29:11 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 09:59:08 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u224T7BN5046688
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 09:59:07 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u224T6cF023263
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2016 09:59:06 +0530
Message-ID: <56D66C12.9090205@linux.vnet.ibm.com>
Date: Wed, 02 Mar 2016 09:59:06 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V10 02/28] powerpc,
 process: Add the function flush_tmregs_to_thread
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-3-git-send-email-khandual@linux.vnet.ibm.com>
 <20160302111500.7b50fac9@camb691>
In-Reply-To: <20160302111500.7b50fac9@camb691>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2016 05:45 AM, Cyril Bur wrote:
> On Tue, 16 Feb 2016 14:29:32 +0530
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> This patch creates a function flush_tmregs_to_thread which
>> will then be used by subsequent patches in this series. The
>> function checks for self tracing ptrace interface attempts
>> while in the TM context and logs appropriate warning message.
>>
> 
> Hi Anshuman,
> 
> You'll have to bare with me, my ptrace knowledge is non existent so you might
> have to walk me though some aspects.
> 
> I have been playing with FPU/VMX and VSX saving so I thought I'd take a look.

Sure.


> 
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/switch_to.h |  8 ++++++++
>>  arch/powerpc/kernel/process.c        | 20 ++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
>> index 5b268b6..7b297bf 100644
>> --- a/arch/powerpc/include/asm/switch_to.h
>> +++ b/arch/powerpc/include/asm/switch_to.h
>> @@ -70,6 +70,14 @@ static inline void disable_kernel_spe(void)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +extern void flush_tmregs_to_thread(struct task_struct *);
>> +#else
>> +static inline void flush_tmregs_to_thread(struct task_struct *t)
>> +{
>> +}
>> +#endif
>> +
>>  static inline void clear_task_ebb(struct task_struct *t)
>>  {
>>  #ifdef CONFIG_PPC_BOOK3S_64
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index dccc87e..2c4fa7f 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -918,6 +918,26 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>>  #endif
>>  }
>>  
> 
> 
> 
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +void flush_tmregs_to_thread(struct task_struct *tsk)
>> +{
>> +	/*
>> +	 * Process self tracing is not yet supported through
>> +	 * ptrace interface. Ptrace generic code should have
>> +	 * prevented this from happening in the first place.
>> +	 * Warn once here with the message, if some how it
>> +	 * is attempted.
>> +	 */
>> +	WARN_ONCE(tsk == current,
>> +		"Not expecting ptrace on self: TM regs may be incorrect\n");
>> +
>> +	/*
>> +	 * If task is not current, it should have been flushed
>> +	 * already to it's thread_struct during __switch_to().
>> +	 */
> 
> I totally agree except this highlights something that I notice in subsequent
> patches, and existing code. All the *_{get,set}() functions call
> flush_*_to_thread() when, as per your comment (and my understanding of task
> switching) there really shouldn't be a need to do that. My only thought is that
> this could be a relic of uniprocessor days when it would have been necessary but
> Anton recently stripped that out. Are you able to shed some light here?

Its been sometime I had looked into this aspect of the series. I remember
Michael Neuling and myself discussed about this and settled on a single
WARN_ON here as nothing else was required to be done in the function. It
may be possible that all the flush_*_to_thread() functions used else where
are because of uniprocessor concerns. I dont understand completely our
context save/restore paths including the lazy ones. I believed that these
flush_*_to_thread() routines just made sure task struct has the latest
values of the thread context in case of some complicated save/restore
paths might not have done the complete save at that point in time.

If you think that all these flush_*_to_thread() functions used through
out POWER ptrace need review to see whether they are required or not
anymore I would suggest we should do it as a separate patch after this
series and I am willing to work with you on that.

> 
> The reason I ask is that if the flush_*_to_thread() calls ARE actually
> important then I worry that this function is inadequate...

I guess we went through that and finally settled on WARN_ON once but dont
remember the exact context now. Will look into all previous discussions
on this and get back.
