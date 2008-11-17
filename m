Return-Path: <penberg@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 9E8FFDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 08:25:32 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1049254ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 13:25:30 -0800 (PST)
Message-ID: <84144f020811171325m5eabca71ge525ea643dbe8209@mail.gmail.com>
Date: Mon, 17 Nov 2008 23:25:30 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <alpine.LFD.2.00.0811171309580.18283@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811171557370.26123@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171309580.18283@nehalem.linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 11:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I do wonder just _what_ it is that causes the stack frames to be so
> horrid. For example, you have
>
>         18)     8896     160   .kmem_cache_alloc+0xfc/0x140
>
> and I'm looking at my x86-64 compile, and it has a stack frame of just 8
> bytes (!) for local variables plus the save/restore area (which looks like
> three registers plus frame pointer plus return address). IOW, if I'm
> looking at the code right (so big caveat: I did _not_ do a real stack
> dump!) the x86-64 stack cost for that same function is on the order of 48
> bytes. Not 160.
>
> Where does that factor-of-three+ difference come from? From the numbers, I
> suspect ppc64 has a 32-byte stack alignment, which may be part of it, and
> I guess the compiler is more eager to use all those extra registers and
> will happily have many more callee-saved regs that are actually used.
>
> But that still a _lot_ of extra stack.
>
> Of course, you may have things like spinlock debugging etc enabled. Some
> of our debugging options do tend to blow things up.

Note that kmem_cache_alloc() is likely to contain lots of inlined
functions for both SLAB and SLUB. Perhaps that blows up stack usage on
ppc?
