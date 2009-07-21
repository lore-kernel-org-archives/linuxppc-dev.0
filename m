Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E1D82B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 03:37:28 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 03429DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2009 03:37:27 +1000 (EST)
Received: from [127.0.0.1] (ssh.southpole.se [193.12.106.19])
	by mail.southpole.se (Postfix) with ESMTPSA id 3BC1A4D4298
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 19:16:46 +0200 (CEST)
Subject: mpc5121 Power Managment errata.
From: Kenneth Johansson <kenneth@southpole.se>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-eyA6VYjd5cRsDZD360BU"
Date: Tue, 21 Jul 2009 19:16:43 +0200
Message-Id: <1248196603.17765.65.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-eyA6VYjd5cRsDZD360BU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have a bit of a problem with arch/powerpc/platforms/512x/mpc512x_pm.c
Since this one is not included in mainline (yet) I have attached it 

Now I have a number of questions and one mystery.

1: why relocate the code ?? is there a reason why the code must be
located at address 0 

http://www.bitshrine.org/gpp/linux-2.6.24.6-mpc5121-99-PM-alternate-external-int-vector.patch

say that this is due to a bug in the PMC module with status bits. Could
this not be worked around by avoiding modifying the exception handler
and just taken care of by C code in ipic.c

2: does it work ??? 
I ask since it do self modifying code but no invalidation of the
instruction cache.


Mystery: If I fix the cache issue with the code and force store of data
with dcbst and invalidate with icbi. I get a very unreliable resume
function that often end up in machine check all over the place 

This machine check also happens on unmodified version but much much more
seldom. I'm just now running some test on a system that only patch this
in once and thus always run with this workaround without constantly
modifying the exception handler . but I wont know if it makes a
difference until tomorrow.


I have inserted this code in the end of both 
mpc5121_copy_pmcclr
mpc5121_reinstall_handler
Is there some reason why this would not work ?? 
-----------------------------------------
	/*
	dcbst |update memory
	sync |wait for update
	icbi |remove (invalidate) copy in instruction cache
	isync |remove copy in own instruction buffer
	*/

	lis	r3, CONFIG_KERNEL_START@h
	ori	r3, r3, CONFIG_KERNEL_START@l

	/* flush and invalidate from 0 to 0x600 */
	li	r5, 0x0
	li	r4, 0x600/L1_CACHE_BYTES
	mtctr	r4
1:
	dcbst	r5,r3
	sync
	icbi	r5,r3
	isync
	addi	r5, r5, L1_CACHE_BYTES    /* Next line, please */

	bdnz	1b
	sync
	isync

--=-eyA6VYjd5cRsDZD360BU
Content-Disposition: attachment; filename="mpc512x.S"
Content-Type: text/x-csrc; name="mpc512x.S"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

#include <asm/reg.h>
#include <asm/ppc_asm.h>
#include <asm/processor.h>
#include <asm/page.h>
#include <asm/cache.h>

#define NUM_CACHE_LINES (128*8)

	/* this variable added to reserve 0x20*4 bytes.
	 * This value has been derived by counting the
	 * number of lines of the function "code_atzero".
	 * In case if the size of this function increases
	 * the number of bytes have to increased accordi-
	 * ngly.
	 */
        .data
mpc5121_data_temp:
        .space 0x20*4

        .text
	.globl mpc5121_copy_pmcclr
mpc5121_copy_pmcclr:
	/* Coming here with interrupts disabled */
	/* storing the content at 0x0 location
	 * to mpc512_data_temp space */
	lis     r6, CONFIG_KERNEL_START@h
	mr	r4, r6
	li	r3, (code_atzero_end - code_atzero)/4
	mtctr	r3
        lis     r3, mpc5121_data_temp@h
        ori     r3, r3, mpc5121_data_temp@l
	/* loops here till the counter is zero */
loop:
        lwz     r5, 0(r4)
        stw     r5, 0(r3)
        addi    r3, r3, 4
        addi    r4, r4, 4
        bdnz    loop

	/* Copy code to Location 0x0 */
	mr	r4, r6
	li	r3, (code_atzero_end - code_atzero)/4
	mtctr	r3
	lis	r3, code_atzero@h
	ori	r3, r3, code_atzero@l
1:
	lwz	r5, 0(r3)
	stw	r5, 0(r4)
	addi	r3, r3, 4
	addi	r4, r4, 4
	bdnz	1b

	/* Copy the jump to 0x0 code at 0x500*/
	lwz	r5, 0x500(r6)
	stw	r5, 0(r6)
	lwz	r5, 8(r6)
	stw	r5, 0x500(r6)

	/* Flush the cache */
	lis	r3, CONFIG_KERNEL_START@h
	ori	r3, r3, CONFIG_KERNEL_START@l

	/* Let us load data starting from 0x600 loc */
	addi	r3, r3, 0x600
	li	r4, NUM_CACHE_LINES
	mtctr	r4
1:
	lwz	r4, 0(r3)
	addi	r3, r3, L1_CACHE_BYTES    /* Next line, please */
	bdnz	1b
	sync; isync
	blr

	.globl mpc5121_reinstall_handler
mpc5121_reinstall_handler:

	/* Rewrite original code at 0x500 */
	lis	r6, CONFIG_KERNEL_START@h
	lwz	r5, 0(r6)
	stw	r5, 0x500(r6)
	/* restoring content at 0x0 location */
        mr      r4, r6
        li      r3, (code_atzero_end - code_atzero)/4
        mtctr   r3
        lis     r3, mpc5121_data_temp@h
        ori     r3, r3, mpc5121_data_temp@l
        /* loops here till the counter is zero */
loop1:
        lwz     r5, 0(r3)
        stw     r5, 0(r4)
        addi    r3, r3, 4
        addi    r4, r4, 4
        bdnz    loop1
	blr

code_atzero:
	.long 0x0  /*Space reserved for copying first word of code from 0x500 */
	ba 0x504
	ba 0xc  /* This code is not executed. This code is copied to 0x500 */
	mtspr	SPRN_SPRG0, r3
	mtspr	SPRN_SPRG1, r4
	mfspr	r3, 311
	addi	r3, r3, 0x1000  /* Assuming that MBAR is aligned to this size */
	lwz	r4, 0x4(r3)
	stw	r4, 0x4(r3)
        /* clearing GPIO evnet registers */
        mfspr   r3, 311
        /* getting offset of GPIO */
        addi    r3, r3,0x1100
        lwz     r4, 0xC(r3)
        stw     r4, 0xC(r3)
	mfspr	r3, SPRN_SPRG0
	mfspr	r4, SPRN_SPRG1
	ba	0x0
code_atzero_end:
	b 	code_atzero_end   /* Should never reach here*/


--=-eyA6VYjd5cRsDZD360BU--
