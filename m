Return-Path: <linuxppc-dev+bounces-28441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB4CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6KM4GMwz2yft;
	Tue, 29 Sep 2026 15:33:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790660007;
	cv=none; b=l5LgUBBt4Wmtzq0uLe1inZXVw9BIRbAWoolxSwz/YCnf/k0IYU48tL6V4rYNa5V7SMTQE8dS+s6Qg5oDiYld5Pg4jREttRMd6Ji7nxqOWm3RnRyz86HcO6VlT+SkZNTjbFtRWZKd1y8AlaOrZrTmYHZihhwg+iImCGpyTegMtaFrzwpD/8Ye70bTJQ0bXf1IQ6yiRyvDbdAnbTCcJ+tddhd/J+XctHP8oZLIQJNd28U7IQgFisK8XvKY4AIGlZCeljUeZYyWssamwy5UMRrg1TUKu4NELJYY50vCU98s+S9YPhM4q7d5iHnrRWBqPjAIsXLaqFZmjYmnCY3NxlWLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790660007; c=relaxed/relaxed;
	bh=EmCovH5RnTA7rUGZy7nldketI90h2YRpy62dJPhw5NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3rbFTCkY7vHXR8j2lFnHLH31TN/uZ0b2rASKY0oh7mpyjIr6WNq9qGWhP3hX+X31oRF2FX3+vtD43HZx4b/ZRIERAVHI4DY4eyGCAdDbIou8QA3nlZD1Xri2QnbrawleeWRprGV9GPaRf7xPkXYt6kd7WPS6ZpyaATgWN0j3MoehjA6RrxNv1cRaR3x+iQuZFHoRzBGQDOq6Ndk79FCRs5QkAm37lP3/PaKVF01nv0rXyGT+xtagUYUd3jtZ63hcOSwIAim5/jCks7eSFkmn5b1BiSNMCEQDEv2EgPxRt7cdOArOl7VduLFipqF4M4k4YS29DqgZWZ+n1Vh1HILhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gpvZJGha; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gpvZJGha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6KM004bz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:26 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso496893a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790660005; x=1791264805; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmCovH5RnTA7rUGZy7nldketI90h2YRpy62dJPhw5NA=;
        b=gpvZJGhav3tkxSzr0wHih3rrQXHarKqrgNBZgYJbyDPG/n3NfYhIzIijLL0p2R4NV2
         CCssY9KxtPEsKGkUYvrc0DYQBTnQQ8AbPHLjb09eP3JmVjwWGEa42RDaczSMwKhpTyPO
         sRmgahpJlFyjPIztQPwty565vF5VKhW6sDS7d8IhxD5M8xhCxSitA+x3GbBmI5vyjVD3
         lOv4OEGlIrlcSfct7OTvDHcd+FH01r3pszptOVyGEi+7iwhCtt+PGiyfaEkYMb3mwhZs
         HHUbyB9Or0OkrLxHxXiBbVleVnkPhVocZ++NdSGwwCNDokFfrWEDPKaMJS+adpvGS2gP
         oCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660005; x=1791264805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmCovH5RnTA7rUGZy7nldketI90h2YRpy62dJPhw5NA=;
        b=ijGgxaCYj8BiKeQvKkdItosIxtvp22XzvRJJDXPQ3ksasyBqEGdxYyCJxH8P0b3Qu6
         oqMwm26oX7EOkiLTVBcqwCmt3qrlM4dN1onnSRROpw+espy12qq0X1GZgBiddO1CT+iL
         Ow18g2psPSHPJssWafaCliJzHSFs8WLSQTvEnDNlgrto0UQ5z78zaLe1sjFLHZI+sYTM
         d9qDZz3yrnerxQ52Kk2HnjQRvP7crT4m+Mhk1nWLRSQwNiDyk5Pg7c1S6ry+j1Xkwnkp
         wQa4tfBMC9HjiBGoqC0AJcwWmneDv2pYvIDG2tgZpUAThx0a5E4l9ptbVCyx372jlgJa
         l2sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuZygTeQeEIa2m+68+i8en1bov8inskZt+InqSTvuAMrOCJJlT7Fr4idOSMy0LrFSTI9Zw9NeH3mJ93FM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKDo16V40cgsLn6/39vfLESVTdYdyozQ6xee6Tpg+wCaIkhfSjd
	wdtvLTp8y9A6teATLPqT4Cdpa+8YFPNTOD2OqlwMNpfSeHo+HwDsMkhSrKqYK+u2opA=
X-Gm-Gg: AYBFou1N/VQVAydxV68e9RuGum89oAr+Zx751Ys8SHEp49WFvKnjZKRACruNnCVnp3n
	d8eBV0BcARoM7TXdfnQ5+0lzQ6JR1Dgljloh1PylqFBVOKrH33e+lpNCtEbkrXixnvwhWhriASQ
	BqL54rmPSQJSGE6nPv5sbGfc7gvlWqKG/KcfRx6MYkQiZgEw2Hov245zfVT/mBEhJ7X0+vIiLUx
	5HMB1tVREbwhRqjx4iphrAbfSeeKNa8QUJ+4Vh5LHdihqr5acc/i2PSz1FEXwroLSMScXUyWvFf
	KT6aBj4IQBBizueGpFNEDUYYLWdOoeSSCeuW4SYH6ayL3FAGRS2pDingB9pmXG04LI4TBgWwOJR
	KPK1huz0r/5b4zPGiwaCKDeKAd4k66SR2qWnmlxqGG2Q5xwuGyN5fUZfR5U2aq4au5vCDXys+rF
	dNrx4w5+x7KzERB5YGxYOxCu/rjajAMuEqmFcHhj2pXhdALf56TNTPqlIv9YVpCRegSACMp0Yi0
	rkIMdWG7aHXszopXZE=
X-Received: by 2002:a17:90b:2682:b0:39e:6a80:b795 with SMTP id 98e67ed59e1d1-3a0bb60b2f7mr9941647a91.37.1790660004661;
        Mon, 28 Sep 2026 22:33:24 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:24 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Tue, 29 Sep 2026 13:32:27 +0800
Message-ID: <20260929053231.66085-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng

v2:
- Expand comments around slab initialization to explain zone lookup and
  page refcounting (suggested by Qi Zheng)
---
 mm/sparse-vmemmap.c | 64 +++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8219abc6c3e5..ee4c113ca938 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -237,18 +237,43 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
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
 
@@ -260,31 +285,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 
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


