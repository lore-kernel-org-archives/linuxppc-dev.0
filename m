Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18960C282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:43:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED3520844
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FdQMu+Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mJbj3k0bzDqDm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 23:43:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="FdQMu+Gx"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mJNv6RKXzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 23:34:07 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43mJNq3G21z9tyxv;
 Fri, 25 Jan 2019 13:34:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=FdQMu+Gx; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zYyVzXCXI4TW; Fri, 25 Jan 2019 13:34:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNq1qH4z9tyxr;
 Fri, 25 Jan 2019 13:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548419643; bh=81GkYVEDUTVX9JUB5EuRLjLcW9Rv+C33s0+G5fqVhSo=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=FdQMu+GxScN29CiBk2xnmZmhoCiJ6ZzvDEy9HprGQXz4/O+81vA9GNo7CfhujdmvU
 Xji37RT0ur76EdDU33ESkNdBsEayulevupGeWKV5TaUQ25aEer3ogMFU0w8PFdg2/w
 irAO95+PblOu9pbxqk4cYPdqLhy4c038FRdmKcik=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 870998B87A;
 Fri, 25 Jan 2019 13:34:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XSReQt1UChOd; Fri, 25 Jan 2019 13:34:04 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 60B1C8B761;
 Fri, 25 Jan 2019 13:34:04 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 550D072DA9; Fri, 25 Jan 2019 12:34:04 +0000 (UTC)
Message-Id: <a805b78bc4c7c24ee061d1578e7ff7bb2746e54a.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 02/10] powerpc/603: Store PGDIR physical address in a SPRG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 joakim.tjernlund@infinera.com
Date: Fri, 25 Jan 2019 12:34:04 +0000 (UTC)
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

Use SPRN_SPRG5 to store the current thread PGDIR and
avoid reading thread_struct->pgdir at every TLB miss.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h      |  1 +
 arch/powerpc/kernel/cpu_setup_6xx.S |  4 ++++
 arch/powerpc/kernel/head_32.S       | 28 ++++++++++++++++------------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c98ef1f2d5b..ba0ab1a1431b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1169,6 +1169,7 @@
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
 #define SPRN_SPRG_RTAS		SPRN_SPRG2
 #define SPRN_SPRG_603_LRU	SPRN_SPRG4
+#define SPRN_SPRG_603_PGDIR	SPRN_SPRG5
 #endif
 
 #ifdef CONFIG_40x
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 8c069e96c478..4c91d1f640fe 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -24,6 +24,10 @@ BEGIN_MMU_FTR_SECTION
 	li	r10,0
 	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
+	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_603_PGDIR, r10
+
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
 END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c2f564690778..dbd15e03952a 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -502,16 +502,15 @@ InstructionTLBMiss:
 	mfspr	r3,SPRN_IMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_603_PGDIR
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
@@ -576,16 +575,15 @@ DataLoadTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_603_PGDIR
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
@@ -660,16 +658,15 @@ DataStoreTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG_THREAD
+	mfspr	r2, SPRN_SPRG_603_PGDIR
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
@@ -1030,6 +1027,13 @@ _ENTRY(switch_mmu_context)
 	lis	r5, abatron_pteptrs@ha
 	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
+BEGIN_MMU_FTR_SECTION
+#ifndef CONFIG_BDI_SWITCH
+	lwz	r4, MM_PGD(r4)
+#endif
+	tophys(r4, r4)
+	mtspr	SPRN_SPRG_603_PGDIR, r4
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_HPTE_TABLE)
 	li	r4,0
 	isync
 3:
-- 
2.13.3

