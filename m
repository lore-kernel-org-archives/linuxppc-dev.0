Return-Path: <linuxppc-dev+bounces-20853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A049CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFtzx5ZPfz2xpt;
	Wed, 13 May 2026 23:07:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677677;
	cv=none; b=Qyd4EQ/xD3E3wEe4TPPZq1E26gfy/chVhZOMGwLzoHEyCUKsLMT06quortkLARp3SSIsVM1oiBMUdbsxdtHRTv6gixqlVa3IdMi9ytLd/Dte4ppcdQmaJdaK3N+7suxfhL66tsQE5e0pDkbNv2348nlDDOFPxuhc1iVockwjeV/zbr9+umvKi4t+/C04+Ax2B9XjjFawxgf5pQRxJkPrvBKgW5nvRYaxwc6WrD8ZhSK7zMdiv6/UG86BGuQU0d3oJHkJKQxbkttoKldrmC5T7isDhBHdhQQHFN+FGEOUyenfHLi5Zy7ve5LynkHnSkHMYxtgzdCp8dm1yWA4LoMugA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677677; c=relaxed/relaxed;
	bh=vB6yS1z5EFpHn1m3zCB1eARc99Wr/QTdVrJKUDK61SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHqIuL1jRgdDAcgmevnkU+dCodqHJ6b14KHQROxBJewlS+UmP68QeeOwAx7VtiyoNeCzbNvr24KbiaYZI+7HZQKTaaziK7dOW03wCXaMjKOF2QmxPKr/4sYyGuxhI8vgG7aXRAYWhX4GraKOFB1EVvUYBHG8BFtamGYuh1KBwwjIawHYCOO0fP1/2+XvdAVMQSohEdzD9mXhUonTtLMPrH90JzjQga6CLS81b6km/nGq5cBKwhkmxJvnony3G94crll7U4RM4SyY3k3XYQ28v6Eg/2r40nm9tl20d1NQfkTMZE1zsiHJMXscYy8YySrMbGLKK5YVgkhEPOWo4yOL6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=N7XoMOxl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=N7XoMOxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFtzx0sqWz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:07:57 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2bcd3ac3307so19192395ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677675; x=1779282475; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB6yS1z5EFpHn1m3zCB1eARc99Wr/QTdVrJKUDK61SU=;
        b=N7XoMOxl19CKYAbZgplHleDwtmD4JThiuujr2abfe0YN6/g+vhR3IM4sYP8eNwWFKh
         XlF2PF2XQGzT87ySppNWAEnQUKTuVVyVwrVFfaM7Nnmqta+iZIfTabpWybygJiTGLen4
         6vmGHCTvlRO6iC3Qi0mwVIUUVsGzyNeMPvG7lGR5SDWO3Tum7CjjIY0zkOTVcS0R5jLF
         UyQRTVpit9BiStZTkCZEv709YUhqz1Fvauo2AJwSzg1LKXEKc4Ii5XkpzgXyZIlkcr0A
         ur0slvVDbQ5r0xxtP7O8Hu7TkNcuC4Q2mEk9RzlkH43e6lmvVOLVpG2UPE1QFmx2VnOO
         85NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677675; x=1779282475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB6yS1z5EFpHn1m3zCB1eARc99Wr/QTdVrJKUDK61SU=;
        b=TEtnxzLwRIUENu8nszDSMUtedpnl5H8cmZyrddwQR3zzAKQ66bOIQXvpVH2V5zr4eJ
         3qI0aR/u8g+VCwmqFGN6YMFX+w5VHjV8qO8Qi9MzHxOItqeylr5KKuG43zs8GnVnZ0na
         SsXV+uXcxYGSGaMP+GzLcX7wl7W42M/DX2hSYIhwXdbyb+JlJIvnyX11G+do5kB9kPZt
         OKNblnGGsHy+GB1KCXCPxlhYkgORUAthkLLgtMOlE/UlWvP86p0+Fv1KxOzsyDQT4TBU
         ebwfjE1gJSmgiTfuQan5zL43J5t5iAuS5FBhmur+ZqKiBBdUhiLjQ56Az1txc+/lC4fw
         gI0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xCCEiF/RMVNBmaKcOq8guXGkab+eIJAt5fghEN7zRrm1zYY0yRErYjk45/SBxre3ROLcrMnl3W7l+l7U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx46ET78x3xJy5WqNYlpodUnnM6LdRdBWvnoC5iNidTKJ03x+z+
	jgXtOTFJev3Pj8Kn7ViY+Dla38H3TL2W6BLOhdyAFxcjcaVFrPzLbWf6kOLLTaVe22U=
X-Gm-Gg: Acq92OEuN1Na2spACwDwQoQ3/z24QstVMY9gKMai9pQ0FFSPSaY+0Uw36nd89ALUDMZ
	Rr3OrfaBwb7kZW/SHt39Z2rvekADydal2BW3DOQrPN4zxX5TL8dZFPfBuSfms8KwKuBy00ShFE2
	QRp3qdYuJElGbeSy7ArprHY2Ijs/sYiybZDN8vtcYNkp0X+J7CBW0JJOk5G6QtZJvXwfm8XvcdQ
	07Myf9E/r7YQEZRM+QQLBZ3mjyLeU9eWw00ahBW7XfICr8z5YCkzOaWAN0BQBynzLHUqqGtHR8G
	JztW0LpiPI6usyZ10VVCbSeYk55JoMj/Mz9zmKw7w3nKAB7y1JiX65Ic76aK9kG80nLKvBLcQ2O
	G0noCcdWRaH/XblEf75CaroRUHyRNqZOxV77691AijMAY2NDsJ0cVD8TP/FHi+yqir5PCp6d0x0
	dc0tJly+jSYUyEVK2N6gyKhAvMGkE56w1Z7wDwefVdRMJrVNNmelHudpwEjLY=
X-Received: by 2002:a17:903:f8e:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2bd271773f9mr36693205ad.13.1778677674866;
        Wed, 13 May 2026 06:07:54 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:54 -0700 (PDT)
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
Subject: [PATCH v2 04/69] mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
Date: Wed, 13 May 2026 21:04:32 +0800
Message-ID: <20260513130542.35604-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 5 +++++
 mm/hugetlb.c            | 3 +--
 mm/mm_init.c            | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 93418625d3c5..52a2c30f866c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -173,6 +173,7 @@ extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_struct_page_init(void);
 void hugetlb_bootmem_alloc(void);
 extern nodemask_t hugetlb_bootmem_nodes;
 void hugetlb_bootmem_set_nodes(void);
@@ -1307,6 +1308,10 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
+
+static inline void hugetlb_struct_page_init(void)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d22683ab30a1..b4999653a156 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3370,7 +3370,7 @@ static void __init gather_bootmem_prealloc_parallel(unsigned long start,
 		gather_bootmem_prealloc_node(nid);
 }
 
-static void __init gather_bootmem_prealloc(void)
+void __init hugetlb_struct_page_init(void)
 {
 	struct padata_mt_job job = {
 		.thread_fn	= gather_bootmem_prealloc_parallel,
@@ -4163,7 +4163,6 @@ static int __init hugetlb_init(void)
 	}
 
 	hugetlb_init_hstates();
-	gather_bootmem_prealloc();
 	report_hugepages();
 
 	hugetlb_sysfs_init();
diff --git a/mm/mm_init.c b/mm/mm_init.c
index fde49f7bba6c..5a910cc5534c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2335,6 +2335,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
-- 
2.54.0


