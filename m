Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Subject: [RFC 3/3] powerpc: copy_4K_page tweaked for Cell
Date: Thu, 19 Jun 2008 17:54:17 +1000
MIME-Version: 1.0
Message-Id: <200806191754.17289.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Cc: Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

/*
 * Copyright (C) 2008 Gunnar von Boehn, IBM Corp.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 *
 *
 * copy_4K_page routine optimized for CELL-BE-PPC
 *
 * The CELL PPC core has 1 integerunit and 1 load/store unit
 * CELL: 1st level data cache = 32K - 2nd level data cache = 512K
 * - 3rd level data cache = 0K
 * To improve copy performance we need to prefetch source data
 * far ahead to hide this latency
 * For best performance instruction forms ending in "." like "andi."
 * should be avoided as they are implemented in microcode on CELL.
 *
 * The below code is loop unrolled for the CELL cache line of 128 bytes.
 */

#include <asm/processor.h>
#include <asm/ppc_asm.h>

#define PREFETCH_AHEAD 6
#define ZERO_AHEAD 4

	.align  7
_GLOBAL(copy_4K_page)
	dcbt	0,r4		/* Prefetch ONE SRC cacheline */

	addi	r6,r3,-8	/* prepare for stdu */
	addi	r4,r4,-8	/* prepare for ldu */

	li	r10,32		/* copy 32 cache lines for a 4K page */
	li	r12,128+8		/* prefetch distance*/

	subi	r11,r10,PREFETCH_AHEAD
	li	r10,PREFETCH_AHEAD

	mtctr	r10
.LprefetchSRC:
	dcbt    r12,r4
	addi    r12,r12,128
	bdnz    .LprefetchSRC

.Louterloop:				/* copy while cache lines */
	mtctr	r11

	li	r11,128*ZERO_AHEAD +8		/* DCBZ dist */

.align	4
	/* Copy whole cachelines, optimized by prefetching SRC cacheline */
.Lloop: 				/* Copy aligned body */
	dcbt    r12,r4			/* PREFETCH SOURCE some cache lines ahead*/
	ld      r9, 0x08(r4)
	dcbz	r11,r6
	ld      r7, 0x10(r4)    	/* 4 register stride copy */
	ld      r8, 0x18(r4)		/* 4 are optimal to hide 1st level cache lantency*/
	ld      r0, 0x20(r4)
	std     r9, 0x08(r6)
	std     r7, 0x10(r6)
	std     r8, 0x18(r6)
	std     r0, 0x20(r6)
	ld      r9, 0x28(r4)
	ld      r7, 0x30(r4)
	ld      r8, 0x38(r4)
	ld      r0, 0x40(r4)
	std     r9, 0x28(r6)
	std     r7, 0x30(r6)
	std     r8, 0x38(r6)
	std     r0, 0x40(r6)
	ld      r9, 0x48(r4)
	ld      r7, 0x50(r4)
	ld      r8, 0x58(r4)
	ld      r0, 0x60(r4)
	std     r9, 0x48(r6)
	std     r7, 0x50(r6)
	std     r8, 0x58(r6)
	std     r0, 0x60(r6)
	ld      r9, 0x68(r4)
	ld      r7, 0x70(r4)
	ld      r8, 0x78(r4)
	ldu     r0, 0x80(r4)
	std     r9, 0x68(r6)
	std     r7, 0x70(r6)
	std     r8, 0x78(r6)
	stdu    r0, 0x80(r6)

	bdnz    .Lloop

	sldi    r10,r10,2         	/* adjust from 128 to 32 byte stride */
	mtctr 	r10
.Lloop2: 				/* Copy aligned body */
	ld      r9, 0x08(r4)
	ld      r7, 0x10(r4)
	ld      r8, 0x18(r4)
	ldu     r0, 0x20(r4)
	std     r9, 0x08(r6)
	std     r7, 0x10(r6)
	std     r8, 0x18(r6)
	stdu    r0, 0x20(r6)

	bdnz    .Lloop2

.Lendloop2:
	blr
