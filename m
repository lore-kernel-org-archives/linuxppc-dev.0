Return-Path: <linuxppc-dev+bounces-19346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A17F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVj1J8rz2yrK;
	Sun, 05 Apr 2026 22:55:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393709;
	cv=none; b=dJ5iPiBE8QBPMevVLjaHmHSQrY3Y36EqTRoTmLMjGeeudVN8+r/5KE0dpA5seg/uPjs+gfAckQXpcsAF8LLctqn0CClvRAs5ppKa2JTXubKSAtiZ7tmYHujwhPDQk7zG0PzvUARJx+f7yQJI5NQJznvgi76p2r+396cXUzy41BDX+ncA08nwTrXMOr1XEXHttQkrtk7IoPFqIO9aOGdhcN53ceun5S0cHpSGlezHf1e7Z9GzaJwLTyZbs5rC92ksK6XE9T5yKcgq6Jq+SDCMq0Ngnh5rrC8UMjC8wCyOXHCWGn86JF6PUCU1XV0sUhDyGRVmg9HRk86lksscHBt5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393709; c=relaxed/relaxed;
	bh=62kILe3INi6GkTRPTI+nnexklobUpHFgUm7h2fdMoGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7spGPH7evxZy+COkH4bT+VTD2BiYuDxa3Fr8AbPNhpqYH7dfXsBY+2QvE3hAr8YvJS3OOMHb6Z9IUeeGGQtcYA7AQs1wsI3C6Ov45GpZQcA27T1lKz511JER4fKZ5TPem75B3zaO+bhLkTAaAuenIfny/Pd0ohnL6UnfLAZcyv8p7Jj0IPaXpdrZdcfeyvoTLdGYRBJYMGiDKpsPjjDKYfrhxDYNLMjtds9/PP5IyM5O2NY2JV9MdlLbd51v048TtNTBdtsNADXqx4z90Cu9V7DTCFvmzB7Qk3aO/A+rNeu9JM/4tzq7LtbuGFrVHXza6ANnFhlRqIRntG5ZZHcUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a813gtRw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a813gtRw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVh3Bp6z2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:08 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso1861303a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393707; x=1775998507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62kILe3INi6GkTRPTI+nnexklobUpHFgUm7h2fdMoGM=;
        b=a813gtRwA5CYxaY51efsZ7kjq9/4Jw7N2Xfa4Vg7AdZQ2InV0n7ypDcjJ1sJPIILzS
         thlYffgqp7GRzXjA8lV/hKySttbBADUkLfk+uPQwlNFri1VQv37xMgUsJi5R6XDTGe+p
         nGuA7o705HB2qy6GtFFUmmeD7SIoSS75+4n/QROe9EQsEEZDHRBt3ZSTlHJARpKCKnJL
         qOmLLCoiMRI2KUKkPJfaSXkNdnVEOV6GdM/o5xarN7PmYYuDWnhxTSPj+hwS+AblHcxO
         ywsrbvHqLFGy3Y6zTI1ihGqDg5/W/azYsftWEt8t0VY1j46E4BAMO5zGvtIgeQZXuRPz
         yCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393707; x=1775998507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62kILe3INi6GkTRPTI+nnexklobUpHFgUm7h2fdMoGM=;
        b=q8uEZ8pkELj1fSzytJMfQ4myYEcJOqX+XzQZRoR/OI/48PJoGeSyEAHzTg5pN9jC3Y
         tjiUAblotGhvQ9PPAs5+uoMYxJt+qLxpba9gRZmu5+4nV9GuoIv71YQnrIwIdiYsiRRF
         zcvFotj9PF9vS8VRYmrmaL3TDUw5y8BtZtJ7FZsqAmpm7cudiProPD2qOdHLH5vjAfY/
         rEAdzLk1E6Ckt1rtc+ER5rUOpkDtkgoearx5qVdrcmxuMuNrjq/49YmJ8YDHb1PAehkk
         x/SJ7OsZUlNiYq4CSE6ljte5lMeP7b1mUJ/2v8iJf0HM7bNFrX1gGOjIgPGo0irqIFl2
         TQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXTifMkIMT5nX1qc6lVMuM/SI9mNlSwJZFajCLu2VrNuB5Qr/fd1NO7phVmRSxEW8eZScB22oXkfuZsl2Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLxzFodxECdFtRqjCHpgeD2re6359XtlyGd+RMFCdHL27t/zZR
	xh8ogoBqJDy/kyQhwlCX4Akd631H90K59CWAuSfJ3N6BDfiDxrczXBIQaSAdxbuFi6c=
X-Gm-Gg: AeBDieubVqKP3BdAL3B1yUJlRCZRxs72tIo8dUuBjW19cO4PiwiafegOCYe8RuZGSNR
	U4KEsKbZvYgdCIonLt/y5p4om0QQGK5WNi2DEbEEIGEMpRI4bWejlHA6lMdHnhBDUNdjoG5GU8h
	KcXa3NNDtAH9zPbiBIZjh7r/Ns6znpjHk5Ol3ziTS0yz40wug0c/57gb3+3LsTKbP19jIyHpTYz
	285lSPdmdpvQu/j6I4our1NPh4+kOyU0mqWCZpwLq+4I+DsX0lEQ5X5BVKcFIwDhn6fihqBp6dY
	M5nJGkjBfzI13zLNObnOuLPXRAvenmcElWIve4jFSWrot2FuQtoMVIwVhm3oBxar5unJRPcTqbz
	nAIEgUcY3nWAtbPZWIz58Ys9szH51dZmLqzq3tMthaYw7W2tu4xU/699ddzzB7anMOhsOblbk2+
	7cwDQZpW8WBXRDOWHN2W/W2f7/p2f8ytHYfBvthHPBjsM=
X-Received: by 2002:a17:90b:3d4b:b0:35d:9fe9:f830 with SMTP id 98e67ed59e1d1-35de5c42865mr7039662a91.12.1775393706456;
        Sun, 05 Apr 2026 05:55:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:06 -0700 (PDT)
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
Subject: [PATCH 16/49] mm/hugetlb: initialize vmemmap optimization in early stage
Date: Sun,  5 Apr 2026 20:52:07 +0800
Message-Id: <20260405125240.2558577-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Move pfn_to_zone() to be available for hugetlb_vmemmap_init_early().
Populate vmemmap HVO in hugetlb_vmemmap_init_early() for bootmem allocated
huge pages.

The zone information is already available in hugetlb_vmemmap_init_early(),
so there is no need to wait for hugetlb_vmemmap_init_late() to access it.
This prepares for the removal of hugetlb_vmemmap_init_late().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 50b7123f3bdd..e25c70453928 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -745,6 +745,20 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
 	return true;
 }
 
+static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
+{
+	struct zone *zone;
+	enum zone_type zone_type;
+
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
+		zone = &NODE_DATA(nid)->node_zones[zone_type];
+		if (zone_spans_pfn(zone, pfn))
+			return zone;
+	}
+
+	return NULL;
+}
+
 /*
  * Initialize memmap section for a gigantic page, HVO-style.
  */
@@ -752,6 +766,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
 {
 	unsigned long psize, paddr, section_size;
 	unsigned long ns, i, pnum, pfn, nr_pages;
+	unsigned long start, end;
 	struct huge_bootmem_page *m = NULL;
 	void *map;
 
@@ -761,6 +776,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	section_size = (1UL << PA_SECTION_SHIFT);
 
 	list_for_each_entry(m, &huge_boot_pages[nid], list) {
+		struct zone *zone;
+
 		if (!vmemmap_should_optimize_bootmem_page(m))
 			continue;
 
@@ -769,6 +786,13 @@ void __init hugetlb_vmemmap_init_early(int nid)
 		paddr = virt_to_phys(m);
 		pfn = PHYS_PFN(paddr);
 		map = pfn_to_page(pfn);
+		start = (unsigned long)map;
+		end = start + nr_pages * sizeof(struct page);
+		zone = pfn_to_zone(nid, pfn);
+
+		BUG_ON(vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
+					    zone, HUGETLB_VMEMMAP_RESERVE_SIZE));
+		memmap_boot_pages_add(HUGETLB_VMEMMAP_RESERVE_SIZE / PAGE_SIZE);
 
 		pnum = pfn_to_section_nr(pfn);
 		ns = psize / section_size;
@@ -784,20 +808,6 @@ void __init hugetlb_vmemmap_init_early(int nid)
 	}
 }
 
-static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
-{
-	struct zone *zone;
-	enum zone_type zone_type;
-
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		zone = &NODE_DATA(nid)->node_zones[zone_type];
-		if (zone_spans_pfn(zone, pfn))
-			return zone;
-	}
-
-	return NULL;
-}
-
 void __init hugetlb_vmemmap_init_late(int nid)
 {
 	struct huge_bootmem_page *m, *tm;
-- 
2.20.1


