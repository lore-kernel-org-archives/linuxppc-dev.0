Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 808066855F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Nov 2005 10:04:58 +1100 (EST)
Date: Fri, 4 Nov 2005 16:06:05 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051104180605.GA3271@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Required functions for relocating not part of relocate section
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Paul,

Recent 2.6-git (from Wednesday) tree fails to boot on 8xx due to:
                                                                                                                                              
BDI>i             
    Target state      : debug mode
    Debug entry cause : trace
    Current PC        : 0x005ba8e8
BDI>md 0x005ba8e8 
005ba8e8 : 00000000 00000000 00000000 00000000  ................
005ba8f8 : 00000000 00000000 00000000 00000000  ................
005ba908 : 00000000 00000000 00000000 00000000  ................
005ba918 : 00000000 00000000 00000000 00000000  ................
005ba928 : 00000000 00000000 00000000 00000000  ................
...
BDI>go 
- TARGET: stopped
BDI>i 
    Target state      : debug mode
    Debug entry cause : software emulation exception
    Current PC        : 0x005ba8e8

Problem is that flush_instruction_cache (and flush_data_cache)
from boot/common/util.S are not being copied to the relocate section,
even though the file contains the proper entry:

        .section ".relocate_code","xa"
/*
 * Flush and enable instruction cache
 * First, flush the data cache in case it was enabled and may be
 * holding instructions for copy back.
 */
_GLOBAL(flush_instruction_cache)

Here is the disassemble of the relocate section:

004047a0 <__relocate_start>:
  4047a0:       38 c0 00 00     li      r6,0
  4047a4:       7c e9 03 a6     mtctr   r7
  4047a8:       3c 80 00 40     lis     r4,64
  4047ac:       60 84 00 20     ori     r4,r4,32
  4047b0:       7d 03 43 78     mr      r3,r8
  4047b4:       7c 04 18 00     cmpw    r4,r3
  4047b8:       41 81 00 20     bgt-    4047d8 <do_relocate_from_end>

004047bc <do_relocate_from_start>:
  4047bc:       80 a3 00 00     lwz     r5,0(r3)
  4047c0:       90 a4 00 00     stw     r5,0(r4)
  4047c4:       38 63 00 04     addi    r3,r3,4
  4047c8:       38 84 00 04     addi    r4,r4,4
  4047cc:       7c c6 2a 78     xor     r6,r6,r5
  4047d0:       42 00 ff ec     bdnz+   4047bc <do_relocate_from_start>
  4047d4:       48 00 00 24     b       4047f8 <do_relocate_out>

004047d8 <do_relocate_from_end>:
  4047d8:       3c 60 00 5b     lis     r3,91
  4047dc:       60 63 d3 40     ori     r3,r3,54080
  4047e0:       54 e4 10 3a     rlwinm  r4,r7,2,0,29
  4047e4:       7c 88 22 14     add     r4,r8,r4
  4047e8:       84 a4 ff fc     lwzu    r5,-4(r4)
  4047ec:       94 a3 ff fc     stwu    r5,-4(r3)
  4047f0:       7c c6 2a 78     xor     r6,r6,r5
  4047f4:       42 00 ff f4     bdnz+   4047e8 <do_relocate_from_end+0x10>

004047f8 <do_relocate_out>:     
  4047f8:       3c 60 00 40     lis     r3,64
  4047fc:       60 63 01 14     ori     r3,r3,276
  404800:       7c 68 03 a6     mtlr    r3
  404804:       4b ff d5 40     b       401d44 <flush_instruction_cache>
Disassembly of section .data:

Replacing "b flush_instruction_cache" with "ba flush_instruction_cache" 
makes the system boot.

The problem does not exist on v2.6.14.

Any clues??
