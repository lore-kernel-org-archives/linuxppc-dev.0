Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410Ksj06FgzF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 15:21:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andy Lutomirski <luto@amacapital.net>,
 Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Paul Turner <pjt@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andrew Hunter <ahh@google.com>, Andi Kleen <andi@firstfloor.org>,
 Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Joel Fernandes <joelaf@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH for 4.18 09/16] powerpc: Add syscall detection for
 restartable sequences
In-Reply-To: <20180602124408.8430-10-mathieu.desnoyers@efficios.com>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
 <20180602124408.8430-10-mathieu.desnoyers@efficios.com>
Date: Tue, 05 Jun 2018 15:21:28 +1000
Message-ID: <871sdlbyg7.fsf@concordia.ellerman.id.au>
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

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> From: Boqun Feng <boqun.feng@gmail.com>
>
> Syscalls are not allowed inside restartable sequences, so add a call to
> rseq_syscall() at the very beginning of system call exiting path for
> CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
> is a syscall issued inside restartable sequences.
>
> [ Tested on 64-bit powerpc kernel by Mathieu Desnoyers. Still needs to
>   be tested on 32-bit powerpc kernel. ]
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> CC: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/entry_32.S | 7 +++++++
>  arch/powerpc/kernel/entry_64.S | 8 ++++++++
>  2 files changed, 15 insertions(+)

I don't _love_ the #ifdefs in here, but they look correct and there's
not really a better option until we rewrite the syscall handler in C.

The rseq selftests passed for me with this applied and enabled. So if
you like here's some tags:

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
