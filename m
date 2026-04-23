Return-Path: <linuxppc-dev+bounces-19993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D44F99340
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:19:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SC617VZz2yGf;
	Thu, 23 Apr 2026 17:19:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928770;
	cv=none; b=lkM9fdAEoH6cmUyARwXc+9RRUH2auT3mhn0pHB6OiNmWQoTLxaBu/wqLkJBS+fcuplixayB4Q53GmHdkPvC14HhF90DkDzPqfT6YoV8uYyWZo2L8cSsvOTQ5UGROOWC9cNIX7i3HMnlyEpSDDOoQjk/rq9VGIxtuMpaYR+WhXNv2wtR1nI5wKlC0N1ldOaGzyA7vmxRa4Chcf5bTM9NiE+qrtfSzHRk2kOMrjfvdpwqwMOMybBDJb75046ioZUEIlrzJezus3bTyB/L9e9Whmsui8Zn+4nEXq9j5BEpHNilsjdPjXHSKxrh+KgUujXW5Jq7xvP6UsiL9CuP6ojxODg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928770; c=relaxed/relaxed;
	bh=aXDuw3SgDm2p1+utjq7Iir9F7HkLAKGsFULdDpxe88Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NE1LUSIjTzMuXq+W60dhu9gHwaNyglioc9sOu1fBL6fZ0YyvNqNjj96Gcs2BqkMIV5PylL4I8rHK+zbroNPXA8heQ/qmpT48gk0NuQm1E++Qq6IyDXKcMb8YyExCCfHQdVgCwaCfKjlvvzao8Df62YoUHFGeyd+ODGtbma3rpwr03Btv3q45HJ88/BOQqELkufbl5agOXIZ9epRb9DJUr7rBMRdPC8M7eQF4NBMS5cVjYWDPqdkXQxvAr03/kCArlhfzJ1cA6iRJF5vdWW+plU9c/fZe6zr15aRhB8BaM/sYs2aHvYvsnKPYpCCqx7M/59UwPVQXo6uEGoipebD0hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZRO+zIkc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZRO+zIkc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SC51MWhz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:28 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4967118a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928767; x=1777533567; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXDuw3SgDm2p1+utjq7Iir9F7HkLAKGsFULdDpxe88Y=;
        b=ZRO+zIkchWyX/dBhPwaGlwKU4fBJTFV53wFVk/sv0viS3gCNOlc4Cg4ChllLT6U59+
         nDH1vh9GVeL7UjQBuZ0WtKwyUsB2MX6XSE1uaCVKhk4KYnEeMIb6lGSho+Y5i663c+KQ
         zYytMwW9FRrasMTiIw1PYp/hmEoMngUlao6/VxkMfrQcTMB9A4cU2PI5t+wa3QUXUOJf
         3NDvXOdADAqhvfaEBOxunntlxU84AFn+8/N0SYpLpZ9u0ssfvf3bXN97vNLgaimLu5kT
         aVJdbgnDOmTVHTt03nSbuM/atsjJTq9sqgzSQWVcEEaeIjZdVfm0hvDR/9/drYwXguqU
         MaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928767; x=1777533567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aXDuw3SgDm2p1+utjq7Iir9F7HkLAKGsFULdDpxe88Y=;
        b=GRF0vz5/5umU8uMoDtZjGOXp+DbUpEWtYrfIde5UuImoqLGEv3kj1r78UfYmWjV1XT
         TazPLPooAFljb+NtffnHaNPLhMWQyXxN+xFlayjy9zuOvcU+wLWoaPR6akroBLcqa/oT
         IaddAHUx16UfCmp6QBy8ZVZyv8X5uTE0uL+gncsZztXZSpIBvt9pZNHBhIxNuWHaUkTK
         4oByOz8dEoCLGhip6fI7mM1SWk0uOI9IsGGUfwLrgMYQ29IkrB5P2YHdvPIVApXO0mBe
         ggN6gsJKTxd/cxnzN136m/RMbOEt7vA4OaYkFrGzdtad16wvlNZH1hgSqFeKauthygCS
         dGBw==
X-Forwarded-Encrypted: i=1; AFNElJ+HilM3LFD6hpB8fOrxkTTiEK17BQoCo7NwttSaeUOwB1F3X8UNs6zxt6oAMqc2w6gzebdIcuLiH30aVv8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy01/r9g3z//1REUExI99iy61zzYBarSPlE6ymqNfKZuXwECVEb
	N6UcJXE5TkxzK2fKNFuXofRVXLBqYI5pU7PxV3/kpIXz2mRdsJzOpxqkP2gYnERp7l0=
X-Gm-Gg: AeBDieswVCKyj9gO+gWM3eo61J9FP5w/lOUtDGdYpVjJv5ht4wclSLZ4L2bnmKC9vQf
	1Ors6s6G13N4XvwL9asbDRd9/5RfGFIBvOhO0l0d+OKN2rmgr5FpN6mtYEG8URPK8/h/OT4PDKS
	AzkllAu92ZgUbFA49im+HkrG0uMB6+uIlFllzMaNeGppsJAfRtWc/ai7FR0Y56+vdQ0Cph18gwO
	zvMLHLk4vuFrtuuLNsE92c8zY/zGlKG3YVWtzGYZ4HXKjpMfNsN5Eed0gwUeVNG1NaWDIo41gtx
	LaEDwWa4e4hmEHcTB/xAdFj6Y9nmpctOsP3uGCFlhiysIg/YQEFQ9Fhs10Jkju40yZKPIn4B5cK
	Bw1K+Ov80vqcF1xDVw5d3lQC5kzSUm9jXbcv4/58Q3fabKoqXcg2/2tCJzGjWvD3vgPTHhr2Gig
	6VLDTWjEnU4WajRVgOH0KJGmz40Lg6vmuZKBmaOC8SD744CD8im8eU/w==
X-Received: by 2002:a17:90b:2fc4:b0:35f:b6d3:da7d with SMTP id 98e67ed59e1d1-361404635e6mr24991060a91.17.1776928766629;
        Thu, 23 Apr 2026 00:19:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:26 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 v5 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Thu, 23 Apr 2026 15:19:06 +0800
Message-Id: <20260423071911.1962859-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260423071911.1962859-1-songmuchun@bytedance.com>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
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

In section_activate(), if populate_section_memmap() fails, the error
handling path calls section_deactivate() to roll back the state. This
causes a vmemmap accounting imbalance.

Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
memmap pages are accounted for only after populate_section_memmap()
succeeds. However, the failure path unconditionally calls
section_deactivate(), which decreases the vmemmap count. Consequently,
a failure in populate_section_memmap() leads to an accounting underflow,
incorrectly reducing the system's tracked vmemmap usage.

Fix this more thoroughly by moving all accounting calls into the lower
level functions that actually perform the vmemmap allocation and freeing:

  - populate_section_memmap() accounts for newly allocated vmemmap pages
  - depopulate_section_memmap() unaccounts when vmemmap is freed

This ensures proper accounting in all code paths, including error
handling and early section cases.

Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse-vmemmap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..a7b11248b989 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -656,7 +656,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
+						      pgmap);
+
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return page;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -665,13 +670,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
+
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						  PAGE_SIZE)));
 	vmemmap_free(start, end, NULL);
 }
 
@@ -774,14 +783,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early) {
-		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	if (!section_is_early)
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	} else if (memmap) {
-		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
-							  PAGE_SIZE)));
+	else if (memmap)
 		free_map_bootmem(memmap);
-	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -826,7 +831,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.20.1


