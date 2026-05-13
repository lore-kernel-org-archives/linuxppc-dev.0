Return-Path: <linuxppc-dev+bounces-20918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C022CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvKg6bLFz3cRP;
	Wed, 13 May 2026 23:23:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678599;
	cv=none; b=fIsj6lcaAWx78nRdUXkBUKH9jkkBuueAErhtb9/SoceJl9LxPmf6m5dBuDAl1jCaB57MLSCWuQIDw2K4akuH8P7JL9g+C3ueImN+SPjiAVvVpC5NadVqzXApyLuiB+0+aGr+AAuRpata4Xe5SUxqj04ngQWFLkftDCIFoPj+qXK/j/rqYlKhdzJ8fnw327BCOhJxRCelRWS6iMCzpNNz3+9djsQ7ToQTcqlpUrFI/ASRUHsnjuRaViTZFGivSYVxWo7Yo3OBjjgswvTRK/cgsu/YHg/sBOe2VisfOCNwd0GK8yr0YvRRLDa1n7imPsDxyRB60DOHXsBd0XSc4SzmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678599; c=relaxed/relaxed;
	bh=+Cnpd+J8+D+7FfVvUC6O4aPMQlYjZ4NT8MOvKV4QYBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPGG+ekamjI/AEXnny7TqBS6dOJLuJGEry63KYDs4I62ciYvVQQxHiMoRffesiZj6KkaSi3/3ihbjHDsnPiUt224cG4GIBfHpA2PEkavXQsciFM+UcGL5kTQ4RdN79fKdTaM0E2pT5S3/OJ+ZZBspfevAo0xt1GBsN3o3rgpGLe1y5RooUm5ISIVEKHucZFJfmwpav51nkgW+7/fmL4bnJaC/X38iEVnCmQhTBMS5PUuq6ZQhVexhT1XZurz7WYWvJKSbcVvBADIND57V5DOW8gHUPa5uKqQlPiY29ATr5MGDqO2Jo4ZPbThoW8ieXwlFpIrWpvudNWcCyVMSJ+wvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SPo+W5Po; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SPo+W5Po;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvKf550Rz3cR8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:23:18 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso1558313a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678597; x=1779283397; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cnpd+J8+D+7FfVvUC6O4aPMQlYjZ4NT8MOvKV4QYBk=;
        b=SPo+W5Po5Mo9UGSXVx1kP3z/k60zi2Es8DqxTbU8myrlD/4HPEosKksS8NwIe1derr
         LpF/NjTC9viPyHU6SyXETEPVniqd/K71kDfQnMR5FpWSvs3q2Bi17x19C7JhHN2HNYBj
         3z1CQpMIlAUQUYL5XQWLG7qAmPrWC2HqshkFGJtVW9WZzUu9kiWqw+hwGiH9QmjjoVbm
         hjJP5UPDT2nWsjDCyfklPSJrlr/ZNM9RdzLwnai8/OWkCXWVeP1lya6fYj3b0mflUK2g
         dTrLe07TvDHm6uamXDheci3TH6eOvNLCBGG1saF/pTHyB90Iv3MFPlNPG9Cf3eR3JsPs
         wC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678597; x=1779283397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Cnpd+J8+D+7FfVvUC6O4aPMQlYjZ4NT8MOvKV4QYBk=;
        b=Li5aaIgBYRDkSOO3S9RyXvAcJDS1ol2JEpuCPzfCy3ZuF7+jbQjLthg1/1uEBqXTgK
         M6rECB2qn8fsda9C2EsFJBq4qiCHXf/tcYdO/bUR6n0s3gRSqxJb8gt2uZufSglC9XfA
         Uw2FEqOZGWMDg6uAjjqXa4LxEpDuj56hu0MUFneF8fmxQi5bM8nlubcgy8t92sIXpD64
         rK4c4BBHRx1D0pBmkleJzWnIQnIsvdUO2JqOT5UBKxhXzV6CgUIq8WtqTA+5M7049Xw8
         pvwmh6SnT8S3KJJWHlGQ/utx5IwxB2e116J4/zPGf6aLBNgojICEQuOqOQfaKcVVWS7v
         qTXg==
X-Forwarded-Encrypted: i=1; AFNElJ8biNiBTpZoB17ap7N8K49nwu6QtDVpFNwYBPNE7r6sLQ6+DUquH53gaEDG/Mqx9399LYGvd3+Vbm9qKnI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0pIgBIFoXCSIef+DLgMxwY4XSLc4jfa2gcMJrgsBo78Aw83gx
	O3q9SPY9/FXdLlYFaHcb4bml8T34bZz3jzGbOPNepZL4UGhkxC5YCPuZ8xSqWwMyme8=
X-Gm-Gg: Acq92OGCWc1Klzj4Q11/Ssy/oC0wZemAF69JmqVSuSQLzyig3eJjB4ZlS6BNi4A/XG8
	wlvyKIqD7ZFcd+ily60G8/BAOcDu/QT1I1Nya8EntWLIoo3itf8s6BCjPcQyiD1WVMVJ945PIOH
	OKORmTx8kFF2Q/n4NC/dwDa00Yp8PdZB2C8WNfBOZRh5TM6S+fFlGSrFLT5Vgt0XfcZKMaBNGE4
	FpoHgW0sdRV6YIWE5novvQKTOn1rPSH2LyMNh2nRrSRaKp1vKNgtT/JljOQUvMglgrnLojhF4Cb
	faYFeX5zOH3wIXBj49GsALpT7SbIEIbh0y3cTOM17WkeOPgYN6xoBKeAuhu9knddMkY1CnK2puH
	aeUbk9e67LaocJEd180cE8p/EXja115rKO1T9aBcQc24tEuX6nDePDiDTHFOyx/ItOhUsKWXYAG
	JNymLiwvpBv9sJwuP+SAp8YdwB+LFlW1JDW/mPp1xvcvcjrRagRs48Nwqkt2Ep
X-Received: by 2002:a17:90b:3a8e:b0:366:5283:cddf with SMTP id 98e67ed59e1d1-368f3d1b489mr2919831a91.9.1778678596480;
        Wed, 13 May 2026 06:23:16 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.23.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:23:16 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 69/69] Documentation/mm: Rewrite vmemmap_dedup.rst for unified HVO
Date: Wed, 13 May 2026 21:20:34 +0800
Message-ID: <20260513132044.41690-23-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

HVO is no longer specific to HugeTLB. The optimization has been
generalized for other large compound-page users, including device DAX,
but vmemmap_dedup.rst still describes the old split model.

Rewrite the document around the shared HVO design and behavior, and
drop the obsolete powerpc-specific document that only covered the old
device DAX path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/arch/powerpc/index.rst         |   1 -
 Documentation/arch/powerpc/vmemmap_dedup.rst | 101 ---------
 Documentation/mm/vmemmap_dedup.rst           | 217 ++++---------------
 3 files changed, 42 insertions(+), 277 deletions(-)
 delete mode 100644 Documentation/arch/powerpc/vmemmap_dedup.rst

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 40419bea8e10..4dcf6b0f218c 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -36,7 +36,6 @@ powerpc
     ultravisor
     vas-api
     vcpudispatch_stats
-    vmemmap_dedup
     vpa-dtl
 
     features
diff --git a/Documentation/arch/powerpc/vmemmap_dedup.rst b/Documentation/arch/powerpc/vmemmap_dedup.rst
deleted file mode 100644
index dc4db59fdf87..000000000000
--- a/Documentation/arch/powerpc/vmemmap_dedup.rst
+++ /dev/null
@@ -1,101 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-==========
-Device DAX
-==========
-
-The device-dax interface uses the tail deduplication technique explained in
-Documentation/mm/vmemmap_dedup.rst
-
-On powerpc, vmemmap deduplication is only used with radix MMU translation. Also
-with a 64K page size, only the devdax namespace with 1G alignment uses vmemmap
-deduplication.
-
-With 2M PMD level mapping, we require 32 struct pages and a single 64K vmemmap
-page can contain 1024 struct pages (64K/sizeof(struct page)). Hence there is no
-vmemmap deduplication possible.
-
-With 1G PUD level mapping, we require 16384 struct pages and a single 64K
-vmemmap page can contain 1024 struct pages (64K/sizeof(struct page)). Hence we
-require 16 64K pages in vmemmap to map the struct page for 1G PUD level mapping.
-
-Here's how things look like on device-dax after the sections are populated::
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
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     15    | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
-
-
-With 4K page size, 2M PMD level mapping requires 512 struct pages and a single
-4K vmemmap page contains 64 struct pages(4K/sizeof(struct page)). Hence we
-require 8 4K pages in vmemmap to map the struct page for 2M pmd level mapping.
-
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
-
-With 1G PUD level mapping, we require 262144 struct pages and a single 4K
-vmemmap page can contain 64 struct pages (4K/sizeof(struct page)). Hence we
-require 4096 4K pages in vmemmap to map the struct pages for 1G PUD level
-mapping.
-
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
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |   4095    | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 44e80bd2e398..c3a68a923b0d 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -1,107 +1,34 @@
 
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================================
-A vmemmap diet for HugeTLB and Device DAX
-=========================================
+===================================================
+Fundamentals of Hugepage Vmemmap Optimization (HVO)
+===================================================
 
-HugeTLB
-=======
-
-This section is to explain how Hugepage Vmemmap Optimization (HVO) for HugeTLB works.
-
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
-
-   struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
-               = n * sizeof(struct page) / PAGE_SIZE
+When huge pages (large compound page) are used, they consist of multiple base
+page size pages. For each base page, there is a corresponding ``struct page``.
+However, only a few ``struct page``
+structures are actually used to contain unique information about the huge page.
+The only 'useful' information in the remaining tail ``struct page`` structures
+is the ``->compound_info`` field to get the head page structure, and this field
+is the same for all tail pages.
 
-We can use huge mapping at the pud/pmd level for the HugeTLB page.
+We can remove redundant ``struct page`` structures for huge pages to save memory.
+This optimization is referred to as Hugepage Vmemmap Optimization (HVO).
 
-For the HugeTLB page of the pmd level mapping, then::
+The optimization is only applied when the size of the ``struct page`` is a
+power-of-2. In this case, all tail pages of the same order are identical. See
+``compound_head()``. This allows us to remap the tail pages of the vmemmap to a
+shared page.
 
-   struct_size = n * sizeof(struct page) / PAGE_SIZE
-               = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
-               = sizeof(struct page) / sizeof(pte_t)
-               = 64 / 8
-               = 8 (pages)
+Let’s take a system with a 2 MB huge page and a base page size of 4 KB as an
+example for illustration. Here is how things look before optimization::
 
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
@@ -112,9 +39,9 @@ Here is how things look before optimization::
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
@@ -124,34 +51,27 @@ Here is how things look before optimization::
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
@@ -159,65 +79,12 @@ Here is how things look after remapping::
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
+Meanwhile, each HVOed hugepage still has ``OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES``
+available ``struct page`` structures.
-- 
2.54.0


