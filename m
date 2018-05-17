Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mjwm230CzF1Q0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 17:43:52 +1000 (AEST)
Date: Thu, 17 May 2018 09:43:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, Dave Watson <davejwatson@fb.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Hunter <ahh@google.com>, Andi Kleen <andi@firstfloor.org>,
 Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
 rostedt <rostedt@goodmis.org>, Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Joel Fernandes <joelaf@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Message-ID: <20180517074313.GK12217@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
 <20180517011949.GA1121@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517011949.GA1121@tardis>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2018 at 09:19:49AM +0800, Boqun Feng wrote:
> On Wed, May 16, 2018 at 04:13:16PM -0400, Mathieu Desnoyers wrote:

> > and that x86 calls it from syscall_return_slowpath() (which AFAIU is
> > now used in the fast-path since KPTI), I wonder where we should call
> 
> So we actually detect this after the syscall takes effect, right? I
> wonder whether this could be problematic, because "disallowing syscall"
> in rseq areas may means the syscall won't take effect to some people, I
> guess?

It doesn't really matter I suspect, the important part is the program
getting killed.

I agree that doing it on sysenter is slightly nicer, but I'll take
sysexit if that's what it takes.

> > this on PowerPC ?  I was under the impression that PowerPC return to
> > userspace fast-path was not calling C code unless work flags were set,
> > but I might be wrong.
> > 
> 
> I think you're right. So we have to introduce callsite to rseq_syscall()
> in syscall path, something like:
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 51695608c68b..a25734a96640 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -222,6 +222,9 @@ system_call_exit:
>  	mtmsrd	r11,1
>  #endif /* CONFIG_PPC_BOOK3E */
>  
> +	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl	rseq_syscall
> +
>  	ld	r9,TI_FLAGS(r12)
>  	li	r11,-MAX_ERRNO
>  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> 
> But I think it's important for us to first decide where (before or after
> the syscall) we do the detection.

The important thing is the processed getting very dead. Either sysenter
or sysexit gets that done.
