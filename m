Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4E281DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 19:57:51 +1100 (EST)
Date: Fri, 16 Nov 2007 00:57:49 -0800 (PST)
Message-Id: <20071116.005749.106893030.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [POWERPC] Fix link errors for allyesconfig
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071115.222313.226097963.davem@davemloft.net>
References: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
	<20071115.222313.226097963.davem@davemloft.net>
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

From: David Miller <davem@davemloft.net>
Date: Thu, 15 Nov 2007 22:23:13 -0800 (PST)

> There has to be a nicer way to do this.  In fact I think I
> just figured out one such technique.
> 
> The whole reason we need these .fixup sections is to encode
> a move of -EFAULT into some register, and a control transfer.
> 
> Every kernel text address, even for modules, is in the low 32-bits on
> sparc64.  So we can encode this more simply, perhaps even with one
> 32-bit word for each entry.
> 
> I can probably encode it all in the __ex_table entries in fact,
> and I'll give that a shot.

Ok, here's what I came up with:

/*
 * The exception table consists 3 32-bit words, the encoding takes
 * advantage of the fact that all kernel text addresses on sparc64 are
 * in the low 4GB of the 64-bit address space so any location can be
 * encoded in 32-bits.
 *
 * The first word is the address of an instruction that is allowed to
 * fault.  This is the search key used by search_exception_tables().
 *
 * The second word is a continuation address in the kernel text.
 *
 * The third word is an instruction to execute before transferring
 * control to the location specified by the second word.  Most of
 * these instructions are of the form:
 *
 *	mov	-EFAULT, %reg
 *
 * Effectively the trap return TPC is set to the address of the third
 * word, and the trap return TNPC is set to the value contained in the
 * second word.
 */
struct exception_table_entry {
	unsigned int insn, fixup_addr, fixup_insn;
};

And then __put_user_asm() now looks like:

#define __put_user_asm(x,size,addr,ret)		\
__asm__ __volatile__(				\
	"/* Put user asm, inline. */\n"		\
"1:\t"	"st"#size "a %1, [%2] %%asi\n\t"	\
	"clr	%0\n"				\
"2:\n\n\t"					\
	".section __ex_table\n\t"		\
	".word	1b, 2b; mov %3, %0\n\t"		\
	".previous\n\n\t"			\
       : "=r" (ret) : "r" (x), "r" (__m(addr)),	\
	 "i" (-EFAULT))

The .fixup section is completely eliminated, and the exception
dispatch goes:

	regs->tpc = (unsigned long) &entry->fixup_insn;
	regs->tnpc = entry->fixup_addr;

I have a full patch implementing this and it passes a
allyesconfig build and link.
