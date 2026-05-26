Return-Path: <linuxppc-dev+bounces-21530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1F7CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:40:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ74n3nRrz2yYd;
	Wed, 27 May 2026 08:40:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779807387;
	cv=none; b=an+HVVFVqTFEcS5w99u3awSetPzb5jEvRi/vckAPl4v0x9e9UP5KYmgM4PNIGfHSPy1mACqLiRyXBRQVDfbM4amoib05mLU5GnM3sShLfur2z2+eJeUZecytLlMOnYq8azr422xXGVU1mHsphqiS8z+04U57yQOF79YnrLzrREKNf2qkf1Z78MIEdW9C0cf6Jd2nC5HNJ5rla8mgsp+oHyh7sKB+AP/Xs8XY82aBtNkQ/cidereZSpSYzjncmlLfvafujsxuls9tw/TOAN5Z7SrbuRr8YZkKJ174Q04RdxPEz3kCeN0GIAf5LkL2Si0gy6bL+FrjewndCIDMQ03kcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779807387; c=relaxed/relaxed;
	bh=wMIWaZV32Daasf+za8/Pnxre+NVOPFzoBSPfz4En8HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdF3v1gzU4yl3V018HSIx5QIW6NZnMkkBWlCEuQc/IdOQ9dhL0/39xIAl+8XUzvMVhlhYlTkaKGhhHhx70M/+gdfW4fO656ZM7+kOXg1aw7iZw0E7izahxBKwqXTU80K8oFrs/GcTUnF3UQinnF8yIfiZdbcxzd0qLLHodvJ7c577T66w+EER7pHlsWgXcRPwtHJfNYYWbWlw+f38sQnWdIeuT6a6eBMm05Czr6ng32zg1lHW/SyswStp3Qlw7hTVKZVhF2R0r/xNQZ3LCULgyeCmbUVibD6zcZTqYZulQDBeUUnovSdgNdp/hEFqbOisDHh7wm8uBXjs+ZvO5hpbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cWP2C5F2; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cWP2C5F2; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cWP2C5F2;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cWP2C5F2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPwn65PM1z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:56:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wMIWaZV32Daasf+za8/Pnxre+NVOPFzoBSPfz4En8HQ=;
	b=cWP2C5F2TBvhzg8T7RVE9LoZ2ByIKu0sClV+EAFEDCH0sYrngJWuk2R/h0BScXfHjlZ39EcF0
	sm2W80NqlJG1l2DcbQ+f7BpC0XXWfXbT14ddcMTDZ61mK12koV6hAqFEZ0BpvXmYoJ1dR3dQgM8
	I5JteHexY65OZ5Vz5woxwvk=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPwm05f4Wz1BGQ7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:55:28 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wMIWaZV32Daasf+za8/Pnxre+NVOPFzoBSPfz4En8HQ=;
	b=cWP2C5F2TBvhzg8T7RVE9LoZ2ByIKu0sClV+EAFEDCH0sYrngJWuk2R/h0BScXfHjlZ39EcF0
	sm2W80NqlJG1l2DcbQ+f7BpC0XXWfXbT14ddcMTDZ61mK12koV6hAqFEZ0BpvXmYoJ1dR3dQgM8
	I5JteHexY65OZ5Vz5woxwvk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gPwcN06v8zpT17;
	Tue, 26 May 2026 22:48:52 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id B5BD740561;
	Tue, 26 May 2026 22:56:16 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:15 +0800
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
Subject: [PATCH mm-unstable RFC v4 5/7] mm/huge_memory: refactor __split_huge_pmd_locked()
Date: Tue, 26 May 2026 22:50:01 +0800
Message-ID: <20260526145003.88445-6-yintirui@huawei.com>
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

Rework __split_huge_pmd_locked() to classify huge PMDs by the PMD entry
itself instead of starting from vma_is_anonymous().

Present PMDs are classified with vm_normal_folio_pmd(): file/shmem THPs
are dropped and refaulted later, anonymous THPs are split into PTEs, and
PMDs without a normal folio are handled as huge zero or special PMDs.

Non-present PMDs are classified with pmd_to_softleaf_folio(): file/shmem
migration entries are dropped, while anonymous migration/device-private
entries are split into PTEs.

This also makes the anonymous decision folio-based.  A private file
mapping that has CoW'ed to an anonymous THP now follows the anonymous
path even though the VMA is file-backed.

No intended behavioural change.

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 mm/huge_memory.c | 197 +++++++++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 83 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3964258ff91d..8cd77389d52f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3136,25 +3136,38 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	count_vm_event(THP_SPLIT_PMD);
 
-	if (!vma_is_anonymous(vma)) {
-		old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
-		/*
-		 * We are going to unmap this huge page. So
-		 * just go ahead and zap it
-		 */
-		if (arch_needs_pgtable_deposit())
-			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
-			return;
-		if (unlikely(pmd_is_migration_entry(old_pmd))) {
-			const softleaf_t old_entry = softleaf_from_pmd(old_pmd);
+	if (pmd_present(*pmd)) {
+		folio = vm_normal_folio_pmd(vma, haddr, *pmd);
+
+		if (unlikely(!folio)) {
+			if (is_huge_zero_pmd(*pmd)) {
+				/*
+				 * FIXME: Do we want to invalidate secondary mmu by calling
+				 * mmu_notifier_arch_invalidate_secondary_tlbs() see comments below
+				 * inside __split_huge_pmd() ?
+				 *
+				 * We are going from a zero huge page write protected to zero
+				 * small page also write protected so it does not seems useful
+				 * to invalidate secondary mmu at this time.
+				 */
+				return __split_huge_zero_page_pmd(vma, haddr, pmd);
+			}
 
-			folio = softleaf_to_folio(old_entry);
-		} else if (is_huge_zero_pmd(old_pmd)) {
+			/* Present but not a normal folio: drop the PMD. */
+			old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
+			if (arch_needs_pgtable_deposit())
+				zap_deposited_table(mm, pmd);
 			return;
-		} else {
+		}
+
+		if (unlikely(!folio_test_anon(folio))) {
+			old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
+			if (arch_needs_pgtable_deposit())
+				zap_deposited_table(mm, pmd);
+			if (vma_is_special_huge(vma))
+				return;
+
 			page = pmd_page(old_pmd);
-			folio = page_folio(page);
 			if (!folio_test_dirty(folio) && pmd_dirty(old_pmd))
 				folio_mark_dirty(folio);
 			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
@@ -3164,72 +3177,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			folio_put(folio);
 			return;
 		}
-		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
-		return;
-	}
-
-	if (is_huge_zero_pmd(*pmd)) {
-		/*
-		 * FIXME: Do we want to invalidate secondary mmu by calling
-		 * mmu_notifier_arch_invalidate_secondary_tlbs() see comments below
-		 * inside __split_huge_pmd() ?
-		 *
-		 * We are going from a zero huge page write protected to zero
-		 * small page also write protected so it does not seems useful
-		 * to invalidate secondary mmu at this time.
-		 */
-		return __split_huge_zero_page_pmd(vma, haddr, pmd);
-	}
-
-	if (pmd_is_migration_entry(*pmd)) {
-		softleaf_t entry;
-
-		old_pmd = *pmd;
-		entry = softleaf_from_pmd(old_pmd);
-		page = softleaf_to_page(entry);
-		folio = page_folio(page);
-
-		soft_dirty = pmd_swp_soft_dirty(old_pmd);
-		uffd_wp = pmd_swp_uffd_wp(old_pmd);
-
-		write = softleaf_is_migration_write(entry);
-		if (PageAnon(page))
-			anon_exclusive = softleaf_is_migration_read_exclusive(entry);
-		young = softleaf_is_migration_young(entry);
-		dirty = softleaf_is_migration_dirty(entry);
-	} else if (pmd_is_device_private_entry(*pmd)) {
-		softleaf_t entry;
-
-		old_pmd = *pmd;
-		entry = softleaf_from_pmd(old_pmd);
-		page = softleaf_to_page(entry);
-		folio = page_folio(page);
-
-		soft_dirty = pmd_swp_soft_dirty(old_pmd);
-		uffd_wp = pmd_swp_uffd_wp(old_pmd);
-
-		write = softleaf_is_device_private_write(entry);
-		anon_exclusive = PageAnonExclusive(page);
-
-		/*
-		 * Device private THP should be treated the same as regular
-		 * folios w.r.t anon exclusive handling. See the comments for
-		 * folio handling and anon_exclusive below.
-		 */
-		if (freeze && anon_exclusive &&
-		    folio_try_share_anon_rmap_pmd(folio, page))
-			freeze = false;
-		if (!freeze) {
-			rmap_t rmap_flags = RMAP_NONE;
-
-			folio_ref_add(folio, HPAGE_PMD_NR - 1);
-			if (anon_exclusive)
-				rmap_flags |= RMAP_EXCLUSIVE;
 
-			folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
-						 vma, haddr, rmap_flags);
-		}
-	} else {
 		/*
 		 * Up to this point the pmd is present and huge and userland has
 		 * the whole access to the hugepage during the split (which
@@ -3255,7 +3203,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		old_pmd = pmdp_invalidate(vma, haddr, pmd);
 		page = pmd_page(old_pmd);
-		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
 			dirty = true;
 			folio_set_dirty(folio);
@@ -3266,7 +3213,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
 		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
-		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -3296,6 +3242,85 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
 						 vma, haddr, rmap_flags);
 		}
+	} else {
+		/*
+		 * Non-present PMD: a softleaf-encoded migration or
+		 * device-private entry. pmd_to_softleaf_folio() warns and
+		 * returns NULL for any other encoding.
+		 */
+		folio = pmd_to_softleaf_folio(*pmd);
+		if (unlikely(!folio))
+			return;
+
+		if (unlikely(!folio_test_anon(folio))) {
+			/*
+			 * File/shmem migration entry: drop the PMD without
+			 * splitting. Unlike the present case the entry holds
+			 * neither a folio reference nor an rmap to release,
+			 * so just adjust the RSS counter.
+			 */
+			pmdp_huge_clear_flush(vma, haddr, pmd);
+			if (arch_needs_pgtable_deposit())
+				zap_deposited_table(mm, pmd);
+			if (unlikely(vma_is_special_huge(vma))) {
+				VM_WARN_ONCE(1,
+					     "unexpected special huge PMD migration entry\n");
+				return;
+			}
+			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
+			return;
+		}
+
+		if (pmd_is_migration_entry(*pmd)) {
+			softleaf_t entry;
+
+			old_pmd = *pmd;
+			entry = softleaf_from_pmd(old_pmd);
+			page = softleaf_to_page(entry);
+
+			soft_dirty = pmd_swp_soft_dirty(old_pmd);
+			uffd_wp = pmd_swp_uffd_wp(old_pmd);
+
+			write = softleaf_is_migration_write(entry);
+			if (PageAnon(page))
+				anon_exclusive = softleaf_is_migration_read_exclusive(entry);
+			young = softleaf_is_migration_young(entry);
+			dirty = softleaf_is_migration_dirty(entry);
+		} else if (pmd_is_device_private_entry(*pmd)) {
+			softleaf_t entry;
+
+			old_pmd = *pmd;
+			entry = softleaf_from_pmd(old_pmd);
+			page = softleaf_to_page(entry);
+
+			soft_dirty = pmd_swp_soft_dirty(old_pmd);
+			uffd_wp = pmd_swp_uffd_wp(old_pmd);
+
+			write = softleaf_is_device_private_write(entry);
+			anon_exclusive = PageAnonExclusive(page);
+
+			/*
+			 * Device-private THP should be treated the same as
+			 * regular folios w.r.t. anon-exclusive handling. See
+			 * the matching code for present anon folios above.
+			 */
+			if (freeze && anon_exclusive &&
+			    folio_try_share_anon_rmap_pmd(folio, page))
+				freeze = false;
+			if (!freeze) {
+				rmap_t rmap_flags = RMAP_NONE;
+
+				folio_ref_add(folio, HPAGE_PMD_NR - 1);
+				if (anon_exclusive)
+					rmap_flags |= RMAP_EXCLUSIVE;
+
+				folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
+							 vma, haddr, rmap_flags);
+			}
+		} else {
+			VM_WARN_ON_ONCE(1);
+			return;
+		}
 	}
 
 	/*
-- 
2.43.0


