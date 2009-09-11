Return-Path: <dgibson@bilbo.ozlabs.org>
Date: Fri, 11 Sep 2009 15:31:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: g r1x <gr1xmail@gmail.com>
Subject: Re: How to access DCR registers in powerpc440gx? Got err when use
	macro def in Linux kernel
Message-ID: <20090911053106.GB11840@yookeroo.seuss>
References: <8abf57fa0909101024n668ad353kf8be038898305c28@mail.gmail.com>
	<8abf57fa0909102114hf935c21h5dd727ba2a9a4825@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8abf57fa0909102114hf935c21h5dd727ba2a9a4825@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 11, 2009 at 12:14:55PM +0800, g r1x wrote:
> Now, I'm writing a DMA driver on powerpc
> 440gx platform(2.6.26.5), as the only way to set up DMA Controller is
> to access it's dcr registers with 'mfdcr' and 'mtdcr'.
> 
> I've found some dma code in Linux kernel 2.6.26.5, so I copy the code
> u wrote to my driver module directory, and include them, but when I
> compile my driver, gcc complains following err messages:

[snip]
> #define mfdcr(rn) \
>      ({      \
>              unsigned long rval; \
>              asm volatile("mfdcr %0,%1" : "=r"(rval) : "i"(rn)); \
>              rval; \
>      })

This form of mfdcr macro will only work when passed a constant DCR
number.  That's a limitation in the actual CPU implementation of the
mfdcr instruction (the DCR number is part of the instruction opcode).

Some newer cores have an indirect for of mfdcr which allows the DCR
number to be specified in a register, but I don't know if 440gx is one
of them.

In current kernels we have some DCR macros that use a big table of
pre-generated instructions in order to allow accesses to runtime
computed DCR numbers.  But either they didn't exist in 2.6.26, or they
have a different name, I don't remember.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
