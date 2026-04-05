Return-Path: <linuxppc-dev+bounces-19378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1110F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXb16ld3z306l;
	Sun, 05 Apr 2026 22:58:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393933;
	cv=none; b=ZPMXav+v20psqR68sOj0w4dg75Pk5/Q3Cdt381WWsGSUkLTM/OWgjnru6FZMFG+YFlpNE59zRe1yI9WHYdRtH9jji6PiutHk7M+3NMn2FUfg9+C8TC1wZhNRKg2aJlLxZcCSOAZwcQZUgnq0IMg7JMkLESKcWwiYBInA18xUr/Mx2t46IXL8P/+EtF1vSvWLAgvbKB8xaSii7VlMQK3BWxkSqaT67l1a5GwT4iyiVMnZaAbxaOG4y8WIjtrRTJtBNSlnu53Xr8Zr1Sptzp3Lr5Kpxi6AjrGr6GgJuwUSoz9yIAuX6bD6aPb9X1yYfxNDOOyCeOxIS34T+83kolcvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393933; c=relaxed/relaxed;
	bh=ydW451GMW82JpMBYkjDYyQiyHYoh54ssuDXhIqDFdlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5dK81ITgGzEVwJtaNB9ChA5OCRETxyESX3RLk2vzCsLTt9r9HNjP2VQZBaB/uHcgnoNxFJtGamHBHL8chz34MsFTZ1+mVkr+WDsHmTf9yst1tjRYeCvYY/Mvir/N4hjw9uzE0X2dNkMHZiLjHx4q6WM1DPXf3MYO/4xZM7Idau13AEMSRdVFRGN5RLF+3EE90jp+ux/G+ZbgZ0X2rY1ZHrS27rxvLWvT5Fr5wbYHz0dcIFl3/nT/QtpGqyjfMh/0TnDXLVqfqGjp+9WLjWmi1IVAn3/RrcoMsVL/tkAZJyOHPy3unZEfBRVFqr4UZ66Wjn6Ci5qRr5ZDow72G1UOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Yvqf97N0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Yvqf97N0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXb04l0Rz3069
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:52 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1788327a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393931; x=1775998731; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydW451GMW82JpMBYkjDYyQiyHYoh54ssuDXhIqDFdlI=;
        b=Yvqf97N0XUSW+tXrZxTl0U/aSpUGT/y4kovCZrM6p7RZK/X20iC7GYbyWZzr3LYUDh
         8cQMjsYXnHd6GFhYPlejVNcVaJWmJWNuUzrMUeuGt9ujnctMYrjPgw4BalUqg/5cWoZa
         kydgvnSWTfdXlpvnT2c0zo7ngqtkKEPCzF2w5kxmC1RxHtAP3JhGJ1r4V8XxS8Sl+zsC
         NKAWR/M65NvWg96kgrpG5UZ9uHC8eh3fQhMrBv7JVJM+F6tzQkWfc3kWLGvGhBSRMiCN
         fIhe50QifPWwgAh6Ka1pSW5lekY42MxbQszPANOnUbMKpDbmLdHXhx+NJJ4rEj16hSJW
         k3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393931; x=1775998731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydW451GMW82JpMBYkjDYyQiyHYoh54ssuDXhIqDFdlI=;
        b=dKZ35snURPlEwPH7xGeOHAm6jX9UwSi+5GNZ3T/3tL/uU2r0CsGW0uh3Pb00AC5mGZ
         e9icUWT2vY/f8aUVQ5fDLB7KTBtQNo46XxwlqvXJtcFB256J1R6t+dwTf0BZZFZaXN2M
         K723CdiP/0SFAuRGbZvrJJ/tFbvofagk+cTlNjzokTDTEKiwKbbuy3Mw29koLdKi165p
         Lspe/Dc/3oZaQjFQKHpP48uTfTazW0r/gX2vMk2EA/Gd+zCeHrd/Vx4NhOknw8aDy1Zo
         OZljaWa6Sr1SiMbGRqQ66RQj/xTqbhQdOiJacsX7oN1y7lu9xovBBY9vyiz1Hg+R6Jbb
         pMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWudEUGrMhUxFqTCuZzsffuJ12YZaTqYFzYdlKpXiOTTEmNiY/XvGJ7aKLuc7ipDLfvrQ7nh7I4aulUU28=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOY/P4/NI7yUEkV56mKJY4U/C55FVNLbhe3Tvv2Erm3r4E84rE
	PUGI5qGQrOF8swkNzYBkmERgS46tBd9ow5EaT34EML8wC1tLcH9yZPQpQRaVTQiviPk=
X-Gm-Gg: AeBDietPxpr+GmX8Np3tA5bECPtGnbRBvXVWse7FdhvJBCN4KjoI2f1JESJzSJwPQWI
	W2ZrWW4ll3RWBzahKMzCNdeRvW2qdDlOxdlNV6QUdPhFMVFGsGtejFVLztNMImqh4bgTw3QHvb7
	0LXroTAGtOKiONP0D47klhL60Up3BAOqoBiau4rTMKVqGrXlelbPk1QTF7sv+sNy9yrs0l14cgK
	Vzz7udaMKe8j2vLl4z/SOIgYLw7fQBejxzSAP3f8X9Y3fovc9JX457sVM0X+aopFVTO+Scqr/jw
	/diinq6oaIpxaulvl0fN4Mw/AXB5sPt1LNfwAlQ6G2jIXPt6idSK56V6TfXnyn5GoQyAhgZGYXe
	CCkmIqmZghbG/+8E8UEu6CuyzM+s/aF69C4ia4M904d8lAy5J1UHGzGpegUjf/lZjPlxbmXnu8n
	RU7q/Ysm/NBYgRq0eEt9d6ZyNlB44NjzvEkc3g8+gqvzo=
X-Received: by 2002:a17:90b:2688:b0:354:a332:1a61 with SMTP id 98e67ed59e1d1-35de678f2b0mr8914364a91.5.1775393930429;
        Sun, 05 Apr 2026 05:58:50 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:50 -0700 (PDT)
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
Subject: [PATCH 48/49] Documentation/mm: restructure vmemmap_dedup.rst to reflect generalized HVO
Date: Sun,  5 Apr 2026 20:52:39 +0800
Message-Id: <20260405125240.2558577-49-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation Documentation/mm/vmemmap_dedup.rst is slightly
outdated and poorly structured. The current document primarily focuses
on HugeTLB pages as the main context, which fails to clearly communicate
the general principles of Hugepage Vmemmap Optimization (HVO).

To make it more logical and readable, refine the document. Specifically,
introduce the general HVO concepts, principles, and calculations that
are agnostic to specific subsystems. Remove the outdated and
subsystem-specific contexts (like explicit HugeTLB and Device DAX sections)
to better reflect the universal applicability of HVO to any large compound
page.

This reorganization makes the documentation much easier to read and
understand, and aligns with the recent renaming and generalization of
the HVO mechanism.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/mm/vmemmap_dedup.rst | 218 ++++++-----------------------
 1 file changed, 42 insertions(+), 176 deletions(-)

diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 44e80bd2e398..a21d84fcbe24 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -1,107 +1,33 @@
-
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================================
-A vmemmap diet for HugeTLB and Device DAX
-=========================================
-
-HugeTLB
-=======
-
-This section is to explain how Hugepage Vmemmap Optimization (HVO) for HugeTLB works.
+===================================================
+Fundamentals of Hugepage Vmemmap Optimization (HVO)
+===================================================
 
-The ``struct page`` structures are used to describe a physical page frame. By
-default, there is a one-to-one mapping from a page frame to its corresponding
+The ``struct page`` structures are used to describe a physical base page frame.
+By default, there is a one-to-one mapping from a page frame to its corresponding
 ``struct page``.
 
-HugeTLB pages consist of multiple base page size pages and is supported by many
-architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
-details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
-currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
-consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
-For each base page, there is a corresponding ``struct page``.
-
-Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
-contain unique information about a HugeTLB page. ``__NR_USED_SUBPAGE`` provides
-this upper limit. The only 'useful' information in the remaining ``struct page``
-is the compound_info field, and this field is the same for all tail pages.
-
-By removing redundant ``struct page`` for HugeTLB pages, memory can be returned
-to the buddy allocator for other uses.
-
-Different architectures support different HugeTLB pages. For example, the
-following table is the HugeTLB page size supported by x86 and arm64
-architectures. Because arm64 supports 4k, 16k, and 64k base pages and
-supports contiguous entries, so it supports many kinds of sizes of HugeTLB
-page.
-
-+--------------+-----------+-----------------------------------------------+
-| Architecture | Page Size |                HugeTLB Page Size              |
-+--------------+-----------+-----------+-----------+-----------+-----------+
-|    x86-64    |    4KB    |    2MB    |    1GB    |           |           |
-+--------------+-----------+-----------+-----------+-----------+-----------+
-|              |    4KB    |   64KB    |    2MB    |    32MB   |    1GB    |
-|              +-----------+-----------+-----------+-----------+-----------+
-|    arm64     |   16KB    |    2MB    |   32MB    |     1GB   |           |
-|              +-----------+-----------+-----------+-----------+-----------+
-|              |   64KB    |    2MB    |  512MB    |    16GB   |           |
-+--------------+-----------+-----------+-----------+-----------+-----------+
-
-When the system boot up, every HugeTLB page has more than one ``struct page``
-structs which size is (unit: pages)::
-
-   struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
-
-Where HugeTLB_Size is the size of the HugeTLB page. We know that the size
-of the HugeTLB page is always n times PAGE_SIZE. So we can get the following
-relationship::
-
-   HugeTLB_Size = n * PAGE_SIZE
-
-Then::
+When huge pages (large compound page) are used, they consist of multiple base
+page size pages. For each base page, there is a corresponding ``struct page``.
+However, only a few ``struct page``
+structures are actually used to contain unique information about the huge page.
+The only 'useful' information in the remaining tail ``struct page`` structures
+is the ``->compound_info`` field to get the head page structure, and this field
+is the same for all tail pages.
 
-   struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
-               = n * sizeof(struct page) / PAGE_SIZE
+We can remove redundant ``struct page`` structures for huge pages to save memory.
+This optimization is referred to as Hugepage Vmemmap Optimization (HVO).
 
-We can use huge mapping at the pud/pmd level for the HugeTLB page.
+The optimization is only applied when the size of the ``struct page`` is a
+power-of-2. In this case, all tail pages of the same order are identical. See
+``compound_head()``. This allows us to remap the tail pages of the vmemmap to a
+shared page.
 
-For the HugeTLB page of the pmd level mapping, then::
+Let’s take a system with a 2 MB huge page and a base page size of 4 KB as an
+example for illustration. Here is how things look before optimization::
 
-   struct_size = n * sizeof(struct page) / PAGE_SIZE
-               = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
-               = sizeof(struct page) / sizeof(pte_t)
-               = 64 / 8
-               = 8 (pages)
-
-Where n is how many pte entries which one page can contains. So the value of
-n is (PAGE_SIZE / sizeof(pte_t)).
-
-This optimization only supports 64-bit system, so the value of sizeof(pte_t)
-is 8. And this optimization also applicable only when the size of ``struct page``
-is a power of two. In most cases, the size of ``struct page`` is 64 bytes (e.g.
-x86-64 and arm64). So if we use pmd level mapping for a HugeTLB page, the
-size of ``struct page`` structs of it is 8 page frames which size depends on the
-size of the base page.
-
-For the HugeTLB page of the pud level mapping, then::
-
-   struct_size = PAGE_SIZE / sizeof(pmd_t) * struct_size(pmd)
-               = PAGE_SIZE / 8 * 8 (pages)
-               = PAGE_SIZE (pages)
-
-Where the struct_size(pmd) is the size of the ``struct page`` structs of a
-HugeTLB page of the pmd level mapping.
-
-E.g.: A 2MB HugeTLB page on x86_64 consists in 8 page frames while 1GB
-HugeTLB page consists in 4096.
-
-Next, we take the pmd level mapping of the HugeTLB page as an example to
-show the internal implementation of this optimization. There are 8 pages
-``struct page`` structs associated with a HugeTLB page which is pmd mapped.
-
-Here is how things look before optimization::
-
-    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
+  2MB Hugepage                  struct pages (8 pages)        page frame (8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     +-----------+                +-----------+
@@ -112,9 +38,9 @@ Here is how things look before optimization::
  |           |                     |     3     | -------------> |     3     |
  |           |                     +-----------+                +-----------+
  |           |                     |     4     | -------------> |     4     |
- |    PMD    |                     +-----------+                +-----------+
- |   level   |                     |     5     | -------------> |     5     |
- |  mapping  |                     +-----------+                +-----------+
+ |           |                     +-----------+                +-----------+
+ |           |                     |     5     | -------------> |     5     |
+ |           |                     +-----------+                +-----------+
  |           |                     |     6     | -------------> |     6     |
  |           |                     +-----------+                +-----------+
  |           |                     |     7     | -------------> |     7     |
@@ -124,34 +50,27 @@ Here is how things look before optimization::
  |           |
  +-----------+
 
-The first page of ``struct page`` (page 0) associated with the HugeTLB page
-contains the 4 ``struct page`` necessary to describe the HugeTLB. The remaining
-pages of ``struct page`` (page 1 to page 7) are tail pages.
-
-The optimization is only applied when the size of the struct page is a power
-of 2. In this case, all tail pages of the same order are identical. See
-compound_head(). This allows us to remap the tail pages of the vmemmap to a
-shared, read-only page. The head page is also remapped to a new page. This
-allows the original vmemmap pages to be freed.
+We remap the tail pages (page 1 to page 7) of the vmemmap to a shared, read-only
+page (per-zone).
 
 Here is how things look after remapping::
 
-    HugeTLB                  struct pages(8 pages)                 page frame (new)
+  2MB Hugepage                  struct pages(8 pages)           page frame (1 page)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +----------------+
  |           |                     |     0     | -------------> |       0        |
  |           |                     +-----------+                +----------------+
  |           |                     |     1     | ------┐
  |           |                     +-----------+       |
- |           |                     |     2     | ------┼        +----------------------------+
+ |           |                     |     2     | ------┼
+ |           |                     +-----------+       |
+ |           |                     |     3     | ------┼        +----------------------------+
  |           |                     +-----------+       |        | A single, per-zone page    |
- |           |                     |     3     | ------┼------> | frame shared among all     |
+ |           |                     |     4     | ------┼------> | frame shared among all     |
  |           |                     +-----------+       |        | hugepages of the same size |
- |           |                     |     4     | ------┼        +----------------------------+
+ |           |                     |     5     | ------┼        +----------------------------+
+ |           |                     +-----------+       |
+ |           |                     |     6     | ------┼
  |           |                     +-----------+       |
- |           |                     |     5     | ------┼
- |    PMD    |                     +-----------+       |
- |   level   |                     |     6     | ------┼
- |  mapping  |                     +-----------+       |
  |           |                     |     7     | ------┘
  |           |                     +-----------+
  |           |
@@ -159,65 +78,12 @@ Here is how things look after remapping::
  |           |
  +-----------+
 
-When a HugeTLB is freed to the buddy system, we should allocate 7 pages for
-vmemmap pages and restore the previous mapping relationship.
-
-For the HugeTLB page of the pud level mapping. It is similar to the former.
-We also can use this approach to free (PAGE_SIZE - 1) vmemmap pages.
-
-Apart from the HugeTLB page of the pmd/pud level mapping, some architectures
-(e.g. aarch64) provides a contiguous bit in the translation table entries
-that hints to the MMU to indicate that it is one of a contiguous set of
-entries that can be cached in a single TLB entry.
-
-The contiguous bit is used to increase the mapping size at the pmd and pte
-(last) level. So this type of HugeTLB page can be optimized only when its
-size of the ``struct page`` structs is greater than **1** page.
-
-Device DAX
-==========
-
-The device-dax interface uses the same tail deduplication technique explained
-in the previous chapter, except when used with the vmemmap in
-the device (altmap).
-
-The following page sizes are supported in DAX: PAGE_SIZE (4K on x86_64),
-PMD_SIZE (2M on x86_64) and PUD_SIZE (1G on x86_64).
-For powerpc equivalent details see Documentation/arch/powerpc/vmemmap_dedup.rst
-
-The differences with HugeTLB are relatively minor.
-
-It only use 3 ``struct page`` for storing all information as opposed
-to 4 on HugeTLB pages.
-
-There's no remapping of vmemmap given that device-dax memory is not part of
-System RAM ranges initialized at boot. Thus the tail page deduplication
-happens at a later stage when we populate the sections. HugeTLB reuses the
-the head vmemmap page representing, whereas device-dax reuses the tail
-vmemmap page. This results in only half of the savings compared to HugeTLB.
-
-Deduplicated tail pages are not mapped read-only.
+Therefore, for any hugepage, if the total size of its corresponding ``struct pages``
+is greater than or equal to the size of two base pages, then HVO technology can
+be applied to this hugepage to save memory. For example, in this case, the
+smallest hugepage that can apply HVO is 512 KB (its order corresponds to
+``OPTIMIZABLE_FOLIO_MIN_ORDER``). Therefore, any hugepage with an order greater
+than or equal to ``OPTIMIZABLE_FOLIO_MIN_ORDER`` can apply HVO technology.
 
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PMD    |                     +-----------+                       | | |
- |   level   |                     |     5     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     6     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     7     | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
+Meanwhile, each HVOed hugepage still has ``OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS``
+available ``struct page`` structures.
-- 
2.20.1


