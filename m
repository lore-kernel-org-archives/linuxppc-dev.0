Return-Path: <linuxppc-dev+bounces-21875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F9FCD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:10:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66P2l6zz2yv2;
	Tue, 02 Jun 2026 20:10:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395053;
	cv=none; b=m9+n0uuKyfV1pOVSFmdbw5qe1I40Ge5U8ELcaDikFlYOd09C444ZtNXKV5D/dTEBMRDXw87u0N0Np9I+p+ongyLOdLvm1IvAeJcjeHTEiA+FXthsFIi75VUrCrwxbvkbkUkFHkg4PR5hZUYKfLgizPByIaii5cr+Bt5TE0pnOVUH6YrvJpcnmWKkJAZJn7WELZRmCNZ4KvhNGQFdTkKkRpVxd8CR/KMsFiPgxbWJ3F2UCIVnOUKFJ6lWglQp4uyCmq9XNJN/zcT0p1NvFQG87yfS7e+VqQo3xXwPB79ymZfKXwS+DwBXV/jUhL15kqUPxVl9XtwUcYMp8PQWvd7JUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395053; c=relaxed/relaxed;
	bh=zNGpJprl3yzyJVtHG2aqs675IpD1ef+Hoi2rqDj3HMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWLhRlPEDu9iiUrMLr+BBGGumIpOU2GfAmQYYA/d1YSnul3dJExFwwbJQ7TdHhaStTdKziR5Nyvpbew2/oPPwiWwFgE75Dzd4eV817A/oSKCx6LAE6/uw5u9Y/scSGrslrsmPTJCvcAkYlV9f2tCmDUl7cs+e06B9LLco/FHtIIeta5yf1PQm4QVSfUyg6a6Lo38GWvLhPSqGLM+fgKk+xn2Ps6lDOAthSDV4K7zcrdSEg/6Hxadu7ly8We//xMqXHf6UzC2ezo2TZ38kpWPUQ5EczLJOtaRfaCrXqVOKog7It8ey9BCX2QKntv1fnAjwZZS5ElovRxKGvUevGAMBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Mu2pth7K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Mu2pth7K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66L6Rp2z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:10:50 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84234c83142so985697b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395048; x=1780999848; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNGpJprl3yzyJVtHG2aqs675IpD1ef+Hoi2rqDj3HMc=;
        b=Mu2pth7Kgl83adAgTH5bFz8qv8QmO03NPE9YrXCK+hteacEyTd+/Ri+EsBpponIfHN
         dgzIeQ9wIyJSZeHxb+KlBnk3nzZCb6WPOBxuzlYoJuRWEgQ++e5ioQOQj82pFKW+V4i+
         ee7jCSbIVC6Ave66mUzvO/PrRLF1huav1eJV7fY9Nhh9t7yCGBITSffzlvuhHTegEHP4
         tOJumTsQ1zjw9FYG3bNYEvwyUwDadNHZBOd31mFB3ytPY1RiXCz8zfIfErPGsOTPoU18
         BgXB6WT5PAD+mE4W2C/0nG5wz8T9N6a6sXaKkuIjG4682ArM+QFsY1qVPTNzNe0+LvRm
         6V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395048; x=1780999848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNGpJprl3yzyJVtHG2aqs675IpD1ef+Hoi2rqDj3HMc=;
        b=GT4e7gn1wHhgmS62qSMCAy7pgXw/ZtKqbZTvrP3xraMcG8E3QmLAGppqU0tN1cqaf9
         qyS7UUs6QEChdnIcdyeaZlcGVpO/Jt4pPLQycW6rzMqP5fN1CXBo4y7VSQIfwWMbKdU1
         qFc1KaaZFou9FBLh9m3t6NY3hxz5QPrJTrgTEixr2UgLZ7Tm/5k7aOXS9c/nwUsFcCmx
         r/w9UqT3QZr8j2OP3iGBravY5/R7GENMiK6LIForVjFSIjBxlDyxRPgmnH/kBTE6T+4m
         szQNrYbaZpVqZY91jnHt189El1L3yxRkVyoLkKopzUqAI7ycHYyHhsMPfykaJPrZtbNC
         o9JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wYryfRAO49mWaM8UW3VxsEWrpXUQekKgTvfVUldesGh+VgfsQQyALGrIvWDhI1TfMDsTwG/t17YA4JYo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwC7gP+VuUiMh5YCZPQzo+6rJXNPKUA0ngoiH39CBUQN13icj0X
	9kmzweRUSYtP1iaZg62rloHHLGkz1ul0RUw/ZMshvplrsp260TxF27YYtD5jbp4mM5I=
X-Gm-Gg: Acq92OFq5PU+LyX7qJKSdHWf0/FvAVnHpHv0MKFtKiLMQO+m6iHd4qGR5CSBulBAlQz
	Xw4h6O93TMNb2AF4sav2lxEZ2pNz3w0mhnSHuihkkS2JHHe0Mn7Ypj9GuJKWap1fWTyFrfWPrmN
	n8Ui3q8HCtJRmBrBSij7xbNXUi8UyI4V0zibvsQ0U1s6W5P98DP8QUccqnzd24r7f7yqUsq/9IE
	ekM3Vj+B4B5TmSGyjphMZnLMQVEABEgIjqvqbC8smAbwLWt270j8PbGbXZVEPtHnaMWM5pDoTH/
	FlgK8+5dpLkBReVSj1JCBO0ajTIT2rnqXhMTeEZR+5DUrjvnKtzGZyCAvjqbintQs6w0sAi7l7F
	6gJIVUhPomDV9hFFq9DKC372Pl4iUwXI3YtZzdQs4piKDNk3rV85wdagrKwx2SLOJ8B39Hil48L
	vz2wOZHFsR7GrF/TQSKhGojmSwUGfkcHS3Uf6MBuhs6xsFGw8edH9acsQ=
X-Received: by 2002:a05:6a00:6f50:b0:842:2ae0:968d with SMTP id d2e1a72fcca58-8422ae09a48mr11734407b3a.32.1780395048489;
        Tue, 02 Jun 2026 03:10:48 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:10:47 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 00/19] mm: Refactor bootmem gigantic hugepage allocation
Date: Tue,  2 Jun 2026 18:10:20 +0800
Message-ID: <20260602101039.1867613-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

This series is split out from the earlier larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. It collects the first 19 patches of
that series as a standalone set of fixes and preparatory cleanups around
bootmem HugeTLB handling, sparse initialization ordering, and related
vmemmap setup.

The first patches fix a few bugs found while reviewing the existing
code, including incorrect bootmem HVO handling, wrong vmemmap
registration arguments, a powerpc compound-vmemmap tracking bug, and
too-late initialization of gigantic bootmem HugeTLB struct pages.

The rest of the series reorders early memory initialization so the
relevant zone state is available before sparse and HugeTLB boot-time
setup runs, then simplifies the remaining bootmem gigantic hugepage
allocation path and removes code made obsolete by that rework.

At a high level:
  - patches [1-4] fix boot-time and arch-specific bugs
  - patches [5-12] reorder and simplify sparse/mm/hugetlb early init
  - patches [13-19] refactor bootmem gigantic hugepage allocation and
    remove obsolete helpers and state

Changes since v2:
  - patch 1: add a comment explaining why shared tail pages must be
    initialized from gather_bootmem_prealloc() before
    hugetlb_vmemmap_init() runs
  - patch 1: update the stale sparse-vmemmap comment to point to
    gather_bootmem_prealloc() as the shared-tail initialization site
  - patch 2: collect Acked-by from Oscar Salvador
  - patch 19: fold __init_page_from_nid() into __init_deferred_page()
    instead of only making it static

[1] https://lore.kernel.org/linux-mm/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (19):
  mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
  mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
  powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
  mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
  mm/mm_init: Simplify deferred_free_pages() migratetype init
  mm/sparse: Panic on memmap and usemap allocation failure
  mm/sparse: Move subsection_map_init() into sparse_init()
  mm/mm_init: Defer sparse_init() until after zone initialization
  mm/mm_init: Defer hugetlb reservation until after zone initialization
  mm/mm_init: Remove set_pageblock_order() call from sparse_init()
  mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
  mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
  mm/hugetlb: Refactor early boot gigantic hugepage allocation
  mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
  mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
  mm/hugetlb: Remove obsolete bootmem cross-zone checks
  mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
  mm/hugetlb: Remove unused bootmem cma field
  mm/mm_init: Fold __init_page_from_nid() into __init_deferred_page()

 arch/powerpc/mm/book3s64/radix_pgtable.c |   7 +-
 arch/powerpc/mm/hugetlbpage.c            |  13 +-
 include/linux/hugetlb.h                  |  24 +--
 include/linux/mmzone.h                   |   7 -
 mm/cma.c                                 |   3 +-
 mm/hugetlb.c                             | 259 +++++++++++------------
 mm/hugetlb_cma.c                         |  44 ++--
 mm/hugetlb_cma.h                         |   8 +-
 mm/hugetlb_vmemmap.c                     |  94 ++------
 mm/hugetlb_vmemmap.h                     |   5 -
 mm/internal.h                            |  14 +-
 mm/mm_init.c                             |  88 +++-----
 mm/sparse-vmemmap.c                      |  26 ++-
 mm/sparse.c                              |  48 +----
 14 files changed, 241 insertions(+), 399 deletions(-)


base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
-- 
2.54.0


