Return-Path: <linuxppc-dev+bounces-19376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7386FF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZh5fW2z304r;
	Sun, 05 Apr 2026 22:58:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393916;
	cv=none; b=m6xP/gKIIRsEulHcvyWb5cJMup70bYrMWUv6WuE3N5osD6tZYyiErC69x5tbJJkWs8CIkUd+cGGyK0m28EjvWDrddgP3c69RWhD0ZEz93xT9LnfyeKDS+/yBcqrpTXzonZ5AVulakiBJpuBXWAwrM+fAwz/sRCNr2/ThbTL5Tt089j7sc+h+TlxLDbFUz15t2EMV9dVFrug2ss2wG7g0UnLK4x2CYl0Jnoyszcs3vJNoqRH0AVUKTYhQAy4V35ktLscmtESgPi29ZC1lgidSpvzJEJSv3edQdYJbAfe4FtZsSKA9RQ1A7eJYD06x4TbvcXm4ol/3TmVOcm0S2zNUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393916; c=relaxed/relaxed;
	bh=64qVqbFMPmvyYt7CQKJ/AlutLuZCqUEnEB7XrUuUTaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5JybHAutBCNg6fovRnj9nQ3GC1pHu3Fin5LIX1KRTmQsSU3Sy/ys1D4wF+mv6wIPe8YjiKIJRQfJ4e1Rx5MUCSVuowGrRSmIoEJ3nVIiQmcvN2g2LKUeeUFodg3KwRMwa1Ms1RgS2B5gpR370RTG4rkm2i93N5P4qimptaSAFePTv3idDMLMHThyYZNCCYmGx1x5ME3a/ZGbdO5zkvHjaqI8mAJNLuQu6/cJRVya881qlw1v2Z9CDlTng9jfzM8d93Hv1hkDaXm92ZzbJkAaP8l1a+MJXObwvtJ021vc9vzQOalT6jOlIUuI/Gz+lcVK15jCPsnTMRaTlT8QDGc0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EF6hbLDd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EF6hbLDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZh03ntz304l
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:35 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2819991a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393914; x=1775998714; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64qVqbFMPmvyYt7CQKJ/AlutLuZCqUEnEB7XrUuUTaU=;
        b=EF6hbLDdWNNqQhearDhoy6QVgLa3411Ugbk+oA29oVka6fHjRKVpksIs/8eaPZy8PB
         ufMFyE9PQyGyHZJRuMPOrUmBKfYnW86yStv/M5zqoo+MB2Dw9BKMpxJe1lw+5ma/EUzS
         XHab3IL+cuxZeCWVPEWRqO0NX84jV+64pzsUoKwsHWSc9WyRSCMLyCwRSTuq7asvbtJ5
         fNmP5WuKm0JUw8uN1UiGV+74fTnk/dX6rMw7oEpk395PPC2TCS3+g2mjSdpdu7Crcorj
         z0gvhWe88yaPD4jGsaN4Rb+USz2V4PAD72Nt52qLeb27GHkhOlIeKTBIEjWXn+TjL+1y
         tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393914; x=1775998714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64qVqbFMPmvyYt7CQKJ/AlutLuZCqUEnEB7XrUuUTaU=;
        b=cJFRFP5j2fLVPnOebXBhvD5Sbk6R/Z4U2tHREfkczWV3/aqRlAPz8GXe11ti/U0wtv
         AgY/14OF/W0bhybn8Fj1h/UMPV4xzPMeJlEF8YO8cwcwSl+enaKjPz3RDC6D2e69tQyQ
         QXIU10KsWsM2I2trEuLBC3mOwYD1D7LyID+Nv7zMvOfzS76ZWEgAnkT4EZH/9KmD0AKw
         BBBA0nUz2P4GVsFqSM3MtUtHRhKAhAFrojqJ6kSm+USwlouzR/fOTXvn3tbDeaOzPy+k
         RVc+g1QzFA/4WAQ3PA5vkOFN032XAXLwNi6UXwnGIX6gk/aIkFE2su8hfkIiTY8lwvbl
         sHLA==
X-Forwarded-Encrypted: i=1; AJvYcCXUst0X9nhCiiqzyTPD1zqr6QxR8YVJ+eKRUmmW3L8SmwA+FjQKrYMTRhBuzGwyclpluQNZ28+Aqk+LmsU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZorRnuou1GQ1WwIxCDjos7djdOtM+8GhSl43J9L0R8mybMh1e
	SNKMw0W9fuA4HhUin+lmuJXXfNKpGGgweZFSUObuRyCqzh7RiX5IxvvHKacrlBC9thI=
X-Gm-Gg: AeBDiesi9riMc7tufcRVQIqMO8GGoTyhU8g8fUXdsK3C5lfzaixGzMQwyHnNoN4c0pb
	vQq4ttBr8DlPoA5qZZKWvq+np0NwfZVqB+EEfQiwVfHZOhykDRcJ/Uun+Wi0ofRDND+V8wGWCFF
	NefeHWUrAA2hy2Z2xqQ2PyCV/scmb6FZK8n9z4L+dLYbwBCl4DOH3TWP8t/xvmrrEt4BsrEhP6Y
	ABh2y8bgFKdK1lJkql2aOsQgEmV3YOBoNH6iGqCoOxKaatALKu/qC6Fls290IKFBecEGX5a19ij
	aJc9p3Dd23v7MPTp7OpntgqmQQOS0mxokrQzhDJWRRN0uIEp2MqLiihnhDIJdl0GKGZfg2HNqzQ
	FUym2AddKiwSr4tYmPzkMXXFavD5wIwW+y/7LN8OpIA7JO0RJuGLFWkov/yaGRHh9ZdxNhH8F72
	0uRybwOgZJVKhSBTKwUXBtHL1aiIWtU64387cb+wJPFOk=
X-Received: by 2002:a17:90b:55cb:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-35de679faa8mr8791452a91.5.1775393913904;
        Sun, 05 Apr 2026 05:58:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:33 -0700 (PDT)
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
Subject: [PATCH 46/49] mm/sparse: replace pgmap with order and zone in sparse_add_section()
Date: Sun,  5 Apr 2026 20:52:37 +0800
Message-Id: <20260405125240.2558577-47-songmuchun@bytedance.com>
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

The sparse_add_section() function was using the struct dev_pagemap
argument only to extract the vmemmap_shift value to set the compound
page order for vmemmap optimization, and to set the zone to ZONE_DEVICE.

Since the full struct dev_pagemap is not needed here and is being
removed from the rest of the vmemmap APIs, replace the pgmap parameter
with direct order and zone parameters in sparse_add_section().

This cleanly decouples the sparse memory infrastructure from the
ZONE_DEVICE struct dev_pagemap. The main motivation behind this decouple
is to make sparse_add_section() a more generic memory population interface
that can be easily reused for other non ZONE_DEVICE population use cases
in the future.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 10 ++++++++--
 mm/sparse-vmemmap.c            | 14 +++++++-------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 815e908c4135..089052d64b01 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -305,7 +305,7 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long nr_pages);
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap);
+		unsigned int order, enum zone_type zone);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
 				  struct vmem_altmap *altmap);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 68dd56dd9f74..0f7707f3d4bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -385,10 +385,17 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	unsigned long cur_nr_pages;
 	int err;
 	struct vmem_altmap *altmap = params->altmap;
+	unsigned int order = params->pgmap ? params->pgmap->vmemmap_shift : 0;
+	enum zone_type zid = 0;
 
 	if (WARN_ON_ONCE(!pgprot_val(params->pgprot)))
 		return -EINVAL;
 
+#ifdef CONFIG_ZONE_DEVICE
+	if (params->pgmap)
+		zid = ZONE_DEVICE;
+#endif
+
 	VM_BUG_ON(!mhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
 
 	if (altmap) {
@@ -412,8 +419,7 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
-					 params->pgmap);
+		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap, order, zid);
 		if (err)
 			break;
 		cond_resched();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 68dcc52591d5..894352cb8957 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -666,7 +666,8 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * @start_pfn: start pfn of the memory range
  * @nr_pages: number of pfns to add in the section
  * @altmap: alternate pfns to allocate the memmap backing store
- * @pgmap: alternate compound page geometry for devmap mappings
+ * @order: section order
+ * @zone: section zone. Note that it is ignored when @order is 0.
  *
  * This is only intended for hotplug.
  *
@@ -681,7 +682,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  */
 int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
+		unsigned int order, enum zone_type zone)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
 	struct mem_section *ms;
@@ -693,11 +694,10 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 		return ret;
 
 	ms = __nr_to_section(section_nr);
-	if (!altmap && pgmap && nr_pages == PAGES_PER_SECTION) {
-		section_set_order(ms, pgmap->vmemmap_shift);
-#ifdef CONFIG_ZONE_DEVICE
-		section_set_zone(ms, ZONE_DEVICE);
-#endif
+	/* HVO is not supported when memmap pages are backed by an altmap. */
+	if (!altmap && nr_pages == PAGES_PER_SECTION && order) {
+		section_set_order(ms, order);
+		section_set_zone(ms, zone);
 	}
 	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
 	if (IS_ERR(memmap))
-- 
2.20.1


