Message-Id: <4.3.2.7.2.20000804014852.00dc3f00@mail.munich.netsurf.de>
Date: Fri, 04 Aug 2000 01:54:53 +0200
To: David Edelsohn <dje@watson.ibm.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: shifts on 64bit ints 
Cc: Thomas Graichen <graichen@innominate.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200008032302.TAA29224@mal-ach.watson.ibm.com>
References: <Message from Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
 <news2mail-8mcs8e$kdj$2@mate.bln.innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:02 04.08.00, David Edelsohn wrote:

>         First, I would suggest that you use a printf format like "%08x"
>for better legibility.
>
>         Second, I tried your example with gcc-2.95.2 on PowerPC AIX
>gcc-2.95.2 on PowrePC Linux, and a recent development snapshot of GCC with
>various optimization levels (you did not specify what options you used to
>compile the testcase) and I consistently saw the following output:
>
>Mask 29 is 0x0000000020000000 - 0xffffffffdfffffff
>Mask 30 is 0x0000000040000000 - 0xffffffffbfffffff
>Mask 31 is 0x0000000080000000 - 0xffffffff7fffffff
>Mask 32 is 0x0000000100000000 - 0xfffffffeffffffff
>Mask 33 is 0x0000000200000000 - 0xfffffffdffffffff
>Mask 34 is 0x0000000400000000 - 0xfffffffbffffffff
>
>         You appear to have a problem, but it is local to your system
>(could be toolchain or C library as well).

Oh no!! It's even worse! The kernel implementation of ashldi3, ashrdi3 and
lshrdi3 seems broken, see this code in arch/ppc/kernel/misc.S:

/*
  * Extended precision shifts
  *
  * R3/R4 has 64 bit value
  * R5    has shift count
  * result in R3/R4
  *
  *  ashrdi3:     XXXYYY/ZZZAAA -> SSSXXX/YYYZZZ
  *  ashldi3:     XXXYYY/ZZZAAA -> YYYZZZ/AAA000
  *  lshrdi3:     XXXYYY/ZZZAAA -> 000XXX/YYYZZZ
  */
_GLOBAL(__ashrdi3)
         li      r6,32
         sub     r6,r6,r5
         slw     r7,r3,r6        /* isolate YYY */
         srw     r4,r4,r5        /* isolate ZZZ */
         or      r4,r4,r7        /* YYYZZZ */
         sraw    r3,r3,r5        /* SSSXXX */
         blr

_GLOBAL(__ashldi3)
         li      r6,32
         sub     r6,r6,r5
         srw     r7,r4,r6        /* isolate ZZZ */
         slw     r4,r4,r5        /* AAA000 */
         slw     r3,r3,r5        /* YYY--- */
         or      r3,r3,r7        /* YYYZZZ */
         blr

_GLOBAL(__lshrdi3)
         li      r6,32
         sub     r6,r6,r5
         slw     r7,r3,r6        /* isolate YYY */
         srw     r4,r4,r5        /* isolate ZZZ */
         or      r4,r4,r7        /* YYYZZZ */
         srw     r3,r3,r5        /* 000XXX */
         blr

I don't see how these can handle shift's >=32...

Somebody should fix that...

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
