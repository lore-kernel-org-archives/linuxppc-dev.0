Return-Path: <linuxppc-dev+bounces-28545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BD2CA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 08:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvpkV48zxz2yqT;
	Wed, 30 Sep 2026 18:54:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790758450;
	cv=none; b=fnJrKAWUclM5IfOtYHKPx3QUfQASuWsL2LXdhOqRihG9cA1uyWJ2qxxICV+6kSB8/PZpLyrPthPSn6kLQUB7Mx+3ooOiMthonytwdLFpKegbtpuCXrxqZ5OBuQO4EYTQC4DPnpt53/pGndV5vWG6ICT4pZ39FHSWycCnANqfDxarGuJV/VRMwalZ8UwzJvcbV+C0D+bW7q6Upoj+8vliTfKYsvg62xfeeDinKiobxrWvn5NUWvcmrCQ8hPMSnOia65vMMw8ykjlbruzEPBI8bsFAg/57IwV1Eyj2QSHfeL3pVFPJ8yaHrdHwfL3S+dE8qTxZ/Pnp27GjnkpbWJRm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790758450; c=relaxed/relaxed;
	bh=ASh1LR56EfBikA9krZgbBpC09kFpBHQaRZVce4w2D60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2PTQOJQVZrRw3rsm5RNrzzTXMwRL9cNHVDv843ULC4gG9HVl2LS8E5mMXUU9PZGVhNM52RbuYd/2h00WQ9xWNVnlNeXmpy7iQdBvHdDa3L16TQr9KIuY+1ZyaGleZGNM5bOCfUUSQMW+wqWX4zLgUATmA8GPBRiF8okRDizj7FA17BtzzlgtS+JPd8IlHA9AILdqTA017cEz6ZjTij19aFFscE2XMSNrBkZ+aW1n+KzzOHB+sEtMNU2dxDniBKxU85GUiO5jhDDor7yQwJj9q119PCumVVA1p5wV5Ow3rmv3jMvCrXJa0TzCe/oI3vD1bVC55jHDG0poGHmw3m/7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=chNeUyIU; dkim-atps=neutral; spf=pass (client-ip=95.215.58.64; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=chNeUyIU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.64; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvpkP3Jbnz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 18:53:58 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=x3C9eFMj4s4C+4L8a6ck2RX+0F5Vx+DLli30NnboIh4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790758418; v=1; x=1791363218;
 b=chNeUyIUcRJiEYe/HzjokB4VaM4k1Frk2WTry5hanTEkS2tnrOXiHZfITnCCETi2CMJOaiMO
 a9onNnLbzGsVFzfoiyTFg60d1ZrM5Cu4ff3Nybfa2HFrZRe8xX0droNFettjFw8mGlH/4wzy2hu
 qR9xeDShk5xtbFQHMl2IcyM0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d8889dd78a97ab2f;
	Wed, 30 Sep 2026 08:53:38 +0000
X-Mizu-Trace-ID: d8889dd78a97ab2f
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	qi.zheng@linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Wed, 30 Sep 2026 16:53:29 +0800
Message-ID: <20260930085329.17337-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-3-songmuchun@bytedance.com>
References: <20260929053231.66085-3-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 29, 2026 at 01:32:27PM +0800, Muchun Song wrote:
>The common vmemmap population path cannot yet handle optimized Device DAX
>mappings on its own. It uses pfn_to_zone() to find the shared tail page,
>but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
>is initialized.
>
>Teach the common path to use device_zone() for runtime optimized vmemmap
>population while retaining pfn_to_zone() for early boot. This allows the
>same path to support both early boot mappings and Device DAX.
>
>The backing PFN supplied by the Device DAX-specific population path is no
>longer used, allowing the redundant lookup and population code to be
>removed later.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---
>v3:
>- Collect Acked-by from Qi Zheng
>
>v2:
>- Expand comments around slab initialization to explain zone lookup and
>  page refcounting (suggested by Qi Zheng)
>---
> mm/sparse-vmemmap.c | 64 +++++++++++++++++++++++++--------------------
> 1 file changed, 35 insertions(+), 29 deletions(-)
>
>diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>index 8219abc6c3e5..ee4c113ca938 100644
>--- a/mm/sparse-vmemmap.c
>+++ b/mm/sparse-vmemmap.c
>@@ -237,18 +237,43 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
> 	struct page *page;
> 	const unsigned int order = pfn_to_section_compound_order(pfn);
> 
>-	/*
>-	 * Device DAX still relies on vmemmap_populate_compound_pages() for
>-	 * head/first-tail allocation and tail-page reuse.
>-	 */
> 	if (!vmemmap_optimizable_pfn(pfn))
> 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
> 
>-	zone = pfn_to_zone(pfn, node);
>+	/*
>+	 * Before slab is available, vmemmap optimization is used for early
>+	 * system RAM, whose zone can be determined from the PFN.
>+	 *
>+	 * Once slab is available, only ZONE_DEVICE memory reaches this
>+	 * optimized population path. Its zone span has not been initialized
>+	 * while its vmemmap is being populated, so pfn_to_zone() cannot be
>+	 * used. Obtain ZONE_DEVICE directly from the node instead.
>+	 */
>+	zone = slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, node);
> 	page = vmemmap_shared_tail_page(order, zone);
> 	if (!page)
> 		return NULL;
> 
>+	/*
>+	 * During early vmemmap population, the shared tail vmemmap backing
>+	 * page is allocated from memblock before its struct page can safely
>+	 * participate in page refcounting. Therefore, no reference can be
>+	 * held for each shared PTE mapping, and the mappings must be unshared
>+	 * before the vmemmap is depopulated.
>+	 *
>+	 * Once slab is available, the shared backing page is allocated from
>+	 * the buddy allocator and can be refcounted. Hold one reference for
>+	 * each shared PTE mapping. The architecture vmemmap teardown drops
>+	 * the reference through __free_pages() when removing the mapping,
>+	 * preventing the backing page from being freed while it is shared.
>+	 *
>+	 * The backing page may be shared by enough PTE mappings to exhaust
>+	 * the positive range of its reference count. Stop populating the
>+	 * vmemmap if another reference cannot be acquired.
>+	 */
>+	if (slab_is_available() && !try_get_page(page))
>+		return NULL;

BTW, shouldn't __add_pages() undo the earlier sections on a population
failure? Say the first section is added successfully, but populating the
next one fails, e.g. due to an allocation failure:

void *memremap_pages(struct dev_pagemap *pgmap, int nid)
{
...
	const int nr_range = pgmap->nr_range;
	int error, i;
...
	pgmap->nr_range = 0;
	error = 0;
	for (i = 0; i < nr_range; i++) {
		error = pagemap_range(pgmap, &params, i, nid);
		if (error)
			break;
		pgmap->nr_range++;
	}

	if (i < nr_range) {
		memunmap_pages(pgmap);
		pgmap->nr_range = nr_range;
		return ERR_PTR(error);
	}
...
}

We still need to undo the sections already added in the failed range,
though ... memunmap_pages() won't touch those, since it only removes
completed ranges.

If the range starts at a section boundary, we'd hit -EEXIST in
fill_subsection_map() on retry while those subsection bits are still set.

The old DAX path had this issue too. Could we roll back [start_pfn, pfn)
in __add_pages() as a separate fix? Something like this:

---8<---
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 796af1028ee2..16a0a2c885bc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
 int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		struct mhp_params *params)
 {
+	const unsigned long start_pfn = pfn;
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
 	int err;
@@ -417,6 +418,10 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 			break;
 		cond_resched();
 	}
+
+	/* Roll back the sections added before the failure. */
+	if (err && pfn != start_pfn)
+		__remove_pages(start_pfn, pfn - start_pfn, altmap, params->pgmap);
 	vmemmap_populate_print_last();
 	return err;
 }
--

Hope I haven't missed anything :)

Cheers, Lance

>+
> 	return page_address(page);
> }
> 
>@@ -260,31 +285,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
> 
> 	if (pte_none(ptep_get(pte))) {
> 		pte_t entry;
>+		void *p = vmemmap_alloc_pte(pfn, node, altmap);
> 
>-		if (ptpfn == (unsigned long)-1) {
>-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
>-
>-			if (!p)
>-				return NULL;
>-			ptpfn = PHYS_PFN(__pa(p));
>-		} else {
>-			/*
>-			 * When a PTE/PMD entry is freed from the init_mm
>-			 * there's a free_pages() call to this page allocated
>-			 * above. Thus this try_get_page() is paired with the
>-			 * put_page_testzero() on the freeing path.
>-			 * This can only called by certain ZONE_DEVICE path,
>-			 * and through vmemmap_populate_compound_pages() when
>-			 * slab is available.
>-			 *
>-			 * Use try_get_page() to prevent the shared page refcount
>-			 * from overflowing.
>-			 */
>-			if (slab_is_available() &&
>-			    !try_get_page(pfn_to_page(ptpfn)))
>-				return NULL;
>-		}
>-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
>+		if (!p)
>+			return NULL;
>+
>+		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
> 		set_pte_at(&init_mm, addr, pte, entry);
> 	} else if (WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)))
> 		return NULL;
>-- 
>2.54.0
>
>

