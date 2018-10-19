Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D21ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:26:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC69921470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byCF2PDPzF3ZD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:26:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxWF66nKzF3Tp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxW95L2Vz9ttFh;
 Fri, 19 Oct 2018 08:55:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NRnhUreGqz5Q; Fri, 19 Oct 2018 08:55:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxW94pphz9ttFM;
 Fri, 19 Oct 2018 08:55:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CE8688B8DF;
 Fri, 19 Oct 2018 08:55:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2TLHKvheB0pR; Fri, 19 Oct 2018 08:55:18 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A94758B75B;
 Fri, 19 Oct 2018 08:55:18 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 75B8F6F496; Fri, 19 Oct 2018 06:55:18 +0000 (UTC)
Message-Id: <22d7505661571fc173ec4c9f916614612f56516f.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 13/20] powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB
 Miss handlers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:18 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch reworks the TLB Miss handler in order to not use r12
register, hence avoiding having to save it into SPRN_SPRG_SCRATCH2.

In the DAR Fixup code we can now use SPRN_M_TW, freeing
SPRN_SPRG_SCRATCH2.

Then SPRN_SPRG_SCRATCH2 may be used for something else in the future.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 110 ++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 50e97027b507..d69c6e3d5cc1 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -302,91 +302,88 @@ SystemCall:
  */
 
 #ifdef CONFIG_8xx_CPU15
-#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)	\
-	addi	tmp, addr, PAGE_SIZE;	\
-	tlbie	tmp;			\
-	addi	tmp, addr, -PAGE_SIZE;	\
-	tlbie	tmp
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)	\
+	addi	addr, addr, PAGE_SIZE;	\
+	tlbie	addr;			\
+	addi	addr, addr, -(PAGE_SIZE << 1);	\
+	tlbie	addr;			\
+	addi	addr, addr, PAGE_SIZE
 #else
-#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)
 #endif
 
 InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-#ifdef ITLB_MISS_KERNEL
-	mtspr	SPRN_SPRG_SCRATCH2, r12
 #endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
+	INVALIDATE_ADJACENT_PAGES_CPU15(r10)
 	mtspr	SPRN_MD_EPN, r10
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
 #ifdef ITLB_MISS_KERNEL
-	mfcr	r12
+	mfcr	r11
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
-	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
+	cmpi	cr0, r10, 0	/* Address >= 0x80000000 */
 #else
-	rlwinm	r11, r10, 16, 0xfff8
-	cmpli	cr0, r11, PAGE_OFFSET@h
+	rlwinm	r10, r10, 16, 0xfff8
+	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_TEXT
 	/* It is assumed that kernel code fits into the first 8M page */
-0:	cmpli	cr7, r11, (PAGE_OFFSET + 0x0800000)@h
+0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x0800000)@h
 	patch_site	0b, patch__itlbmiss_linmem_top
 #endif
 #endif
 #endif
-	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 #ifdef ITLB_MISS_KERNEL
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
-	beq+	3f
+	bge+	3f
 #else
 	blt+	3f
 #endif
 #ifndef CONFIG_PIN_TLB_TEXT
 	blt	cr7, ITLBMissLinear
 #endif
-	rlwinm	r11, r11, 0, 20, 31
-	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
+	rlwinm	r10, r10, 0, 20, 31
+	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
 #endif
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	lwz	r10, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
+	mtspr	SPRN_MI_TWC, r10	/* Set segment attributes */
 
-	mtspr	SPRN_MD_TWC, r11
+	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
 
 #ifdef ITLB_MISS_KERNEL
-	mtcr	r12
+	mtcr	r11
 #endif
-	/* Load the MI_TWC with the attributes for this "segment." */
-	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
-
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
-	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
 	 * Software indicator bits 22, 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	rlwimi	r11, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
-	rlwimi	r10, r11, 0, 0x0ff0	/* Set 22, 24-27, clear 20,23 */
+	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
+	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
+	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#ifdef ITLB_MISS_KERNEL
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
 	patch_site	0b, patch__itlbmiss_exit_1
@@ -397,9 +394,8 @@ InstructionTLBMiss:
 	addi	r10, r10, 1
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#ifdef ITLB_MISS_KERNEL
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
 #endif
@@ -408,40 +404,37 @@ InstructionTLBMiss:
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mtspr	SPRN_SPRG_SCRATCH2, r12
-	mfcr	r12
+	mfcr	r11
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r11, r10, 16, 0xfff8
-	cmpli	cr0, r11, PAGE_OFFSET@h
-	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
-	blt+	3f
-	rlwinm	r11, r10, 16, 0xfff8
+	rlwinm	r10, r10, 16, 0xfff8
+	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_IMMR
-	cmpli	cr0, r11, VIRT_IMMR_BASE@h
+	cmpli	cr6, r10, VIRT_IMMR_BASE@h
 #endif
-0:	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x1800000)@h
 	patch_site	0b, patch__dtlbmiss_linmem_top
+
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
+	blt+	3f
 #ifndef CONFIG_PIN_TLB_IMMR
-0:	beq-	DTLBMissIMMR
+0:	beq-	cr6, DTLBMissIMMR
 	patch_site	0b, patch__dtlbmiss_immr_jmp
 #endif
 	blt	cr7, DTLBMissLinear
-	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
-	rlwinm	r11, r11, 0, 20, 31
-	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
+	rlwinm	r10, r10, 0, 20, 31
+	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtcr	r11
+	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
 
 	mtspr	SPRN_MD_TWC, r11
 	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
 
-	mtcr	r12
-
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC (at least
 	 * I got that right :-).  It will be better when we can put
@@ -479,7 +472,6 @@ DataStoreTLBMiss:
 
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_1
 
@@ -490,7 +482,6 @@ DataStoreTLBMiss:
 	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 #endif
 
@@ -598,7 +589,7 @@ InstructionBreakpoint:
  * not enough space in the DataStoreTLBMiss area.
  */
 DTLBMissIMMR:
-	mtcr	r12
+	mtcr	r11
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	mtspr	SPRN_MD_TWC, r10
@@ -613,16 +604,15 @@ DTLBMissIMMR:
 
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_2
 
 DTLBMissLinear:
-	mtcr	r12
+	mtcr	r11
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
@@ -632,24 +622,22 @@ DTLBMissLinear:
 
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_3
 
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
-	mtcr	r12
+	mtcr	r11
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID
 	mtspr	SPRN_MI_TWC, r11
-	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 	patch_site	0b, patch__itlbmiss_exit_2
 #endif
@@ -661,7 +649,7 @@ ITLBMissLinear:
  /* define if you don't want to use self modifying code */
 #define NO_SELF_MODIFYING_CODE
 FixupDAR:/* Entry point for dcbx workaround. */
-	mtspr	SPRN_SPRG_SCRATCH2, r10
+	mtspr	SPRN_M_TW, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
 	mtspr	SPRN_MD_EPN, r10
@@ -706,7 +694,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	beq+	142f
 	cmpwi	cr0, r10, 1964	/* Is icbi? */
 	beq+	142f
-141:	mfspr	r10,SPRN_SPRG_SCRATCH2
+141:	mfspr	r10,SPRN_M_TW
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
 200:
@@ -741,7 +729,7 @@ modified_instr:
 	bne+	143f
 	subf	r10,r0,r10	/* r10=r10-r0, only if reg RA is r0 */
 143:	mtdar	r10		/* store faulting EA in DAR */
-	mfspr	r10,SPRN_SPRG_SCRATCH2
+	mfspr	r10,SPRN_M_TW
 	b	DARFixed	/* Go back to normal TLB handling */
 #else
 	mfctr	r10
@@ -795,7 +783,7 @@ modified_instr:
 	mfdar	r11
 	mtctr	r11			/* restore ctr reg from DAR */
 	mtdar	r10			/* save fault EA to DAR */
-	mfspr	r10,SPRN_SPRG_SCRATCH2
+	mfspr	r10,SPRN_M_TW
 	b	DARFixed		/* Go back to normal TLB handling */
 
 	/* special handling for r10,r11 since these are modified already */
-- 
2.13.3

