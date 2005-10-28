Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0CB468621
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 07:43:04 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DE2261B53D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 23:42:59 +0200 (CEST)
Date: Fri, 28 Oct 2005 23:42:59 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051028214258.GA30726@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: memcpy for unaligned memory regions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The vmlinux.coff is constantly crashing for me, depending on the size
and location of the vmlinux.gz and the ramdisk. The 601 can not handle
unaligned memory access that cross a page boundary (or whatever).
So I tweaked the memcpy.S from arch/ppc64/boot to deal with this. 
Does this look ok?


	.globl	memmove
memmove:
	cmpwi	0,r5,0
	beqlr
	cmplw	0,r3,r4
	bgt	backwards_memcpy
	/* fall through */

	.globl	memcpy
memcpy:
	cmpwi	0,r5,0
	beqlr
	andi.	r0,r4,3			/* get src word aligned */
	beq	20f
10:	subfic	r0,r0,4
	cmpd	r0,r5
	blt	11f
	mr	r0,r5
11:	mtctr	r0
12:	lbz	r7,0(r4)
	stb	r7,0(r3)
	addi	r4,r4,1
	addi	r3,r3,1
	bdnz	12b
	subf.	r5,r0,r5
	beqlr
20:	andi.	r0,r3,3			/* get dest word aligned */
	beq	30f
	subfic	r0,r0,4
	cmpd	r0,r5
	blt	21f
	mr	r0,r5
21:	mtctr	r0
22:	lbz	r7,0(r4)
	stb	r7,0(r3)
	addi	r4,r4,1
	addi	r3,r3,1
	bdnz	22b
	subf.	r5,r0,r5
	beqlr
	andi.	r0,r4,3			/* get src word aligned */
	bne	10b
30:
	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
	addi	r6,r3,-4
	addi	r4,r4,-4
	beq	32f			/* if less than 8 bytes to do */
	mtctr	r7
31:	lwz	r7,4(r4)
	lwzu	r8,8(r4)
	stw	r7,4(r6)
	stwu	r8,8(r6)
	bdnz	31b
	andi.	r5,r5,7
32:	cmplwi	0,r5,4
	blt	33f
	lwzu	r0,4(r4)
	addi	r5,r5,-4
	stwu	r0,4(r6)
33:	cmpwi	0,r5,0
	beqlr
	mtctr	r5
	addi	r4,r4,3
	addi	r6,r6,3
34:	lbzu	r0,1(r4)
	stbu	r0,1(r6)
	bdnz	34b
	blr

	.globl	backwards_memcpy
backwards_memcpy:
	add	r6,r3,r5
	add	r4,r4,r5

	andi.	r0,r4,3			/* get src word aligned */
	beq	20f
10:	cmpd	r0,r5
	blt	11f
	mr	r0,r5
11:	mtctr	r0
12:	lbzu	r7,-1(r4)
	stbu	r7,-1(r6)
	bdnz	12b
	subf.	r5,r0,r5
	beqlr
20:	andi.	r0,r6,3			/* get dest word aligned */
	beq	30f
	cmpd	r0,r5
	blt	21f
	mr	r0,r5
21:	mtctr	r0
22:	lbzu	r7,-1(r4)
	stbu	r7,-1(r6)
	bdnz	22b
	subf.	r5,r0,r5
	beqlr
	andi.	r0,r4,3			/* get src word aligned */
	bne	10b
30:
	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
	beq	32f
	mtctr	r7
31:	lwz	r7,-4(r4)
	lwzu	r8,-8(r4)
	stw	r7,-4(r6)
	stwu	r8,-8(r6)
	bdnz	31b
	andi.	r5,r5,7
32:	cmplwi	0,r5,4
	blt	33f
	lwzu	r0,-4(r4)
	subi	r5,r5,4
	stwu	r0,-4(r6)
33:	cmpwi	0,r5,0
	beqlr
	mtctr	r5
34:	lbzu	r0,-1(r4)
	stbu	r0,-1(r6)
	bdnz	34b
	blr

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
