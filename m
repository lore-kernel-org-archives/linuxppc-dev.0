Return-Path: <linuxppc-dev+bounces-21525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7135BCD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ73q0wv0z2xPb;
	Wed, 27 May 2026 08:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779807384;
	cv=none; b=aEYgp4+d0QsN/4iokIB5HUR0s84Wn19HLLwdpBCVKpblY9DES7vcIy2EP+qC2KkuNEptAGdIspKEBw69rpldpXSKGJ8lzPZ1n4pbmfwZkK4A0YV4sB3XQOJ7CndeVpTpRlD5sfcy9HkgKzb0dXV/0IJhkikbKwx/k8asFZ0i5u/BS1JG0MceOSQKdaa2bO24SmeMtAICH/ZONimA2X+7ZL0LSbGHktRG0/VfEjDlY398izvYvKkTyIXjQ4Mw5sWDmMtXybC5djsGBwRCyGHlzlKCxULYccpApE4NrAq0MlgmNPisgdkM4DXxbDuUUSuPLsF12db678JG2+dlmZ21QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779807384; c=relaxed/relaxed;
	bh=SRAvpL5kg7zfVB87jHmBF+c3eWPsqtwvfUMg/m3KWqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHA87WAAtO0GKiqAkd+ruxDh2+XBNNO+7UP2/rl/uNlyz5JwK6P5B92SAyPjaZ996yGc66jWMkJbX8pxGoj0Mt7BNDv/mNHaPckSjQBUFHYcrvBg88QUYWssTKpCiiFVq2uyppx6NPeUXDuPreUHks5L9sdZWqBPyROVqS3gpK4XoxMbWZ/2Ad7iWSTSegUA7WDIKdmGP5VYl8RRhdWFSDv/lcfNWFzT8SvhG3mpBbCYDxf74ECowDinPG8RWlunUgvkt65eLl8/bwOBcIhEmUJmcqxoclLwiYe+6p9K9jTu/n2h1t1ypUbUbOP4mQwbt7Z1LjQAfdLshJBU1464KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6IZrptZt; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6IZrptZt; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6IZrptZt;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6IZrptZt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPwn16Jxgz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:56:21 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SRAvpL5kg7zfVB87jHmBF+c3eWPsqtwvfUMg/m3KWqc=;
	b=6IZrptZt5pccedulAnBT8WZ9BpyHxnDtRYuwsBIYpsE+R49/hVIqXtnwoIHkcra0wdM3302cd
	TArJlb9VMRw0M09I5X1Ptta9isxW+2x2NHLRQMjUNumTS8/2z7/BgrG5HQgOGHeoowJftfugxM4
	f1Mp3586pp6HqfZ8jmmJtRQ=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPwm03327z1BGQ7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:55:28 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SRAvpL5kg7zfVB87jHmBF+c3eWPsqtwvfUMg/m3KWqc=;
	b=6IZrptZt5pccedulAnBT8WZ9BpyHxnDtRYuwsBIYpsE+R49/hVIqXtnwoIHkcra0wdM3302cd
	TArJlb9VMRw0M09I5X1Ptta9isxW+2x2NHLRQMjUNumTS8/2z7/BgrG5HQgOGHeoowJftfugxM4
	f1Mp3586pp6HqfZ8jmmJtRQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gPwby4VlGzLlSS;
	Tue, 26 May 2026 22:48:30 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 613854055B;
	Tue, 26 May 2026 22:56:15 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:13 +0800
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
Subject: [PATCH mm-unstable RFC v4 4/7] mm/huge_memory: refactor copy_huge_pmd()
Date: Tue, 26 May 2026 22:50:00 +0800
Message-ID: <20260526145003.88445-5-yintirui@huawei.com>
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

Classify the source PMD via pmd_present() and vm_normal_folio_pmd(),
matching the way the PTE path uses pte_present() and vm_normal_page().
This moves the present-PMD decision from VMA identity checks to the
actual PMD/folio state.

Drop the defensive "if (!pmd_trans_huge(pmd)) goto out_unlock" branch:
with mmap_write_lock held during fork, it should not occur.

Extract the present-PMD side of copy_huge_pmd() into
copy_present_huge_pmd(). The helper owns the child pgtable passed by the
caller: it either deposits the pgtable when installing a copied PMD, or
frees it on paths that do not install one.

The child pgtable is now allocated once up front and freed on every skip
path. This makes file/shmem and PFNMAP/special skip paths take the PMD
locks and free the preallocated pgtable before returning. These are not
expected to be hot paths, and the PFNMAP case is reused by the follow-up
PMD PFNMAP copy support.

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 mm/huge_memory.c | 175 +++++++++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 80 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9832ee910d5e..3964258ff91d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1879,6 +1879,82 @@ bool touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
+static int copy_present_huge_pmd(
+		struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pmd_t pmd, pgtable_t pgtable, bool *need_split)
+{
+	struct folio *src_folio;
+	bool wrprotect = true;
+
+	src_folio = vm_normal_folio_pmd(src_vma, addr, pmd);
+	if (!src_folio) {
+		/*
+		 * When page table lock is held, the huge zero pmd should not be
+		 * under splitting since we don't split the page itself, only pmd to
+		 * a page table.
+		 */
+		if (is_huge_zero_pmd(pmd)) {
+			/*
+			 * mm_get_huge_zero_folio() will never allocate a new
+			 * folio here, since we already have a zero page to
+			 * copy. It just takes a reference.
+			 */
+			mm_get_huge_zero_folio(dst_mm);
+			goto set_pmd;
+		}
+
+		/*
+		 * Making sure it's not a CoW VMA with writable
+		 * mapping, otherwise it means either the anon page wrongly
+		 * applied special bit, or we made the PRIVATE mapping be
+		 * able to wrongly write to the backend MMIO.
+		 */
+		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
+		pte_free(dst_mm, pgtable);
+		pgtable = NULL;
+		wrprotect = false;
+		goto set_pmd;
+	}
+
+	/* File THPs are copied lazily by refaulting. */
+	if (!folio_test_anon(src_folio)) {
+		pte_free(dst_mm, pgtable);
+		return 0;
+	}
+
+	folio_get(src_folio);
+	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio,
+							&src_folio->page,
+							dst_vma, src_vma))) {
+		/* Page maybe pinned: split and retry the fault on PTEs. */
+		folio_put(src_folio);
+		pte_free(dst_mm, pgtable);
+		*need_split = true;
+		return -EAGAIN;
+	}
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+
+set_pmd:
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
+
+	if (wrprotect) {
+		pmdp_set_wrprotect(src_mm, addr, src_pmd);
+		if (!userfaultfd_wp(dst_vma))
+			pmd = pmd_clear_uffd_wp(pmd);
+		pmd = pmd_wrprotect(pmd);
+	}
+
+	pmd = pmd_mkold(pmd);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+
+	return 0;
+}
+
 static void copy_huge_non_present_pmd(
 		struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -1940,104 +2016,43 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	spinlock_t *dst_ptl, *src_ptl;
-	struct page *src_page;
-	struct folio *src_folio;
-	pmd_t pmd;
 	pgtable_t pgtable = NULL;
-	int ret = -ENOMEM;
-
-	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-		     !is_huge_zero_pmd(pmd))) {
-		dst_ptl = pmd_lock(dst_mm, dst_pmd);
-		src_ptl = pmd_lockptr(src_mm, src_pmd);
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
-		 */
-		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
-		goto set_pmd;
-	}
-
-	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(dst_vma))
-		return 0;
+	bool need_split = false;
+	int ret = 0;
+	pmd_t pmd;
 
 	pgtable = pte_alloc_one(dst_mm);
 	if (unlikely(!pgtable))
-		goto out;
+		return -ENOMEM;
 
 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
 	src_ptl = pmd_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	if (unlikely(thp_migration_supported() &&
-		     pmd_is_valid_softleaf(pmd))) {
-		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+	if (likely(pmd_present(pmd))) {
+		ret = copy_present_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+					  dst_vma, src_vma, pmd, pgtable, &need_split);
+	} else if (unlikely(thp_migration_supported() && pmd_is_valid_softleaf(pmd))) {
+		if (unlikely(!vma_is_anonymous(dst_vma)))
+			pte_free(dst_mm, pgtable);
+		else
+			copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
 					  dst_vma, src_vma, pmd, pgtable);
-		ret = 0;
-		goto out_unlock;
-	}
-
-	if (unlikely(!pmd_trans_huge(pmd))) {
+	} else {
+		VM_WARN_ONCE(1, "unexpected non-present PMD %llx\n",
+				(unsigned long long)pmd_val(pmd));
 		pte_free(dst_mm, pgtable);
-		goto out_unlock;
-	}
-	/*
-	 * When page table lock is held, the huge zero pmd should not be
-	 * under splitting since we don't split the page itself, only pmd to
-	 * a page table.
-	 */
-	if (is_huge_zero_pmd(pmd)) {
-		/*
-		 * mm_get_huge_zero_folio() will never allocate a new
-		 * folio here, since we already have a zero page to
-		 * copy. It just takes a reference.
-		 */
-		mm_get_huge_zero_folio(dst_mm);
-		goto out_zero_page;
+		ret = -EAGAIN;
 	}
 
-	src_page = pmd_page(pmd);
-	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
-	src_folio = page_folio(src_page);
+	spin_unlock(src_ptl);
+	spin_unlock(dst_ptl);
 
-	folio_get(src_folio);
-	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
-		/* Page maybe pinned: split and retry the fault on PTEs. */
-		folio_put(src_folio);
-		pte_free(dst_mm, pgtable);
-		spin_unlock(src_ptl);
-		spin_unlock(dst_ptl);
+	if (unlikely(need_split))
 		__split_huge_pmd(src_vma, src_pmd, addr, false);
-		return -EAGAIN;
-	}
-	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-out_zero_page:
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
-	if (!userfaultfd_wp(dst_vma))
-		pmd = pmd_clear_uffd_wp(pmd);
-	pmd = pmd_wrprotect(pmd);
-set_pmd:
-	pmd = pmd_mkold(pmd);
-	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
-	ret = 0;
-out_unlock:
-	spin_unlock(src_ptl);
-	spin_unlock(dst_ptl);
-out:
 	return ret;
 }
 
-- 
2.43.0


