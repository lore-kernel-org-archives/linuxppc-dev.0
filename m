Return-Path: <linuxppc-dev+bounces-28099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08349C98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5mm2cqhz2y7Y;
	Thu, 24 Sep 2026 17:58:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236696;
	cv=none; b=i0f5LHHnsNUV037YWT3z9rGDLHk6wZ736YmxGL54xXZ8RQvL8fmE39YLTCu1IIYIadaXu90qfqmzxKNFzPgN4vBUL3GzUtw7rrl2j3jNV9dgUbfjfwQ+1MZiLCVnZwm9itG9utlqOpDtb5GgY0/+zf4MmWbyaFp3bVw/SRQPme94acHEAVEWBAGo0cpUAL/KWy1zM/eYSuAyh64KW+4H9VDSGZun7c9K1IdEEc1Vn/w81nbwlrIINjYSBmtJkJvPKkQFRgyG4Xs9uQCl7T0O/TbL4/9mkUpvPAvxOjZKZ/GrHr8me1OxwXbev6Ja1UOhpcfNOlacit4Q7jVmNiU+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236696; c=relaxed/relaxed;
	bh=ypgv34u1izH3x2bQ0aB2L9cYWw/W1JF39DJ+G9Ytha0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHqE9IXOfVFjDhRnt965FHoKPtEXVRB2tdvshyJ89jSMfCPd3Zl2ebWvxOodIxuBHSz0yHkj3W7DLvy38+1e+19TRmxaSTVLxYiO7x9ba5EI9Zj/xKDnmfKL9i1/bTiiv+RqRI3Epyy11fsgKiGg3kQ2nVpRxOHydd5ux5GCKv/IsCKvzZeAv6BF1rvMFcjrltxLlsns9u0Zv2QNZra2aHYod+ddX5TA6QwjhCp52fkY/+e6GNUi7Y6LojktyK/r2Y/zFqd5Oq3zVobbMQkzDcTuy0Nj2q1GjkS4cXBCSos4F794sQ2XBrdKSFsbHAtQ5ylJKntHHPL0iVcggtZPDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dLSmPY+K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dLSmPY+K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com [IPv6:2607:f8b0:4864:3b::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5ml4Rs2z30TL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:15 +1000 (AEST)
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1355148a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236693; x=1790841493; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypgv34u1izH3x2bQ0aB2L9cYWw/W1JF39DJ+G9Ytha0=;
        b=dLSmPY+KtK2q74Cgqi+sUp1u8G4SC95TS6vSJFfRaP0nRcildhZy9/G9kSEbbHF2Ka
         fYOEb3+H/sj3pgNVMZtEsvwKY3c/o0tZ1XAfnKKegNJ7E2HxHcbMrBi1xmLA1spjqt1A
         f64L1De0cODLZ+y7rjXwOeSVZ3KUSPhDGiYbDd7x+sObQ1FLEP5D2Vk0xxoluA5GYaXG
         1X4TF94NQDetpUVmwgFpUkjSQRdMCIADnTIyqcD3NuNZH4PiA2zvbXJzNxPwYbpw0KDA
         oA8hTiAPq9PZ+FW+zjRf0KqNs2Y76E73ozT6xpzGwcm8dNCO7bIC5krV+4oy+igajgxK
         pJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236693; x=1790841493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypgv34u1izH3x2bQ0aB2L9cYWw/W1JF39DJ+G9Ytha0=;
        b=MWDdq7g/9AY+l86QFU5lK75/0I6tgiffyGhyixdKFYprYnXF33X7szv45iJ08bH5bE
         d5dhMb9ZHc/7w+ypSPToFQ4ciR4w8XxMW6OegDMbxV0XC/VB/D6rNwBK/pSqi8rfwxYE
         RKpCXB8Tn1NtZAhQVG6nTV1iZ88iIL97Bw+mde5DDmBIatpVPIL6s6BmlT0GNQvHRHP/
         qXIoykygU64kyWitJ6z50jnci72aFwTd8xU7us6oB//4gqIjEyYCTBPgUsFlkZbqKz2C
         BjA+0C15TX6ABIkLFPup4hJi+lxgAQ4GD5/UrqP2oxSBU6UsD2azDoCQTkKDKKXxeh7d
         5hWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSnnrvu+hexVT8ET6dFec6nFuiWPTKhdhXLeFWPXwrYI4frjG5CCg+AmC7q81P/v+tF85YQ8fKH4GDb84=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nuNIK3Dw1E/zDWT0S0EW5gt5OsvSK+ho/G7AbcJPtpnSUszXsH
	roYmVG7phK5Y3raTgoWxV/qOFxZ6hltZT7DhTq+ke8fPlkag+vSUJxq5oW2MjBgkHsc=
X-Gm-Gg: AYBFou2X24PwPOrciLruOKG2/8VBXV+uFl7T6++g2vmOE+zerCrwWFW+QjknZvxYEMn
	ZRk3Qu5j1h9wuT4LBt6X29NwsPpXMv43DyD7tDpwSJR2YLU9ZByNpgC5S6TfD52E8Lk8TKw5K80
	9o1nbwIWxu9mUSCN2oOYUSHrH1wVJ0vBRIRG6pD2pdz84XlqDc4yqK9rLf2TgDHuISVDgwIN/o8
	joCg36riQh8NjR+Ei7diPYPaUKL2gdIRJx+ejuk7oa1D7x2JCcKZWwef5KZ3AOdcHCAN/RWsBR8
	5tolKMOghsgf03Niyw02jF4IhNYBGEPwGbzGky3v8Xz+AQ6cL4o9wNF1rELxsxA8qWlaP8SZgaL
	IfpOxIOQYQLZs6iYO0U5/YPa0TgnG6Js7aFmxS4P28tRKFzMu5UreNYKtJ1td4Zlb+TsaqnL8XL
	13q+kMU18zDmqdytKWaGvMULEjt3T6Winfy66EXJr5fm+fxMxCl/NoGU+haIs+/8K/eUIE9bwT4
	6q5H3VmUzcDtqn+U2QPeFA4jJDogA==
X-Received: by 2002:a17:90b:3852:b0:39d:f024:c7ec with SMTP id 98e67ed59e1d1-3a098d883b8mr1610039a91.16.1790236693438;
        Thu, 24 Sep 2026 00:58:13 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:12 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
Subject: [PATCH v2 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Thu, 24 Sep 2026 15:52:55 +0800
Message-ID: <20260924075259.2013039-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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
---
v2:
- Expand comments around slab initialization to explain zone lookup and
  page refcounting (suggested by Qi Zheng)
---
 mm/sparse-vmemmap.c | 56 +++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 919c94a36346..cdcc93714a9a 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -208,18 +208,39 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
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
+	 */
+	if (slab_is_available())
+		get_page(page);
+
 	return page_address(page);
 }
 
@@ -231,27 +252,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 
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
-			 * above. Thus this get_page() is paired with the
-			 * put_page_testzero() on the freeing path.
-			 * This can only called by certain ZONE_DEVICE path,
-			 * and through vmemmap_populate_compound_pages() when
-			 * slab is available.
-			 */
-			if (slab_is_available())
-				get_page(pfn_to_page(ptpfn));
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


