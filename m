Return-Path: <linuxppc-dev+bounces-18405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6531088E70
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 03:24:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrf60tPJz2ynf;
	Thu, 19 Mar 2026 14:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773890670;
	cv=none; b=b5ZeFkEhVzX3VLmpn0lKgTr+oHESPfICPm6GAkIioZ7UBi91q/Af1kHMc01y1g/lX5Wi0l/e0RDnnPTBZdmtGMjGdiytvs+nK/hicW3xj5Vy76tOnxU9hmieiz5/4w2JydXE+fUDJpK4XPmNmlY13O8B6vIM7GT4NYMZwjeV5fhuQCYY9icDYY3vofBCaPwVp5HY96UfArx37QlAj04Z7LCO61aSavPDMuFLluAy8jhst9jm5X7so8b8KJYkvo/o4ObDmdJvA3AS+jjVeVsMU85vfrpAppJJ+m3rFE6n7Iq4ZhQlc23ytwswsnQtRMYIxzYAnwMw8eO/N4ep3xoozA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773890670; c=relaxed/relaxed;
	bh=X6l6KoTpEXERAeGDFQhqpgsjuu2KQfJTQ5hxLP+6Eu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1LN72/eQtKTQH9aU4Uwd1a7/iBhunnEpRngaZ6ZyChaiio+lPfIjiiAT2Mi1dTppMhGQFBqSBcXgT4eYG6nxsCPYSXI3yHaeWeVSc8zGGpRpzEvk8GgIW3nA7DHawiDBnNiFoqky1TWnCsi/VaWV0AMH08tQlQqVwgCMZW4vNGwjjwOoeZrd21xZFCbP7jhP2WkwFxa3n1H2J01e+X/FRtoysjQJQkPAxMhg1/gboY8QkfImRHv5B8EWN8S8kahbnO1doN3zVCV+1G7XlWpYQcWBQ43c1//GgZYTUShbzR0sA5PaHIC/RYoL1UZPbETMksqcAtS/oM9Qc4yHH8taA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DEu2mzbI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DEu2mzbI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrf33Vzcz2yZ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 14:24:25 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890660; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X6l6KoTpEXERAeGDFQhqpgsjuu2KQfJTQ5hxLP+6Eu8=;
	b=DEu2mzbI7RwmkHSMYIdRnPzbUnVwNcABuQ+kRg8QTUNGR3ShkiHo5PL1R3fMVV3NIaCrQn1q1cdj3+KXZlI16c2ldEJYUmys9XOqhpOOBK2tNNVHDYU/CKQqqlIcu1UYFKmZVOmIHV63pejojCR5czWSKehaS5+0ERKXz7Us1fo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.GpFaD_1773890659;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.GpFaD_1773890659 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
Date: Thu, 19 Mar 2026 11:24:01 +0800
Message-ID: <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
the young flag and flush the TLB, returning whether the young flag was set.
Change the return type to bool to make the intention clearer.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
 arch/arm64/mm/contpte.c                      |  4 ++--
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/parisc/kernel/cache.c                   |  8 ++++----
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h             |  4 ++--
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/x86/mm/pgtable.c                        |  4 ++--
 include/linux/pgtable.h                      |  8 ++++----
 mm/pgtable-generic.c                         |  7 ++++---
 11 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8c651695204c..393a9d1873f6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1299,10 +1299,10 @@ static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return pte_young(pte);
 }
 
-static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
+					    unsigned long address, pte_t *ptep)
 {
-	int young = __ptep_test_and_clear_young(vma, address, ptep);
+	bool young = __ptep_test_and_clear_young(vma, address, ptep);
 
 	if (young) {
 		/*
@@ -1648,7 +1648,7 @@ extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned int nr, int full);
 bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
-int contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
+bool contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep, unsigned int nr);
 extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr);
@@ -1831,7 +1831,7 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep)
 {
 	pte_t orig_pte = __ptep_get(ptep);
@@ -1843,9 +1843,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #define clear_flush_young_ptes clear_flush_young_ptes
-static inline int clear_flush_young_ptes(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep,
-					 unsigned int nr)
+static inline bool clear_flush_young_ptes(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
 		return __ptep_clear_flush_young(vma, addr, ptep);
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 0b88278927a4..2ef4bff3b998 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -535,11 +535,11 @@ bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(contpte_test_and_clear_young_ptes);
 
-int contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
+bool contpte_clear_flush_young_ptes(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				unsigned int nr)
 {
-	int young;
+	bool young;
 
 	young = contpte_test_and_clear_young_ptes(vma, addr, ptep, nr);
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index d5e39f2eb415..f6984b3ba531 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -450,7 +450,7 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma, unsigne
 	return true;
 }
 
-int ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
+bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 
 struct mm_struct;
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 4c5240d3a3c7..268530eb107d 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -781,18 +781,18 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned lon
 	__flush_cache_page(vma, vmaddr, PFN_PHYS(page_to_pfn(page)));
 }
 
-int ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr,
-			   pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
 
 	if (!pte_young(pte))
-		return 0;
+		return false;
 	set_pte(ptep, pte_mkold(pte));
 #if CONFIG_FLUSH_PAGE_ACCESSED
 	__flush_cache_page(vma, addr, PFN_PHYS(pte_pfn(pte)));
 #endif
-	return 1;
+	return true;
 }
 
 /*
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 2deb955b7bc8..661eb3820d12 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -155,7 +155,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young = ptep_test_and_clear_young(__vma, __address, __ptep);\
+	bool __young = ptep_test_and_clear_young(__vma, __address, __ptep);\
 	__young;							\
 })
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index fb010dcdf343..11f57ccf6dc9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -695,8 +695,8 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
+					  unsigned long address, pte_t *ptep)
 {
 	/*
 	 * This comment is borrowed from x86, but applies equally to RISC-V:
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index da1a7a31fa22..c9ab81caaf75 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1174,8 +1174,8 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
+					  unsigned long address, pte_t *ptep)
 {
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 563a6289ea44..554dea93eb99 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1236,8 +1236,8 @@ extern bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-extern int ptep_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pte_t *ptep);
+extern bool ptep_clear_flush_young(struct vm_area_struct *vma,
+				   unsigned long address, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index c594976afc5c..0007dc3d739e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -483,8 +483,8 @@ int pudp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep)
 {
 	/*
 	 * On x86 CPUs, clearing the accessed bit without a TLB flush
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8e75dc9f7932..1198e216fde3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -531,8 +531,8 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep);
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep);
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
@@ -1086,10 +1086,10 @@ static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
  * Context: The caller holds the page table lock.  The PTEs map consecutive
  * pages that belong to the same folio.  The PTEs are all in the same PMD.
  */
-static inline int clear_flush_young_ptes(struct vm_area_struct *vma,
+static inline bool clear_flush_young_ptes(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
-	int young = 0;
+	bool young = false;
 
 	for (;;) {
 		young |= ptep_clear_flush_young(vma, addr, ptep);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index af7966169d69..db0ee918b08a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -81,10 +81,11 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep)
 {
-	int young;
+	bool young;
+
 	young = ptep_test_and_clear_young(vma, address, ptep);
 	if (young)
 		flush_tlb_page(vma, address);
-- 
2.47.3


