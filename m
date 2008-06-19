Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Subject: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
Date: Thu, 19 Jun 2008 17:53:59 +1000
MIME-Version: 1.0
Message-Id: <200806191753.59599.markn@au1.ibm.com>
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
 * __copy_tofrom_user routine optimized for CELL-BE-PPC
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
 *
 */

#include <asm/processor.h>
#include <asm/ppc_asm.h>

#define PREFETCH_AHEAD 6
#define ZERO_AHEAD 4

        .align  7
_GLOBAL(__copy_tofrom_user)
	dcbt	0,r4		/* Prefetch ONE SRC cacheline */

	std     r5,-8(r1)	/* remember size */

	cmpldi	cr1,r5,16	/* is size < 16 ? */
	mr	r6,r3
	blt+	cr1,.Lshortcopy

.Lbigcopy:
	neg	r8,r3		/* LS 3 bits = # bytes to 8-byte dest bdry */
        clrldi  r8,r8,64-4	/* aling to 16byte boundary */
	sub     r7,r4,r3
	cmpldi	cr0,r8,0
	beq+	.Ldst_aligned

.Ldst_unaligned:
	mtcrf	0x01,r8		/* put #bytes to boundary into cr7 */
	subf	r5,r8,r5

	bf	cr7*4+3,1f
20:	lbzx	r0,r7,r6	/* copy 1 byte */
60:	stb	r0,0(r6)
	addi	r6,r6,1
1:	bf	cr7*4+2,2f
21:	lhzx	r0,r7,r6	/* copy 2 byte */
61:	sth	r0,0(r6)
	addi	r6,r6,2
2:	bf	cr7*4+1,4f
22:	lwzx	r0,r7,r6	/* copy 4 byte */
62:	stw	r0,0(r6)
	addi	r6,r6,4
4:	bf	cr7*4+0,8f
23:	ldx	r0,r7,r6	/* copy 8 byte */
63:	std	r0,0(r6)
	addi	r6,r6,8
8:
	add	r4,r7,r6

.Ldst_aligned:

	cmpdi	cr5,r5,128-1

	neg	r7,r6
	addi	r6,r6,-8	/* prepare for stdu */
	addi	r4,r4,-8	/* prepare for ldu */

	clrldi  r7,r7,64-7	/* align to cacheline boundary */
	ble+	cr5,.Llessthancacheline


	cmpldi	cr6,r7,0
	subf	r5,r7,r5
	srdi	r7,r7,4		/* divide size by 16 */
	srdi	r10,r5,7	/* number of cache lines to copy */


	cmpldi	r10,0
	li	r11,0			/* number cachelines to copy with prefetch */
	beq	.Lnocacheprefetch

	cmpldi	r10,PREFETCH_AHEAD
	li	r12,128+8		/* prefetch distance*/
	ble	.Llessthanmaxprefetch

	subi	r11,r10,PREFETCH_AHEAD
	li	r10,PREFETCH_AHEAD
.Llessthanmaxprefetch:

	mtctr	r10
.LprefetchSRC:
	dcbt    r12,r4
        addi    r12,r12,128
        bdnz    .LprefetchSRC
.Lnocacheprefetch:


	mtctr	r7
	cmpldi	cr1,r5,128
	clrldi  r5,r5,64-7

	beq	cr6,.Lcachelinealigned	/* 	*/
.Laligntocacheline:
24:	ld 	r9,0x08(r4)
25:	ldu	r7,0x10(r4)
64:	std	r9,0x08(r6)
65:	stdu	r7,0x10(r6)
	bdnz	.Laligntocacheline


.Lcachelinealigned:				/* copy while cache lines */


	blt- 	cr1,.Llessthancacheline		/* size <128 */

.Louterloop:
        cmpdi   r11,0
	mtctr	r11
	beq-	.Lendloop

	li	r11,128*ZERO_AHEAD +8		/* DCBZ dist */

.align	4
	/* Copy whole cachelines, optimized by prefetching SRC cacheline */
.Lloop: 				/* Copy aligned body */
	dcbt    r12,r4			/* PREFETCH SOURCE cache lines ahead*/
26:	ld      r9, 0x08(r4)
4000:	dcbz	r11,r6
27:	ld      r7, 0x10(r4)    	/* 4 register stride copy */
28:	ld      r8, 0x18(r4)		/* 4 are optimal to hide 1st level cache lantency*/
29:	ld      r0, 0x20(r4)
66:	std     r9, 0x08(r6)
67:	std     r7, 0x10(r6)
68:	std     r8, 0x18(r6)
69:	std     r0, 0x20(r6)
30:	ld      r9, 0x28(r4)
31:	ld      r7, 0x30(r4)
32:	ld      r8, 0x38(r4)
33:	ld      r0, 0x40(r4)
70:	std     r9, 0x28(r6)
71:	std     r7, 0x30(r6)
72:	std     r8, 0x38(r6)
73:	std     r0, 0x40(r6)
34:	ld      r9, 0x48(r4)
35:	ld      r7, 0x50(r4)
36:	ld      r8, 0x58(r4)
37:	ld      r0, 0x60(r4)
74:	std     r9, 0x48(r6)
75:	std     r7, 0x50(r6)
76:	std     r8, 0x58(r6)
77:	std     r0, 0x60(r6)
38:	ld      r9, 0x68(r4)
39:	ld      r7, 0x70(r4)
40:	ld      r8, 0x78(r4)
41:	ldu     r0, 0x80(r4)
78:	std     r9, 0x68(r6)
79:	std     r7, 0x70(r6)
80:	std     r8, 0x78(r6)
81:	stdu    r0, 0x80(r6)

	bdnz    .Lloop
.Lendloop:


        cmpdi   r10,0
	sldi    r10,r10,2         	/* adjust from 128 to 32 byte stride */
        beq-     .Lendloop2
        mtctr 	r10
.Lloop2: 				/* Copy aligned body */
42:	ld      r9, 0x08(r4)
43:	ld      r7, 0x10(r4)
44:	ld      r8, 0x18(r4)
45:	ldu     r0, 0x20(r4)
82:	std     r9, 0x08(r6)
83:	std     r7, 0x10(r6)
84:	std     r8, 0x18(r6)
85:	stdu    r0, 0x20(r6)

	bdnz    .Lloop2

.Lendloop2:


.Llessthancacheline:		/* less than cache to do ? */
	cmpldi	cr0,r5,16
	srdi	r7,r5,4		/* divide size by 16 */
        blt-    .Ldo_lt16
	mtctr	r7
.Lcopy_remaining:
46:	ld 	r8,0x08(r4)
47:	ldu	r7,0x10(r4)
86:	std	r8,0x08(r6)
87:	stdu	r7,0x10(r6)
	bdnz	.Lcopy_remaining


.Ldo_lt16:			/* less than 16 ? */
	cmpldi	cr0,r5,0	/* copy remaining bytes (0-15) */
	beq	sp1		/* no rest to copy */
	addi	r4,r4,8
	addi	r6,r6,8
.Lshortcopy:			/* SIMPLE COPY to handle size =< 15 bytes */
	mtcrf	0x01,r5
	sub     r7,r4,r6
	bf-	cr7*4+0,sp8
48:	ldx	r0,r7,r6	/* copy 8 byte */
88:	std	r0,0(r6)
	addi	r6,r6,8
sp8:
	bf	cr7*4+1,sp4
49:	lwzx	r0,r7,r6	/* copy 4 byte */
89:	stw	r0,0(r6)
	addi	r6,r6,4
sp4:
	bf	cr7*4+2,sp2
50:	lhzx	r0,r7,r6	/* copy 2 byte */
90:	sth	r0,0(r6)
	addi	r6,r6,2
sp2:
	bf	cr7*4+3,sp1
51:	lbzx	r0,r7,r6	/* copy 1 byte */
91:	stb	r0,0(r6)
sp1:
	li	r3,0
	blr




/*
 * exception handlers follow
 * we have to return the number of bytes not copied
 * for an exception on a load, we set the rest of the destination to 0
 */

151:
150:
149:
148:
	add	r4,r7,r6
	b	1002f

123:
122:
121:
	add	r4,r7,r6
	add	r5,r8,r5	/* original size is r5 + r8, no need to go to stack */
	b	1001f

120:
	add	r5,r8,r5	/* original size is r5 + r8, no need to go to stack */
	b	1003f		/* we know we can't copy any more bytes so jump to clring */

141:
140:
139:
138:
	addi	r6,r6,32
	addi	r4,r4,32
137:
136:
135:
134:
	addi	r6,r6,32
	addi	r4,r4,32
133:
132:
131:
130:
	addi	r6,r6,32
	addi	r4,r4,32
4100:
147:
146:
145:
144:
143:
142:
129:
128:
127:
126:
125:
124:
	addi	r6,r6,8
	addi	r4,r4,8

/*
 * we had a fault on a load
 * r6 - first unmodified byte of the destination
 * r3 - original destination
 * r4 - next byte we have to read for a load
 */

1002:	ld	r5,-8(r1)
1001:	subf	r3,r3,r6	/* number of bytes we did copy */
	subf	r5,r3,r5	/* #bytes left to go */

/*
 * first see if we can copy any more bytes before hitting another exception
 */
	mtctr	r5
52:	lbz	r0,0(r4)
	addi	r4,r4,1
92:	stb	r0,0(r6)
	addi	r6,r6,1
	bdnz	52b
	li	r3,0		/* huh? all copied successfully this time? */
	blr

/*
 * here we have trapped again, need to clear ctr bytes starting at r6
 */
152:	mfctr	r5
1003:	li	r0,0
	mr	r4,r6
	mr	r3,r5		/* return the number of bytes not copied */
1:	andi.	r9,r4,7
	beq	3f
93:	stb	r0,0(r4)
	addic.	r5,r5,-1
	addi	r4,r4,1
	bne	1b
	blr
3:	cmpldi	cr1,r5,8
	srdi	r9,r5,3
	andi.	r5,r5,7
	blt	cr1,1000f
	mtctr	r9
94:	std	r0,0(r4)
	addi	r4,r4,8
	bdnz	94b
1000:	beqlr
	mtctr	r5	
95:	stb	r0,0(r4)
	addi	r4,r4,1
	bdnz	95b
	blr



/*
 * we had a fault on a store
 * r6 - byte we tried to store to
 * r3 - original destination
 */
181:
	addi	r6,r6,8
180:
	addi	r6,r6,8
179:
	addi	r6,r6,8
178:
	addi	r6,r6,8
177:
	addi	r6,r6,8
176:
	addi	r6,r6,8
175:
	addi	r6,r6,8
174:
	addi	r6,r6,8
173:
	addi	r6,r6,8
172:
	addi	r6,r6,8
171:
	addi	r6,r6,8
170:
	addi	r6,r6,8
185:
169:
	addi	r6,r6,8
184:
168:
	addi	r6,r6,8
187:
183:
167:
165:
	addi	r6,r6,8
186:
182:
166:
164:
	addi	r6,r6,8
191:
190:
189:
188:
163:
162:
161:
160:
	ld	r5,-8(r1)
	subf	r3,r3,r6	/* number of bytes we did copy */
	subf	r3,r3,r5
195:
194:
193:
	blr			/* #bytes not copied in r3 */

192:
	mfctr	r3
	blr


	.section __ex_table,"a"
	.align	3
	.llong	20b,120b
	.llong	60b,160b
	.llong	21b,121b
	.llong	61b,161b
	.llong	22b,122b
	.llong	62b,162b
	.llong	23b,123b
	.llong	63b,163b
	.llong	24b,124b
	.llong	25b,125b
	.llong	64b,164b
	.llong	65b,165b
	.llong	26b,126b
	.llong	27b,127b
	.llong	28b,128b
	.llong	29b,129b
	.llong	66b,166b
	.llong	67b,167b
	.llong	68b,168b
	.llong	69b,169b
	.llong	30b,130b
	.llong	31b,131b
	.llong	32b,132b
	.llong	33b,133b
	.llong	70b,170b
	.llong	71b,171b
	.llong	72b,172b
	.llong	73b,173b
	.llong	34b,134b
	.llong	35b,135b
	.llong	36b,136b
	.llong	37b,137b
	.llong	74b,174b
	.llong	75b,175b
	.llong	76b,176b
	.llong	77b,177b
	.llong	38b,138b
	.llong	39b,139b
	.llong	40b,140b
	.llong	41b,141b
	.llong	78b,178b
	.llong	79b,179b
	.llong	80b,180b
	.llong	81b,181b
	.llong	42b,142b
	.llong	43b,143b
	.llong	44b,144b
	.llong	45b,145b
	.llong	82b,182b
	.llong	83b,183b
	.llong	84b,184b
	.llong	85b,185b
	.llong	46b,146b
	.llong	47b,147b
	.llong	86b,186b
	.llong	87b,187b
	.llong	48b,148b
	.llong	88b,188b
	.llong	49b,149b
	.llong	89b,189b
	.llong	50b,150b
	.llong	90b,190b
	.llong	51b,151b
	.llong	91b,191b
	.llong	52b,152b
	.llong	92b,192b
	.llong	93b,193b
	.llong	94b,194b
	.llong	95b,195b
        .llong  4000b,4100b
