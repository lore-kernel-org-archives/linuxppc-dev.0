Return-Path: <linuxppc-dev+bounces-19370-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AE8EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXYt2nCpz2yxk;
	Sun, 05 Apr 2026 22:57:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393874;
	cv=none; b=TVRAxD9AoAu0NpiCvr/TM2F8KFir9NvZCDvK1xcW7qQ5DYAn+qV8g0m2CAiiUAXG7q36zCAqoWhMvRJhmisivQUWJm8X3YnCPlRPC6WC1YtDZJVHrUTbCC9+DXGDN5W6Rfg0FxyoL9raEtLCafPOuA3JVkPS+rZ1jObiak4k9ZCllGf0t5P/TKN4icqZT3Tq4Q4hHFvlm3/tlyCsjBv9H6Oaksll4V4dj3TiS/89Gg/pRgw2F1x4XK/ZhAphcAv1rxUnqF1ObozWNXHNbve0/aLiHH62EKk5hEKHNpyViNLXkQ0E24/cF2NK1g5SGW9w4fJRFVkvQqZup6n9awxYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393874; c=relaxed/relaxed;
	bh=S8clnDPRP9vVZ4b0lvB2dcHmNampuC1uraKtfe//7Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMpXVvdEcMSGRAYnaEdpJfJIbUTBJQfK+DIq8SOy0xRYkNWTW6e+ytLPcCpxu1WZ+W4LmpXlkHOz5x+3DSSq5Mh2luTBSmmFnN4yntU7OmGcw+Afi34XBsA6PB+JbQ168T79FDtwZrFgOT1Kv4baZOCo0ryKwAcX1gCXIl8gWs4lgice4dkVR2U+ByzAJDCz2sVkC2j6PLVkBN4aoG6ZF06sTlBwbFvf0pqAk72J3qecR9t47i1DYFk2Z8o23vt1tn8JSDoqUcLvewNPy3n21gkH56sp8trsK9jodFClO9ECbswZlAkyojF9XmgrxcRyo2pNdgom/oFds6kvhjozHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SkG41WnU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SkG41WnU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXYs4cMXz2yxf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:53 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1734889a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393872; x=1775998672; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8clnDPRP9vVZ4b0lvB2dcHmNampuC1uraKtfe//7Z8=;
        b=SkG41WnUbN39rOqrqcdkpomSG+ATu4bP4/6j0Q78ePoOZw+7raqIYndlPebNAZJPSD
         R4Nsj4h29M8dGeG7bGO0jF1P2CFzHrPDssN5ZfAj+bk7ggdThqbL8iAS7laB7flBLsJ+
         E3G0k8fHSPPkKx+H97sAz5ZGY03KtnV8myQX0ycBLexxF8ftteImFi9vCxEi1cV6F+Dd
         y4cc5OnT9jMwZXvQyX//2nPLENjXBX8rhdkbAVPpqwQz1gJmEfR4alnH0NZYOgKw232M
         dsG90/kh3xzXCf0nsxh/EQ9F/jEULI4v+hZ1DefyPHdgKWpC+vfr5Rn7mwHonBN7NTAB
         n+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393872; x=1775998672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8clnDPRP9vVZ4b0lvB2dcHmNampuC1uraKtfe//7Z8=;
        b=rlncXNBJrqGvorqf94IVVBzzgHksx03zuQ9g+KlWtiO0kD1O07gTEkV1W3KdpBN7bN
         zcyhxzqVL7ezOjICo0b7e9BAofK51WxhKbkQ3CfcEacZRZMzaerGmW/3V/pxcKU9Pf9Z
         gCbOyjkikCeZ/j/ct5Y7vGXOhnQxXcMUaWBJqN7OYqnJnnNii774RkX2s3MCwLproygl
         gZfGLgbXlP2wRD2QlP1NgUZpgKgsTe7469kTu4SHelb414A+wFWLxkhLEUMkUga+1gV1
         lKEKEGCEr4gXsSx0O+LswTwZZfSR+FmJvBzlkVSb7Qf3oY+e01OzklOVOvDXOw9SKNG4
         J8mw==
X-Forwarded-Encrypted: i=1; AJvYcCUUE6+10qhfHCIMEAjZYJCgBoHQ16wmu6infNVh43WRKtbFIavot3mTA03S7yXK4ivwMW+ocibguTRdF98=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXCtXrqpZUUfq+/sIGoHrsNQTdn4uURX86Yao3X2bXHUrNdwkn
	pFlWES7+P/MYP1biPMXRs6hacAOPfQzhppwK+oq6+Zhx3aEgf6cSXRIVQ3EpxD+Vrkk=
X-Gm-Gg: AeBDietZo1UYTNXgujZ8NmlJ91bTmEhfoG/LxMaYZdcJ1fkPh7cNYSvNIbunkZGDZX4
	JcxggoVg/6cVmH9CkpTfAoQfMVx0ni1xy4Mguu9qQipR/sbsdB2wZAdvQDC+PPQPlSTlUwxBSZZ
	XWfHau566Ho1qK4r+L4itAglnD60MkPBDI27yiI/AxRjppqlH+iA97wNBdwA37DkTSdfCcF+eR3
	0J1H3lJikiIRCa/6Ja9ttF7hH5UogSPQQACV8uN2fVG+SIqH37MMwGF/Lwno7ytX3SmoAca4d7s
	PjHqW3+lwXT2r1lcw/wDkgtVSxPMTGlX2l/jDioTC1duQfnQWjq1wefjnD9gFYfZfV6qVhPyEAM
	aJlZg3Nj+ypzjyYn5NKPS41nOn4GMsEcGZIy5mD0bIctjrtBLdPV0LUDAlW9OBhFksw9g6JSc5h
	ASZVP73LGtPDHUdPkZ14QoYnmIAFjlr9gC82xiBJ+boz0=
X-Received: by 2002:a17:90b:4ac7:b0:35d:a2aa:3b05 with SMTP id 98e67ed59e1d1-35de678f96fmr8947608a91.5.1775393871728;
        Sun, 05 Apr 2026 05:57:51 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:57:51 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 40/49] mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo() and related code
Date: Sun,  5 Apr 2026 20:52:31 +0800
Message-Id: <20260405125240.2558577-41-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Since we have already remapped the shared tail pages as read-only in
vmemmap_pte_populate() right at the point of mapping establishment,
the separate pass of read-only mapping enforcement via
vmemmap_wrprotect_hvo() for HugeTLB bootmem folios is no longer
necessary.

Remove vmemmap_wrprotect_hvo() and the associated wrapper
hugetlb_vmemmap_optimize_bootmem_folios(), simplifying the code by
directly using hugetlb_vmemmap_optimize_folios() for bootmem folios
as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  2 --
 mm/hugetlb.c         |  2 +-
 mm/hugetlb_vmemmap.c | 31 ++++---------------------------
 mm/hugetlb_vmemmap.h |  6 ------
 mm/sparse-vmemmap.c  | 23 -----------------------
 5 files changed, 5 insertions(+), 59 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bceef0dc578b..c36001c9d571 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4877,8 +4877,6 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       struct dev_pagemap *pgmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
-			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ce5a58aab5c3..84f095a23ef2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3226,7 +3226,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
-	hugetlb_vmemmap_optimize_bootmem_folios(h, folio_list);
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 92c95ebdbb9a..d595ef759bc2 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -589,31 +589,18 @@ static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *fol
 	return vmemmap_remap_split(vmemmap_start, vmemmap_end);
 }
 
-static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
-					      struct list_head *folio_list,
-					      bool boot)
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
-	int nr_to_optimize;
+	unsigned long nr_to_optimize = 0;
 	LIST_HEAD(vmemmap_pages);
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
-	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
-		unsigned long spfn, epfn;
-
-		if (boot && folio_test_hugetlb_vmemmap_optimized(folio)) {
-			/*
-			 * Already optimized by pre-HVO, just map the
-			 * mirrored tail page structs RO.
-			 */
-			spfn = (unsigned long)&folio->page;
-			epfn = spfn + pages_per_huge_page(h);
-			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
-					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
+
+		if (folio_test_hugetlb_vmemmap_optimized(folio))
 			continue;
-		}
 
 		nr_to_optimize++;
 
@@ -667,16 +654,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, false);
-}
-
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list)
-{
-	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
-}
-
 void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
 	struct hstate *h = m->hstate;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index ff8e4c6e9833..0022f9c5a101 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,7 +19,6 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
-void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -61,11 +60,6 @@ static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list
 {
 }
 
-static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
-						struct list_head *folio_list)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 36e5bcb5ba9b..ba8c0c64f160 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -296,29 +296,6 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-/*
- * Write protect the mirrored tail page structs for HVO. This will be
- * called from the hugetlb code when gathering and initializing the
- * memblock allocated gigantic pages. The write protect can't be
- * done earlier, since it can't be guaranteed that the reserved
- * page structures will not be written to during initialization,
- * even if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
- *
- * The PTEs are known to exist, and nothing else should be touching
- * these pages. The caller is responsible for any TLB flushing.
- */
-void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
-				    int node, unsigned long headsize)
-{
-	unsigned long maddr;
-	pte_t *pte;
-
-	for (maddr = addr + headsize; maddr < end; maddr += PAGE_SIZE) {
-		pte = virt_to_kpte(maddr);
-		ptep_set_wrprotect(&init_mm, maddr, pte);
-	}
-}
-
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
 	void *addr;
-- 
2.20.1


