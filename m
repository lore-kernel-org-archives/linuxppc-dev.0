Return-Path: <linuxppc-dev+bounces-20905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC56FCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJ563zpz2yTP;
	Wed, 13 May 2026 23:21:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678517;
	cv=none; b=kn2ppuWQDGER9rXewk5SuXnpPEkqGf1QmWkQkjYrv4cUkTQgzwqtNa/C30VPz6CwQQnLocnfWPr3TGLg5TSmZaq9TqbiP1i/MubgR+hoxj3VeA4s9ATCUxmivCpDEKa7ZDcJJL1MXh+pFC/fW3Agj7dl8W2kfnGITdqb51fT51a2rM41sFN81+BAdfHIZh6JfsXqVvjM70OPUa85dQkjrGPrgIYap8DU3g8+O3s4iSvXe52SGE0+oX4GITS9lB33DLr0GagS7+VlH++jVf94jQdxnmDtWm50Gfd0hHH5G0yTGmR5Fbx++ulRTBCubhaKAKeJJVqjlOfqMpCx4mdkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678517; c=relaxed/relaxed;
	bh=09ZAgIruVIYnDt/DEHrKUKC/462Uq37TlLUpE9pDl/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlwcc2iTMVCVHoZaLj7TQ0QArym0DlLOIOyAK6gJy3rogSCIUVgq0K6EBEUUs2jtp/XbwhpkLh7a+6GDP0pSlogZSOVgX/DrYhKevu+nYSY7HpQpjISULFiGSIoyz/dipRpGdq1m7WSeKOaPhA9+LdEEPFWs2xGIKQTWy+zziGYPwioHCFUCg6la1LUiMl6LQTRkjUkpXlnRDvATvtvDQPeYjEhXc6ipaST21mJmQ45WPMIZwMGF8rq7T1lDYw8sxA9j217bxuZgvZmlqk9rcc1J0oqqARBeBATZ3JfgSlk8/gVnFPipwfi/rA0tl/Rj7KmP2MGRr/ZMc0hAFA48Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OU8nKm+c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OU8nKm+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJ50bDCz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:56 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-367d88b9940so3258795a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678515; x=1779283315; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09ZAgIruVIYnDt/DEHrKUKC/462Uq37TlLUpE9pDl/8=;
        b=OU8nKm+cfLuDrJC6fS8HctDqtTNh6Q3ZTntB+mnhaVFVH9JoVozKQ9n0aAYhY/ceZ5
         wfRvyQ3J8pXUYDOyP5npDAcgB3VvXW4EccF377ytJ6IBKskYYrCJC1nwSlGz4mwI5lGi
         eqCAZBR2dL444/KsFsWKKTp7uqVNG2UqnlsLiXQoGVVeDEgX022/ftC31shW9zr3hgvH
         Bb+JC+rYxOYxBwJtNCCCisXTVnIiBVO5hRJl7w1tnNnMz/6orPeZfy+aPuY423jNikBE
         gc6Id2PPQdX5wFKhtmJIK1JYM2XN4Wfvw1BlFRP1WMVuKbQRw6HqNHQv3gNsTBIMtAWL
         jUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678515; x=1779283315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09ZAgIruVIYnDt/DEHrKUKC/462Uq37TlLUpE9pDl/8=;
        b=CxLPP4h5VxQB2W/IDRKLsUweNPCCOWLnzSQk5tStOTBTOd5dGDK6p9KLTnu9jnBdZy
         88yPZS3+darxRsF/78lEahmzPrdtrk1X1dtnVWt6SX1UYJaSNNqW/dVl7WKoHnOe8+bg
         Yrz1rIKfX+FIrnF7j6Zxp4M5qKlvnkdcVYkaMOiswuDH3Ji4tgvBkQxWkcHL6ENX5whi
         Mj1CiHXqpo5SQ5d/2Z4r1iVhBaS+xYQdL2d7HCj6HsvHQyJjijpxuhqQviHp5Kmfqj0i
         rWpLU4iCBOTTet9lNx0bhW2h/1SKxlO72exMNrdv9ye6/2PNSc717ixH04eALEPy/MoX
         tgEg==
X-Forwarded-Encrypted: i=1; AFNElJ80IMK/e+7GZw2Buhaxeg1BUuD2/zAbEVNux0CmV0jqv4K2xHpb6MM+TyvDppS13lqKlzUuiaK1s8WhU7M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxElkBZm8aQS0Cg6RfCoxv95xzw8zUprWU9f7t5SrxPpME8ZSKV
	hDk3k0K9ky4KxYth1iQ2RoNc8bVcE3sSrhwJYojuMWQeeGL4lc9S25sO+PxJjnCB3TI=
X-Gm-Gg: Acq92OHefrrhpLCDDz43ePzmVhG0Sp4RaNUUTeYWOy4RI3p2W342Q9U6ihM/XDYhHDA
	IvbdukSgfOvXXit8/x/1mJxs/NtmEKFUlED9sjgbEn8F4TggLB5kOIw8S7ExEJ6M2LHOz54Xdvx
	1oKuui38SwUnrj56/+5ZdrDZ9D2YJ0wB+auaUNzKusJdSO9AIcUxz6kx9s0AF973MBfuILpNEjz
	/f1lhdXAR0RlsWwtNGyL42x+MdvSPEde9URbvf5zxH8gndIAycPqSPzhE+vLWLtD1CqjANE6o68
	6zCyM5ZV/5ksYxiv5gy04h6NqqpLhPAHus/J1MZVaZT8rjKVMxlwReEV4Sdm7+P82dOsMf758yf
	Bn7hFaWxL1A/roS2YHybbBJ0ycSZJqtyH7VgTAQOm7KnZtfde+SZ7vxIk5LqzOi+/FE4JBpVp30
	dhtr3QSHIsEDVT6Hjk0ETqdkXr3+HfVD6nIzJV8E3JlVM3PVKx4NOzUVFTNmEO
X-Received: by 2002:a17:90b:1d4e:b0:368:2289:42cc with SMTP id 98e67ed59e1d1-368f4092542mr3912735a91.24.1778678514599;
        Wed, 13 May 2026 06:21:54 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:54 -0700 (PDT)
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
Subject: [PATCH v2 56/69] mm: Redefine HVO as Hugepage Vmemmap Optimization
Date: Wed, 13 May 2026 21:20:21 +0800
Message-ID: <20260513132044.41690-10-songmuchun@bytedance.com>
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
Content-Transfer-Encoding: 8bit

HVO no longer refers only to HugeTLB vmemmap optimization. The same
optimization is now used more broadly for large compound-page mappings,
so the old expansion is too narrow.

Redefine HVO as Hugepage Vmemmap Optimization and update the generic
documentation, Kconfig text, and comments accordingly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/admin-guide/mm/hugetlbpage.rst    | 4 ++--
 Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
 Documentation/admin-guide/sysctl/vm.rst         | 3 ++-
 Documentation/mm/vmemmap_dedup.rst              | 2 +-
 fs/Kconfig                                      | 4 ++--
 include/linux/mmzone.h                          | 2 +-
 mm/Kconfig                                      | 2 +-
 mm/hugetlb_vmemmap.c                            | 2 +-
 mm/hugetlb_vmemmap.h                            | 2 +-
 mm/memory-failure.c                             | 6 +++---
 11 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0eb64aab3685..2d4cfdcb7535 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2114,7 +2114,7 @@ Kernel parameters
 	hugetlb_free_vmemmap=
 			[KNL] Requires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
-			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
+			Control if Hugepage Vmemmap Optimization (HVO) for HugeTLB is enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
 			Format: { on | off (default) }
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 67a941903fd2..3f98ca1d7ce1 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -172,8 +172,8 @@ default_hugepagesz
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
 hugetlb_free_vmemmap
-	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HugeTLB
-	Vmemmap Optimization (HVO).
+	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables Hugepage
+	Vmemmap Optimization (HVO) for HugeTLB.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0207f8725142..d5e350607baa 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -682,7 +682,7 @@ block might fail:
   ZONE_MOVABLE for increasing the reliability of gigantic page allocation
   against the potential loss of hot-unplug reliability.
 
-- Out of memory when dissolving huge pages, especially when HugeTLB Vmemmap
+- Out of memory when dissolving huge pages, especially when Hugepage Vmemmap
   Optimization (HVO) is enabled.
 
   Offlining code may be able to migrate huge page contents, but may not be able
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 97e12359775c..9f333970fdb2 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -665,7 +665,8 @@ This knob is not available when the size of 'struct page' (a structure defined
 in include/linux/mm_types.h) is not power of two (an unusual system config could
 result in this).
 
-Enable (set to 1) or disable (set to 0) HugeTLB Vmemmap Optimization (HVO).
+Enable (set to 1) or disable (set to 0) Hugepage Vmemmap Optimization (HVO) for
+HugeTLB.
 
 Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
 buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 9fa8642ded48..44e80bd2e398 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -8,7 +8,7 @@ A vmemmap diet for HugeTLB and Device DAX
 HugeTLB
 =======
 
-This section is to explain how HugeTLB Vmemmap Optimization (HVO) works.
+This section is to explain how Hugepage Vmemmap Optimization (HVO) for HugeTLB works.
 
 The ``struct page`` structures are used to describe a physical page frame. By
 default, there is a one-to-one mapping from a page frame to its corresponding
diff --git a/fs/Kconfig b/fs/Kconfig
index f6cee1bbb1fc..496cfa2379e5 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,11 +261,11 @@ menuconfig HUGETLBFS
 
 if HUGETLBFS
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
-	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
+	bool "Hugepage Vmemmap Optimization (HVO) for HugeTLB defaults to on"
 	default n
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  The HugeTLB Vmemmap Optimization (HVO) defaults to off. Say Y here to
+	  The Hugepage Vmemmap Optimization (HVO) for HugeTLB defaults to off. Say Y here to
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 endif # HUGETLBFS
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7484e7be7b6d..efb37f2ffec4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -97,7 +97,7 @@
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
 
 /*
- * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
+ * Hugepage Vmemmap Optimization (HVO) requires struct pages of the head page to
  * be naturally aligned with regard to the folio size.
  *
  * HVO which is only active if the size of struct page is a power of 2.
diff --git a/mm/Kconfig b/mm/Kconfig
index ddd10cb4d0a3..c85ed7d7f37d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -416,7 +416,7 @@ config SPARSEMEM_VMEMMAP_OPTIMIZATION
 
 #
 # Select this config option from the architecture Kconfig, if it is preferred
-# to enable the feature of HugeTLB/dev_dax vmemmap optimization.
+# to enable the feature of HVO.
 #
 config ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	bool
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fce772e95adc..6f6f1740f540 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * HugeTLB Vmemmap Optimization (HVO)
+ * Hugepage Vmemmap Optimization (HVO) for HugeTLB
  *
  * Copyright (c) 2020, ByteDance. All rights reserved.
  *
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 2b0a85e09602..b4d0ba27b42c 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * HugeTLB Vmemmap Optimization (HVO)
+ * Hugepage Vmemmap Optimization (HVO) for HugeTLB
  *
  * Copyright (c) 2020, ByteDance. All rights reserved.
  *
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 866c4428ac7e..ad6416145667 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -175,9 +175,9 @@ static int __page_handle_poison(struct page *page)
 	/*
 	 * zone_pcp_disable() can't be used here. It will
 	 * hold pcp_batch_high_lock and dissolve_free_hugetlb_folio() might hold
-	 * cpu_hotplug_lock via static_key_slow_dec() when hugetlb vmemmap
-	 * optimization is enabled. This will break current lock dependency
-	 * chain and leads to deadlock.
+	 * cpu_hotplug_lock via static_key_slow_dec() when HVO for HugeTLB
+	 * is enabled. This will break current lock dependency chain and leads
+	 * to deadlock.
 	 * Disabling pcp before dissolving the page was a deterministic
 	 * approach because we made sure that those pages cannot end up in any
 	 * PCP list. Draining PCP lists expels those pages to the buddy system,
-- 
2.54.0


