Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 311CBDE0C6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 20:45:22 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4846F0C0.80808@freescale.com>
References: <4846F0C0.80808@freescale.com> <4846EEAE.3000908@hypersurf.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: inline assembly
Date: Thu, 05 Jun 2008 11:44:51 +0100
Message-ID: <11849.1212662691@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote:

> int tmp;
> 
> asm volatile("addi %1, %2, -1;"
>              "andc %1, %2, %1;"
>              "cntlzw %1, %1;"
>              "subfic %0, %1, 31" : "=r" (j), "=&r" (tmp) : "r" (i));

Registers are usually assumed to be 'long' in size, so I'd recommend using
that rather than 'int' for tmp, though I suspect it'll make little difference
(except, perhaps on x86 where you can partially use registers).

> However, it'd be better to let the compiler do more, by just using the
> existing cntlzw() function.

Look in include/asm-powerpc/bitops.h.  There are examples of the things you're
trying to do:

	static __inline__ __attribute__((const))
	int __ilog2(unsigned long x)
	{
		int lz;

		asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (x));
		return BITS_PER_LONG - 1 - lz;
	}

	static __inline__ int __ffs(unsigned long x)
	{
		return __ilog2(x & -x);
	}

Where:

	asm-compat.h:79:#define PPC_CNTLZL	stringify_in_c(cntlzd)
	asm-compat.h:100:#define PPC_CNTLZL	stringify_in_c(cntlzw)

Depending on whether you're in 32-bit mode or 64-bit mode.

David
