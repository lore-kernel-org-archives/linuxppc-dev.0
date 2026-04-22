Return-Path: <linuxppc-dev+bounces-19937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2889DF94CDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:14:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sTT3mJ5z2yql;
	Wed, 22 Apr 2026 18:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845693;
	cv=none; b=GQskjx8ikFKC9r1S8q0Mxjsw9L0oi1WsxktG5G8fLcK5gp+J0UpnDhp649JlwRLsxIXPEkJ4wR6xwhZh2Otn73a2urXpEKItUPiEcBQyPjF0i6vzQx6aS7ef/yVYtt2XAD+O7XVMPoCoCQq+uWOHedx3tmxlb9szdgIXIU22T39B5boOT/VwhyfgPr8I/Fgr3aGSR0cocvgeefFrBg7slToWvJRevy3XAkfHdRnNXzXJGF5J8eMgtYiWtpUpGoJD/hBn+KVrHORENO6dKKDKHvQQQhiSvq+w9delnAvtlR8yZv7YYuCuCpSFfPP0iKaJxjNm+ZlkxKz/yw5XzQhzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845693; c=relaxed/relaxed;
	bh=6TG6JcdOEtIWQgfEa9nERXqC1ZnDVOapveQPimu2FdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IC5AjWhHHrOVqFPE9T0YM3xEZTCsTe52cMtOwOsa9OOr3Jmo5tSw6MPTwfQPMARoXAGVRBlxOZxSeNgp9HtnPYN69TNrE/5+0bMAKSrNHWQkwcsD7ji8WyOOo/fMIvq0IFW3lCfP5SVaHvuR8t6WhVommc5sWYcxjKZ+EJ9Ik5YE5C5c6KKnWEOHBTjpBXVetVCoHXBxxym+/qlFi/RPyfYaG5YSGoY21FvfgwQGvcCTVByNfXWPHDEk8nk4FaxM+nIUFvic58DiOUug8d5Vi8YSxhQKdHsBbnrR93248ytx9ErwISQ/LLmsC28RIm0cqNkcUn8ENYNugZS24ln17Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YGwUKA/F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YGwUKA/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sTS4F8Zz2yv4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:14:52 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1890054b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776845690; x=1777450490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TG6JcdOEtIWQgfEa9nERXqC1ZnDVOapveQPimu2FdY=;
        b=YGwUKA/FvMfjUkU5q28EUleyxsLI9tyqfTJCbGC6/Zoo6Fl4+ae3+kVIs5UnLpAp15
         USD5yWPVbJOeXH7P7ZNq8sodLlGoaj0wK3vYQtj8uHRWOVb3k9ZieWqhkivIzkpThTrU
         LeSrIs6V7yxjcQvjKRukzITXH+SJe59oyOJxU2g9TNS2MtR5cQ3RVN6+nqM+uYREoVCD
         HIuR+ybckCCA/1JMEJT1MtXiJbVacvLLEXJKcABZiR1BYxxVvr2n4bFX9pG88g31bFkx
         0ERP6uAIfHbPluhHMb6vwcnis10v4JQVdm3VD6cv/HwhHQfe8jz6LA2b1dHfSW6yWE1O
         /ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845690; x=1777450490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TG6JcdOEtIWQgfEa9nERXqC1ZnDVOapveQPimu2FdY=;
        b=L9Lk00DKIVMygaEmOorkUUtg0j1Q1Nb8m9ElisifOBJDB97sYLtJS4BS5NJKTkfOsg
         Y4+36wPYp/ho7mIAdO2RXqp1IWNFc/4OoP3YR2xPKkOKYYJ204HsyKWNio/y49z4eT+J
         CdMmf9v2DTApZcpHE57QGw1unr7qJZRtlS5gmEBP45v8ll/aIRgDHFQBtc9mhAH76Hu/
         xlIAe9lTJU9v9Xl35Z1bNOOPv2cAhsYCfYzeryQ6nfaGvRbQcltGlw1kE/EelX0yRXiN
         sz01HLokTflWHd27J24jV9GdkRwECtNJgdXm/ZtEmZIu4yJyMWqL2wx98o73lrp02Zd3
         S4zQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yq09hhl+3jJiGybXP3VIz+RoirCDW9cmWHNiv0JwFfYE/pe8A9Ni7Ef3CeaFsSEAPIXqdLZdtUwzU6NQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSb9j3Q3cHHbMpvUVvBuws2547fKx8dJ5CphrljbwXcxdUJjBc
	uuZa0axilABf/GDPItG2EM7gUb9tASXmWOb2raGcFEnUQUzJbmuueG56H5f9gYGWI+w=
X-Gm-Gg: AeBDiesYO8mKBvzgUdqBzAQBcgTQweu6MCrIHnpss3qvJBSVv3gt8EXNj2HdhRgrybS
	ukwoV8eBNgtDceatxoLZaRzdrGX0rc98HXCtDtH0JcScQMPuqOmC/ZaW5zrOAqFsIJfi74elBZl
	M6zKCu1PMpopOqGoclsDjJ3xwNdIhfKLFasKXLeAatolHbxlaLZZfohtLqg/Gsz3i2KqPGR1H2E
	bwrDsjKO90xwVERWgYT4XM8DH+WqpxEqwvykBHCbdF8mvaSutZosmesQXq3j4iGhpT+Ta1Aqlys
	O/j0shHOwB+dDiv1Wn34a9s6IXNZLq5oLDelRqR/9NzTmF1ZWwGSTrL7mZ1Ims1bn2WlmpFNZkd
	ShV7LueeDkbLmM6+QN3bHYEKwATta054pmiOsCfsuSaC/I/NK2G2XN7rtzkAHzvD+ZXD+iEDCa/
	QTwbJ7GhDHvBMOsEn77ciF0kzZH34g
X-Received: by 2002:a05:6a00:1826:b0:82f:2384:212a with SMTP id d2e1a72fcca58-82f8c961ef5mr22759743b3a.26.1776845690162;
        Wed, 22 Apr 2026 01:14:50 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm16522874b3a.53.2026.04.22.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:14:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Wed, 22 Apr 2026 16:14:16 +0800
Message-Id: <20260422081420.4009847-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260422081420.4009847-1-songmuchun@bytedance.com>
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
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
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
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


