Return-Path: <linuxppc-dev+bounces-20222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6062FF886D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YHh1sSnz2yr4;
	Tue, 28 Apr 2026 18:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364352;
	cv=none; b=dj4pI7b1jjRwRopkUJVoTmHGSADyxp5QzTIBGaxRgTEAdJqkeyMW3nu8EdVQq0fVUZmidd1mwwyPuoDaP8nMSrp4nrSiY7mlsau6dhvEPQ+UcPL6Utqx7iwmJhgbYsE7tZz3T2E+aMTcSY0nk3UAyMpKjeNkKdD8GiMi+wtbFa1OvBpjbnjsDlJ+pTJpXYiK8wyy6lOsG/Z5xN5DnDN6LPKxZcV4SOAgv5LNzekvCgkUdndWAiz4gT2BAjs7tqNGUDBD7fqYGbqqmUBjXwC0KTT/+LY06he4XL67FchiDLgKXCP8ROiBe2LFHziJSUV6d3206F49/Se2HfwD0NofFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364352; c=relaxed/relaxed;
	bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdkUQhURwmx/uUALe1XY9ZV4/CLTPjm8fc4s3EbatzIwbT5g3+++lRzYiX1L9MDR9U5MHY4rTGa1NduphgI85NRKN9DEyV/o07m3bcFh5ekbWGqjqqOIEnfq5wWd//BAQyOM4xPBFYrbyJB3bMQiuD0mYdVpBPgOMhEvtGXRlXm9mSNfZtt9vMvzHFZNwFhlVNoEg4mhzaMJgWugwzZQAFZzCqOgA6Aila2d9boSoqVVJrE69zoYaPooxbs8r/08Zt7emSc/3uZOSJrmjkdJ0U70+UZHYzEjYUuClX3f8/pbk4e1aTs7JuTdIp8fPvG7eizxVy9dxH8GhU3KZyH25Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R4NmnHt0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R4NmnHt0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YHg1szrz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:11 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so5346071a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364349; x=1777969149; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=R4NmnHt0grv+L1NQg09yAvYBrZO9CAhIro/vy2DfTHES+EK6PU65qDBrw7CW6eacb5
         u+rUfUSr9U4LcBuy9bxBvOx+US8qGgRSDOoFqgdPFzMKIbKbqdBAbYJ2ygNSOrx5rjLN
         Gsdn2KYIhJhk+IvbUtlOGixoHHQ8f/VqTO+hUOTOmU0OIWgABaiuYcFQ7/bCIfSuf4qO
         kVDXtFTLmwfvNY6ROk9RquX4q8clXTkV542asOqHWz0yVIq46QhNcyu3VqAV+fMB/Wle
         6JJzTwOLRwcvaH3h4f9s/UkwKZZS5/t2PV7Yem7PFVG7xTggTrYz6PHdObRbQEwsx40h
         SRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364349; x=1777969149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=dmIkhaZ1YuxCpL8/d+Xd6Y6khGYMAwIaGfsjuKw5yJgpRTPmO+Ex8ikqD1LT8lgCBR
         5U3SCAeEybP+Di2FFFGNszPz8AXJf0Wj+6dhyWEcpzNDIhOBbIPBsWTKhFYBMkD1hRAq
         Vz6OXH15PfcOvEHn2SCw4wolT9bbzF+eGqJ1de/YZxcGiULcY0yfpmzBre4c7riW5HiW
         7Ir7IZX0RbZyUIBRaKWu433Hb7VIj5DNjYBMnHCfwpHRSrbfBH3+pGtlUkIrW20Lr324
         wExA10skNlIh6LZyDAv5w+h3EXXjI6tjKI9sHguDCD4eT+Sq6e2PEHrkb+sh7gtaOvNq
         9E7A==
X-Forwarded-Encrypted: i=1; AFNElJ8SOiVazx00oT8CC8Ydjvb48WnkPaOol4I7M0BthVDKFUyJK+7OiP9gLLcjQ5ajbk2xDaxpHLyVWiSIcYc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzgaqT+G7fwZux180t+vATpQbhR94xpbktt/NA7sFGxxZMtBHZ
	29zV2uEr76vQbogT0gCb5lch1scTqlD8bsljpshG8Rhy6VYDtSTK6hk4Ontz+rhgWvE=
X-Gm-Gg: AeBDiev5nPVj4u0pvrtNd/KwqMM6hYvCg1MOEo/Csi+E96bgZ5hA5MIqiOZhT+xoM+D
	US+xiNNMrGsxDFOTRk+2gdOt+ZXJ/GMwPbTO3IEXbka3i64frW0gvX20IETiLcLSWSzncCQGANF
	bTIzSNMv/45zzqmnCrcmIkUGe3DkGjphRYEcp7CiECyXlp3wdmdJKLmWtsjZyX59Sw5dIkG4RQ+
	N9GdQX5xj5T0TfTIW0lzW5rooFlVNSens+GsL7ld9Wfk+6UfxEwJkbgo4oCRqwmGIxUtljAAj+H
	9q1hWAUmkDe4UJDw8L2eMgqwQD/fT9M49tQJeeNk8pjv/BB86ntvr3TtywTIT16qZfoqn7tamti
	jWeX0NHOd/GtQNn2EwwepFPS7H2C+r3Se71/rXrhITyfEZrJhDD3aQiWkCXsRJbkIKTKhk7sfuf
	X/sihbpphGh5/hDSr2PhM0An6xAoRZ5DTFP7/7hFGlhsHqMQnaK3p9XVs=
X-Received: by 2002:a17:90a:d64e:b0:35d:8fdb:4f26 with SMTP id 98e67ed59e1d1-36491f89e50mr2246840a91.1.1777364349228;
        Tue, 28 Apr 2026 01:19:09 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:08 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Tue, 28 Apr 2026 16:18:50 +0800
Message-Id: <20260428081855.1249045-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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
Cc: stable@vger.kernel.org
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


