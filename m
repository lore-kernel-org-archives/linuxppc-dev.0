Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJPbP6PfBzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 16:03:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/kprobes: un-blacklist system_call() from
 kprobes
In-Reply-To: <20170427123536.GB3313@naverao1-tp.localdomain>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
 <e15c0617dbf4ff85d3e8f91b7a3ef8e2071b581d.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
 <87d1by17b0.fsf@concordia.ellerman.id.au>
 <20170427123536.GB3313@naverao1-tp.localdomain>
Date: Thu, 04 May 2017 16:03:26 +1000
Message-ID: <87k25xyx8x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> On 2017/04/27 08:19PM, Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> 
>> > It is actually safe to probe system_call() in entry_64.S, but only till
>> > .Lsyscall_exit. To allow this, convert .Lsyscall_exit to a non-local
>> > symbol __system_call() and blacklist that symbol, rather than
>> > system_call().
>> 
>> I'm not sure I like this. The reason we made it a local symbol in the
>> first place is because it made backtraces look odd:
>> 
>>   commit 4c3b21686111e0ac6018469dacbc5549f9915cf8
>>   Author:     Michael Ellerman <mpe@ellerman.id.au>
>>   AuthorDate: Fri Dec 5 21:16:59 2014 +1100
>>   
>>   powerpc/kernel: Make syscall_exit a local label
>>   
>>   Currently when we back trace something that is in a syscall we see
>>   something like this:
>>   
>>   [c000000000000000] [c000000000000000] SyS_read+0x6c/0x110
>>   [c000000000000000] [c000000000000000] syscall_exit+0x0/0x98
>>   
>>   Although it's entirely correct, seeing syscall_exit at the bottom can be
>>   confusing - we were exiting from a syscall and then called SyS_read() ?
>>   
>>   If we instead change syscall_exit to be a local label we get something
>>   more intuitive:
>>   
>>   [c0000001fa46fde0] [c00000000026719c] SyS_read+0x6c/0x110
>>   [c0000001fa46fe30] [c000000000009264] system_call+0x38/0xd0
>>   
>>   ie. we were handling a system call, and it was SyS_read().
>> 
>> 
>> I think you know that, although you didn't mention it in the change log,
>> because you've called the new symbol __system_call. But that is not a
>> great name either because that's not what it does.
>
> Yes, you're right. I used __system_call since I felt that it won't cause 
> confusion like syscall_exit did. I agree it's not a great name, but we 
> need _some_ label other than system_call if we want to allow probing at 
> this point.
>
> Also, if I'm reading this right, there is no other place to probe if we 
> want to capture all system call entries.
>
> So, I felt this would be good to have.
>
>> 
>> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> > index 380361c0bb6a..e030ce34dd66 100644
>> > --- a/arch/powerpc/kernel/entry_64.S
>> > +++ b/arch/powerpc/kernel/entry_64.S
>> > @@ -176,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
>> >  	mtctr   r12
>> >  	bctrl			/* Call handler */
>> >  
>> > -.Lsyscall_exit:
>> > +__system_call:
>> >  	std	r3,RESULT(r1)
>> >  	CURRENT_THREAD_INFO(r12, r1)
>>   
>> Why can't we kprobe the std and the rotate to current thread info?
>> 
>> Is the real no-probe point just here, prior to the clearing of MSR_RI ?
>> 
>> 	ld	r8,_MSR(r1)
>> #ifdef CONFIG_PPC_BOOK3S
>> 	/* No MSR:RI on BookE */
>
> We can probe at all those places, just not once MSR_RI is unset. So, the 
> no-probe point is just *after* the mtmsrd.
>
> However, for kprobe blacklisting, the granularity is at a function level 
> (or ASM labels). As such, we will have to blacklist all of 
> syscall_exit/__system_call.

Would this work?

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 767ef6d68c9e..8d0fa4a2262a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -207,6 +207,7 @@ system_call:			/* label this so stack traces look sane */
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
+syscall_exit:
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)


cheers
