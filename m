Return-Path: <linuxppc-dev+bounces-19345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A08F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVb4fb8z2yr8;
	Sun, 05 Apr 2026 22:55:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393703;
	cv=none; b=Q54puTsnQsNctZjXBydMP40Om/a5bAPjHZ0PFH/mm+d8dNTBibPTXuf/ZgjRJg3T19qB1Hopg0n/qZ97gCk0cC5T6HEpTR6zOjYBtEhJzXQwffSZvCotKkezEbLwdB9boVEc9HPvuNgwbyOu4MkBGkdrwCohhvMysZh/qvcr1juJ7krZRrSHwPsPDT1+z3FxkBUvdc77SPO/N1zWyHqjFvpahS+k8Y/S3mS5JYcJ3rCPUmAICVTHOEXRhcVXn/4qwZG7vqSt13to8dZCMzs9p7iepKwPkKvhYZ4xec6qape7lHSrUw7xaWlNPJ8+FjjHGwKucPnynyUyKJ6b4tLwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393703; c=relaxed/relaxed;
	bh=QwFPS6YUW38IEMACgWNvn97a3hFqhS5O4/kjgd2aI1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHq4Vcpjvpl9tu281Xc9FP6pCD5tigUk2WlX2dj9kkjaJKArdpleclsBWvXa+9zJ554YP+kCOZQ44N9IOSCisVYat86Czi/Z1CZRo6XwKB8eeQo9CAJKlKzrGxLpPW+6ANrxZqSuJCvtWLcvQ7v9Py46BgNZ9+7jO8wpv6rONun9V1A4b0oTbNnUXYQRChn+bWF4+aLcnzgFWhMmTP7o9QcsYU+Vset1lWhmGwa70yDt3ndcVbPMJ9IC4iWAQkEh1W2BzW8vQpPvPAcFh5Z2u1FVtWfWpPSixB2acSJGGqxbaeeg8D55UZTt0ZeqCWMzJxxpRDiLdhTzWOjNgnyw2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gRZckZkl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gRZckZkl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVZ5z4cz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:02 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1787437a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393701; x=1775998501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwFPS6YUW38IEMACgWNvn97a3hFqhS5O4/kjgd2aI1E=;
        b=gRZckZklLFteDeghJVauD76fCI3D/D5Bg7xSQV7nQN5+Q35ri6ih3RSDiXqCBU9tZ1
         C2RMQljkJkrYQvssPiHabb4sfh3XGWtM9kjhR8UmWCJHSAMYaAaOYdu1aUFy1iNB2qiX
         Yaz4WTGW+aDeAAbjfyNHBIIwrqWx/U3ltUS0BOJ8plNgAJRxyncGlZiRHrcSC0WALHY9
         nL45dkqfbljzEMvHL7VqHJz6Ja0RXH5/NvmHYM+F2kARATLepqTTHTuXvF5Kifsgi//f
         /e/phFcKlWqOynLdpaoOMrBi3n+46loEMD4pIQ8UfC1M3d9MzFBU5Ji3aKJt2+pZCgBA
         D0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393701; x=1775998501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwFPS6YUW38IEMACgWNvn97a3hFqhS5O4/kjgd2aI1E=;
        b=eWifNmuX/Z/Z7aqlW+uKzNo2IT9YptzSlSIh03yFYQaJxp51rge+J8jCUog1IOHFeT
         Fg0LAmlyN5dAeguLAn1oGz95ZKjEI3vP1bH9maG30qJIctA8EKiXEKbpSV8rMXNqItxb
         X8J1aetJVofdZ2auxcn+HKUobNs3sxCcjOIg1dFCbDsLCs6eIoU+t/2iOdrKfI1tD2qk
         S9z5vewBdnCrveLnVrbK2pG200fbGVDij3Jh/6tvEMxXAkhq31t/nwqCcr4ItvI0pzOx
         S65JNs3TTQ0SX3olBZ7RgXMCFLAovNLuZ379SIAppjK3dQq/rwUc/we+pTPmUTelGi8t
         IigQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCJKIxr9+dLmxT8al+xf17J8Ay6tWafH35GUASyrf9D2x6Jk181Uyzjcvgee/RBzBOIjwCOcthX952FRA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8573hQ7r/lBHpWTmayW5go9LbA4g/2u9z5eR9yL1h/319glQi
	XN9qoJgkWn4bhAvZpzE6MZyzwWx4i6VOeAJW5mRwgIDjyAo+0Ki97a/jgGdYXJA2d3g=
X-Gm-Gg: AeBDievb1a6qbAx1TS7Zg0GDY4ccREyGOO6Ye8OqczOGJfrZFaVJvOojr1z7ogdirIG
	POYhDIHtuD6hWTN2B/t3g8WXjTf+gFcxdyiow+lJzqikSwCOVYkv+w0ZE1r/lTB9u8P2wns1vaZ
	BRTkARFaQCGZV6TiApa0WQeXgJkpMiTicqHRxrFkaRSDOfOSR7I8m273w1+hAm2lz2s5zrIERSZ
	O38yhkWAd1JRCShdpxiHtHRA3YtHr91/62JThnD56HkZsrmcJOhnUuv5X/YwnrdRBWIohWShyNG
	1bUoUgCplkTByBAP39YsKHh8FyExEbvhGjcFRqV44WkuICUCcg022sPmR3fnNk5yEEhIBEY0GST
	0vLckT/Eul7TUktvMrqKj+OaKjsy7MDGoYoeETAXkZoA+tFqY/WVYO4ZOEwioKFVylTET01FEfj
	JpGHuCsxVa5SxD7gPfCp7DEeGW44Wu1yGPaQxalYzMmdY=
X-Received: by 2002:a17:90a:d406:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-35de68f82damr8709011a91.17.1775393700794;
        Sun, 05 Apr 2026 05:55:00 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:00 -0700 (PDT)
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
Subject: [PATCH 15/49] mm/hugetlb: free cross-zone bootmem gigantic pages after allocation
Date: Sun,  5 Apr 2026 20:52:06 +0800
Message-Id: <20260405125240.2558577-16-songmuchun@bytedance.com>
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

After moving hugetlb reservation after free_area_init(), zone information
becomes available during bootmem huge page allocation. This allows us to
identify and handle cross-zone gigantic pages more precisely.

During alloc_bootmem(), pages that intersect multiple zones are added to
the head of huge_boot_pages[nid] list (without ZONES_VALID flag), while
pages with valid zones are added to the tail (with ZONES_VALID flag).

After allocation completes, hugetlb_free_cross_zone_pages() iterates
through the list and frees those cross-zone pages (entries without
HUGE_BOOTMEM_ZONES_VALID flag). The count of freed pages is subtracted
from the allocated count to ensure the final number reflects only valid
huge pages.

This applies to both per-node allocation path and the global gigantic
allocation path, simplifying the code by avoiding cross-zone checks at
later stages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6ea11113f1d..238495fd04e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3049,6 +3049,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(-ENOSPC);
 }
 
+static bool __init hugetlb_bootmem_page_earlycma(struct huge_bootmem_page *m)
+{
+	return m->flags & HUGE_BOOTMEM_CMA;
+}
+
 static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 {
 	struct huge_bootmem_page *m;
@@ -3092,7 +3097,14 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 		 * is not up yet.
 		 */
 		INIT_LIST_HEAD(&m->list);
-		list_add(&m->list, &huge_boot_pages[listnode]);
+		if (pfn_range_intersects_zones(listnode, PHYS_PFN(virt_to_phys(m)),
+					       pages_per_huge_page(h))) {
+			VM_BUG_ON(hugetlb_bootmem_page_earlycma(m));
+			list_add(&m->list, &huge_boot_pages[listnode]);
+		} else {
+			list_add_tail(&m->list, &huge_boot_pages[listnode]);
+			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
+		}
 		m->hstate = h;
 	}
 
@@ -3186,11 +3198,6 @@ static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
 	return m->flags & HUGE_BOOTMEM_HVO;
 }
 
-static bool __init hugetlb_bootmem_page_earlycma(struct huge_bootmem_page *m)
-{
-	return m->flags & HUGE_BOOTMEM_CMA;
-}
-
 /*
  * memblock-allocated pageblocks might not have the migrate type set
  * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
@@ -3393,6 +3400,34 @@ static void __init gather_bootmem_prealloc(void)
 	padata_do_multithreaded(&job);
 }
 
+static unsigned long __init hugetlb_free_cross_zone_pages(struct hstate *h, int nid)
+{
+	unsigned long freed = 0;
+	struct huge_bootmem_page *m, *tmp;
+
+	if (!hstate_is_gigantic(h))
+		return freed;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages[nid], list) {
+		if (m->flags & HUGE_BOOTMEM_ZONES_VALID)
+			break;
+
+		list_del(&m->list);
+		memblock_free(m, huge_page_size(h));
+		freed++;
+	}
+
+	if (freed) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, sizeof(buf));
+		pr_warn("HugeTLB: freeing %lu cross-zone hugepage of page size %s failed node%d.\n",
+			freed, buf, nid);
+	}
+
+	return freed;
+}
+
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
@@ -3423,6 +3458,8 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 		cond_resched();
 	}
 
+	i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	if (!list_empty(&folio_list))
 		prep_and_add_allocated_folios(h, &folio_list);
 
@@ -3496,6 +3533,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 
 static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 {
+	int nid;
 	unsigned long i;
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
@@ -3504,6 +3542,9 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 		cond_resched();
 	}
 
+	for_each_node(nid)
+		i -= hugetlb_free_cross_zone_pages(h, nid);
+
 	return i;
 }
 
-- 
2.20.1


