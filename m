Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C6C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:46:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1105E2085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hkT3Osgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1105E2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rkk00s3zDq64
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:46:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hkT3Osgd"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rXR3KtqzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:37:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444rXL67rLz9tylf;
 Thu, 21 Feb 2019 11:37:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=hkT3Osgd; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id phakU_ZkaBQA; Thu, 21 Feb 2019 11:37:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444rXL4k4fz9tylQ;
 Thu, 21 Feb 2019 11:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550745474; bh=IMmLAiWE/kGi3D2q5kYot9NClowu6oW90X7D5So0rZE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=hkT3OsgdgkF7maIHz6t8Vk4eAEr9AdPQG8O5DcZZvSFn79vlUgYAVEGjSJC0vst5+
 5cTZrMuwZy8z+TWs1aPcLzoeby0LaNvrtgiHmMCET9qHzs4F76sv0jjJIJIxC41fsP
 oXOMk4VMlVSq9EZOLkAyNbHbQIR6bg1zRSLi7ie8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C49A08B859;
 Thu, 21 Feb 2019 11:37:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7jT4ni4CVXj6; Thu, 21 Feb 2019 11:37:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F7F68B852;
 Thu, 21 Feb 2019 11:37:55 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 5777A6E856; Thu, 21 Feb 2019 10:37:55 +0000 (UTC)
Message-Id: <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/10] powerpc/6xx: Store PGDIR physical address in a SPRG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Feb 2019 10:37:55 +0000 (UTC)
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

Use SPRN_SPRG2 to store the current thread PGDIR and
avoid reading thread_struct.pgdir at every TLB miss.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h      |  1 +
 arch/powerpc/kernel/cpu_setup_6xx.S |  4 ++++
 arch/powerpc/kernel/head_32.S       | 25 ++++++++++++-------------
 arch/powerpc/mm/hash_low_32.S       |  3 +--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 371ef6e8248e..1f79e1d8fb0b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1167,6 +1167,7 @@
 #ifdef CONFIG_PPC_BOOK3S_32
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_PGDIR		SPRN_SPRG2
 #define SPRN_SPRG_603_LRU	SPRN_SPRG4
 #endif
 
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 8c069e96c478..6f1c11e0691f 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -24,6 +24,10 @@ BEGIN_MMU_FTR_SECTION
 	li	r10,0
 	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
+	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_PGDIR, r10
+
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
 END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 04128899a0a5..2b0a26f66115 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -500,16 +500,15 @@ InstructionTLBMiss:
 	mfspr	r3,SPRN_IMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_PGDIR
 	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
-	lwz	r2,PGDIR(r2)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-112:	tophys(r2,r2)
-	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+	tophys(r2,r2)
+112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
@@ -574,16 +573,15 @@ DataLoadTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_PGDIR
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
-	lwz	r2,PGDIR(r2)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-112:	tophys(r2,r2)
-	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+	tophys(r2,r2)
+112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
@@ -658,16 +656,15 @@ DataStoreTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_PGDIR
 	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
-	lwz	r2,PGDIR(r2)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-112:	tophys(r2,r2)
-	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+	tophys(r2,r2)
+112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
@@ -1024,14 +1021,16 @@ _ENTRY(switch_mmu_context)
 	li	r0,NUM_USER_SEGMENTS
 	mtctr	r0
 
+	lwz	r4, MM_PGD(r4)
 #ifdef CONFIG_BDI_SWITCH
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is passed as second argument.
 	 */
-	lwz	r4,MM_PGD(r4)
 	lis	r5, abatron_pteptrs@ha
 	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
+	tophys(r4, r4)
+	mtspr	SPRN_SPRG_PGDIR, r4
 	li	r4,0
 	isync
 3:
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1e2df3e9f9ea..82e7dd0c0220 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -70,9 +70,8 @@ _GLOBAL(hash_page)
 	/* Get PTE (linux-style) and check access */
 	lis	r0,KERNELBASE@h		/* check if kernel address */
 	cmplw	0,r4,r0
-	mfspr	r8,SPRN_SPRG_THREAD	/* current task's THREAD (phys) */
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
-	lwz	r5,PGDIR(r8)		/* virt page-table root */
+	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
 	blt+	112f			/* assume user more likely */
 	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
-- 
2.13.3

