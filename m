Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BE2ECAAD5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Sep 2022 09:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLk4G3nk0z3bVB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Sep 2022 19:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLk3p6XLmz2xGB
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2022 19:38:45 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4MLk3g3Dkkz9sf2;
	Mon,  5 Sep 2022 11:38:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kv_mhwZ_2oli; Mon,  5 Sep 2022 11:38:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4MLk3Y3cKhz9sfx;
	Mon,  5 Sep 2022 11:38:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 69FAF8B76C;
	Mon,  5 Sep 2022 11:38:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oBEjZLODXewf; Mon,  5 Sep 2022 11:38:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4232A8B763;
	Mon,  5 Sep 2022 11:38:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2859cQXm2574990
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Sep 2022 11:38:26 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2859cPQi2574988;
	Mon, 5 Sep 2022 11:38:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/book3s: Inline first level of update_mmu_cache()
Date: Mon,  5 Sep 2022 11:38:25 +0200
Message-Id: <bea5ad0de7f83eff256116816d46c84fa0a444de.1662370698.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662370704; l=3705; s=20211009; h=from:subject:message-id; bh=qKquPqCwVOVBNSiGTfFSYH26Sba7qHorr6rv6pPHCmQ=; b=tneaAHvb+tDXQ74I3O8vmHZHWSL2HSHYmUrAGWUYPXRVm8dDBro3cVX1eBFuZqzBnli4bZJLG4OK ZcCsLvv/DY4Mc+rwFy3Ny8IDJJPWdxOBBRYtDNe69u9Yb+CRgyTA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

update_mmu_cache() voids when hash page tables are not used.
On PPC32 that means when MMU_FTR_HPTE_TABLE is not defined.
On PPC64 that means when RADIX is enabled.

Rename core part of update_mmu_cache() as __update_mmu_cache()
and include the initial verification in an inlined caller.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/pgtable.h | 15 ++++++++++-----
 arch/powerpc/mm/book3s32/mmu.c            |  4 +---
 arch/powerpc/mm/book3s64/hash_utils.c     |  5 +----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index e8269434ecbe..d18b748ea3ae 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -25,7 +25,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
-#if defined(CONFIG_PPC32) || defined(CONFIG_PPC_64S_HASH_MMU)
+void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
+
 /*
  * This gets called at the end of handling a page fault, when
  * the kernel has put a new PTE into the page table for the process.
@@ -35,10 +36,14 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  * corresponding HPTE into the hash table ahead of time, instead of
  * waiting for the inevitable extra hash-table miss exception.
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
-#else
-static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep) {}
-#endif
+static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	if (IS_ENABLED(CONFIG_PPC32) && !mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		return;
+	if (radix_enabled())
+		return;
+	__update_mmu_cache(vma, address, ptep);
+}
 
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index a96b73006dfb..7053eb229b4f 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -314,11 +314,9 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea)
  *
  * This must always be called with the pte lock held.
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		return;
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 363a9447d63d..ced1107b1677 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1781,7 +1781,7 @@ static void hash_preload(struct mm_struct *mm, pte_t *ptep, unsigned long ea,
  *
  * This must always be called with the pte lock held.
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
 	/*
@@ -1791,9 +1791,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	unsigned long trap;
 	bool is_exec;
 
-	if (radix_enabled())
-		return;
-
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
 	if (!pte_young(*ptep) || address >= TASK_SIZE)
 		return;
-- 
2.37.1

