Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:52:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BEA2085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qlhfEdym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BEA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rry3gRszDqNf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:52:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="qlhfEdym"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rXT1TydzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:38:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444rXN6fmZz9tylh;
 Thu, 21 Feb 2019 11:37:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=qlhfEdym; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CXXuWGMnqPVA; Thu, 21 Feb 2019 11:37:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444rXN5Yp4z9tylQ;
 Thu, 21 Feb 2019 11:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550745476; bh=UeHkTRfqYRLixgHy6BuAzstdksYL6TNrbkkuMKgFKb8=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=qlhfEdymCzwD4TR06dhzm2yTrq+1ZKaPgJQ9TQA3OA3X6ORH+gnkcVCZ+my/W1D8G
 pNgHxbsylf6LoYwqUQJNqjnwEN65gP4jFmDbaLk6rnAgHVkyMrftRn2E7LwGAQIbOL
 AOi043Ij5q310OmIYE8iM/P60imJ0tDT/JTUaUxY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D26F08B852;
 Thu, 21 Feb 2019 11:37:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RjL3ZaVABooj; Thu, 21 Feb 2019 11:37:57 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DD0B8B859;
 Thu, 21 Feb 2019 11:37:57 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 62D856E856; Thu, 21 Feb 2019 10:37:57 +0000 (UTC)
Message-Id: <d64b402fecd5088ce8ea607bb654c6226cf99c35.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/10] powerpc/hash32: use physical address directly in
 hash handlers.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Feb 2019 10:37:57 +0000 (UTC)
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

Since commit c62ce9ef97ba ("powerpc: remove remaining bits from
CONFIG_APUS"), tophys() has become a pure constant operation.
PAGE_OFFSET is known at compile time so the physical address
can be builtin directly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hash_low_32.S | 62 +++++++++++++++++++------------------------
 arch/powerpc/mm/ppc_mmu_32.c  |  6 +++--
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 82e7dd0c0220..d94fef524ef5 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -47,14 +47,13 @@ mmu_hash_lock:
  * Returns to the caller if the access is illegal or there is no
  * mapping for the address.  Otherwise it places an appropriate PTE
  * in the hash table and returns from the exception.
- * Uses r0, r3 - r8, r10, ctr, lr.
+ * Uses r0, r3 - r6, r8, r10, ctr, lr.
  */
 	.text
 _GLOBAL(hash_page)
-	tophys(r7,0)			/* gets -KERNELBASE into r7 */
 #ifdef CONFIG_SMP
-	addis	r8,r7,mmu_hash_lock@h
-	ori	r8,r8,mmu_hash_lock@l
+	lis	r8, (mmu_hash_lock - PAGE_OFFSET)@h
+	ori	r8, r8, (mmu_hash_lock - PAGE_OFFSET)@l
 	lis	r0,0x0fff
 	b	10f
 11:	lwz	r6,0(r8)
@@ -76,7 +75,7 @@ _GLOBAL(hash_page)
 	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
-112:	add	r5,r5,r7		/* convert to phys addr */
+112:	tophys(r5, r5)
 #ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
 	lwz	r8,0(r5)		/* get pmd entry */
@@ -143,25 +142,24 @@ retry:
 
 #ifdef CONFIG_SMP
 	eieio
-	addis	r8,r7,mmu_hash_lock@ha
+	lis	r8, (mmu_hash_lock - PAGE_OFFSET)@ha
 	li	r0,0
-	stw	r0,mmu_hash_lock@l(r8)
+	stw	r0, (mmu_hash_lock - PAGE_OFFSET)@l(r8)
 #endif
 
 	/* Return from the exception */
 	lwz	r5,_CTR(r11)
 	mtctr	r5
 	lwz	r0,GPR0(r11)
-	lwz	r7,GPR7(r11)
 	lwz	r8,GPR8(r11)
 	b	fast_exception_return
 
 #ifdef CONFIG_SMP
 hash_page_out:
 	eieio
-	addis	r8,r7,mmu_hash_lock@ha
+	lis	r8, (mmu_hash_lock - PAGE_OFFSET)@ha
 	li	r0,0
-	stw	r0,mmu_hash_lock@l(r8)
+	stw	r0, (mmu_hash_lock - PAGE_OFFSET)@l(r8)
 	blr
 #endif /* CONFIG_SMP */
 
@@ -207,11 +205,9 @@ _GLOBAL(add_hash_page)
 	SYNC_601
 	isync
 
-	tophys(r7,0)
-
 #ifdef CONFIG_SMP
-	addis	r6,r7,mmu_hash_lock@ha
-	addi	r6,r6,mmu_hash_lock@l
+	lis	r6, (mmu_hash_lock - PAGE_OFFSET)@ha
+	addi	r6, r6, (mmu_hash_lock - PAGE_OFFSET)@l
 10:	lwarx	r0,0,r6			/* take the mmu_hash_lock */
 	cmpi	0,r0,0
 	bne-	11f
@@ -256,8 +252,8 @@ _GLOBAL(add_hash_page)
 
 9:
 #ifdef CONFIG_SMP
-	addis	r6,r7,mmu_hash_lock@ha
-	addi	r6,r6,mmu_hash_lock@l
+	lis	r6, (mmu_hash_lock - PAGE_OFFSET)@ha
+	addi	r6, r6, (mmu_hash_lock - PAGE_OFFSET)@l
 	eieio
 	li	r0,0
 	stw	r0,0(r6)		/* clear mmu_hash_lock */
@@ -277,10 +273,8 @@ _GLOBAL(add_hash_page)
  * It is designed to be called with the MMU either on or off.
  * r3 contains the VSID, r4 contains the virtual address,
  * r5 contains the linux PTE, r6 contains the old value of the
- * linux PTE (before setting _PAGE_HASHPTE) and r7 contains the
- * offset to be added to addresses (0 if the MMU is on,
- * -KERNELBASE if it is off).  r10 contains the upper half of
- * the PTE if CONFIG_PTE_64BIT.
+ * linux PTE (before setting _PAGE_HASHPTE). r10 contains the
+ * upper half of the PTE if CONFIG_PTE_64BIT.
  * On SMP, the caller should have the mmu_hash_lock held.
  * We assume that the caller has (or will) set the _PAGE_HASHPTE
  * bit in the linux PTE in memory.  The value passed in r6 should
@@ -341,7 +335,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	patch_site	1f, patch__hash_page_A1
 	patch_site	2f, patch__hash_page_A2
 	/* Get the address of the primary PTE group in the hash table (r3) */
-0:	addis	r0,r7,Hash_base@h	/* base address of hash table */
+0:	lis	r0, (Hash_base - PAGE_OFFSET)@h	/* base address of hash table */
 1:	rlwimi	r0,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
 2:	rlwinm	r3,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
 	xor	r3,r3,r0		/* make primary hash */
@@ -355,10 +349,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	beq+	10f			/* no PTE: go look for an empty slot */
 	tlbie	r4
 
-	addis	r4,r7,htab_hash_searches@ha
-	lwz	r6,htab_hash_searches@l(r4)
+	lis	r4, (htab_hash_searches - PAGE_OFFSET)@ha
+	lwz	r6, (htab_hash_searches - PAGE_OFFSET)@l(r4)
 	addi	r6,r6,1			/* count how many searches we do */
-	stw	r6,htab_hash_searches@l(r4)
+	stw	r6, (htab_hash_searches - PAGE_OFFSET)@l(r4)
 
 	/* Search the primary PTEG for a PTE whose 1st (d)word matches r5 */
 	mtctr	r0
@@ -390,10 +384,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	beq+	found_empty
 
 	/* update counter of times that the primary PTEG is full */
-	addis	r4,r7,primary_pteg_full@ha
-	lwz	r6,primary_pteg_full@l(r4)
+	lis	r4, (primary_pteg_full - PAGE_OFFSET)@ha
+	lwz	r6, (primary_pteg_full - PAGE_OFFSET)@l(r4)
 	addi	r6,r6,1
-	stw	r6,primary_pteg_full@l(r4)
+	stw	r6, (primary_pteg_full - PAGE_OFFSET)@l(r4)
 
 	patch_site	0f, patch__hash_page_C
 	/* Search the secondary PTEG for an empty slot */
@@ -427,8 +421,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	 * lockup here but that shouldn't happen
 	 */
 
-1:	addis	r4,r7,next_slot@ha		/* get next evict slot */
-	lwz	r6,next_slot@l(r4)
+1:	lis	r4, (next_slot - PAGE_OFFSET)@ha	/* get next evict slot */
+	lwz	r6, (next_slot - PAGE_OFFSET)@l(r4)
 	addi	r6,r6,HPTE_SIZE			/* search for candidate */
 	andi.	r6,r6,7*HPTE_SIZE
 	stw	r6,next_slot@l(r4)
@@ -500,8 +494,6 @@ htab_hash_searches:
  * We assume that there is a hash table in use (Hash != 0).
  */
 _GLOBAL(flush_hash_pages)
-	tophys(r7,0)
-
 	/*
 	 * We disable interrupts here, even on UP, because we want
 	 * the _PAGE_HASHPTE bit to be a reliable indication of
@@ -546,10 +538,10 @@ _GLOBAL(flush_hash_pages)
 	SET_V(r11)			/* set V (valid) bit */
 
 #ifdef CONFIG_SMP
-	addis	r9,r7,mmu_hash_lock@ha
-	addi	r9,r9,mmu_hash_lock@l
+	lis	r9, (mmu_hash_lock - PAGE_OFFSET)@ha
+	addi	r9, r9, (mmu_hash_lock - PAGE_OFFSET)@l
 	CURRENT_THREAD_INFO(r8, r1)
-	add	r8,r8,r7
+	tophys(r8, r8)
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,9
 10:	lwarx	r0,0,r9
@@ -583,7 +575,7 @@ _GLOBAL(flush_hash_pages)
 	patch_site	1f, patch__flush_hash_A1
 	patch_site	2f, patch__flush_hash_A2
 	/* Get the address of the primary PTE group in the hash table (r3) */
-0:	addis	r8,r7,Hash_base@h	/* base address of hash table */
+0:	lis	r8, (Hash_base - PAGE_OFFSET)@h	/* base address of hash table */
 1:	rlwimi	r8,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
 2:	rlwinm	r0,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
 	xor	r8,r0,r8		/* make primary hash */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 3f4193201ee7..fb747bb0b3e4 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -231,7 +231,8 @@ void __init MMU_init_hw(void)
 	if (lg_n_hpteg > 16)
 		mb2 = 16 - LG_HPTEG_SIZE;
 
-	modify_instruction_site(&patch__hash_page_A0, 0xffff, (unsigned int)Hash >> 16);
+	modify_instruction_site(&patch__hash_page_A0, 0xffff,
+				((unsigned int)Hash - PAGE_OFFSET) >> 16);
 	modify_instruction_site(&patch__hash_page_A1, 0x7c0, mb << 6);
 	modify_instruction_site(&patch__hash_page_A2, 0x7c0, mb2 << 6);
 	modify_instruction_site(&patch__hash_page_B, 0xffff, hmask);
@@ -240,7 +241,8 @@ void __init MMU_init_hw(void)
 	/*
 	 * Patch up the instructions in hashtable.S:flush_hash_page
 	 */
-	modify_instruction_site(&patch__flush_hash_A0, 0xffff, (unsigned int)Hash >> 16);
+	modify_instruction_site(&patch__flush_hash_A0, 0xffff,
+				((unsigned int)Hash - PAGE_OFFSET) >> 16);
 	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, mb << 6);
 	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, mb2 << 6);
 	modify_instruction_site(&patch__flush_hash_B, 0xffff, hmask);
-- 
2.13.3

