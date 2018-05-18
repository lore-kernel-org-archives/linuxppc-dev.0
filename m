Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nbxK6Vj5zF2Cj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 04:17:25 +1000 (AEST)
Date: Fri, 18 May 2018 14:17:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, Dave Watson <davejwatson@fb.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
 Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
 Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Joel Fernandes <joelaf@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <418003803.516.1526667437396.JavaMail.zimbra@efficios.com>
In-Reply-To: <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
 <20180517011949.GA1121@tardis>
 <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
 <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- On May 17, 2018, at 7:50 PM, Boqun Feng boqun.feng@gmail.com wrote:
[...]
>> > I think you're right. So we have to introduce callsite to rseq_syscall()
>> > in syscall path, something like:
>> > 
>> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> > index 51695608c68b..a25734a96640 100644
>> > --- a/arch/powerpc/kernel/entry_64.S
>> > +++ b/arch/powerpc/kernel/entry_64.S
>> > @@ -222,6 +222,9 @@ system_call_exit:
>> > 	mtmsrd	r11,1
>> > #endif /* CONFIG_PPC_BOOK3E */
>> > 
>> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
>> > +	bl	rseq_syscall
>> > +
>> > 	ld	r9,TI_FLAGS(r12)
>> > 	li	r11,-MAX_ERRNO
>> > 	andi.
>> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>> > 

By the way, I think this is not the right spot to call rseq_syscall, because
interrupts are disabled. I think we should move this hunk right after system_call_exit.

Would you like to implement and test an updated patch adding those calls for ppc 32 and 64 ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
