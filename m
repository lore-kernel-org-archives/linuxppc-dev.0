Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47744C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:45:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A8D20657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KNcrWpx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A8D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hs9m33hmzDqFM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:45:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KNcrWpx/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HrsF2YSQzDqCl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrs46Kb9zB09b6;
 Mon, 11 Mar 2019 09:30:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KNcrWpx/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xZ6WnD4igb7U; Mon, 11 Mar 2019 09:30:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrs458GkzB09ZD;
 Mon, 11 Mar 2019 09:30:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293032; bh=bzb7tbtz58KcKGXVz0npIEZ2YqE0AYxi6XnTc8LXFYA=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=KNcrWpx/lpuhI1tvFDqEBxNyw6NlQnVyPehJHWZOhG5MxNzDlQTwqW3Uqq8glYNnb
 QhhUCgkgK366yxHjmaHynDVIOQDQElm9pqaV6lPDnFahCL2G3KRLPGifFljpRUr5YS
 loWJJxJJWu4OK/5auVA5U8MMgxe/Di0V9Lg1W4OA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 406BA8B813;
 Mon, 11 Mar 2019 09:30:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mHb2pQUqJf8i; Mon, 11 Mar 2019 09:30:37 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1623D8B7FE;
 Mon, 11 Mar 2019 09:30:37 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F3F646FA08; Mon, 11 Mar 2019 08:30:36 +0000 (UTC)
Message-Id: <683fa04df77339ae76dd86faba9883771da2b127.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/10] powerpc/32s: Prepare Kernel Userspace Access
 Protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Mon, 11 Mar 2019 08:30:36 +0000 (UTC)
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

This patch prepares Kernel Userspace Access Protection for
book3s/32.

Due to limitations of the processor page protection capabilities,
the protection is only against writing. read protection cannot be
achieved using page protection.

book3s/32 provides the following values for PP bits:

PP00 provides RW for Key 0 and NA for Key 1
PP01 provides RW for Key 0 and RO for Key 1
PP10 provides RW for all
PP11 provides RO for all

Today PP10 is used for RW pages and PP11 for RO pages, and user
segment register's Kp and Ks are set to 1. This patch modifies
page protection to use PP01 for RW pages and sets user segment
registers to Kp 0 and Ks 0.

This will allow to setup Userspace write access protection by
settng Ks to 1 in the following patch.

Kernel space segment registers remain unchanged.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
 arch/powerpc/kernel/head_32.S                 | 22 +++++++++++-----------
 arch/powerpc/mm/hash_low_32.S                 |  6 +++---
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 8c5727a322b1..f9eae105a9f4 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -65,6 +65,8 @@ typedef pte_t *pgtable_t;
 
 /* Values for Segment Registers */
 #define SR_NX	0x10000000	/* No Execute */
+#define SR_KP	0x20000000	/* User key */
+#define SR_KS	0x40000000	/* Supervisor key */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 5e792f2634fc..dfc1a68fc647 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -522,9 +522,9 @@ InstructionTLBMiss:
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
-	ori	r1, r1, 0xe05		/* clear out reserved bits */
-	andc	r1, r0, r1		/* PP = user? 2 : 0 */
+	rlwimi	r0,r0,32-2,31,31	/* _PAGE_USER -> PP lsb */
+	ori	r1, r1, 0xe06		/* clear out reserved bits */
+	andc	r1, r0, r1		/* PP = user? 1 : 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
@@ -590,11 +590,11 @@ DataLoadTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
+	rlwinm	r1,r0,32-9,30,30	/* _PAGE_RW -> PP msb */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
-	andc	r1,r0,r1		/* PP = user? rw? 2: 3: 0 */
+	andc	r1,r0,r1		/* PP = user? rw? 1: 3: 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
@@ -670,9 +670,9 @@ DataStoreTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
-	li	r1,0xe05		/* clear out reserved bits & PP lsb */
-	andc	r1,r0,r1		/* PP = user? 2: 0 */
+	rlwimi	r0,r0,32-2,31,31	/* _PAGE_USER -> PP lsb */
+	li	r1,0xe06		/* clear out reserved bits & PP msb */
+	andc	r1,r0,r1		/* PP = user? 1: 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
@@ -900,9 +900,9 @@ load_up_mmu:
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SPRN_SDR1,r6
-	li	r0, NUM_USER_SEGMENTS	/* load up segment register values */
+	li	r0, NUM_USER_SEGMENTS /* load up user segment register values */
 	mtctr	r0		/* for context 0 */
-	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
+	li	r3, 0		/* Kp = 0, Ks = 0, VSID = 0 */
 #ifdef CONFIG_PPC_KUEP
 	oris	r3, r3, SR_NX@h	/* Set Nx */
 #endif
@@ -914,6 +914,7 @@ load_up_mmu:
 	li	r0, 16 - NUM_USER_SEGMENTS /* load up kernel segment registers */
 	mtctr	r0			/* for context 0 */
 	rlwinm	r3, r3, 0, ~SR_NX	/* Nx = 0 */
+	oris	r3, r3, SR_KP@h		/* Kp = 1 */
 3:	mtsrin	r3, r4
 	addi	r3, r3, 0x111	/* increment VSID */
 	addis	r4, r4, 0x1000	/* address of next segment */
@@ -1024,7 +1025,6 @@ _ENTRY(switch_mmu_context)
 	blt-	4f
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
-	addis	r3,r3,0x6000	/* Set Ks, Ku bits */
 #ifdef CONFIG_PPC_KUEP
 	oris	r3, r3, SR_NX@h	/* Set Nx */
 #endif
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index a6c491f18a04..e27792d0b744 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -309,13 +309,13 @@ Hash_msk = (((1 << Hash_bits) - 1) * 64)
 
 _GLOBAL(create_hpte)
 	/* Convert linux-style PTE (r5) to low word of PPC-style PTE (r8) */
-	rlwinm	r8,r5,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwinm	r0,r5,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
+	rlwinm	r8,r5,32-9,30,30	/* _PAGE_RW -> PP msb */
+	rlwinm	r0,r5,32-6,30,30	/* _PAGE_DIRTY -> PP msb */
 	and	r8,r8,r0		/* writable if _RW & _DIRTY */
 	rlwimi	r5,r5,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r8,r8,0xe04		/* clear out reserved bits */
-	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
+	andc	r8,r5,r8		/* PP = user? (rw&dirty? 1: 3): 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r8,r8,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
-- 
2.13.3

