Return-Path: <linuxppc-dev+bounces-19766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5C5F41990
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:14:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdp958fYz2yvr;
	Wed, 15 Apr 2026 21:14:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251681;
	cv=none; b=fWg+Q999jW388++79FTca/BfdxfG049dJrlzfuuZnmshBsgoMKUHf2Ygpxj3d6WgiwpNLY6f1MD94y6/YnzjfBUZXHV0BRLmqpfcM6mSEYr8/5pYY/GclhDGy514i2jnEDKn5jyH4Deq2S/bf8hVIpJ18E4hM0O3bhL9xtDP7jfcRTKXTCRyzUZHYCd+JcIjJZrmraTF1CYWj9/mS3r7zpy0m5LeaYGh8CaxXOmZIQGyYDRAsI3jddEXL1KkUq2yfTEE7cJJ+/4xE52xkxJP38oIKatdNMdgwvnaQBVwDlZmOeh9Fk9thinrcNi4DaGCxCDl0ULPd5QavYhyMjtWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251681; c=relaxed/relaxed;
	bh=vC2b62MaZVNGL0bmie++eHoqVNtyAoC7qXucopPxUdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+u6jzbUh3IgJI2XXXo9qrYvjFFni9rP2dTaX0s0m7SdNqlQ4au0DaHlbBNrOoax3PjU8tW8SgQa5MNfjvVfMq+CZsrkHyBrTmXUJa5uaGfpkou1n5Ps1jTRv3K4tGNYzZoAEfp7+AYDYSvGf1Qlj2ArGo0oDnilhNKChgc2CNEzEkkwgAQ/H8bAMmUAJMk0uqBknv4jAiiuTvHnUp2mXDxP8r4dSJtImaFp//FNY2F9Cxnlvav3lBSwrNRnNPbXsJuWP0Zlj6b+kOLW12ZRqRA678tgKOoHtAj2LP2Yz3ZeFkB6retPnBqV6jXpw0SwQkbRTnOvPE8scucXFx05bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MeUirYDk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MeUirYDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdp86pr4z2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:40 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3109501a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251679; x=1776856479; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC2b62MaZVNGL0bmie++eHoqVNtyAoC7qXucopPxUdw=;
        b=MeUirYDkVw+1c2oaidKVz6WKJgSPfhlKxXXxBsmaHnmh1z+LebqeD8+f8Ce09zD+Dy
         fy++3g5reEVomqDgGSmrOm0DQM2nfn1/liI79dqaEcchl/UAjyS67svjGR3HxdR1dNlQ
         yfR5Wy1k3DdxInA/5goUCj6x3Rizlv/LPNu++R3eOVn67VWLy7MJOSHE5Wkd6i2OfnXv
         QzpFw1jHtXphlHMFovtxgTN5rFMIz/TIPDG0X0/PIHK0whzYf+O1yb5nLC9B84PTbWkR
         /HMPnnexCUptiLDfj2pFG9WEu9a1FV93FCLinQ1L9HpG7WW/Ykqz+7P4L9tm6UEK+N/y
         Bb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251679; x=1776856479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vC2b62MaZVNGL0bmie++eHoqVNtyAoC7qXucopPxUdw=;
        b=O5BXTh/3iI7HauA31hLNUq5e4OGkcrMZG1ZmwLFokxP5wnrOzhKAhrTp3LWk8p0sqP
         uHQRW6Wr6qwrSEJj+cNKG/hgSiFQP6nsfJuUz8AjTWZX74xkawg5DcDk2qYVhJuhKzA+
         6ueEbJyyX9XScUHskGmqPTKdPYk2UtNXyYKOakxwtXKz4Hg+EB5Dtad6T+7rJ2X28vIj
         M7PgVPmuk7CsphDHDnAW/6uFFrBPfKRtlnrg/L60AHc2ZRiGRQHmfH9QA9J6ktiOx0ng
         b6ivAW5CTYlpFrlcreqbiRHD1rcX+iuVnHLZOCrsNp/NgZabP3Ina78SOSncPG/8MKt4
         1lzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HXwxzr0/b3SZSJvv8JAqatanCTx6BMIeaegI5cGswGkjXpxZJNANgj92b0KvjtYoq4cSFOtMUCe+gDdY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7NU2dx0KsBvTfC5MIxkF5rBococPfE2JUm5Mwx3kskk5PU2AB
	GQu7aMaytHAILlGGMG85Ao8s0/0VRK14L4zgDj+krMFw7odBcx1uwumCZ53bXi3rfuU=
X-Gm-Gg: AeBDieulUA6qd7Q0JeYrKUFfmtKPGqEeIYBF21fXC8376eeGBLROYAZI3/8W17sqfFg
	Iy3mAW+dE6iTFYyte4q5slTJE4WiXDeqm+72wkiDOZEEf0FCPKP/hPz7y9ZQVceVacLeffC3F9H
	PpicA3nokuPrqsn5cBvr8y7Ou9XnTOCRuvXLSFoRfBVqxXefYtXRlaZpABNRyzX8WtV4f4zuBpP
	5C4ow9NMk0PVUUd6orUvcPbKIQjtrA9w69PnA4KJP8amPhfgy0oczi1Z9fNbGzxrlhWX0n95BPb
	y/5csZNrrWkekvoutu9XeiDzlgUiwcEApyPxL+9NInnhm9SkUofeP4mu6QO7tQVqEFxD+sdnhm8
	eKNL53CtUe59Qr5QWs56bviquO+TxfsD/Wd6Mvlz1vGm8lTn3OVVQOIpruOx7vigMboNL6ztFzI
	P3vPD2eNPZX0FOqdEaYbTQxpw60OdrnJf19xlFnlMBxlE=
X-Received: by 2002:a17:903:249:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b2d59411dbmr209611585ad.1.1776251679043;
        Wed, 15 Apr 2026 04:14:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:38 -0700 (PDT)
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
Subject: [PATCH v2 3/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Wed, 15 Apr 2026 19:14:09 +0800
Message-Id: <20260415111412.1003526-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415111412.1003526-1-songmuchun@bytedance.com>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
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


