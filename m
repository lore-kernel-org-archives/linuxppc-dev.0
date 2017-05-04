Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJVgz2T60zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 19:52:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/kprobes: un-blacklist system_call() from
 kprobes
In-Reply-To: <20170504072807.GC9733@naverao1-tp.localdomain>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
 <e15c0617dbf4ff85d3e8f91b7a3ef8e2071b581d.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
 <87d1by17b0.fsf@concordia.ellerman.id.au>
 <20170427123536.GB3313@naverao1-tp.localdomain>
 <87k25xyx8x.fsf@concordia.ellerman.id.au>
 <20170504072807.GC9733@naverao1-tp.localdomain>
Date: Thu, 04 May 2017 19:52:46 +1000
Message-ID: <87bmr9ymmp.fsf@concordia.ellerman.id.au>
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
> On 2017/05/04 04:03PM, Michael Ellerman wrote:
>> Would this work?
>> 
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index 767ef6d68c9e..8d0fa4a2262a 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -207,6 +207,7 @@ system_call:			/* label this so stack traces look sane */
>>  	mtmsrd	r11,1
>>  #endif /* CONFIG_PPC_BOOK3E */
>> 
>> +syscall_exit:
>>  	ld	r9,TI_FLAGS(r12)
>>  	li	r11,-MAX_ERRNO
>>  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>
> Ah, nice. I previously incorrectly assumed that syscall_exit was not 
> desirable throughout this function. Your earlier patch was only about 
> what label showed up while _inside_ a syscall.

Yep. When you're somewhere in a syscall the LR on the stack points to
the instruction following the bctrl that called the syscall handler, so
as long as the label preceeding that is system_call then the backtrace
should look good.

We could even just have a nop after the bctrl and then the label, but
that would be a bit gross.

> So, syscall_exit post handling of a syscall is fine.
>
> This patch looks fine to me. I will test with this change and get back.

Thanks.

cheers
