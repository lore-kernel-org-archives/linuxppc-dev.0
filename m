Return-Path: <linuxppc-dev+bounces-28562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1458CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxh82sGQz2y2J;
	Thu, 01 Oct 2026 00:07:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777256;
	cv=none; b=SGRIFpqrqfTQaxYJ5gClUVX1eS5SWfmwlR/1gsKMroTjZ29NsuHWTaxHiqqopW8CzbB4yCMuN0iPXymZdbF4irk6Xljis/L0mbS4ORtlEXJcUhMT5gXNW32wDuw2P2QN7aegHZcOlh7VBKOgnSbjsq0aJ47WR50Y8Ie0ovHt9BG0ATwL2SJuetL/WVRzG77z0bxRoa2tgKVSKqgxn6vEahaAi9gMFZc0p1N3EY81ABZ1209pTBngqiUuhrrCbVCrN2FlA/Haw4PetlkDkC2TDqM91567njaZbK2sk6GRdcBMfuFmnfle1tZLzVXB9ltGLebs3cpIvikNjHUvFxU9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777256; c=relaxed/relaxed;
	bh=MYebeXJuBW0flbBBO8JM/NAxNtBzSIotmtzU/jzSaT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gukd50GVgCcMZMK63zB8nhqLL7BkSKd1LA2JxW18N2mOfFtM33BdKxK8kMy8Kd69ErBm3X1R/G8hzIkG8qONy79yzbsjRb43TI9Ix8xLniFzgj1mnjeS4dVE9q2lTr0MbeB7qGl5w/CTmRpsev/c4/pH0IaZAxL5PEVs4yoYg2FaQ+9BySSaTIX7myizy6wO/n9G5HFuKrUFFbpN5CCrJ7B7fXNkmOSoq0Xt5CkwOByECBwdoLdlJp05O8qfDl0xSgJxNFYfEfQhX9DBEviyYB5kQDbY7aMhW7NN/mz2ZQcf9no8RiWUkvLCMsvWmOMDgRVBq853e99tMFUTcY/wwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MDsIYf1M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MDsIYf1M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxh735skz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:07:35 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3902040a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777253; x=1791382053; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYebeXJuBW0flbBBO8JM/NAxNtBzSIotmtzU/jzSaT0=;
        b=MDsIYf1MdNM/od4tEVKTHacIUA9ZQ0Jy+mf8N31pd1vZw4yM6EPHYgzLM+SbHQVOJt
         kg1tcVn0BFOneo3xks+ZcLJC6ob4zl+1sn3obdUKLRypZ3yNMROUh0VydedkKvJBegWt
         wQ9sOYbc0yWYKoGPWP6uOnS+Vcuc2q3GzP3sbnKNUUQLR6TdKnqohliyBlxZs1iqCbrU
         wcJzngilCd9ssVhUpw3kv3MG5kVE8FMby2Vt+aPmrxK0hC37ZgVRUFllHRh8PgYjmAXf
         o6BIS4VOSswAOkksta4IH7rzTuFXGaXCbYr0TGRBXC+fBzGF1UR6E6c2TrTMtCeLgou3
         yvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777253; x=1791382053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MYebeXJuBW0flbBBO8JM/NAxNtBzSIotmtzU/jzSaT0=;
        b=GHtgoecbxKYqhSW+PMCuL1WdwHDWRCihw23tEkdvTMoDKGtzyLBYYEppOsiZk6djKx
         ZdOyBFuYsopb4YhHrmp1EqpIWq0zqyGkMgpcqQjwGG9q696rIa2vtBvcbfOdDScEVmcd
         mNWnaxB7OJ0/JtvHK9/XNpnOkBHQlOG+yjutBAdFAdBfZFC8iGW1iTj7s0JXLcELS4ho
         NaCWAkhlhwgKPs05JLgpPp+BR1BQXa0ZY0ohslJB+eBFo3+sNyzVBuoq0pdVcI+ZwOjC
         gAnqqsZ0A/YuwPctQyycCH5riXouttiPGslKa5dZDJBeqPu32yM2Eov8KvmUs2MuAB5z
         i/kg==
X-Forwarded-Encrypted: i=1; AKwUvBxhHrA6I8dNSifUxSAHXZ4WhoQsMPUkYp6M3Nzxb0Zsp2iZYyQ3E9xsof2H860QthtaFfJkEHFqmhKCFJs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI0bSlD87Gl1ONYYga2CO821nOUM4nPEzBlOBjDbSg7UfPouN2p
	MwQXLil7kiv8c4MPM8wXJKBbC/dXNe3lfIULQ5bKPupjsJ62YZNR2ns1fFFhfI9APd8=
X-Gm-Gg: AYBFou3Tg42Az7okOd417GCKctkGVR+zgO/f9jw8vmOrc0b9jK+ow2GIo1GKCSk5lsi
	TtyeN0g3DeiJOAUyS2JFbBO3YT5ccEHX7WY3zhcWQn7TUjfWcPP0sNOJGnGkacHBk+170bvwHZg
	XkPSeCeUZT9gwLL6wpm7908AoouTGPTfPr7+vXUohrhXAKUjtWPrRmrR21HVhoJiRFJeiG0iD1Z
	+FUeaeZ3CgdWo3AOu78wRmkNrUp1q2GsWmWvsBeG3M+wTxwPvtwuF8NLrTzt0gdsprO/6RbTO1r
	z5ko2s3IWBVFAwAKZsQtCrM75EFHOawzJGd7PKhdXynRWHYbo4F0YZes6eOE3e5Wo8/7JyZIFb6
	/OI0v6eMnpu5maiTVNc0ufDIE1Pz3ONrYUK7Pb5Av83lps5cup6yEJXCMMjoxBh51+IEkR5nJrs
	/D98PHsAZp8QdplI/Gp6xZQkddAaeMfXvwmdA+tFyXbo2F4RV744hFux9Xbb2F7F1H8FdrTjYTh
	d4TKJqqhiXRuA==
X-Received: by 2002:a17:90b:134c:b0:39e:6c6a:6580 with SMTP id 98e67ed59e1d1-3a4d199cbd8mr1390228a91.67.1790777253237;
        Wed, 30 Sep 2026 07:07:33 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 02/12] mm/sparse-vmemmap: allocate shared tail page array dynamically
Date: Wed, 30 Sep 2026 22:06:17 +0800
Message-ID: <20260930140627.57431-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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

Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") added the
per-zone vmemmap_tails array. Its size depends on MAX_FOLIO_ORDER, which
had been moved to mmzone.h in preparation for the array.

PUD_ORDER is defined by linux/pgtable.h, which cannot be included from
mmzone.h without creating an include cycle. It was therefore open-coded
as PUD_SHIFT - PAGE_SHIFT.

This removed the dependency on PUD_ORDER, but not the underlying
dependency on architecture page-table definitions. PUD_SHIFT is
generally provided by architecture page-table headers, which are not
guaranteed to have been included when mmzone.h is parsed.

The dependency remained hidden because vmemmap_tails was originally
guarded by CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP. Under that condition,
MAX_FOLIO_ORDER resolves to either MAX_PAGE_ORDER or the fixed HugeTLB
limit, rather than the PUD_SHIFT-based definition.

Device DAX, however, does not require CONFIG_HUGETLB_PAGE. When it is
converted to use section-based vmemmap optimization, MAX_FOLIO_ORDER can
resolve to PUD_SHIFT - PAGE_SHIFT while it is being used to size
vmemmap_tails. This would make struct zone depend on architecture
page-table definitions being available when mmzone.h is parsed.

Replace the embedded array with a pointer and allocate it on first use.
This moves the order-count evaluation into sparse-vmemmap.c, after the
architecture page-table definitions are available, and removes the
dependency from mmzone.h.

Removing the compile-time array also removes the original reason for
keeping MAX_FOLIO_ORDER and the vmemmap optimization sizing definitions
in mmzone.h. Follow-up cleanups can place each definition in the header
owned by its respective subsystem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v6:
- Move the shared tail array lookup into vmemmap_tails() (suggested by
  David Hildenbrand)

v5:
- Add this patch to fix the RISC-V build failure under the configuration
  reported by the kernel test robot
---
 include/linux/mmzone.h |  7 +------
 mm/sparse-vmemmap.c    | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index acd94cecc0d3..68807ff7f946 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -113,11 +113,6 @@
 	(VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
 #define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
 
-#define __VMEMMAP_OPTIMIZATION_NR_ORDERS	\
-	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
-#define VMEMMAP_OPTIMIZATION_NR_ORDERS		\
-	(__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
-
 enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
@@ -1156,7 +1151,7 @@ struct zone {
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
+	struct page **vmemmap_tails;
 #endif
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 9af349581fbd..0ace48268095 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -170,16 +170,47 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
+
+static __ref struct page **vmemmap_tails(struct zone *zone)
+{
+	const size_t size = array_size(VMEMMAP_OPTIMIZATION_NR_ORDERS,
+				       sizeof(*zone->vmemmap_tails));
+	struct page **pages = READ_ONCE(zone->vmemmap_tails);
+
+	if (pages)
+		return pages;
+
+	pages = slab_is_available() ? kzalloc_objs(*pages, VMEMMAP_OPTIMIZATION_NR_ORDERS) :
+		memblock_alloc(size, __alignof__(*pages));
+	if (!pages)
+		return NULL;
+
+	if (cmpxchg(&zone->vmemmap_tails, NULL, pages) != NULL) {
+		if (slab_is_available())
+			kfree(pages);
+		else
+			memblock_free(pages, size);
+		pages = READ_ONCE(zone->vmemmap_tails);
+	}
+
+	return pages;
+}
+
 struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
 	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
-	struct page *page;
+	struct page *page, **pages;
 	void *addr;
 
 	if (WARN_ON_ONCE(idx >= VMEMMAP_OPTIMIZATION_NR_ORDERS))
 		return NULL;
 
-	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	pages = vmemmap_tails(zone);
+	if (!pages)
+		return NULL;
+
+	page = READ_ONCE(pages[idx]);
 	if (page)
 		return page;
 
@@ -194,12 +225,12 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 	}
 
 	page = virt_to_page(addr);
-	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
+	if (cmpxchg(&pages[idx], NULL, page) != NULL) {
 		if (slab_is_available())
 			__free_page(page);
 		else
 			memblock_free(addr, PAGE_SIZE);
-		page = READ_ONCE(zone->vmemmap_tails[idx]);
+		page = READ_ONCE(pages[idx]);
 	}
 
 	return page;
-- 
2.54.0


