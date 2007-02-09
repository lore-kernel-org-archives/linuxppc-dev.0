Return-Path: <michael@lug-owl.de>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 750D9DDE3C
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 02:54:31 +1100 (EST)
Date: Fri, 9 Feb 2007 14:46:38 +0100
From: Michael Westermann <michael@dvmwest.de>
To: linuxppc-dev@ozlabs.org
Subject: Booting a microchannel IBM 7013 with a simple Programm via tftp
Message-ID: <20070209134637.GB20296@dvmwest.dvmwest.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've a Bull ESCALA-D (IBM 7013J) with microchannel and 8 PPC 604 and one gig ram. I work for
a few years on the booting and loading this box with linux.

this is the second version of my testprog. 

I've attached the source and the  bootfile. This load and display an hexvalue
to the Small user display, and loop until power off. This Programm use
the BUMP-Processor.

I've compiled with a gcc ppc-crosscompile on a i386 box.


Michael

--mP3DRpeJDSE+ciuQ
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="ppc.h"

/*
 * include/asm-ppc/ppc_asm.h
 *
 * Definitions used by various bits of low-level assembly code on PowerPC.
 *
 * Copyright (C) 1995-1999 Gary Thomas, Paul Mackerras, Cort Dougan.
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version
 *  2 of the License, or (at your option) any later version.
 */

/* Changed for ppc-test by Michael Westermann 2007 */

#define	cr0	0
#define	cr1	1
#define	cr2	2
#define	cr3	3
#define	cr4	4
#define	cr5	5
#define	cr6	6
#define	cr7	7


/* General Purpose Registers (GPRs) */

#define	r0	0
#define	r1	1
#define	r2	2
#define	r3	3
#define	r4	4
#define	r5	5
#define	r6	6
#define	r7	7
#define	r8	8
#define	r9	9
#define	r10	10
#define	r11	11
#define	r12	12
#define	r13	13
#define	r14	14
#define	r15	15
#define	r16	16
#define	r17	17
#define	r18	18
#define	r19	19
#define	r20	20
#define	r21	21
#define	r22	22
#define	r23	23
#define	r24	24
#define	r25	25
#define	r26	26
#define	r27	27
#define	r28	28
#define	r29	29
#define	r30	30
#define	r31	31


/* Floating Point Registers (FPRs) */

#define	fr0	0
#define	fr1	1
#define	fr2	2
#define	fr3	3
#define	fr4	4
#define	fr5	5
#define	fr6	6
#define	fr7	7
#define	fr8	8
#define	fr9	9
#define	fr10	10
#define	fr11	11
#define	fr12	12
#define	fr13	13
#define	fr14	14
#define	fr15	15
#define	fr16	16
#define	fr17	17
#define	fr18	18
#define	fr19	19
#define	fr20	20
#define	fr21	21
#define	fr22	22
#define	fr23	23
#define	fr24	24
#define	fr25	25
#define	fr26	26
#define	fr27	27
#define	fr28	28
#define	fr29	29
#define	fr30	30
#define	fr31	31

#define	vr0	0
#define	vr1	1
#define	vr2	2
#define	vr3	3
#define	vr4	4
#define	vr5	5
#define	vr6	6
#define	vr7	7
#define	vr8	8
#define	vr9	9
#define	vr10	10
#define	vr11	11
#define	vr12	12
#define	vr13	13
#define	vr14	14
#define	vr15	15
#define	vr16	16
#define	vr17	17
#define	vr18	18
#define	vr19	19
#define	vr20	20
#define	vr21	21
#define	vr22	22
#define	vr23	23
#define	vr24	24
#define	vr25	25
#define	vr26	26
#define	vr27	27
#define	vr28	28
#define	vr29	29
#define	vr30	30
#define	vr31	31

#define	evr0	0
#define	evr1	1
#define	evr2	2
#define	evr3	3
#define	evr4	4
#define	evr5	5
#define	evr6	6
#define	evr7	7
#define	evr8	8
#define	evr9	9
#define	evr10	10
#define	evr11	11
#define	evr12	12
#define	evr13	13
#define	evr14	14
#define	evr15	15
#define	evr16	16
#define	evr17	17
#define	evr18	18
#define	evr19	19
#define	evr20	20
#define	evr21	21
#define	evr22	22
#define	evr23	23
#define	evr24	24
#define	evr25	25
#define	evr26	26
#define	evr27	27
#define	evr28	28
#define	evr29	29
#define	evr30	30
#define	evr31	31

/* some stab codes */
#define N_FUN	36
#define N_RSYM	64
#define N_SLINE	68
#define N_SO	100

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_boot.S"

#include "ppc.h" 

#define block_size	512
#define bootstrap	0x400
#define blocks_bootstarp bootstrap/block_size
#define nvram		0xff60
#define	start_prog	0x3f0
#define	ende_file	0xA00
#define anz_blocks	ende_file/block_size
#define	magic_number	0xc9c2d4c1			// 'IBMA' EBCIDIC

							/* boot record  */
		.org	0
		.long magic_number			// IPL Record id		
		.long 0, 0, 0, 0, 0			
		.long 0, 0, 0		
		.long anz_blocks			// anz blocks bootcode base
		.long start_prog			// start_prog base
		.long blocks_bootstarp
		.long blocks_bootstarp
		.long anz_blocks
		.long 0
		.byte 0x01,0x02,0x00,0x00
		.long 0, 0, 0, 0, 0, 0, 0, 0, 0
		.long anz_blocks			// anz blocks bootcode sevice
		.long start_prog			// start_prog service
		.long blocks_bootstarp			
		.long blocks_bootstarp
		.long anz_blocks
		.long 0

		.org	bootstrap 
		.org	bootstrap+start_prog
test_lix:	mflr	r26			
		lis	r1,32		// Stack 0x200000

		addi	r28, r4 ,0	

		mtibatu	0,r3
		mtdbatu	0,r3
		mtibatu	1,r3
		mtdbatu	1,r3
		mtibatu	2,r3
		mtdbatu	2,r3
		mtibatu	3,r3
		mtdbatu	3,r3
		addi	r0,r4,19	
		mtibatl	0,r0		// BPRN=0,      PP = 11 WIMG=0010
		addi	r0,r4,18
		mtdbatl	0,r0		// BPRN=0,      PP = 10 WIMG=0010
		addi	r0,r4,255
		mtibatu	0,r0		// BEPI=0, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	0,r0		// BEPI=0, Area Length=8MB, Vs=1,Vp=1
		li	r4,0
		oris	r4,r4,65472	
		addi	r0,r4,19	
		mtibatl	1,r0		// BPRN=0xffc0, PP = 11 WIMG=0010, 
		addi	r0,r4,19
		mtdbatl	1,r0		// BPRN=0xffc0, PP = 11 WIMG=0010, 
		addi	r0,r4,127	
		mtibatu	1,r0		// BEPI=0xffc0, Area Length=1MB, Vs=1,Vp=1
		mtdbatu	1,r0		// BEPI=0xffc0, Area Length=1MB, Vs=1,Vp=1
		lis	r4,-256
		addi	r0,r4,35
		mtibatl	2,r0		// BPRN=0xff00, PP = 11 WIMG=0100, 
		addi	r0,r4,34	// BPRN=0xff00, PP = 10 WIMG=0100, 
		mtdbatl	2,r0
		addi	r0,r4,255
		mtibatu	2,r0		// BEPI=0xff00, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	2,r0		// BEPI=0xff00, Area Length=8MB, Vs=1,Vp=1
		lis	r4,384		
		addi	r0,r4,19
		mtibatl	3,r0		// BPRN=0x0180, PP = 11 WIMG=0010, 
		addi	r0,r4,18	// BPRN=0x0180, PP = 10 WIMG=0010, 
		mtdbatl	3,r0
		addi	r0,r4,255
		mtibatu	3,r0		// BEPI=0x0180, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	3,r0		// BEPI=0x0180, Area Length=8MB, Vs=1,Vp=1
		sync	
		isync
		li	r0,12400
		mtmsr	r0
		isync
		sync
		
		bl 	set_led_copy
		
		li	r3, 0x444	
		bl	dump_IPL	
		sync
		isync
loop:		b loop

dump_IPL:	mflr	r0		
      		mtctr	r0
		rlwinm	r4,r3,20,0,11
		li	r3,	0x300
		oris	r3,r3,	nvram
		stw	r4,0(r3)
		sync
		bctr

set_led_copy:	cmpwi	r3,0		// set_led_copy
		lis	r3,-158
		addic	r3,r3,2528
		li	r0,1
		beq-	L00004f68
		stw	r0,-2376(r3)
		blr
L00004f68:	li	r0,0
		stw	r0,-2376(r3)
		blr
		.org	ende_file-1
		.byte 0	

--mP3DRpeJDSE+ciuQ
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=test_boot
Content-Transfer-Encoding: base64

ycLUwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABQAAA/AAAAACAAAAAgAA
AAUAAAAAAQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAPw
AAAAAgAAAAIAAAAFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH9IAqY8IAAgO4QAAHxwg6Z8eIOm
fHKDpnx6g6Z8dIOmfHyDpnx2g6Z8foOmOAQAE3wRg6Y4BAASfBmDpjgEAP98EIOmfBiDpjiA
AABkhP/AOAQAE3wTg6Y4BAATfBuDpjgEAH98EoOmfBqDpjyA/wA4BAAjfBWDpjgEACJ8HYOm
OAQA/3wUg6Z8HIOmPIABgDgEABN8F4OmOAQAEnwfg6Y4BAD/fBaDpnweg6Z8AASsTAABLDgA
MHB8AAEkTAABLHwABKxIAAA5OGAEREgAABF8AASsTAABLEgAAAB8CAKmfAkDplRkoBY4YAMA
ZGP/YJCDAAB8AASsToAEICwDAAA8YP9iMGMJ4DgAAAFBggAMkAP2uE6AACA4AAAAkAP2uE6A
ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==

--mP3DRpeJDSE+ciuQ--
