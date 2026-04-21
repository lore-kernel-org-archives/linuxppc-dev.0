Return-Path: <linuxppc-dev+bounces-19860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B922F5A8A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 02:21:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g05h72yp4z306l;
	Tue, 21 Apr 2026 12:21:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776738087;
	cv=none; b=TogBZ8nsNfgXUdkc0JbRDA+4wgH9Qy26QiTyZZaIWUjQuck0mOqCPbJ8/TrU4K+blf4K2N/bBcGJqDKlPv9rvzda7v+ALgQds+Zk+CQphSDRimMjGCJflDvtu5MLE+KmSCA+QcgiOWI0AODyX9q/2sdbevqJKkEEJywQlyAfqIGFup6BdLimNvev/fe7eA1BeDfi01HQzYwTjS8e3VgUWiuMh9UBW2v7Cyz7veGVl9uSxND+InADlHoOD9xBecK2MlxkBlDvWS/aXNTWuIBFOOl9v7bS7lPWxZROxsVEALEhuQkZ8j1MGjdmjn8LDiAja33kh+4Ondz8rumzGLPt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776738087; c=relaxed/relaxed;
	bh=yQT9sgIl1x5UPRFaiEeld1v2vJgPbOqztRRBh4ZUxsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lwd/NN6zY0Q464N4DxhhIOZFgfg+mRRhT7paWGRzDzYg4MGytPIV6BAlGI4He9u0DbqK1T5jE4sJ4oOBe32GxSd1k2uPOF/y3zNyTPoPPaoczh7sEEDSVM98zPxuzN7xgYaylzzRNewCW2WAp7AKFwTx5Q7cmfKHlRBKK7DE0hTG9I4sIHLwnh2OK09PrL/OAjAI5tJ3VInB+wdMxawnMbDBJzsvqO28ajLkmE2Qvma3Pi0PQEUYxNWxqLJil+0TWa9nIWVUjRAqzRNNf4POh5ippDnZ+U4Mx6M0OCHRmalVmKcBNLugqj/piFVqJizEUadaiUdrdXcKOLPe5Y0gBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QGR7md10; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QGR7md10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g05h65Gl4z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 12:21:26 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so1090691b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776738084; x=1777342884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQT9sgIl1x5UPRFaiEeld1v2vJgPbOqztRRBh4ZUxsY=;
        b=QGR7md10ySFJw0y9Rlc8HL1+qdh34O3QGHBRkXr+Zk5NNG+u7I++55pjIgexNq0rUh
         SFHWsLex1Oq8Y6bSYoH8e8C5zOqi/b/BODp3+xaR7LW7utxGdCB5RADFPX7CZcU3kkx4
         XEIN+DF/PbXEYoDyBI0ij2jsWMd6Jy2oc7F7bBorYOrRgFBK1puQiuz2o+nOSvrGdfxM
         vQuG8NxFGkCUV36kFA4OEUP1Pai8Zyna1nB2QTKLlDXmqx3UEmFsUd7nhtJi3Tk+uJSm
         mSDUZ0lbpUH6JpjKiYvWhdbYDAHS9NTYLBzdwF/JSzkU02fg4S/yhMJVvcYbPLHMItWO
         CJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738084; x=1777342884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQT9sgIl1x5UPRFaiEeld1v2vJgPbOqztRRBh4ZUxsY=;
        b=E5tXzU3NQGS4tJO9i1m5HyOj9dmuAVsv1Yel/1h5YEcuPQ3VrNaJFYCMTo2mlaYsFC
         FoSy3v7yTOBOLpG1+lBdmQ/TcD6tVczYIOs/2y1OE4b/6nopRrU/o630YJ8Z2xY9BaTj
         3okGXgWw2b1hZTULeLtWxZIy9F+/yRRbQW0pOPVr4eu4R43bPZcWdWmkEeS8PLxzlIex
         j+QKG3VWOpzGUIle+KMlq8roEM/ycjQW/UdUZaaf6KOAxgY9fd4YlMCMxxX/VTMjCGVi
         Nx6g/GQzcOoi8jk+7/v3I5AXJviLB5nzLktheRZswFPhaL8FmRTT5z5g5Rbd2ctnpsKC
         Jzvw==
X-Forwarded-Encrypted: i=1; AFNElJ/0F/HrshVdzR83YELk0Srj8rBJBMwF8s4i1W0hp9pABMGWdwripJ7gSkwpYl6hRUCZCaXHa77IyhPRJ1Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydGvprl4hIR4wcjSAdx/orwyHVsQtsMDwbnee4o8AiyG50ox7Y
	Lp7yq2p1okV9OVcm7rYAsRe8ef05oOTcSCM2uhcDxgMQahSpGupqZRbmdRN+E4FB454=
X-Gm-Gg: AeBDietmOLF1uorLxtIGtqOLwmm02n4j+cU3wqDhIg9d5e5ro48E3KShlNS/agpoUn9
	Nqo0v+XbYBqZE9UDDCwfF3sUxacupvDBnUJV5qAdV6gqG6ramn3kW/gFKI9eKToZZmq3vmzmYCr
	u4lIioVAcq2uy07yljiSwNwnUWyVv27Be8i13lh3uh9+DYbAb1dFSXUmchzDyQWTQjGNLFH7X0x
	/Fzoo69zvWBeyVGlyiqEIXyEkr6z6L4DglbEL1Z629aq61Syo3Cjdq1iiV1QOrDLUk2WKLhQNZv
	SbKuQTSS4lMbOB1CMIlC2FsNITxIFHeZEkNxjpCJgO1ybYShELuUuYL/Qe25pFIOP4OVGaJqyt4
	kV24tO2Yt5Q6x5knSzBBHgvbm80JhVyhE5QdrL9RlgP1p3eXTCnWVC/xceSC/EgLP5XP3OlJbcZ
	e5WOQIUj7mj18sh+mE30l2E63zXQiu
X-Received: by 2002:a05:6a00:be8:b0:82f:9a88:9092 with SMTP id d2e1a72fcca58-82f9a889558mr7527975b3a.33.1776738084191;
        Mon, 20 Apr 2026 19:21:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::340])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932dabd4sm11538780b3a.51.2026.04.20.19.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:21:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Tue, 21 Apr 2026 10:20:43 +0800
Message-Id: <20260421022044.1217503-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260421022044.1217503-1-songmuchun@bytedance.com>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
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

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/sparse-vmemmap.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 40290fbc1db4..05e3e2b94e32 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,29 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+					   struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	unsigned long pages_per_compound = 1L << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound,
+							PAGES_PER_SECTION)));
+	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT)
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -659,7 +682,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +693,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -679,9 +702,10 @@ static void free_map_bootmem(struct page *memmap, struct vmem_altmap *altmap,
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_vmemmap_pages(pfn, PAGES_PER_SECTION,
+						     altmap, pgmap));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1


