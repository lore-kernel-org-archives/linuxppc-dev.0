Return-Path: <linuxppc-dev+bounces-21879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A6CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV66n3zRCz2yrt;
	Tue, 02 Jun 2026 20:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395073;
	cv=none; b=V/RK5BlV4/u2r8RfNG7oilkxGBgcOKnTOK7i+/xeSIlmqaviGdvJNBUJuiigLhXQpSK1GKfRT2xLEUcuQK4qwfVSqXY8JQ94ZJMv3nvqt18HV2z/WF8j0Rh+nOALGyRKOTALiu/qiJoSdNCsNdupwfwgy6iF/C8F7zCOi9fHyVvDwaMbodgpupeoXhj1LyaeesCHYb8+vVGU09VrSwrLfZBxbMaucCJ6sYtxcQZJV08kIEaYp4V+RAv5opBQY97hgyHgtosLy2eJavF5IX87O/FbkDRqFEDh48KFGCF5MH/z74DN5YyVYgBCwVg4KFzo+XJuxR2QUxpHtmxe/c8PFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395073; c=relaxed/relaxed;
	bh=6ifAYajDzE3bfTkaM223T1RUSqkPH2sIJK1XHV+rXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIT5qHnispDgHv0f6yO1p36D1KJ1vaCKcef/dVXfRpK41oqjhqioOsImxt93Xl8VKicDoI45R3hpdUJgMsav4z1y5j9f7eyCWmpi0ajizQzNZkHKuQsV1m1ONCsgx1qfhMCOzKVpeHM8AwxntIBMyFjsR5JQXrhX8MF/US3wlSWfpbwXxw1zep0CZLcMK+mvBzzcI6Z7EWwWBpme+aOxezFD1VWEfbqd6kR5hk1u8Xw3DoteNbW7QN73vGiKjDoFScU0mtQ0fmQrqkG70Y7JsrCFZPCxm8XPlkyMfmLJknBFSRKzVda4U8d3aR2YXNSqQ02E+FCvlOnzmURYCuCi/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VcBYfQ6W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VcBYfQ6W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV66m6YPDz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:12 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so1772287a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395071; x=1780999871; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ifAYajDzE3bfTkaM223T1RUSqkPH2sIJK1XHV+rXLE=;
        b=VcBYfQ6W0jv8YeVrbJEc2/gxQHpxN/zoQnrPHiZTcxadpniJnSjgAgTthVKr8kF+gS
         VSumSxu1LMNvNoBECeqpuc67C/FiZAmozyHSiZpERGLIKvLrUiUS3VUzFPL+Xu7dCw9b
         4NeUI3JYJMDTgslQHnr9HULpMY2oeHTkqpz2C9UFM0TOxdbXdFggipYEda6FUPKqf022
         B2zKdgpH/Orq3FhjsJJKukDDn+LtL9BrWuOAmWDCjScq6v1GQm8GAI+TX9rvhUEFVWpr
         ZjBvtZ0sCZSvuCnDB++D3Suti5LUbely3QgNzVoSJI1+GlpaaD0shogNfR7mrL2A1v9o
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395071; x=1780999871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ifAYajDzE3bfTkaM223T1RUSqkPH2sIJK1XHV+rXLE=;
        b=NDYZSSBZtkOgczhuo3g+HVh40/4ZIx3eBslIRv2pfBJzR7leGBfj3YjLiYMowMCqyh
         VoLYj9HCSkpkLb3mYnM5GEdU2+VobfOBybvhir7XbF7NA7cDcoFz3Ox/SkDvE/QvJ32h
         y7Eh710kttHusIxq8srBPklI148y00bAncLrkHJSwu0Wy7SiWYM++5MCD9DLtbAQOK5R
         VuI0MMjC9epwcLx9TQDwc/bVojb5wScqJhKpXhtWzIeBI50bjV3656fPfSY28/A7TiVX
         yF3SupXBMv7R4jekBkKovcTjYZxhOUUyYndMS9AKz+zVOD10buVObcnTt/X2Du7dOozK
         ssEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F+VXOO1Jx376NS0HP1689qRf2PFlTbFKqhLiR05hPq3XLoHHojXgbCKXGYrYIdUs9iP+JuWPrgYbRDYs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3pS497+mZn5Zc2ryLePLPsEZhY1uwjhBT2qUQP5DLgHTqki2T
	7s87aMHBIMJzuXkR0LsmxXKPXyDLOWpZNWhf9wcEcHabSAkHkfqnWIAgN5oOShLZqFQ=
X-Gm-Gg: Acq92OH54Y8W0U8fGyfbCMGUqzinePCwpPSj+48EkG9qxqCPUdD6Ll7m2mLAplSdPKG
	MUy6QweCE6RfPmMA4rOC6cFKCg8CxtZc77sC1XT0strnB0bRaMn2mJSn/6J8iz6GQfPmvW/xhhs
	S/Ybo7eiRcSuEt/Hlsx4vm0r+2Oqgyu+fjibxxepSLES2c4DhSgCZnD214CeiVL28ec1Ws1FgAu
	jZfNidScKBXN265MTDYx8fteS3PAV4KZY9+C7ftLLHc+Vj0QemgYbBCghwcw1Wcx5ZVOsEMCa8X
	Ci6tIbdlavv2uxeiSdZmRKNRNsvb/W06wlSFZaQP+/Ftm08UG1soa6QckmfONCWeM+emVV+zWb3
	gL5+8oP1cQ/cJ46AqlJVU72OueCKS7UlnRg5KRh+5RlPTyTBmcuZ86tLf07if62oJoC6tQDuvCK
	GcCrz7uaDCevuCvPiT+YQkQbhMzSqrvRU9qFh4jrRbUVoNm3hYRLrWqCk=
X-Received: by 2002:a05:6a00:3c91:b0:842:1052:5fe7 with SMTP id d2e1a72fcca58-8422532c951mr13639719b3a.6.1780395070652;
        Tue, 02 Jun 2026 03:11:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:10 -0700 (PDT)
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
Subject: [PATCH v3 04/19] mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
Date: Tue,  2 Jun 2026 18:10:24 +0800
Message-ID: <20260602101039.1867613-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- rename the helper to hugetlb_bootmem_struct_page_init() to make the
  bootmem-only scope explicit (per Oscar Salvador)
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
index 6de3a77eb9ae..1890bda948b8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2338,6 +2338,7 @@ void __init page_alloc_init_late(void)
 	/* Reinit limits that are based on free pages after the kernel is up */
 	files_maxfiles_init();
 #endif
+	hugetlb_bootmem_struct_page_init();
 
 	/* Accounting of total+free memory is stable at this point. */
 	mem_init_print_info();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8f41b73fb674..db9cfe57e827 100644
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


