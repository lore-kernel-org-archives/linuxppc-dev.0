Return-Path: <linuxppc-dev+bounces-22532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F2CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:59:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5PL3zYKz3bs2;
	Fri, 12 Jun 2026 13:59:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236774;
	cv=none; b=YYoZOFHr9slDPc0tbtwwnAHA/cnqwFw9rtst4iniRLDfOKE9pWjdUnPQ/Lym6KV85TsL4sfS43hBFv64SjU+3SvbPR2BSI62+10uzFtbnJq31aQrge3ou8UrCHt42vAb5+JcpjeDJnwfEhCVAPQYupR1ekJ7Dcbmpe/Cb/AowhcGNF45lNHlCohyJ8NZ0htwVXKtVto3rbJbV5hd/XJyYm6Xg0DLVVr6qkL/ZnaDRuRgMXzHNhrKbAqF2S8xagNek1P6mSZDJONzjDWKD18xEctuSLie4TJkiRFGCIZhZsXUBj3BAcEsQOYRgnAdPxiRuKbnVR2VCTeqK8ZfEcNpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236774; c=relaxed/relaxed;
	bh=bw/+TUFGRb1cb6WBPutvKTpZXTM41uBrQaMLYOSWWQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+9bZrm9e9wEE+uz7vyOepbQlI9w6GgkZM+RTsXJv48IdbsmaoGwU5j0lpQnSWITRi1Bfg6dwKyCfMIknO0hPgI1AHKElxKqwnK34+2QAJvS/VYIYdjSNtNcGLcKhXPxKIpvrRmdkKVSW8Nu+mVhKWDu0/k+1ym5yFOb0ZzAWkc3Vm5CxjzoAo00s4Tuf1bPQ5D4MKvQuMBStGZ3LkgP0A6W8RRKuwauoPNUWQMg+ZQrVlwmAo11MbbU7Os0/eEMXVKBGBAQneVX/txkhxCTXJscqP5QSKkZI3ZvaOIRphsfV6shLHlyr77HAfQeye6IMdK8fkIJUVvn3axqz5ksBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dHqgbzC/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dHqgbzC/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5PK5fL5z3bs0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:33 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-842cd900ee0so267580b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236772; x=1781841572; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw/+TUFGRb1cb6WBPutvKTpZXTM41uBrQaMLYOSWWQg=;
        b=dHqgbzC/4AyQaI0Q/rhEpXHg3nwZa7XHvmVgE7nErNqts+yCLxzhDZC6js+HQVEhsX
         PJGzfNHZgMv2hBLpK7Env7TL/mmgcu2p8TOOzxdTh6dX4PQptIorGh04fhoaBwocEtwj
         AieUhcBzGP+mNAgxTeu0qaB8qpentIgDl15VWda06xpn8ohv0HsiXFswYMSW6BC8G/gh
         d5C9nkZfRRBdfDniWBxI9XS9qelt1SW2r7hbXJEGVVhxjbhwkGd0b5hdDLESoMbWASZ7
         AcUB5pMFl8FhAeNirAogvx0vafFwC0HwYZpjm++Lv3oLdKVAjq9maMO6b1ehZlBdJCVF
         V6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236772; x=1781841572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bw/+TUFGRb1cb6WBPutvKTpZXTM41uBrQaMLYOSWWQg=;
        b=OOWQCXKeRswrPKXM+PAgkynPLssyUg1DF95JsU3xNhcviJdXyojGKpqTjYLkcsVZth
         S8Xg3bjOGf8IAhapIg2EB3qTG+rSf1oCqdEpnsTvgNi8A1dYUavYPUbcbicn7eZ9mubL
         bWy1mGlpMWP/F+Eq0OJ+DUhn71uO4u2Dn1FX0QzyUdpJSC2wCZpeHVbol2Lt2Z5aATWE
         WYEXaaC29t1xsppKS1vTPcyZOgcwX6k/ZR/tiukyxIhv6O0jIuUpi/mKdwdm4hXAxLyq
         PUQzpnnlMJ0FM35MT7nv6VCqg/h+T58ZNQkkCwDEcRO/Q8xocF8CSBpdYbbHArNBuz5V
         aoMA==
X-Forwarded-Encrypted: i=1; AFNElJ9YVOVw85pXPul/SqKxGnTGF0i6NrRg3b+6Al/USak5FDMG9zKfvR1KL64R+QkgYturQNZPFMnZo+FZ6jg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycoBxlYrcg7/URw7MPue9jE5xuHe0oLVtem0Myh0bHhRML3cgD
	KOGZrrOmodUVNnKupJCOmGCteVV3J4Bvpg1h0XeLr76zg6K2Ys7vNx3f1APS1OUeu+E=
X-Gm-Gg: Acq92OHJpWhIns95oCC3KifBCrDXYHeO2xM2DqAnhnZXhdXsikc1juSU9o86zJupgD7
	Nr72UpfwBIq0GEsqAkWD5KgM14qeRd9dyVPPZ0tYK93DVC84oufW1hdZmqbo1eJizEkLwtN41eY
	sZT8u3gXNUOaGJVZLgg/BT5nmaRCcM6jlvhKjAKVLc4hCYeHf8LurzLT5XJi0q1hm0Gfv2c5LmP
	JY4w2t/elTBmOzKeTosJnRzqFV526ci839UE4+X1oSGq0v73k2lF9xDL6A7NY1syDnrinmDfzyi
	lLiO32CfPdJ5HUFRUL3cblcQpHExJzftOv3DEODwB1alW6BqlzaFsLaAt3/mg8UVLJ/hwXHHFQE
	r76aWYp7a0dk5zqp6d1aV9pDUzi7XoeepOqjNpHdxoUocf5VVMRO6gZdTfgBxwAf2BeTekpqGgY
	i8YMNyMiJ9Fipk5J9s94GPwzDjYUHw/IR1gE63G0CqFRo=
X-Received: by 2002:a05:6a00:3395:b0:842:5b1e:5908 with SMTP id d2e1a72fcca58-8434d0795a6mr1106623b3a.25.1781236771699;
        Thu, 11 Jun 2026 20:59:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:31 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 04/19] mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
Date: Fri, 12 Jun 2026 11:58:48 +0800
Message-ID: <20260612035903.2468601-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

Gigantic bootmem HugeTLB pages are currently initialized from hugetlb_init(),
but page_alloc_init_late() runs earlier and walks pageblocks to determine
zone contiguity.

If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() can
observe still-uninitialized struct pages through __pageblock_pfn_to_page().
This may not trigger an immediate failure, but it can make
set_zone_contiguous() compute the wrong zone contiguity state. If extra
poisoned-page checks are added in this path, such as PF_POISONED_CHECK()
in page_zone_id(), it can also trigger an early boot panic.

Initialize gigantic bootmem HugeTLB struct pages from page_alloc_init_late(),
before zone contiguity is evaluated, so later page allocator setup only
sees valid struct page state. This also makes the initialization order
more natural, as struct pages should be initialized before later code
inspects them.

Fixes: fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 5 +++++
 mm/hugetlb.c            | 5 ++---
 mm/mm_init.c            | 1 +
 mm/sparse-vmemmap.c     | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2abaf99321e9..3700c0a1f6ff 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,6 +171,7 @@ extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_bootmem_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
 extern nodemask_t hugetlb_bootmem_nodes;
 void hugetlb_bootmem_set_nodes(void);
@@ -1293,6 +1294,10 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
+
+static inline void hugetlb_bootmem_struct_page_init(void)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cd55524c7e30..2bf9fe16abb9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3353,7 +3353,7 @@ static void __init gather_bootmem_prealloc_parallel(unsigned long start,
 		gather_bootmem_prealloc_node(nid);
 }
 
-static void __init gather_bootmem_prealloc(void)
+void __init hugetlb_bootmem_struct_page_init(void)
 {
 	struct padata_mt_job job = {
 		.thread_fn	= gather_bootmem_prealloc_parallel,
@@ -3582,7 +3582,7 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
  * - For gigantic pages, this is called early in the boot process and
  *   pages are allocated from memblock allocated or something similar.
  *   Gigantic pages are actually added to pools later with the routine
- *   gather_bootmem_prealloc.
+ *   hugetlb_bootmem_struct_page_init.
  * - For non-gigantic pages, this is called later in the boot process after
  *   all of mm is up and functional.  Pages are allocated from buddy and
  *   then added to hugetlb pools.
@@ -4152,7 +4152,6 @@ static int __init hugetlb_init(void)
 	}
 
 	hugetlb_init_hstates();
-	gather_bootmem_prealloc();
 	report_hugepages();
 
 	hugetlb_sysfs_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..92e88fca717f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2323,6 +2323,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_bootmem_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bb23fb3077a3..6e09000ed3e1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -342,8 +342,8 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	 *
 	 * Any initialization done here will be overwritten by memmap_init().
 	 *
-	 * gather_bootmem_prealloc() will take care of initialization after
-	 * memmap_init().
+	 * hugetlb_bootmem_struct_page_init() will take care of initialization
+	 * after memmap_init().
 	 */
 
 	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-- 
2.54.0


