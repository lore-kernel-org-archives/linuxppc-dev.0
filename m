Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2DC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACC4204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s6tY6Sd6zF3Nc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 04:42:45 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s6gq59z3zF3b2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 04:33:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42s6gf4rnHz9v0XM;
 Fri,  9 Nov 2018 18:33:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Bpk0BSEYd526; Fri,  9 Nov 2018 18:33:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42s6gf4G1rz9v0XL;
 Fri,  9 Nov 2018 18:33:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57BB58B899;
 Fri,  9 Nov 2018 18:33:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sIcZUMigJTKI; Fri,  9 Nov 2018 18:33:24 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 278308B887;
 Fri,  9 Nov 2018 18:33:24 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 154CA69A2A; Fri,  9 Nov 2018 17:33:24 +0000 (UTC)
Message-Id: <698c656b1a6caeb430234fb4882ba65c227da205.1541784640.git.christophe.leroy@c-s.fr>
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
References: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/9] powerpc/book3s/32: Use patch_site to patch hash functions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  9 Nov 2018 17:33:24 +0000 (UTC)
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

Use patch_sites and the new modify_instruction_site() function
instead of hardcoding hash functions patching.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  6 +++++
 arch/powerpc/mm/hash_low_32.S                 | 33 ++++++++++++++-----------
 arch/powerpc/mm/ppc_mmu_32.c                  | 35 ++++++++-------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index e38c91388c40..9662a44c5639 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -83,6 +83,12 @@ typedef struct {
 	unsigned long vdso_base;
 } mm_context_t;
 
+/* patch sites */
+extern s32 patch__hash_page_A0, patch__hash_page_A1, patch__hash_page_A2;
+extern s32 patch__hash_page_B, patch__hash_page_C;
+extern s32 patch__flush_hash_A0, patch__flush_hash_A1, patch__flush_hash_A2;
+extern s32 patch__flush_hash_B;
+
 #endif /* !__ASSEMBLY__ */
 
 /* We happily ignore the smaller BATs on 601, we don't actually use
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 26acf6c8c20c..1e2df3e9f9ea 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -28,6 +28,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
+#include <asm/code-patching-asm.h>
 
 #ifdef CONFIG_SMP
 	.section .bss
@@ -337,11 +338,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	rlwimi	r5,r4,10,26,31		/* put in API (abbrev page index) */
 	SET_V(r5)			/* set V (valid) bit */
 
+	patch_site	0f, patch__hash_page_A0
+	patch_site	1f, patch__hash_page_A1
+	patch_site	2f, patch__hash_page_A2
 	/* Get the address of the primary PTE group in the hash table (r3) */
-_GLOBAL(hash_page_patch_A)
-	addis	r0,r7,Hash_base@h	/* base address of hash table */
-	rlwimi	r0,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
-	rlwinm	r3,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
+0:	addis	r0,r7,Hash_base@h	/* base address of hash table */
+1:	rlwimi	r0,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
+2:	rlwinm	r3,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
 	xor	r3,r3,r0		/* make primary hash */
 	li	r0,8			/* PTEs/group */
 
@@ -366,10 +369,10 @@ _GLOBAL(hash_page_patch_A)
 	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
 	beq+	found_slot
 
+	patch_site	0f, patch__hash_page_B
 	/* Search the secondary PTEG for a matching PTE */
 	ori	r5,r5,PTE_H		/* set H (secondary hash) bit */
-_GLOBAL(hash_page_patch_B)
-	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
+0:	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
 	xori	r4,r4,(-PTEG_SIZE & 0xffff)
 	addi	r4,r4,-HPTE_SIZE
 	mtctr	r0
@@ -393,10 +396,10 @@ _GLOBAL(hash_page_patch_B)
 	addi	r6,r6,1
 	stw	r6,primary_pteg_full@l(r4)
 
+	patch_site	0f, patch__hash_page_C
 	/* Search the secondary PTEG for an empty slot */
 	ori	r5,r5,PTE_H		/* set H (secondary hash) bit */
-_GLOBAL(hash_page_patch_C)
-	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
+0:	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
 	xori	r4,r4,(-PTEG_SIZE & 0xffff)
 	addi	r4,r4,-HPTE_SIZE
 	mtctr	r0
@@ -577,11 +580,13 @@ _GLOBAL(flush_hash_pages)
 	stwcx.	r8,0,r5			/* update the pte */
 	bne-	33b
 
+	patch_site	0f, patch__flush_hash_A0
+	patch_site	1f, patch__flush_hash_A1
+	patch_site	2f, patch__flush_hash_A2
 	/* Get the address of the primary PTE group in the hash table (r3) */
-_GLOBAL(flush_hash_patch_A)
-	addis	r8,r7,Hash_base@h	/* base address of hash table */
-	rlwimi	r8,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
-	rlwinm	r0,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
+0:	addis	r8,r7,Hash_base@h	/* base address of hash table */
+1:	rlwimi	r8,r3,LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT    /* VSID -> hash */
+2:	rlwinm	r0,r4,20+LG_PTEG_SIZE,HASH_LEFT,HASH_RIGHT /* PI -> hash */
 	xor	r8,r0,r8		/* make primary hash */
 
 	/* Search the primary PTEG for a PTE whose 1st (d)word matches r5 */
@@ -593,11 +598,11 @@ _GLOBAL(flush_hash_patch_A)
 	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
 	beq+	3f
 
+	patch_site	0f, patch__flush_hash_B
 	/* Search the secondary PTEG for a matching PTE */
 	ori	r11,r11,PTE_H		/* set H (secondary hash) bit */
 	li	r0,8			/* PTEs/group */
-_GLOBAL(flush_hash_patch_B)
-	xoris	r12,r8,Hash_msk>>16	/* compute secondary hash */
+0:	xoris	r12,r8,Hash_msk>>16	/* compute secondary hash */
 	xori	r12,r12,(-PTEG_SIZE & 0xffff)
 	addi	r12,r12,-HPTE_SIZE
 	mtctr	r0
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 3c7c73defcb6..cc4b81331167 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -31,6 +31,7 @@
 #include <asm/prom.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
+#include <asm/code-patching.h>
 
 #include "mmu_decl.h"
 
@@ -182,10 +183,6 @@ void __init MMU_init_hw(void)
 	unsigned int hmask, mb, mb2;
 	unsigned int n_hpteg, lg_n_hpteg;
 
-	extern unsigned int hash_page_patch_A[];
-	extern unsigned int hash_page_patch_B[], hash_page_patch_C[];
-	extern unsigned int flush_hash_patch_A[], flush_hash_patch_B[];
-
 	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
 		return;
 
@@ -234,31 +231,19 @@ void __init MMU_init_hw(void)
 	if (lg_n_hpteg > 16)
 		mb2 = 16 - LG_HPTEG_SIZE;
 
-	hash_page_patch_A[0] = (hash_page_patch_A[0] & ~0xffff)
-		| ((unsigned int)(Hash) >> 16);
-	hash_page_patch_A[1] = (hash_page_patch_A[1] & ~0x7c0) | (mb << 6);
-	hash_page_patch_A[2] = (hash_page_patch_A[2] & ~0x7c0) | (mb2 << 6);
-	hash_page_patch_B[0] = (hash_page_patch_B[0] & ~0xffff) | hmask;
-	hash_page_patch_C[0] = (hash_page_patch_C[0] & ~0xffff) | hmask;
-
-	/*
-	 * Ensure that the locations we've patched have been written
-	 * out from the data cache and invalidated in the instruction
-	 * cache, on those machines with split caches.
-	 */
-	flush_icache_range((unsigned long) &hash_page_patch_A[0],
-			   (unsigned long) &hash_page_patch_C[1]);
+	modify_instruction_site(&patch__hash_page_A0, 0xffff, (unsigned int)Hash >> 16);
+	modify_instruction_site(&patch__hash_page_A1, 0x7c0, mb << 6);
+	modify_instruction_site(&patch__hash_page_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__hash_page_B, 0xffff, hmask);
+	modify_instruction_site(&patch__hash_page_C, 0xffff, hmask);
 
 	/*
 	 * Patch up the instructions in hashtable.S:flush_hash_page
 	 */
-	flush_hash_patch_A[0] = (flush_hash_patch_A[0] & ~0xffff)
-		| ((unsigned int)(Hash) >> 16);
-	flush_hash_patch_A[1] = (flush_hash_patch_A[1] & ~0x7c0) | (mb << 6);
-	flush_hash_patch_A[2] = (flush_hash_patch_A[2] & ~0x7c0) | (mb2 << 6);
-	flush_hash_patch_B[0] = (flush_hash_patch_B[0] & ~0xffff) | hmask;
-	flush_icache_range((unsigned long) &flush_hash_patch_A[0],
-			   (unsigned long) &flush_hash_patch_B[1]);
+	modify_instruction_site(&patch__flush_hash_A0, 0xffff, (unsigned int)Hash >> 16);
+	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, mb << 6);
+	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__flush_hash_B, 0xffff, hmask);
 
 	if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
 }
-- 
2.13.3

