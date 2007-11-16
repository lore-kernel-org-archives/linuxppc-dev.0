Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 96AF5DDDE9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 17:23:16 +1100 (EST)
Date: Thu, 15 Nov 2007 22:23:13 -0800 (PST)
Message-Id: <20071115.222313.226097963.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [POWERPC] Fix link errors for allyesconfig
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
References: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 4 Nov 2007 13:28:39 +1100

> Dave, would something like this help as an alternative to the .fixup
> change you committed recently?

I tried it, doesn't help:

kernel/built-in.o: In function `context_switch':
/home/davem/src/GIT/sparc-2.6/kernel/sched.c:1950: relocation truncated to fit: R_SPARC_WDISP22 against symbol `ret_from_syscall' defined in .text section in arch/sparc64/kernel/head.o
drivers/built-in.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x2c): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x38): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x44): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x50): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
drivers/built-in.o:(.fixup+0x5c): additional relocation overflows omitted from the output
make: *** [.tmp_vmlinux1] Error 1

drivers/built-in.o itself has a 16MB+ .text section which is
beyond the 22-bit signed branch displacement we have available.

There has to be a nicer way to do this.  In fact I think I
just figured out one such technique.

The whole reason we need these .fixup sections is to encode
a move of -EFAULT into some register, and a control transfer.

Every kernel text address, even for modules, is in the low 32-bits on
sparc64.  So we can encode this more simply, perhaps even with one
32-bit word for each entry.

I can probably encode it all in the __ex_table entries in fact,
and I'll give that a shot.
