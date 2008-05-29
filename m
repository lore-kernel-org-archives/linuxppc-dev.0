Return-Path: <mohan@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 269E7DDF4F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 05:16:18 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TJGFPX003978
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:16:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TJGF5u142718
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:16:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TJGFhf017572
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:16:15 -0400
Date: Fri, 30 May 2008 00:46:12 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 3/4] Apply relocation info to vmlinux
Message-ID: <20080529191612.GC15762@in.ibm.com>
References: <20080529190809.GA15388@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080529190809.GA15388@in.ibm.com>
Cc: paulus@samba.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apply relocation info to vmlinux

This code is a wrapper around regular kernel. This checks whether the
kernel is loaded at 32MB, if its not loaded at 32MB, its treated as a
regular kernel and the control is given to the kernel immediately. If
the kernel is loaded at 32MB, it applies relocation delta to each offset
in the list which was generated and appended by patch 1 and 2. After
updating all offsets, control is given to relocatable kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
Index: linux-2.6.26-rc3/arch/powerpc/kernel/reloc_apply.S
===================================================================
--- /dev/null
+++ linux-2.6.26-rc3/arch/powerpc/kernel/reloc_apply.S
@@ -0,0 +1,223 @@
+#include <asm/ppc_asm.h>
+
+#define RELOC_DELTA 0x4000000002000000
+
+#define LOADADDR(rn,name) \
+	lis     rn,name##@highest;	\
+	ori     rn,rn,name##@higher;	\
+	rldicr  rn,rn,32,31;		\
+	oris    rn,rn,name##@h;		\
+	ori     rn,rn,name##@l
+
+/*
+ * Layout of vmlinux.reloc file
+ * 	Minimal part of relocation applying code +
+ *	vmlinux +
+ *	Rest of the relocation applying code
+ */
+
+.section .text.head
+
+.globl start_wrap
+start_wrap:
+	/* Get relocation offset in r15 */
+	bl	1f
+1:	mflr	r15
+	LOAD_REG_IMMEDIATE(r16,1b)
+	subf	r15,r16,r15
+
+	LOAD_REG_IMMEDIATE(r17, _reloc)
+	add	r17,r17,r15
+	mtctr	r17
+	bctr		/* Jump to start_reloc in section ".text.reloc" */
+
+/* Secondary cpus spin code */
+. = 0x60
+	/* Get relocation offset in r15 */
+	bl	1f
+1:	mflr	r15
+	LOAD_REG_IMMEDIATE(r16,1b)
+	subf	r15,r16,r15
+
+	LOADADDR(r18, __spinloop)
+	add	r18,r18,r15
+100:	ld	r19,0(r18)
+	cmpwi	0,r19,1
+	bne	100b
+
+	LOAD_REG_IMMEDIATE(r17, _reloc)
+	add	r17,r17,r15
+	addi	r17,r17,0x60
+	mtctr	r17
+	/* Jump to start_reloc + 0x60 in section ".text.reloc" */
+	bctr
+
+/*
+ * Layout of vmlinux.reloc file
+ * 	Minimal part of relocation applying code +
+ *	vmlinux +
+ *	Rest of the relocation applying code
+ */
+
+
+.section .text.reloc
+
+start_reloc:
+	b	master
+
+.org start_reloc + 0x60
+	LOADADDR(r18, __spinloop)
+	add	r18,r18,r15
+100:	ld	r19,0(r18)
+	cmpwi	0,r19,2
+	bne	100b
+
+	/* Now vmlinux is at _head */
+	LOAD_REG_IMMEDIATE(r17, _head)
+	add	r17,r17,r15
+	addi	r17,r17,0x60
+	mtctr	r17
+	bctr
+
+master:
+	LOAD_REG_IMMEDIATE(r16, output_len)
+	add	r16,r16,r15
+
+	/*
+	 * Load the delimiter to distinguish between different relocation
+	 * types
+	 */
+	LOAD_REG_IMMEDIATE(r24, __delimiter)
+	add	r24,r24,r15
+	ld	r24,0(r24)
+
+	LOAD_REG_IMMEDIATE(r17, _head)
+	LOAD_REG_IMMEDIATE(r21, _ehead)
+	sub	r21,r21,r17	/* Number of bytes in head section */
+
+	sub	r16,r16,r21	/* Original output_len */
+
+	/* Destination address */
+	LOAD_REG_IMMEDIATE(r17, _head) /* KERNELBASE */
+	add	r17,r17,r15
+
+	/* Source address */
+	LOAD_REG_IMMEDIATE(r18, _text) /* Regular vmlinux */
+	add	r18,r18,r15
+
+	/* Number of bytes to copy */
+	LOAD_REG_IMMEDIATE(r19, _etext)
+	add	r19,r19,r15
+	sub	r19,r19,r18
+
+	/* Move cpu spin code to "text.reloc" section */
+	LOADADDR(r23, __spinloop)
+	li	r25,1
+	stw	r25,0(r23)
+
+	/* Copy vmlinux code to physical address 0 */
+	bl	.copy	/* copy(_head, _text, _etext-_text) */
+
+	/*
+	 * If its nots running at 32MB, assume it to be a normal kernel.
+	 * Copy the vmlinux code to KERNELBASE and jump to KERNELBASE
+	 */
+	LOAD_REG_IMMEDIATE(r21, RELOC_DELTA)
+	cmpd	r15,r21
+	bne	skip_apply
+
+	/* Kernel is running at 32MB */
+	mr	r22,r15
+	xor	r23,r23,r23
+	addi	r23,r23,16
+	srw	r22,r22,r23
+
+	li	r25,0
+
+	LOAD_REG_IMMEDIATE(r26, _head)
+
+	/*
+	 * Start reading the relocation offset list from end of file
+	 * Based on the relocation type either add the relocation delta
+	 * or do logical ORing the relocation delta
+	 */
+3:
+	addi	r16,r16,-8
+	ld	r18,0(r16)
+	cmpdi	r18,0		/* Processed all offsets */
+	beq	4f		/* Start vmlinux */
+	/* Are we processing reloction type R_PPC64_ADDR16_HI */
+	cmpdi	r25,1
+	beq	rel_hi
+	cmpd	r18,r24
+	beq	set_rel_hi
+	/* Process 64bit absolute relocation update */
+rel_addr64:
+	add	r18,r18,r15
+	ld	r28,0(r18)
+	cmpdi	r28,0
+	beq	next
+	add	r28,r28,r15	/* add relocation offset */
+	add	r28,r28,r26	/* add KERNELBASE */
+	std	r28,0(r18)
+	b	next
+set_rel_hi:			/* Enable R_PPC64_ADDR16_HI flag */
+	addi	r25,r25,1
+	b	3b
+rel_hi:
+	add	r18,r18,r15
+	lhz	r28,0(r18)
+	or	r28,r28,r22
+	sth	r28,0(r18)
+next:
+	b	3b
+4:
+	mr	r6,r15
+
+
+skip_apply:
+	isync
+	sync
+
+	/* Now vmlinux is at _head */
+	LOAD_REG_IMMEDIATE(r17, _head)
+	add	r17,r17,r15
+	mtctr	r17
+
+	/* Move cpu spin code to "text.reloc" section */
+	LOADADDR(r23, __spinloop)
+	li	r25,2
+	stw	r25,0(r23)
+
+	bctr
+
+/* r17 destination, r18 source, r19 size */
+.copy:
+	addi	r19,r19,-8
+	li	r22,-8
+4:	li	r21,8			/* Use the smallest common	*/
+					/* denominator cache line	*/
+					/* size.  This results in	*/
+					/* extra cache line flushes	*/
+					/* but operation is correct.	*/
+					/* Can't get cache line size	*/
+					/* from NACA as it is being	*/
+					/* moved too.			*/
+
+	mtctr	r21			/* put # words/line in ctr	*/
+3:	addi	r22,r22,8		/* copy a cache line		*/
+	ldx	r21,r22,r18
+	stdx	r21,r22,r17
+	bdnz	3b
+	dcbst	r22,r17			/* write it to memory		*/
+	sync
+	icbi	r22,r17			/* flush the icache line	*/
+	cmpld	0,r22,r19
+	blt	4b
+	sync
+	blr
+
+__delimiter:
+	.llong 0xffffffffffffffff
+__spinloop:
+	.llong	0x0
