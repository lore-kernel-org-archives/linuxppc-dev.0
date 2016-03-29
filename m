Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ0Bh0msPzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:46:20 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qZ0Bg2h86z9sdt
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2016 16:46:19 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id u190so6185145pfb.3
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 22:46:19 -0700 (PDT)
Subject: Re: [PATCH 5/6] powerpc/livepatch: Add livepatch stack to struct
 thread_info
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
 <56F9C531.3090703@gmail.com> <1459228740.8173.10.camel@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FA1697.8090800@gmail.com>
Date: Tue, 29 Mar 2016 16:45:59 +1100
MIME-Version: 1.0
In-Reply-To: <1459228740.8173.10.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> At this point ti->livepatch_sp points to the next CPUs thread_info for softirq_ctx?
> Sorry I'm not sure what you mean.
>
> None of this relates to the current CPUs thread info.
Oh! I meant that klp_init_thread_info points to the end of (struct thread_info {} + 1) in the stack of the thread/task, but with the irq_contexts they are a separate array and not on stack
>>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>>> index 3807fb05b6de..1b6cabb8e715 100644
>>> --- a/arch/powerpc/kernel/setup_64.c
>>> +++ b/arch/powerpc/kernel/setup_64.c
>>> @@ -69,6 +69,7 @@
>>>  #include <asm/kvm_ppc.h>
>>>  #include <asm/hugetlb.h>
>>>  #include <asm/epapr_hcalls.h>
>>> +#include <asm/livepatch.h>
>>>  
>>>  #ifdef DEBUG
>>>  #define DBG(fmt...) udbg_printf(fmt)
>>> @@ -667,16 +668,16 @@ static void __init emergency_stack_init(void)
>>>  	limit = min(safe_stack_limit(), ppc64_rma_size);
>>>  
>>>  	for_each_possible_cpu(i) {
>>> -		unsigned long sp;
>>> -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
>>> -		sp += THREAD_SIZE;
>>> -		paca[i].emergency_sp = __va(sp);
>>> +		struct thread_info *ti;
>>> +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
>>> +		klp_init_thread_info(ti);
>>> +		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
>>  
>> Does emergency_sp still end up 128 byte aligned after this?
> It should end up THREAD_SIZE aligned as before, due to the memblock_alloc_base().
Yep.. I missed it.. so where is the space for ti? The stack is going to go grow downwards from ti+THREAD_SIZE
>>>  #ifdef CONFIG_PPC_BOOK3S_64
>>>  		/* emergency stack for machine check exception handling. */
>>> -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
>>> -		sp += THREAD_SIZE;
>>> -		paca[i].mc_emergency_sp = __va(sp);
>>> +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
>>> +		klp_init_thread_info(ti);
>> Do we care about live-patching in this context? Are we mixing per-thread and per-cpu contexts?
> Well we probably don't want to be doing live patching when we're on the
> emergency stacks. But we have no control over whether that happens so we have
> to support it.
>

OK.. I was wondering if the code will even work.. I wonder if the ftrace data structures will work in real mode, including the hash/etc.

Balbir
