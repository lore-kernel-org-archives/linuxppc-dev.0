Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410WqY29yszF1my
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 22:50:15 +1000 (AEST)
Date: Tue, 5 Jun 2018 08:50:10 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andy Lutomirski <luto@amacapital.net>,
 Dave Watson <davejwatson@fb.com>,
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
 Will Deacon <will.deacon@arm.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Joel Fernandes <joelaf@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1448764618.5559.1528203010706.JavaMail.zimbra@efficios.com>
In-Reply-To: <871sdlbyg7.fsf@concordia.ellerman.id.au>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
 <20180602124408.8430-10-mathieu.desnoyers@efficios.com>
 <871sdlbyg7.fsf@concordia.ellerman.id.au>
Subject: Re: [RFC PATCH for 4.18 09/16] powerpc: Add syscall detection for
 restartable sequences
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

----- On Jun 5, 2018, at 1:21 AM, Michael Ellerman mpe@ellerman.id.au wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> From: Boqun Feng <boqun.feng@gmail.com>
>>
>> Syscalls are not allowed inside restartable sequences, so add a call to
>> rseq_syscall() at the very beginning of system call exiting path for
>> CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
>> is a syscall issued inside restartable sequences.
>>
>> [ Tested on 64-bit powerpc kernel by Mathieu Desnoyers. Still needs to
>>   be tested on 32-bit powerpc kernel. ]
>>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> CC: linuxppc-dev@lists.ozlabs.org
>> ---
>>  arch/powerpc/kernel/entry_32.S | 7 +++++++
>>  arch/powerpc/kernel/entry_64.S | 8 ++++++++
>>  2 files changed, 15 insertions(+)
> 
> I don't _love_ the #ifdefs in here, but they look correct and there's
> not really a better option until we rewrite the syscall handler in C.
> 
> The rseq selftests passed for me with this applied and enabled. So if
> you like here's some tags:
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 

Adding you ack to the series.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
