Return-Path: <linuxppc-dev+bounces-22529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3BCCD98D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 03:59:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5P60qVFz3bs0;
	Fri, 12 Jun 2026 13:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236761;
	cv=none; b=cWWXBNrANbIFo1vpLCvrV0ypRygTJz0iJsKpE+AIaz+zML/KyYZo6uESxJigCfpTLSKUJM7u6p+2uIvqyZHQntYVNSOQ5/MfOiOAx2AG7oYe/YPBYv2mqXidEL3UdKTNTIqOuCo7b+/SOQA7ssa+BRAHe0d9iUBJOIWH3YG69an3RkrNeIeJ02Frsyg+ozPDw21Y4mREOIicOPzouCIn7qLewGKN7zjC409dFDRRtJ12GUq7NCIa2cRYIiEj+m3NrmIpLsX/Q7Phk4S5hd2a9D1w6wRmC2ptVWSjehumOI4EJTf1NCBz06Szg+jLis2G8FEMZD+43J2sywJq9hD8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236761; c=relaxed/relaxed;
	bh=BGnxBE9ZAaNi/tjsaLR7aR0BPLKcOcY8H1vV/Mvx5Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLMnF5fyRyeMuDCYRcB5/tnJsDNkQ3vHTFUeoSXUxZbQG9DB2VUea6oXu92zTVSPV0O9Pe1KlRXiUhmvVGNjDDtPDGfc8guQXhYtAV+fKOPFhoVVMbIMMvkmV+uHP4ry11NKdhpiansZxlPw/SMmZYGE6F07fOxyQ1EpDQYptTOH3LuiLgrRKR10r9uYZ/dyns3ik7R05mrBAc9wqMkJwbsuvB7P6+9hdapADctpNAGjulmZNBo1nsxM9VkkplR7jAMTKiY3rMNIimc5vzSpanpe7yQK+oqvf84s5FwlEr7TeHbz0oALOFLSZZBNRQWnoqJv6LLZi6/vZYGpO60bpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=J+nVLAKH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=J+nVLAKH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5P34z1rz3brC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:18 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-842cd900ee0so267508b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236756; x=1781841556; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGnxBE9ZAaNi/tjsaLR7aR0BPLKcOcY8H1vV/Mvx5Rg=;
        b=J+nVLAKHmm3N5x9gEZppGuTSknjROrjW38Tehlb69pSVvEjeBs+WX4Iiq70/uD06aB
         NrUI2XzwimS1xbxGssvsh7I4UyMFzftXShvTc9y45UfdC02Q2dXWZlvkvs/lp/5hX/Y/
         y2XPKlduuVBw5qHhBqJSYIm3MJstewdbRvKalu/kQX4yv0l4+XyH78qsfs1viUGB7FAy
         6PSMqYrdTjb/eewx9JSEoyoRnM8Iq0CHl/U7cGcZThWrAwYGVKfosXAqwSYi+C2qdOS8
         3cU1HYid5v6C75lissuGgzUMGBFvV4frz8MpGirqt8qA2liPRzNTzw99D3vcYbtdLe3D
         HaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236756; x=1781841556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGnxBE9ZAaNi/tjsaLR7aR0BPLKcOcY8H1vV/Mvx5Rg=;
        b=dq3x9tczUeYak5Cw84RwKwmRsJD3esENdsTh6INlmKZN4xOfLaKX39Vk9yfrsH0JTm
         14Hg+/3o4ns8F00N1wjNISxOq631/MWm1lB6+oSLsDmJmBe9X+TOywyuvBU2Jkme660Z
         BioymnYUXuQcnJl+u0Bv55MFiKCRrPo4p/125nRy1VfbQD1XzyzIA2kM7/Dos/rZQ6vP
         MZWfzwhqjPYbJBEiP+9V09C5wW+xUqXlg8NAl/xGieYG9KMSpUGYLgyRx34hDRUBusys
         jT+FlvHjmiDkhgqu/lj50IYaQhSgWxIETmoodyW275Oly22+3V+mDJzmIZz5obzmchlY
         sMow==
X-Forwarded-Encrypted: i=1; AFNElJ9EQoVcZIvLM9eT5K3l96Y6BNTtRuD4aBdjLnIOqo9GkL/hDqYa0kywE+v6ztqNDLznR7/nRk1stxn9784=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNsgO8ujun8GQ36+6pyOIKakOpi+S2EHZ/T+eD5w8DOipPmgrF
	f8dCZT4b98Sf+3asDPdG64EsCGfLiwyTX62wtml+dHIULY/YkA76A2cbgUE05VvEs8U=
X-Gm-Gg: Acq92OGUQrYYANQTMLbAOEnFv/sR8iuII8Qw1fyxOIhjq1TczUmKnxp8c1UCxYL9BDT
	cpQk7W9+X1NoWbWKR4uflbsKbv7rMITWm+WlX84ETDUBiRfsShzCBY8DXlzpUjWjSYQIm0FgAFX
	rUf5n6bop9rH/ZOMb8+Bq+M3nCjZR6VwKYQRcllthyKrX2d0aXSK6BvldHQ+69eCXWQ6RJJpWQG
	c9FtAjcFJa8Ye7YprDgKTHDF//sgG7rzOp4uFi8EAPqUjfTZKkwxUSPPrz2BLIUZLICxdcvX8PQ
	hEOE1THek9WfydJpg3DRZANWlRdUaZxEXMwvLvsZxt7wfA5cxUnnjEtEgeFY4AtufNuyFd7WdXd
	zzhxTZZFuBzBk0S8fX+RfAmYYmXm1XyipTyHFHNCX3ahKIHIJY9tdT0quSillrV9QRhT3iMTj3a
	RKMLq8qJYPbSnqzfjSTtXd5GHX+YwLVIucMbCi2/O4MR87Wk+ZB7Y26w==
X-Received: by 2002:a05:6a00:2e82:b0:842:48ae:1d56 with SMTP id d2e1a72fcca58-8434d0cdb37mr1033250b3a.35.1781236756174;
        Thu, 11 Jun 2026 20:59:16 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:15 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 01/19] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
Date: Fri, 12 Jun 2026 11:58:45 +0800
Message-ID: <20260612035903.2468601-2-songmuchun@bytedance.com>
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

Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].

Those shared tail pages were initialized in hugetlb_vmemmap_init(), but
bootmem HugeTLB folios are prepared earlier from gather_bootmem_prealloc().
With hugetlb_free_vmemmap=on, prep_and_add_bootmem_folios() can access
pageblock flags on bootmem HugeTLB pages whose mirrored tail struct pages
already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
get_pfnblock_bitmap_bitidx() then dereferences the still-uninitialized
shared tail page and can panic during boot.

Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), before
bootmem HugeTLB folios are processed, and drop the later initialization
from hugetlb_vmemmap_init().

This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
assertion is evaluated.

Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c         | 25 +++++++++++++++++++++++++
 mm/hugetlb_vmemmap.c | 17 -----------------
 mm/sparse-vmemmap.c  |  2 +-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..cd55524c7e30 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3365,6 +3365,31 @@ static void __init gather_bootmem_prealloc(void)
 		.max_threads	= num_node_state(N_MEMORY),
 		.numa_aware	= true,
 	};
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
+			struct page *tail, *p;
+			unsigned int order;
+
+			tail = zone->vmemmap_tails[i];
+			if (!tail)
+				continue;
+
+			order = i + VMEMMAP_TAIL_MIN_ORDER;
+			p = page_to_virt(tail);
+			/*
+			 * prep_and_add_bootmem_folios() can access pageblock
+			 * flags on bootmem HugeTLB pages, so initialize the
+			 * shared tail struct pages here before bootmem folios
+			 * start using them.
+			 */
+			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
+				init_compound_tail(p + j, NULL, order, zone);
+		}
+	}
+#endif
 
 	padata_do_multithreaded(&job);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 133b46dfb09f..c713c0d2593a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -870,27 +870,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static int __init hugetlb_vmemmap_init(void)
 {
 	const struct hstate *h;
-	struct zone *zone;
 
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
-	for_each_zone(zone) {
-		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
-			struct page *tail, *p;
-			unsigned int order;
-
-			tail = zone->vmemmap_tails[i];
-			if (!tail)
-				continue;
-
-			order = i + VMEMMAP_TAIL_MIN_ORDER;
-			p = page_to_virt(tail);
-			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
-				init_compound_tail(p + j, NULL, order, zone);
-		}
-	}
-
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
 			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 99e2be39671b..bb23fb3077a3 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -342,7 +342,7 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	 *
 	 * Any initialization done here will be overwritten by memmap_init().
 	 *
-	 * hugetlb_vmemmap_init() will take care of initialization after
+	 * gather_bootmem_prealloc() will take care of initialization after
 	 * memmap_init().
 	 */
 
-- 
2.54.0


