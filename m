Return-Path: <linuxppc-dev+bounces-29166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE571CA9EC0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:58:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x1w3Lsnz30DH;
	Sat, 10 Oct 2026 18:58:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619124;
	cv=none; b=WEs9XDJqI+c9vRdLu6GDR2wmEZmK0OCAfXnzMCQnesSuIAlC+qysecG2RjDeVBk+p7vBVjogwyNe//Hjx1cvvAXonidVp73NIaWnd1yMqcTT3LadyGf3uEZBsWSbJv3FoPuxxYXRmVKyarbx2FUFlDcGQwGkhC1s8iJxRvj364ozBSITjh1z7vzozoQYqr3vXNLA552RMIjnG6DefaF45W+bXkU1ikN/XD0EKerLbyVhCzxEMcUXZ8cNzPWCZKXWqtl9ARBl/L8O1/yidKAr0pIJaBiDO99Kz1rohBUzkLzN0HgQdSqM7Zu3G7w/uZkQ4sELIfPovL0uZxsUiNpVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619124; c=relaxed/relaxed;
	bh=ma837HBXIsXlkZZedCno7jR/Be5/TxFOjn4ZcgPZXQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwIzRkfYLPqMy1odcvMy2n5mtawBcVALw+jFCFKTn9wwJGwwsTuiUdFCAfpN5ea/gYQfmLlpzE/Y+F9Hq66eySSwgwYcV64iTCOIGFNmdlPuZWqV+PsSsNpGl7BvTVyofLYoFltHqyzbnmP/GGmfThsd6Q4pjKhJbv8RdWRBTqdjmfn2Wi36EKPvyVZYKP/I+t2JFCVBFpeYgoe+PVokYECb7Usi6j5EjhJHUGp3scVltzRj6s0k3I+LvRp8QE31qGfTmkQU06s0kGO1U/JCoWh8/sBFR1oaMOao0GNwRTNFhRJPJU4mtN6Z27ouk97vQ5RE9Iem8NDg9964kLBhug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R3tgCyYx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=R3tgCyYx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x1v2tNwz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:58:43 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso170294a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619121; x=1792223921; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ma837HBXIsXlkZZedCno7jR/Be5/TxFOjn4ZcgPZXQ8=;
        b=R3tgCyYxBIgB6rMJzNKtMU4La397VT/YCe7ontrNWTiBd3j86+mIvq4yz5iRI3TnRD
         NPb/sB/uEN/XtxSVV1Lftbw4zI45gyywCqRqPeRgxboIF+Y5HevxktUCiLo3cZH9PoxT
         vBadF0pbSkr8D7wzg/vKIAzu9aU+b8elm+vzePBSe0pUD7Ybf29YvkQSTxkT+X5gCzg6
         CFzUhyFwM6UP7Uu8kVMW8sonHTfkMZnqSekRzSvAaqbMOE9qWPzd4huc+li4SoT+TdQI
         VVCPzN9decMq3Qri8CadhM3i3mHsxrIJexfp9BWZY+yQ3KSfDoEkALDRcTDJhNh6iRGh
         TvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619121; x=1792223921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ma837HBXIsXlkZZedCno7jR/Be5/TxFOjn4ZcgPZXQ8=;
        b=o3UCjC3OiuvlPdRB+lAQSiTO4eRZvXIOgoWkeF4BKkF3ExPCZbueOEC5tCjMOuUIpf
         O6lLkiVIcpmr400LCkTOZzc1KVD+lYPAGvhZKazeROvr/U3l3elRx5XIHhc5NkloQscI
         Ez7JHNbHgf/pOjwV/gyIE8t9n6Ob0IIqhtrS9wZT99EpfTzu33xhNKCWWiTh351bC6e4
         uVk6jbtJIIz2SLXTSUTz9VvSeXSnKX1TaVQ7+KT6YeDimz7weEigDNkMUC2QWpzrfPnc
         m9VGOhQhSuWRqzerF/Pv0XwZBkR/ti618M+QnEFmtUN+/wFd27cfOtuaB/yf3sNjwKhA
         pu0g==
X-Forwarded-Encrypted: i=1; AKwUvByM9tuhWxXJo8tnSZWElJkZ6TTweHn/OVYEgx88BOVKijsGumM7QwjrVPsXpOraUDxYWkYuhrt1IgdCXMU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJIEmTZsuNqJCy9Y9GUd6N8Jx7Ov6dE8knyLJ0owfR037n75bJp
	SuqzHmI+4MNTpLIkFHJYqNHBV2jDL7RgNgSRAz7NXevOHnLjvSKF4VA+dgJhni+YMcI=
X-Gm-Gg: AYBFou21sqPqyCLMP14glWNlc6Uy2K9+C0ardyULj8I0voMF43H9atU0rCZNW9CS4Vz
	rbpuAk3OAkkOgGMb9hoe6gPzh82Qax3lueJxneQ/MZWhNT3EIGqSzGlDDYbq37DVrYqf1At2oOs
	1JvcNd26GLFHJSVHLJFq+vl3sRl8Io2ErSx3526Fce7BGCngeuKIif2p0lPOr4vauZNNW5gs4dZ
	5oL7A2MTmEzmbVQuEzKy39K2CBwd4tq1zLUAKc4AD8HidZKAh1w2+psGx3Sl3O158RAsnpJIY4x
	sRkwi4qP/jUf8iKoXjcUotuUpeUiBXjt9KBIqBUkhRTUBojt7osEeE4qScCyEXHatainvrZe2Ar
	ncXXQJ2l9TetsdJX2QLVWm9gapHaXcODxy1UxWdBtHg6VixOt/TXBlassRPMsLFcCEV8jlHWkEb
	qiFYjmRQ1Ut6VM8Ho7G6pC5WAvmkOyklBHxTDOGK4vSAP/NkzaKMQ7RRN2lKfGYnFbfqZeSVWk5
	ufHNSqGJLTSKrsTEwXPRwWCdQeegjCv+Kzk5YCgdAZs/U/v5Q==
X-Received: by 2002:a17:90b:1d4f:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3ab3a954001mr3617692a91.30.1791619121000;
        Sat, 10 Oct 2026 00:58:41 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.58.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:58:40 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Sat, 10 Oct 2026 15:57:51 +0800
Message-ID: <20261010075755.83339-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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

The common vmemmap population path cannot yet handle optimized Device DAX
mappings on its own. It uses pfn_to_zone() to find the shared tail page,
but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
is initialized.

Teach the common path to use device_zone() for runtime optimized vmemmap
population while retaining pfn_to_zone() for early boot. This allows the
same path to support both early boot mappings and Device DAX.

The backing PFN supplied by the Device DAX-specific population path is no
longer used, allowing the redundant lookup and population code to be
removed later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Collect Reviewed-by from Lance Yang

v3:
- Collect Acked-by from Qi Zheng

v2:
- Expand comments around slab initialization to explain zone lookup and
  page refcounting (suggested by Qi Zheng)
---
 mm/sparse-vmemmap.c | 64 +++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b23efff80137..62327ac15206 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -241,18 +241,43 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	struct page *page;
 	const unsigned int order = pfn_to_section_compound_order(pfn);
 
-	/*
-	 * Device DAX still relies on vmemmap_populate_compound_pages() for
-	 * head/first-tail allocation and tail-page reuse.
-	 */
 	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
-	zone = pfn_to_zone(pfn, node);
+	/*
+	 * Before slab is available, vmemmap optimization is used for early
+	 * system RAM, whose zone can be determined from the PFN.
+	 *
+	 * Once slab is available, only ZONE_DEVICE memory reaches this
+	 * optimized population path. Its zone span has not been initialized
+	 * while its vmemmap is being populated, so pfn_to_zone() cannot be
+	 * used. Obtain ZONE_DEVICE directly from the node instead.
+	 */
+	zone = slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, node);
 	page = vmemmap_shared_tail_page(order, zone);
 	if (!page)
 		return NULL;
 
+	/*
+	 * During early vmemmap population, the shared tail vmemmap backing
+	 * page is allocated from memblock before its struct page can safely
+	 * participate in page refcounting. Therefore, no reference can be
+	 * held for each shared PTE mapping, and the mappings must be unshared
+	 * before the vmemmap is depopulated.
+	 *
+	 * Once slab is available, the shared backing page is allocated from
+	 * the buddy allocator and can be refcounted. Hold one reference for
+	 * each shared PTE mapping. The architecture vmemmap teardown drops
+	 * the reference through __free_pages() when removing the mapping,
+	 * preventing the backing page from being freed while it is shared.
+	 *
+	 * The backing page may be shared by enough PTE mappings to exhaust
+	 * the positive range of its reference count. Stop populating the
+	 * vmemmap if another reference cannot be acquired.
+	 */
+	if (slab_is_available() && !try_get_page(page))
+		return NULL;
+
 	return page_address(page);
 }
 
@@ -264,31 +289,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 
 	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
+		void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
-		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
-
-			if (!p)
-				return NULL;
-			ptpfn = PHYS_PFN(__pa(p));
-		} else {
-			/*
-			 * When a PTE/PMD entry is freed from the init_mm
-			 * there's a free_pages() call to this page allocated
-			 * above. Thus this try_get_page() is paired with the
-			 * put_page_testzero() on the freeing path.
-			 * This can only called by certain ZONE_DEVICE path,
-			 * and through vmemmap_populate_compound_pages() when
-			 * slab is available.
-			 *
-			 * Use try_get_page() to prevent the shared page refcount
-			 * from overflowing.
-			 */
-			if (slab_is_available() &&
-			    !try_get_page(pfn_to_page(ptpfn)))
-				return NULL;
-		}
-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
+		if (!p)
+			return NULL;
+
+		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 	} else if (WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)))
 		return NULL;
-- 
2.54.0


