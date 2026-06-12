Return-Path: <linuxppc-dev+bounces-22528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63863CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5P607ckz3brx;
	Fri, 12 Jun 2026 13:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236761;
	cv=none; b=cUlBVpbROpXF3mnW9u31PTKhO+zwTaHk1ke6SxKGZzDa+jkq2xW8zsQz59wLMfzpeHzrw/45dNGDV35CL+Yugdws+KqSnUEj/dK3xM5V5glOheofm34ycUi9Mo8K8jDimVpt0gqlG+2VCA6TrKxx6qEqB2Uw2ckbZHkr0ZQIE2WFYDxT1Q0zl+hPPOx/onN7d7WsYFWBtLdXC1Vuplaq1JHrT70vt5oQO8FtOT0yERvqglD/04Ua6CK9/pJpzJmAXCwekwMQ+C/MNrwbpZsvAW+gjEupWokYbec9tRei5JDrpQe0jdlAOAMFKuGIc3puqxYpzMcoi1lBl4B+gnb7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236761; c=relaxed/relaxed;
	bh=qXrTtpT2gfzfA9UVBfYwsqqZhVEbHAXGcBbRyTvn7RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3iS6vZ7N+YxV7mULRirVJWDeBqK+8YxpZzct6cCL8+gldFiXVOqLG0mz55REg500/kLTPC5U6yloROESB/IIXPRP3voxg80/wA3BQl3s12xXg0Tv8CuY3g1mqT+7rVgEXtj9WgX7Q1CXEw0nt8Kw/pt4PmnL4VJIXD84qlRH6pBMZYVlBr/3u9l7ZMjnr7aVCcxIEUTi0R1E3GeXLlMKP3xm8wD6LftpDyZ9EzIuw7gY+R8DqJ8gMlCPAReH+9aTD6w6sBrvjBSwT7B4MyIwj25aiOX+IbSTktDjrh/srC7kLk1sDg0+8FoCpVvCbP9uqfCJov7YFDNHQnXHIAbow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jiDwmN/H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jiDwmN/H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5P35DSSz3brt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:18 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8423b08b293so293255b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236751; x=1781841551; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXrTtpT2gfzfA9UVBfYwsqqZhVEbHAXGcBbRyTvn7RE=;
        b=jiDwmN/HyBVFrKKOCZaiAleFMRGuIHytxCG+pmR5nXRSDKOpyCe086FV6o2bLzwQpD
         lunIpi8UYAo2qHVR60DpoJHcvBRhpGnH0k0NEv5c9RxArp1nq0B9O+YAi+Xz2sL/AFnT
         2vkGlImsAMrJ/KzA6CMQWKMLhTNwHtYLVHawQlx0PCZofdgZ5z27YnnYq7EIbjjSwyPb
         d7lP46IGml2GITq2Rsx+e1Gli8znFf8SN++RBprCQluWKFgmLk74srMe5g9870Z3AxmF
         YYhHGJJ5ZmDDjsWGOkEccD/9+nb88uZmW1xOLd+A200PGdBbQljxNSK/DqzabT63wv+I
         9+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236751; x=1781841551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXrTtpT2gfzfA9UVBfYwsqqZhVEbHAXGcBbRyTvn7RE=;
        b=LjvACIw+/ts/mzRNv+d7Kxcf3grEfprSZvHVc27k3WMtthxNVWao64DdvdEDr7pvva
         AI9/Ito+A11STNC6BaWYCi14muCr6YIgss5AD7Zvp4f346hkMKdJKvz5X6rzcVfcFt/o
         Lwk9wWGr2434/ar+5d7GnQ8QgdJ/yPYqg5WNAjPoj4B6MKiliXvjtV3InH+EzChA3QW3
         Mb86XujWpM7tnkwxQexZJJryK82I9DXxFGAYTmJkHeC+PoCTmdXUBOvhnqNqeuA95gCc
         /nY4UiNQOdYUqo0I4vCMb5+BrvJYxeyBwKkbmUj6362MoH1fopPaz476rTzGTONDAg08
         t0rg==
X-Forwarded-Encrypted: i=1; AFNElJ8gn43R3dt+7DolLV5caQGPkMjTQd42UjB7kyO1+lAytmYS/vSly74HYc+TGvE1mKldGqdx9zTN8L1ycOo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6BLNyL8KNaeYHuAMW9cOTlQRYLGIrzaT6EQ+EW0KW/YY9JQPN
	EEniAbG0xGTnTSnUrm4lKVEAxCoSaAMfq9577t9vILqh1S4CO9DuZRzLN0dejWt8CBY=
X-Gm-Gg: Acq92OGC3gQ9BQxNbKVbrTTd7/xYUpLIOLbEDGzDJhUm/18HFB2MiFaR6MarYpXujMY
	ZaI5keL6Bh37dSAID9zbFeoztjP/4vqz3NUOuEBOrtn0XD+Hq+uhZrRZtGpAFN51b1+C1W0Q1En
	CGjGt9T3IRi6x5awo3n2Mt80GQamLLq5/5JHx2/JJdhKfezBB5iTSUFA9HiPYIil5L5KDdbrnBy
	T9L4N5OZadxSQJWf6ssUwp3+YFw15ZA3umBm3ejLp4wXaqekLqwHyiJwTjgVKxJzn+DABgORWuo
	jS5ti4JCc+qzhJi7CnE2UcuGUx+voJHYV4eOIXJxydKyLrDQSvCAv4csvFkdAMVYR2heBp6yTCv
	cArPNtIKoITInjA6zgtPNB2he9hF4X0AlRzI3S2yB7U4NUOI1ditYgxz3OjFSSjr4gyUSHjmPAa
	7BwfmoUuYaXDiRYXBbv1btpwr0HBmlxSIO5+h5khboQDQ=
X-Received: by 2002:a05:6a00:3a29:b0:842:5b63:6118 with SMTP id d2e1a72fcca58-8434cd0b6e4mr980556b3a.3.1781236750991;
        Thu, 11 Jun 2026 20:59:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 00/19] mm: Refactor bootmem gigantic hugepage allocation
Date: Fri, 12 Jun 2026 11:58:44 +0800
Message-ID: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

Changes since v3:
  - patches 2-4: add Cc: stable@vger.kernel.org to the applicable fixes
  - patch 3: collect Reviewed-by from Ritesh Harjani
  - patch 15: move pfn_to_zone() before hugetlb_vmemmap_init_early()
    instead of using a forward declaration
  - patches 15-17: collect Acked-by from Mike Rapoport where applicable
  - patch 15: collect Acked-by from Usama Arif
  - patch 18: clarify that the changelog also covers the early CMA
    bootmem allocation fallback refactoring
  - patch 19: initialize pgdat at declaration in
    __init_deferred_page() and collect Reviewed-by from Mike Rapoport

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
 mm/hugetlb_vmemmap.c                     | 120 +++--------
 mm/hugetlb_vmemmap.h                     |   5 -
 mm/internal.h                            |  14 +-
 mm/mm_init.c                             |  86 +++-----
 mm/sparse-vmemmap.c                      |  26 ++-
 mm/sparse.c                              |  48 +----
 14 files changed, 251 insertions(+), 413 deletions(-)


base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
-- 
2.54.0

