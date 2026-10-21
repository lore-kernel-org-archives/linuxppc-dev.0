Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34915606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=RhqVHXEU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j91KC0qt2z308f;
	Thu, 22 Oct 2026 07:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792614991;
	cv=none; b=bVuFEiHrwTIlH7fswW8i2+RnftqZKVs+VYlRZG2O5EVj6SkJjxmZMvsIHhhVbKFw9u68r6um4r7ZtL/E61xMEPkN0ZOVMHo/CUDq79Yf8hjkeSmYDO0hP1gFewvbmLQx03lUPK86lKPV2vzthpCphOXgB53ZGMwIQzAwVFOiJMLfOcrHxgzLf2bFNxqlWfwv5Av41SGNVOP4i/ZM1bj2Q7el2ljUGQ6kWQxvDhMfcoepkXhxm4LbHxHksg1yc1RbTrNFfW86E428VitF6+ncyKVNCLIv9Jsj4no08ttOk6AcQRDy97jFhUqUN7R8MZzjDc9zXTxTczHvHamwuR0eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792614991; c=relaxed/relaxed;
	bh=Y1RzK/YwA6RDAUfpjsoiTntAin9i553yc8Nq4zLllH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WacGIOfFJv328uqKSDou4gexNk1GvLeNDrKZOShEGBEL6D/e7H8rggLpwLMzmjSewrYLdbI8+6lF42x2CM8+O1d3w3gNhVJ6yNayQ3scRyYjk0wrOQzTDVBVS0yrl7H4DtsXi1Uk3BY3eS1vg4cvDn+1XRcQCWBJF8Ih5JZfQXKZSyKEdUcyUZL3ILYLq8RdFBkM9UoWP0NnjR9IEYEUtcpqnAvDD9LThJqe3qcwWSJQLGixKL8j0KCHnEQk7lI0BD85tTLeS2uz41cXy6KJ0VJl1y/MF2IiyV3ug3T5xzsyXSU6CNmr9OD4Yt2PdBF4zgLTOwFXadSbbwKY/47YDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=RhqVHXEU; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=RhqVHXEU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j91K64WmDz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 07:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=Y1RzK/YwA6RDAUfpjsoiTntAin9i553yc8Nq4zLllH0=; b=RhqVHXEUndGRIBgj47h
	pPTEb3m6RFxj9akFPIe49tfRDAWGu26fjc4+SDC49mdYbeFVhe8zQZkaUaZFK7AjbQL3IGmqVKaCa
	gOS7QcNIMyb6KrjZCFIVIRvhYvww4AV1cssjbcdRr/Q3L82+1sVwQ31SOyzTWtyZ5jQDeBfLsQrpJ
	m6u91/gJhvifPvsIhnE6+5GKwT4TRY3m705hpJo9F8zBUd2XTeL0tOlofB6fwXlyd/0bGmar9P0xU
	tkE1I0WfXSxsDKFEVnTWFOvW6QJ/5uCmZiNTT2iaEfIuUDWH6HHGV3U1ciwYdxbhRZLnmDCBicEKA
	fjiy54bFVpTiO9w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xJcz5-00D9zC-2L;
	Wed, 21 Oct 2026 22:36:10 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 21 Oct 2026 22:36:01 +0200
Subject: [PATCH v4 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-2-66f00b7a564c@virtuozzo.com>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6227;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=nh00pu51IsT3zM5A1R7uGgA2XAL0sg7pMkX5L0hR5qg=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq2SI40uwjfe9GN/YmjA61tXcSKiQclxtfzMsN2
 Mbs7XLQIiKJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCatkiOAAKCRBRlgpH+WFc
 KrT/D/9BsSDADsSj6G/kkL7TPB7IeoBkX1b2TyhPck22FQPKaM7KpzLFRcfIlpY+i8x0WkPgfBY
 OBi4LgL4xWrkveBTEc9ukzjhBe6h48OLwn2ImfvO9Fz4qKbPu7tK5NdQH/MeE62+bE3uujTmIxk
 TPXMxn0+GDL+7egr1nSfucEIITm1+vBjjSF0BddxU6SdmEXheMXxx7owHZD69xk1pSvp2ME16Jl
 JXdCj47SxNS19CV9mwQMe1p6xni3KnyIOsHhDwfK/c9Gv5fhAtoZAiKXBoIFQheeVFs6W3i2EaE
 BLytz3oIIRe6UOIyoQiQWoTz58090luuI7BLEgWefdW8n105r9mpEPEWdfCzcV4WnAV85LCBJjY
 3GGRaiYqsiwNOOYHOJSDDFuQ6wNU2f7qUQW00F7+ItUW/YNpQkduJPd0oyhkVjZElADi1N1HmED
 L8Yqb7L2nDf5XmAe3bxSMP94FZgLsWj2sc6Eu7a2MBBSIQm/2uTIANeUPY+zPYaCpq4u6gvcdIK
 gQO3Y7YvAVIwgR0Xe9qpaqBAac7KKA4EKcHbyksi4H3gfdfbIOyUoR061Zy/oRCnbeqKhSCK68/
 34DxAgGEfDzRaZ4v3q1LOAQnbQa3gKN6FDRCB/n+uTAD7MA5e3jl5ouJo1FKowyN2ZOOwJFJk1J
 IpAwWMr+4r/tNzQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
non-anonymous VMA and left the child to fault them in again, while the
PTEs of the same VMA are copied.

Treat file folios as the PTE path does: take a reference, duplicate the
rmap and account them. fork then pays a reference and an rmap update
per PMD, and saves the child a fault per PMD it touches. The next patch
sends PFN mappings through the same tail.

That covers the VMAs vma_needs_copy() sends here:

- private file mappings with an anon_vma;
- VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP (fuse DAX),
  and VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get
  from a guard region.

The DAX huge zero PMD is copied too, with a reference taken by
mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
file folio is copied and accounted like copy_nonpresent_pte() does, and
made read-only in both processes only in a CoW mapping.

The copy then gets the same tail as __copy_present_ptes(): write
protect both sides in a CoW mapping, mark the child's copy clean in a
shared one, and drop the uffd-wp bit where the child is not armed. An
anonymous THP is now write protected only when its PMD is writable, as
a PTE is.

A page table is deposited under the copy where the fault paths deposit
one: in anonymous VMAs, and wherever the architecture needs one.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 60 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a5..13e3674fb6115 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1898,12 +1898,13 @@ static void copy_huge_non_present_pmd(
 		pmd_t pmd, pgtable_t pgtable)
 {
 	softleaf_t entry = softleaf_from_pmd(pmd);
-	struct folio *src_folio;
+	struct folio *src_folio = softleaf_to_folio(entry);
 
 	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(pmd));
 
-	if (softleaf_is_migration_write(entry) ||
-	    softleaf_is_migration_read_exclusive(entry)) {
+	if ((softleaf_is_migration_write(entry) ||
+	     softleaf_is_migration_read_exclusive(entry)) &&
+	    vma_is_cow_mapping(src_vma)) {
 		entry = make_readable_migration_entry(swp_offset(entry));
 		pmd = softleaf_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*src_pmd))
@@ -1927,7 +1928,6 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = softleaf_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -1939,9 +1939,11 @@ static void copy_huge_non_present_pmd(
 					    dst_vma, src_vma);
 	}
 
-	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	add_mm_counter(dst_mm, mm_counter(src_folio), HPAGE_PMD_NR);
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 	if (!userfaultfd_protected(dst_vma))
 		pmd = pmd_swp_clear_uffd(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
@@ -1957,6 +1959,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmd_t pmd;
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
+	bool writable;
 
 	pmd = pmdp_get_lockless(src_pmd);
 	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
@@ -1977,13 +1980,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto set_pmd;
 	}
 
-	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(dst_vma))
-		return 0;
-
-	pgtable = pte_alloc_one(dst_mm);
-	if (unlikely(!pgtable))
-		goto out;
+	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(dst_mm);
+		if (unlikely(!pgtable))
+			goto out;
+	}
 
 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
 	src_ptl = pmd_lockptr(src_mm, src_pmd);
@@ -2001,7 +2002,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
-		pte_free(dst_mm, pgtable);
+		if (pgtable)
+			pte_free(dst_mm, pgtable);
 		goto out_unlock;
 	}
 	/*
@@ -2016,7 +2018,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * copy. It just takes a reference.
 		 */
 		mm_get_huge_zero_folio(dst_mm);
-		goto out_zero_page;
+		goto copy_pmd;
 	}
 
 	src_page = pmd_page(pmd);
@@ -2024,6 +2026,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	src_folio = page_folio(src_page);
 
 	folio_get(src_folio);
+	if (!folio_test_anon(src_folio)) {
+		folio_dup_file_rmap_pmd(src_folio, src_page, dst_vma);
+		add_mm_counter(dst_mm, mm_counter_file(src_folio),
+			       HPAGE_PMD_NR);
+		goto copy_pmd;
+	}
 	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		folio_put(src_folio);
@@ -2034,19 +2042,25 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		return -EAGAIN;
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-out_zero_page:
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+copy_pmd:
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 
-	/* See __copy_present_ptes(): restore accessible protection. */
+	/* See __copy_present_ptes(). */
+	writable = pmd_write(pmd);
 	if (!userfaultfd_protected(dst_vma)) {
 		if (userfaultfd_rwp(src_vma) && pmd_uffd(pmd))
 			pmd = pmd_modify(pmd, dst_vma->vm_page_prot);
 		pmd = pmd_clear_uffd(pmd);
 	}
-
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
-	pmd = pmd_wrprotect(pmd);
+	if (vma_is_cow_mapping(src_vma) && writable) {
+		pmdp_set_wrprotect(src_mm, addr, src_pmd);
+		pmd = pmd_wrprotect(pmd);
+	}
+	if (src_vma->vm_flags & VM_SHARED)
+		pmd = pmd_mkclean(pmd);
 set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);

-- 
2.43.0


