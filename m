Return-Path: <linuxppc-dev+bounces-20878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B5CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2c14bCz2yY1;
	Wed, 13 May 2026 23:10:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677816;
	cv=none; b=Wrc1OEfOl5xWUZrvfAezwI6rDUyQze8B53osjdUJxLw97p9B3MWK8aqB0N3vOssto3sB/Fh1jb+h2Y8wNTXoB183yx70tec5i0aZeSTdPkstaZXpbCf9TPgCK/thMgj4lVo3l8JOXFT2qsiPRtlm9wZtZ1zHrz75XS7kuimek1RYmgFvj86mF1sTY77fxeLsu8VzgZ9roBE4mkKGRAXdhyja/qZjKM3NBEvdxcJRZkFYR3GSaFG98SNeG/M0nKndPTOu57W5gkoqQq4ODKR+4WV71fn4xCS4O7G9llDvNRLQGZIg/mSC4dodsUO8hb/O/ZbJ6+9K4kfu9U4l62ZeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677816; c=relaxed/relaxed;
	bh=Y3uLkZc/zeI4wWlYRCnYJNtlEmmCl6e0Ymtz/E5HBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEu2hWxGc9eq/LWB4ZJdOagR2bJ3C5/yqN6McxiRzMJ2auozUB/vc8hswJeUMWdbs40KZStdJyGGBO8K3HW8J24E0qskRh4BqnmhsLfvjG42Rqe+2ikoFDekO5DjhpAk3xz0tv1fSI3mzfFx87EGSeDl/PX5SvG2TKDelhYBahh9P4N8A4Ku3nMNnsQt9i6NRjDnzADCM2QhjexuJJpymEl5cIMv/qhTAk0BwEK3kOhsxfmPkBx7eDf6Hu7CzaDNfTqlAKZRXsnrHNRalRcUa4dlYrP8yGyosEJxlK6Cv4HsHQc8LQivpZLQBanm2cO71DnTlPoxoADbCnKekkI2Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S2NmvPvI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S2NmvPvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2b3TdTz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:15 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2739065a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677813; x=1779282613; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3uLkZc/zeI4wWlYRCnYJNtlEmmCl6e0Ymtz/E5HBFc=;
        b=S2NmvPvIUrYaxfHA5xSUa6KbDeC3WRk50c8OGVaWNdkojvR1eOEvpDEUl90MYySTUZ
         b/6OgHs6JKp1lZgMT2KSe5uCbPoWf5FG5yck6m98XtqkuLoOOIIVunh/9p9xntboC9J9
         0s3R1Aibvy+vMnxUiLyTnPkN9fXFFqt5vkwKVgfDg+FIq2nl4oGgbBMLa81r7v4PTlz8
         IGEuXA2GrmZSYjkqMKThUa5iY7FE6qKMaW1TzzbmBUHuZhR4qEVSVuJtNErPvEMi3Qgy
         BSLimk2I6HQ00hGOHpfmcM5k02O33nrEIKX7D9jrGb2MIld2K/BeIJnNWFebpHCfn9Ca
         97yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677813; x=1779282613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3uLkZc/zeI4wWlYRCnYJNtlEmmCl6e0Ymtz/E5HBFc=;
        b=tM1W9Nez20Pm5DLuSmlA6wZeY976qd+UF7h+qHvRNPayFCCmlv1gRYNnjn26mDl+Zg
         mtLQRQ5IEcCy7E0CfSyOI3xFn3F49ahn5Mo+vc4vDOLHM+EuWFbiqGyjtuBkjKvgmr7a
         CB7dYHMwprlDWW/hKKg5RQ99y67jjmY5CatCqf8qNjJLwqgxwa3J446/eov53MkRtX2c
         KfPtY56zOzrPQyBfxJYZQVN84hKgghxqdqnMBgJzkj7OUJhNOZ01cIpfOCfzMyJcQAAu
         DLTvHcvc0pPAqJQ18kDoABdyH14br2ln5tqF4MDdZ6M9spzTD24XwNEfQz1nYi6puIZX
         Pmzg==
X-Forwarded-Encrypted: i=1; AFNElJ+PuScKp4PGhvn7aL6ehhCkjHy20ge+7QqgVfmDllAOCWsv2nC+9kX/Bb8rPIoK6C5Wq06wQUFLzRJp6eE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyC745E5z9o5hu4P1bojtLepkd2gKpYwlhBxPSd06Bz/rio4jlg
	tGBOUd2Ruma7r5EEZrO1vvD21EGIBlZOpaUI4fUBYlAbkpy1XC64pHjIf+7V5pDoOiA=
X-Gm-Gg: Acq92OGakuZ3kLvUORyvBwrg1oihLtRGoXHKFsr1o9dPlzCjNmffScoN3jNqir+VZqU
	9APEXe27CLysLeocGEshuOJGz5vRQOyW8KsC42PxTh/GycQJcleSRemtMu3+fBNP5Z5fcJpOZwB
	OmdyPMbpJPJ6mt88Wwi4BnSoegFbStW0QTk72ZyNO2mkoaSdaKpbW6uN9KZAoAhOpkyA2TRelAe
	cf+V/XAtXRXGTrBdYX4i3PFi1d1RHFcVrQO8Ve/RcYZS+UZBbhJTR76c/n9setReGpWW1GfBk3g
	3vXbSTtDSqmQh0qf11aWFIpPMUBR9aSCUZUFHbCgMBYexpRJKwehAC1k+azpi2yi5NkhyxbTPKn
	zrHWrM6j86hI5pkOLoi33bZMEQdun5L2VFgYLBcb+E2+1ydi1h5ZHmvIiMCFo7PoNRMiG2l5pp1
	9sXmFo4wHbsqCxU7kc4ExXoib4U+OngpiLLrAYIy2h3/1ebupNif5r8z3EJSo=
X-Received: by 2002:a17:902:e54f:b0:2bd:4b8c:fd30 with SMTP id d9443c01a7336-2bd4b8cff82mr5004355ad.41.1778677813243;
        Wed, 13 May 2026 06:10:13 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:12 -0700 (PDT)
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
Subject: [PATCH v2 29/69] mm/sparse: Mark memblocks present earlier
Date: Wed, 13 May 2026 21:04:57 +0800
Message-ID: <20260513130542.35604-30-songmuchun@bytedance.com>
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

Later patches need struct mem_section entries to be available before
HugeTLB bootmem allocation starts, so the section metadata can be set up
at that stage.

Move the memblock-based section present marking out of sparse_init() and
call it earlier from mm_core_init_early().  Rename the helper to
sparse_memblocks_present() while doing so.

This prepares sparsemem section metadata before the early HugeTLB setup
path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 2 ++
 mm/mm_init.c  | 1 +
 mm/sparse.c   | 4 +---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2defdef1aedf..bf30617c78d8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -962,6 +962,7 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
  * mm/sparse.c
  */
 #ifdef CONFIG_SPARSEMEM
+void sparse_memblocks_present(void);
 void sparse_init(void);
 int sparse_index_init(unsigned long section_nr, int nid);
 
@@ -999,6 +1000,7 @@ static inline void __section_mark_present(struct mem_section *ms,
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #else
+static inline void sparse_memblocks_present(void) {}
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3aaee1cf7bf0..6723c604eefd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2693,6 +2693,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	sparse_memblocks_present();
 	free_area_init();
 
 	hugetlb_cma_reserve();
diff --git a/mm/sparse.c b/mm/sparse.c
index 3e96478a63e0..33e89bf1ec0c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -195,7 +195,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
  * This is a convenience function that is useful to mark all of the systems
  * memory as present during initialization.
  */
-static void __init memblocks_present(void)
+void __init sparse_memblocks_present(void)
 {
 	unsigned long start, end;
 	int i, nid;
@@ -361,8 +361,6 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	memblocks_present();
-
 	if (compound_info_has_mask()) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
 				    MAX_FOLIO_VMEMMAP_ALIGN));
-- 
2.54.0


