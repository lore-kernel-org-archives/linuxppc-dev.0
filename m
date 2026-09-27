Return-Path: <linuxppc-dev+bounces-28294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5BC98328
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvW4TlQz3bNw;
	Sun, 27 Sep 2026 12:55:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477703;
	cv=none; b=Ldw+cNIeADXCpuLhD41sZ18woKDSzqS1ToXQFng7WlseUIORgR1BYc2mV8NbAVslTzqs4naSZcVUzcvt1ejXKXKy7tVX9QQxx4qkRBu4cn57LDbxcLWa9bwATpZzUYknGPJ5NzVPoc4Fsew5UNCZ7lVnUhTmmm0o60uZL5eQJSAOoBnDV+xuC5jrVWqIzbds/B8d8TVJ7XtRomtgGa5WU5DiMdqnZ5LTmwlDRPUdFm7kH7FL3Tmv/v9OXW+OyXC3CM+T8sK420y/fk8vN+1Yeh0hgf9h+6FZStdqftx2C3czoYyLUxFxCoHcX6jjRyUrj0Mxqd0u/rXiJuq9OFqsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477703; c=relaxed/relaxed;
	bh=mAkta7mZeKcSnQKAIidETfQVRbQyIgGdyROsCEAgaZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIpaH+b2WX1fYafzxElfKcXY4aokSNB7KCiCsdzHobs8XXGp+led2HbrqmGlPsDTTDoYw6gyjhccubi7qwmF7MpQjREjrbf51Nx5jlJCfI7fNMXqv969aXZxzTA/3fA7JT4JBpVpQPS69TLTmPI/BOTfZkQpfJFExNj0yxDFdTnYujRQqQPRPh89glA7y+o1p+2G6h8Z9HswWl7UMli8Ro8aX2mThmXlTfpGKlCoDn+zrFcJ5pCc8YpKf9bRGip9zY5c5zrpkFEJfdOE/ZcnUKJ3sSOfPCf+oku+TCcdk4UsNYu7ZRBPyp01UNbFv2AySEu2oWLVI11DZWWCtcRAKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SeOrBknR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SeOrBknR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvV5gSqz30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:02 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so891999a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477701; x=1791082501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAkta7mZeKcSnQKAIidETfQVRbQyIgGdyROsCEAgaZU=;
        b=SeOrBknRr2TTZk9V95MMXlkxKswRscbTQUnQmY2J0FgHRRjh9kM9vWCCS12Q30bK2r
         twKKxG+p3fwoySue8mUs9ny399GcfkLrZNMGm0QnJ9z5fIk6w9YOnfeMifU1i8NixEpZ
         tgUvjgzxs9ln3J1X/JnRWTNgciqamdV1CCVfH9iKM0iDbXXqEjSWvpSTzKXYfxKQ8sBK
         Oksu6B6f4i/vzr4DhuNJ2e28oAuUAjFCL+vhbC4Q086ylxag8ZlsP1FlU7AlDRov/SM4
         s3BuvowvbacywYhNdyGlpFL56PaZHA9UnGYZfU0UkFIPJZYRsaJC1KW9TSudsBlL5UHK
         usJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477701; x=1791082501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAkta7mZeKcSnQKAIidETfQVRbQyIgGdyROsCEAgaZU=;
        b=A5oytZCyRG95GwJ8upFYFJFoiV8xuHChL6/6SokF66Bocm9qxAdjoB0ABcHQT+Wnnf
         vCVleEjZt+ocu1k/gDn5zXdfwgsXkIZynK8YALsZbpvCZLZBDIxn4WztGjRObjzeQago
         2B52RzfJs/mhbGVAs6rZhStz/tb+JV5rkBFtI0lEfHhHuosJssFVyWaA9f4sFrPlMGXA
         kZ8jc99VJzlflFzhravUT4zfsb/T7o34KtPQBJrqStpYbgxkvt5J3UomTZYVDOzGuqbQ
         2zH/FUrqFwpK2HN5Rx5WpabsHdJGW5NPe6VNF/zB6C5024Vv5ki8/oeNg9MiTyCwO+oD
         71nQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/fG/TQoo36pBCPov2ei77tizWy0FbABEaHIpDyecMANaMtlTreTy6MSyTNtf1Mw5btRFN3yW/IsV3Bvw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIHcaNg7b6WuW/51gp5NWl/0thWT8YSS8uUbxsM3uNcVxHOV2PF
	V9JN8x3Bpc2L1zWDkoC814bjQ1ZohwI8I/UgGd8b2PGX25mkS4RLv9QDCwJlBrFTQL0=
X-Gm-Gg: AYBFou1OpM339UhAAGKrbClG5Fhr/zLkhghUMimeo4fQosavFxjuCrdw0VwMJBnnWFB
	IFw+WCDC8hwZWLQnGnKhkysIEHMGvdyuk9shpZdjA0YZs+EfDVtO1G34pG+5DHwuH2eJz5sqg4X
	icPCfXuzVaVwh3ZXc1zqXM6m+19myCFBMouQAl9o56FbWcMYWbv4Cj1wPyfQObdvOqbj41JQD8A
	0NhPtc3gR1btLIicV5LtVt2Pgvs817HUl4LH1xxALopa29lFwaK7489HlTp7YLUhg+DaOAWulk1
	mKncNqEoDx4FnnbjlwSin4+h4WLuDmbEI9KAUTAwK35NnC2HXD2bNnBQ2x2wo4t/NXia/4InWXY
	H20yw9aNz6YdZW8nYJ12s1cxZ+q3/d3ngzOXVm6ttTPT66VMP0cS22McTnGlSpeX7v7eY2TLbYz
	sZ6MijJQgHeXV4b5S8CT8kWlDzktIDYRXIJR68zxY6TeU8fX5qU/d4nfuv5vBOSS7zPk4+hbnl7
	RT40Y+riSiwbk77+njy
X-Received: by 2002:a17:90b:17c8:b0:39e:433:23b5 with SMTP id 98e67ed59e1d1-3a098b973c5mr8380169a91.5.1790477700749;
        Sat, 26 Sep 2026 19:55:00 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:00 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 02/12] mm/sparse-vmemmap: allocate shared tail page array dynamically
Date: Sun, 27 Sep 2026 10:54:31 +0800
Message-ID: <20260927025441.741633-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
v5:
- Add this patch to fix the RISC-V build failure under the configuration
  reported by the kernel test robot
---
 include/linux/mmzone.h |  7 +------
 mm/sparse-vmemmap.c    | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 10 deletions(-)

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
index 9b00085122b2..46d9a25b3275 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -170,16 +170,43 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
+
+static __ref struct page **vmemmap_tails_alloc(struct zone *zone)
+{
+	struct page **pages;
+	const size_t size = array_size(VMEMMAP_OPTIMIZATION_NR_ORDERS, sizeof(*pages));
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
 	void *addr;
-	struct page *page;
+	struct page *page, **pages;
 	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
 
 	if (WARN_ON_ONCE(idx >= VMEMMAP_OPTIMIZATION_NR_ORDERS))
 		return NULL;
 
-	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	pages = READ_ONCE(zone->vmemmap_tails) ? : vmemmap_tails_alloc(zone);
+	if (!pages)
+		return NULL;
+
+	page = READ_ONCE(pages[idx]);
 	if (likely(page))
 		return page;
 
@@ -194,12 +221,12 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
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


