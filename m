Return-Path: <linuxppc-dev+bounces-20027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F7F34C45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yJh61xRz2xYw;
	Fri, 24 Apr 2026 12:56:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999364;
	cv=none; b=F5Ce8lPdEyfvPRNGLz6gOT4AkpJW+M0enRIslY449DT5GZYZ+wWO+gzDtg2iZnbVGvoDpDmfQkLc6lz9Pyl0zOixDG6v4zzoqlqVxVsANbXvLGf+b0V3GEZcDcyVRKw4nEuF7+xdt5oxEA4v+BCYjzqx20u+M6F/9SDwm3LGT8RrGma1SiuVn0Nw2AQfwSuJc4ohsN1tDBKahlx50QxfWBzRHdKupwe/Ni/JKKI5C1gR4vjyv/9DPYf4wC4wn+FQMcCEIuapAOYWQ3e/N9Rrt2U2+PxthuOo0+l70MSxyzSJumalZZFaq9AY72GIbgDUzFRub8mhqdkZqhwKuqdNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999364; c=relaxed/relaxed;
	bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmoOJm+RFgEmlJYL/BNxmvUFd1mHbR+FXjSswCiTjc1Jll18NTN4p1yem01CpFOQi7DjRwYmdn7Im4DUcfyVgebNXncJ2k2n3ZekXkkaWdagvCpcOiudlG1PlrqEpbKSaRe73Qu5l80A6rnXE1psiMcc/EV183MlHwPPWTQW8OqXsjSDRO0TZjMyyqMvWVwfaVuZggt/OPgdnUjUs2BZV4ohd/IKPEOlsTIPkoDrWvmaPGN5cjtfBEwoPYQXPgbi+QIcFzxtmxKd19bpmcQ82gC4V9fOY/mE5elgrHepUlpzTOqXCq7xEmTROkPXXB63lWx+bXefsSPnNJl7B9hSwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LX8oHOHT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LX8oHOHT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yJg6PHzz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:03 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2aaed195901so32170375ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999361; x=1777604161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=LX8oHOHTDtyc8vGdKlF1ftFApPJWLH3yfvaW8Fi7BSvX4wBxCcI1nGifY/RCZfKiKO
         n6XjH1untT0ZPQYz2BjKMcBjeWasNFMi3fHK0D1ws1kZt4XKXUuSEJf3GkhETxvylxz0
         Wja9/Yneg6ozEBevwCmu0UWB7KGxwe9PnHKKvVjbF8J8hIODnXrRFXnSGqXhjUkpoQcb
         nK+oMZMvV5oESpTkGXHX4Uzbi8SCjOdxR9hfeS3daOW7QQJhea2CtO6x547tZ2IUQQMl
         4rB3akw/86dxzov0iUQWZrxPVuplQLI6v0K9bo0875CUu3WaXwKe0XssPuU34IiHb7CM
         2GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999361; x=1777604161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=q2vvdR748RzTde3U4XbBGFRAaGMalNJdWH933YWWxXYKmJ2M28FgMaw3kHomZR1/aa
         qol1sRzCk/Eq5ndu7InfQ505ZOqNkqTEholuOgNhKEOxCqb4StBBtglEK8zqep6YW/Q2
         QqHxUSPUjxkj8yn4rHWsmqqsl6q/ZkVMiOZeb02snwoI9pbwgCpjgPUvcewXzAAZc23Q
         CUWUCU/+wjmZV54z2k3MyK0tlIZhQ/LPP6dpClAdRwX7uaFyF6L4Yymc/7U127aBGUDm
         bfnq/qqJtCMwNKbyhhWvNZvIlDAZ/lQeD2OGXoLtE1In/B/NsscPbJQz9gn/lvV6vVy0
         yR0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+zyqUkIBp5wZqmvwzVr9+KZB+AVjds3+kOmYn/3R78GQ6QKHcNJB0uQbNeQKxoxEAacodAsjPrwfmqYKk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1lYwoKQD7vKBDdz0A9VxkGBk4Tj3hRfd8HNUkdDlOGHB28dpC
	uSvFKejNNMRCbB1Q14ztcTNJT0BoVIdxBN9UEypPFJMPFVz7Zezs820uHwa4qMoHXXs=
X-Gm-Gg: AeBDiesZ9BoXm03MwWABcOLghHg74cSCwnF+12ca13MbQEjCX6fbbSzgRz+EaXrp+SH
	HzitOwjBUJBUb+kBYmhkG0FBWzfurMsImPrOljwTBzR4mMK60Wx0JJ8kc3P1zpK6MhIQfmN7DJ4
	mJpJdE7rO0qkgD1bJ6Hh7wIHPgbX4d3AWsuMZ0r3/kANYMEjD4v82e/NeB5yMvLY2/f7POlodgW
	5KlVGvm+1OQtgOxHmYTYFspPDwErSYG14Yu4WhTbBh3aFturYnTmluEhprmMs3xzr8dtWdTht6z
	E41NlHd1VREukKDNAJ406+0fYR+Eec9PtNzVIt36iKTROiQVtf5/NjpJ0ibhIO/Rt6o/cwGf2GR
	tHJenSaz6jFH0/7Hvrewrr/eKfQE8BsK1VIRMbPQ9ZXMMlwZtlWhSayoVGN+NyonDkdrk3BGxHn
	KBm86jG7Iq08bCpsTeD5mkjR16dU3xZR35arR3xCXnFaO8Sue3ebYDm7w=
X-Received: by 2002:a17:903:1b03:b0:2ae:ac0c:5a2a with SMTP id d9443c01a7336-2b5f9e7a9a0mr309495685ad.6.1776999361448;
        Thu, 23 Apr 2026 19:56:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:01 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/7] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Fri, 24 Apr 2026 10:55:41 +0800
Message-Id: <20260424025547.3806072-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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


