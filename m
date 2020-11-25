Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B4C56201
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 07:19:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0709D208B8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 07:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709D208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cgsj56rBszDqKP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 18:19:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgsVj4RYJzDqg4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 18:10:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CgsVZ5rqWz9tyTS;
 Wed, 25 Nov 2020 08:10:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fTd3LyOUb1yf; Wed, 25 Nov 2020 08:10:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CgsVZ493Sz9tyTJ;
 Wed, 25 Nov 2020 08:10:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 799208B7C2;
 Wed, 25 Nov 2020 08:10:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id AMr85lhAaESG; Wed, 25 Nov 2020 08:10:47 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E3E88B7B7;
 Wed, 25 Nov 2020 08:10:47 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 0FAE9668BA; Wed, 25 Nov 2020 07:10:47 +0000 (UTC)
Message-Id: <0a0bab7fadd89aa829e33420fbc10d60c59040a7.1606285014.git.christophe.leroy@csgroup.eu>
In-Reply-To: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
References: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/8] powerpc/32s: Don't hash_preload() kernel text
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 25 Nov 2020 07:10:47 +0000 (UTC)
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

We now always map kernel text with BATs. Neither need to preload
hash with kernel text addresses nor ensure they are never evicted.

This is more or less a revert of commit ee4f2ea48674 ("[POWERPC] Fix
32-bit mm operations when not using BATs")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/hash_low.S | 18 +-----------------
 arch/powerpc/mm/book3s32/mmu.c      |  2 +-
 arch/powerpc/mm/mmu_decl.h          |  2 --
 arch/powerpc/mm/pgtable_32.c        |  4 ----
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index b2c912e517b9..48415c857d80 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -411,30 +411,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	 * and we know there is a definite (although small) speed
 	 * advantage to putting the PTE in the primary PTEG, we always
 	 * put the PTE in the primary PTEG.
-	 *
-	 * In addition, we skip any slot that is mapping kernel text in
-	 * order to avoid a deadlock when not using BAT mappings if
-	 * trying to hash in the kernel hash code itself after it has
-	 * already taken the hash table lock. This works in conjunction
-	 * with pre-faulting of the kernel text.
-	 *
-	 * If the hash table bucket is full of kernel text entries, we'll
-	 * lockup here but that shouldn't happen
 	 */
 
-1:	lis	r4, (next_slot - PAGE_OFFSET)@ha	/* get next evict slot */
+	lis	r4, (next_slot - PAGE_OFFSET)@ha	/* get next evict slot */
 	lwz	r6, (next_slot - PAGE_OFFSET)@l(r4)
 	addi	r6,r6,HPTE_SIZE			/* search for candidate */
 	andi.	r6,r6,7*HPTE_SIZE
 	stw	r6,next_slot@l(r4)
 	add	r4,r3,r6
-	LDPTE	r0,HPTE_SIZE/2(r4)		/* get PTE second word */
-	clrrwi	r0,r0,12
-	lis	r6,etext@h
-	ori	r6,r6,etext@l			/* get etext */
-	tophys(r6,r6)
-	cmpl	cr0,r0,r6			/* compare and try again */
-	blt	1b
 
 #ifndef CONFIG_SMP
 	/* Store PTE in PTEG */
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 5c60dcade90a..23f60e97196e 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -302,7 +302,7 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 /*
  * Preload a translation in the hash table
  */
-void hash_preload(struct mm_struct *mm, unsigned long ea)
+static void hash_preload(struct mm_struct *mm, unsigned long ea)
 {
 	pmd_t *pmd;
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 1b6d39e9baed..0ad6d476d01d 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -91,8 +91,6 @@ void print_system_hash_info(void);
 
 #ifdef CONFIG_PPC32
 
-void hash_preload(struct mm_struct *mm, unsigned long ea);
-
 extern void mapin_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 079159e97bca..6e0083e7f008 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -112,10 +112,6 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		ktext = ((char *)v >= _stext && (char *)v < etext) ||
 			((char *)v >= _sinittext && (char *)v < _einittext);
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
-#ifdef CONFIG_PPC_BOOK3S_32
-		if (ktext)
-			hash_preload(&init_mm, v);
-#endif
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
-- 
2.25.0

