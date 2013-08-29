Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 7138B2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 03:11:52 +1000 (EST)
Message-ID: <521F80D4.2030300@c-s.fr>
Date: Thu, 29 Aug 2013 19:11:48 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Feedback wished on possible improvment of CPU15 errata handling on
 mpc8xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc8xx powerpc has an errata identified CPU15 which is that whenever 
the last instruction of a page is a conditional branch to the last 
instruction of the next page, the CPU might do crazy things.

To work around this errata, one of the workarounds proposed by freescale is:
"In the ITLB miss exception code, when loading the TLB for an MMU page, 
also invalidate any TLB referring to the next and previous page using 
tlbie. This intentionally forces an ITLB miss exception on every 
execution across sequential MMU page boundaries"

It is that workaround which has been implemented in the kernel. The 
drawback of this workaround is that TLB miss is encountered everytime we 
cross page boundary. On a flat program execution, it means that we get a 
TLB miss every 1000 instructions. A TLB miss handling is around 30/40 
instructions, which means a degradation of about 4% of the performances.
It can be even worse if the program has a loop astride two pages.

In the errata document from freescale, there is an example where they 
only invalidate the TLB when the page has the actual issue, in extenso 
when the page has the offending instruction at offset 0xffc, and they 
suggest to use the available PTE bits to tag pages in advance.

I checked in asm/pte-8xx.h : we still have one SW bit available 
(0x0080). So I was thinking about using that bit to mark pages 
CPU15_SAFE when loading them if they don't have the offending instruction.

Then, in the ITLBmiss handler, instead of always invalidating preceeding 
and following pages, we would check SW bit in the PTE and invalidate 
following page only if current page is not marked CPU15_SAFE, then check 
the PTE of preceeding page and invalidate it only if it is not marked 
CPU15_SAFE

I believe this would improve the CPU15 errata handling and would reduce 
the overhead introduced by the handling of this errata.

Do you see anything wrong with my proposal ?

Christophe
