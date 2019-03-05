Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 21:28:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9EF2075B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 21:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LrQNcKDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9EF2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DVP636jSzDqHk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 08:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="LrQNcKDz"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DV9x1Lx3zDqCx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 08:18:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44DV9n0jtSz9v6LX;
 Tue,  5 Mar 2019 22:18:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=LrQNcKDz; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CNNeqwAp82rK; Tue,  5 Mar 2019 22:18:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44DV9m6kQFz9v6LR;
 Tue,  5 Mar 2019 22:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551820700; bh=XSZFAiXAvWAlQS1ejrFPi6x0pQ+Koy1bP3Glj4TzHRg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=LrQNcKDz4OpF6jTb53UFa30pqGKBz1qdxElrlbAPPb1xJDwcODE+xQ67fs834Sb1Y
 NnL3pxDRcK5KmweDSAEX8ApHvyepBQtZk4vF7N0wZdxJ/rWpVZozdntFD0Eyb7Hz+i
 9LnUDGQmp1TibkUSdQbpvtsCfL7qxROA6bXjdPXI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EE708B860;
 Tue,  5 Mar 2019 22:18:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ouNFNqaZUx8h; Tue,  5 Mar 2019 22:18:21 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DE7388B83A;
 Tue,  5 Mar 2019 22:18:20 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 558876F8CD; Tue,  5 Mar 2019 21:18:20 +0000 (UTC)
Message-Id: <06ad54973913c3768896d9a21556a9e6fbc02761.1551820475.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1551820474.git.christophe.leroy@c-s.fr>
References: <cover.1551820474.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc/book3s32: Prepare Kernel Userspace Access
 Protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Tue,  5 Mar 2019 21:18:20 +0000 (UTC)
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
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  4 ++++
 arch/powerpc/kernel/head_32.S                 | 28 ++++++++++++++++-----------
 arch/powerpc/mm/hash_low_32.S                 |  6 +++---
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 5cb588395fdc..82492dcfa81c 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -63,6 +63,10 @@ typedef pte_t *pgtable_t;
 #define PP_RWRW 2	/* Supervisor read/write, User read/write */
 #define PP_RXRX 3	/* Supervisor read,       User read */
 
+/* Values for Segment Registers */
+#define SR_KS	0x40000000	/* Supervisor key */
+#define SR_KP	0x20000000	/* User key */
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index ce6a972f2584..46b633514422 100644
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
@@ -897,14 +897,21 @@ load_up_mmu:
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SPRN_SDR1,r6
-	li	r0,16		/* load up segment register values */
+	li	r0, NUM_USER_SEGMENTS /* load up user segment register values */
 	mtctr	r0		/* for context 0 */
-	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
+	li	r3, 0		/* Kp = 0, Ks = 0, VSID = 0 */
 	li	r4,0
 3:	mtsrin	r3,r4
 	addi	r3,r3,0x111	/* increment VSID */
 	addis	r4,r4,0x1000	/* address of next segment */
 	bdnz	3b
+	li	r0, 16 - NUM_USER_SEGMENTS /* load up kernel segment registers */
+	mtctr	r0			/* for context 0 */
+	oris	r3, r3, SR_KP@h		/* Kp = 1 */
+3:	mtsrin	r3, r4
+	addi	r3, r3, 0x111	/* increment VSID */
+	addis	r4, r4, 0x1000	/* address of next segment */
+	bdnz	3b
 
 /* Load the BAT registers with the values set up by MMU_init.
    MMU_init takes care of whether we're on a 601 or not. */
@@ -1008,7 +1015,6 @@ _ENTRY(switch_mmu_context)
 	blt-	4f
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
-	addis	r3,r3,0x6000	/* Set Ks, Ku bits */
 	li	r0,NUM_USER_SEGMENTS
 	mtctr	r0
 
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1f13494efb2b..37964878e392 100644
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

