Return-Path: <linuxppc-dev+bounces-21531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CB0CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ74y1MqZz2xq0;
	Wed, 27 May 2026 08:40:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779807388;
	cv=none; b=fwwB+NdvjFyv0qYpqMNEC/iG3LkaRJ64lKmT9wFhwH9LF3PTy2YJXRNogvt1CG2wSXUGO9Kw1aCIpMBd7RQLD6PRbIIXANxQdrNm9/KWcw8CsCyg06GVSpMH9pptRlzmWcdzM/qO+r6fd43cL8oppbN40s3fdsIIi4fXHdoXaJ3X2/FO8MpFNoH0FCXTX44CakM/Q0qsWMqrUJ7B6GjOLK5aGl8Lx0HGNqWN1tyy+nRGNbjc9don4tWrGS9zZUDYKlmnixgKFSemCpI4d1QFrwLziTfwZYjDQVDounhJYhpu3gjLPwb0PgL3osONucbVB7/e5IU+9sCAYfmNpt0G1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779807388; c=relaxed/relaxed;
	bh=k9KVwVo2Cm4f4rYBWd0AF4RdxTPXu9UJm3DZXHV1hSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftRpPYpUWv03RS6QyIDicQYd/CQ2cGlcF1cm1tcU1zrY/p9gubdE5i7ti6zrCe6tdViFnvwmSOwjycUuE/qy71xd6JFjC1q3x2LOI9dHxFy5At0vUNV5ByQ021hjiYRe4RQzmXrWe8j/SI3N/ehmb5HxnzsPWhiYlY9KAt0aYywcrBkLVtwjYZEE/zhbAUSx/KNHE/zEnZza6UdnmkIG1lm8hsDvWDsjysFXanyxVD1zbR+qT1d1DqqjhEaC75ix9wFiRk7+0S+GLf1mHRI4/CmwxCbAlpGJ3XLcahf13fUBN9aW6GJxL7EogGdfu+ORX6Hq8AVR4R2MpALxEPxA+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CR/mU79d; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CR/mU79d; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CR/mU79d;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CR/mU79d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPwn6622Mz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:56:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k9KVwVo2Cm4f4rYBWd0AF4RdxTPXu9UJm3DZXHV1hSk=;
	b=CR/mU79d0PRk0JiMm+3Bz8ydmIH42L8XRQ5l/1mx34szLa8TeL9FDoHeIzGpUof1CeyHqV1uo
	MiMAzDnrdroxqRe8tboa8teu1VRpNr2pbt00sMv5yTUngQDbQorn/c8WgUYfzFhtNbbmPTL1rES
	BykeJAQlxO0hm/dE9NVpZho=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPwm41wx9z1BGfL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:55:32 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k9KVwVo2Cm4f4rYBWd0AF4RdxTPXu9UJm3DZXHV1hSk=;
	b=CR/mU79d0PRk0JiMm+3Bz8ydmIH42L8XRQ5l/1mx34szLa8TeL9FDoHeIzGpUof1CeyHqV1uo
	MiMAzDnrdroxqRe8tboa8teu1VRpNr2pbt00sMv5yTUngQDbQorn/c8WgUYfzFhtNbbmPTL1rES
	BykeJAQlxO0hm/dE9NVpZho=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gPwc33yv6z1cyNp;
	Tue, 26 May 2026 22:48:35 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C67340539;
	Tue, 26 May 2026 22:56:19 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:17 +0800
From: Yin Tirui <yintirui@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
	<ljs@kernel.org>, Juergen Gross <jgross@suse.com>, Jonathan Cameron
	<jic23@kernel.org>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>,
	Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Coiby Xu <coxu@redhat.com>, Dan Williams
	<djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, Rik
 van Riel <riel@surriel.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <yintirui@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH mm-unstable RFC v4 7/7] mm: add PMD-level PFNMAP support for remap_pfn_range()
Date: Tue, 26 May 2026 22:50:03 +0800
Message-ID: <20260526145003.88445-8-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>
References: <20260526145003.88445-1-yintirui@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.87.63]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Teach remap_pfn_range() to install PMD-sized PFNMAP entries when the
virtual range and PFN are PMD-aligned, the architecture exposes PMD
PFNMAP support, and PMD leaves are available at runtime. The path only
runs on VMAs without ->fault or ->huge_fault, so the resulting PMDs
are known to be non-refaultable.

Non-refaultable PFNMAP PMDs cannot be rebuilt on demand and are
therefore installed with a deposited pgtable.
vma_pfnmap_has_deposited_pgtable() becomes the common predicate driving
the deposit logic in copy_huge_pmd(), zap_huge_pmd() through
has_deposited_pgtable(), and the new __split_huge_pfnmap_pmd().

The split path withdraws the pgtable and populates it with special PTEs
derived from the original PMD using pmd_pfn() and pmd_pgprot(). With
pmd_pgprot() returning PTE-level pgprot_t, this preserves protection and
cache attributes without reintroducing pte_clrhuge().

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 mm/huge_memory.c | 60 ++++++++++++++++++++++++++++-----
 mm/internal.h    | 21 ++++++++++++
 mm/memory.c      | 87 +++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 148 insertions(+), 20 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index be9b637c813b..19e6d856e8bf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1879,6 +1879,8 @@ bool touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
+static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
+		struct folio *folio);
 static int copy_present_huge_pmd(
 		struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -1912,8 +1914,12 @@ static int copy_present_huge_pmd(
 		 * able to wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
-		pte_free(dst_mm, pgtable);
-		pgtable = NULL;
+
+		if (!has_deposited_pgtable(dst_vma, pmd, NULL)) {
+			pte_free(dst_mm, pgtable);
+			pgtable = NULL;
+		}
+
 		wrprotect = false;
 		goto set_pmd;
 	}
@@ -2495,11 +2501,19 @@ static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
 	if (is_huge_zero_pmd(pmdval))
 		return !vma_is_dax(vma);
 
+	/*
+	 * PMD-sized PFNMAP mappings installed without fault handlers cannot be
+	 * refaulted after the PMD is cleared, so they carry a deposited page
+	 * table for later partial unmap/mprotect.
+	 */
+	if (!folio)
+		return pmd_present(pmdval) && vma_pfnmap_has_deposited_pgtable(vma);
+
 	/*
 	 * Otherwise, only anonymous folios are deposited, see
 	 * __do_huge_pmd_anonymous_page().
 	 */
-	return folio && folio_test_anon(folio);
+	return folio_test_anon(folio);
 }
 
 /**
@@ -3118,6 +3132,32 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pmd_populate(mm, pmd, pgtable);
 }
 
+static void __split_huge_pfnmap_pmd(struct vm_area_struct *vma,
+		unsigned long haddr, pmd_t *pmd)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgtable_t pgtable;
+	pmd_t old_pmd, _pmd;
+	pte_t *pte, entry;
+
+	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
+	if (!has_deposited_pgtable(vma, old_pmd, NULL))
+		return;
+
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	pmd_populate(mm, &_pmd, pgtable);
+
+	pte = pte_offset_map(&_pmd, haddr);
+	VM_BUG_ON(!pte);
+
+	entry = pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd));
+	set_ptes(mm, haddr, pte, entry, HPAGE_PMD_NR);
+	pte_unmap(pte);
+
+	smp_wmb(); /* make pte visible before pmd */
+	pmd_populate(mm, pmd, pgtable);
+}
+
 static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
@@ -3157,11 +3200,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				return __split_huge_zero_page_pmd(vma, haddr, pmd);
 			}
 
-			/* Present but not a normal folio: drop the PMD. */
-			old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
-			if (arch_needs_pgtable_deposit())
-				zap_deposited_table(mm, pmd);
-			return;
+			/*
+			 * Present PMDs without a normal folio are special mappings. Huge zero PMDs
+			 * are handled above; the remaining PMD-level special mappings are PFNMAP
+			 * mappings.
+			 */
+			return __split_huge_pfnmap_pmd(vma, haddr, pmd);
 		}
 
 		if (unlikely(!folio_test_anon(folio))) {
diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..f82bd987131d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -198,6 +198,27 @@ static inline void vma_close(struct vm_area_struct *vma)
 	}
 }
 
+static inline bool vma_has_fault_handler(const struct vm_area_struct *vma)
+{
+	const struct vm_operations_struct *vm_ops = vma->vm_ops;
+
+	return vm_ops && (vm_ops->fault || vm_ops->huge_fault);
+}
+
+/*
+ * PMD-sized PFNMAP mappings installed without fault handlers cannot be
+ * recreated after the PMD is cleared. Such mappings need a deposited page
+ * table so they can be split into PTEs for partial unmap/mprotect.
+ *
+ * Faultable PFNMAP VMAs can drop the PMD and refault it later, so they do
+ * not need a deposited page table.
+ */
+static inline bool
+vma_pfnmap_has_deposited_pgtable(const struct vm_area_struct *vma)
+{
+	return vma_test(vma, VMA_PFNMAP_BIT) && !vma_has_fault_handler(vma);
+}
+
 /* unmap_vmas is in mm/memory.c */
 void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
 
diff --git a/mm/memory.c b/mm/memory.c
index 56886d1ddaf3..226e3a53a48e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2943,9 +2943,66 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	return err;
 }
 
-static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
-			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+static int remap_try_install_pmd_leaf(struct mm_struct *mm,
+		pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, unsigned long pfn, pgprot_t prot)
+{
+	pgtable_t pgtable;
+	spinlock_t *ptl;
+	unsigned long i;
+	pmd_t entry;
+
+	if (!pgtable_level_has_pxx_special(PGTABLE_LEVEL_PMD))
+		return 0;
+
+	if (!pgtable_has_pmd_leaves())
+		return 0;
+
+	/*
+	 * Do not install PMD leaves through remap_pfn_range() for VMAs that have
+	 * a fault handler. With this restriction, a PFNMAP PMD in a VMA without
+	 * a fault handler is known to have been installed by remap_pfn_range()
+	 * and to have a deposited page table for later split; see
+	 * vma_pfnmap_has_deposited_pgtable().
+	 */
+	if (vma_has_fault_handler(vma))
+		return 0;
+
+	if (!IS_ALIGNED(addr | end, PMD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(PFN_PHYS(pfn), PMD_SIZE))
+		return 0;
+
+	for (i = 0; i < PFN_DOWN(PMD_SIZE); i++) {
+		if (!pfn_modify_allowed(pfn + i, prot))
+			return -EACCES;
+	}
+
+	pgtable = pte_alloc_one(mm);
+	if (unlikely(!pgtable))
+		return 0;
+
+	ptl = pmd_lock(mm, pmd);
+	if (!pmd_none(*pmd)) {
+		spin_unlock(ptl);
+		pte_free(mm, pgtable);
+		return 0;
+	}
+
+	entry = pfn_pmd(pfn, prot);
+	entry = pmd_mkspecial(entry);
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	mm_inc_nr_ptes(mm);
+	set_pmd_at(mm, addr, pmd, entry);
+	spin_unlock(ptl);
+
+	return 1;
+}
+
+static inline int remap_pmd_range(struct mm_struct *mm,
+		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long pfn, pgprot_t prot)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -2958,6 +3015,12 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
+		err = remap_try_install_pmd_leaf(mm, pmd, vma, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+		if (err < 0)
+			return err;
+		if (err > 0)
+			continue;
 		err = remap_pte_range(mm, pmd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2966,9 +3029,9 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	return 0;
 }
 
-static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
-			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+static inline int remap_pud_range(struct mm_struct *mm,
+		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
+		unsigned long end, unsigned long pfn, pgprot_t prot)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -2980,7 +3043,7 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		err = remap_pmd_range(mm, pud, addr, next,
+		err = remap_pmd_range(mm, vma, pud, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
@@ -2988,9 +3051,9 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	return 0;
 }
 
-static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
-			unsigned long addr, unsigned long end,
-			unsigned long pfn, pgprot_t prot)
+static inline int remap_p4d_range(struct mm_struct *mm,
+		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long pfn, pgprot_t prot)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -3002,7 +3065,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		err = remap_pud_range(mm, p4d, addr, next,
+		err = remap_pud_range(mm, vma, p4d, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
@@ -3049,7 +3112,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	flush_cache_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = remap_p4d_range(mm, pgd, addr, next,
+		err = remap_p4d_range(mm, vma, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
-- 
2.43.0


