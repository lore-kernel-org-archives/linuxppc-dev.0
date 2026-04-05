Return-Path: <linuxppc-dev+bounces-19336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9B6F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTR09Pvz2ynW;
	Sun, 05 Apr 2026 22:54:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393642;
	cv=none; b=jzTRD/BdIKRH/Jy9W0bWxyPPLnBHVbIM+uMxy8H8lwAbTTZacHm2J8FgOOdqcEYs+GQweUFAjdpetckRka19Fk/cPKXeZ25UKVDYa17QY75yj8QdZfL369knAGhsw2fdY603ZICqr8GwDpvl52kPcgHvxJ91b8UdtSYgxjeqPYYj35PLO/ig2u3wI6eJM7H3bII6MkUTChWjgi8qG81e3/SxZBpYCKLi03BQlBZD2/prkgbdlhl4L6o2A2eoPcVs4uTsihlrfAUe9mqFY2tZ9G2g9/NiXOyTRTsVU7Nh4oyhkXbxu1JJxD6pMNVeB1oEm3A3npVUINZNdYLwKWilZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393642; c=relaxed/relaxed;
	bh=XDmw/QSiGpmicKvHs3oRyZcvGRBcNXeGZ4EHaUFkJWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDyuBNhHwBNJFIsLrSM50El5k3RqaPvGqVLhSWe1TGYXKh1JLe05drL1l23P1KcMEsnZlt9LunUaAVmLTvv4I8L9nhkP84wHfk1S1tM12dveXCwqnnAcGO4RXvhMs/50yJzix4XfCQ92GfwxscPBaq9xjj9Il5kdGzqoTL56+B7xWsLuLd4qsmnUl/NjWHkHxBj4qua7vyIIFrmax6q95+ZLMa+HHti/eVm1nDmmFzw/lFC4XJt66dvCfh+kMUeptV/m4BhK3gJbkDIZCF8pdfKEypggM1k82Fk7fdQl+0N3oAUfiZoZwBimppWNzDxdYtu8+RJryxRUDQ4YoJOT5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=An/jjgi4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=An/jjgi4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTQ295kz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:02 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2804258a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393640; x=1775998440; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDmw/QSiGpmicKvHs3oRyZcvGRBcNXeGZ4EHaUFkJWQ=;
        b=An/jjgi44ohLpm+4oSzPVsH8vNY/bUpGHPaS1ZuhSo4RZBNNNlmI1icaRU/D+B7frG
         cL0ROzuh/KXq27fzyQL7UOGidWVUtTjwX6w1wjwkCmBCcQSBDI935J/h/NNRMkjKl4IR
         oxflzBQJJ1smM5oUQ49Te4fJgWXMm9ZHnAJA61Vau6x5btrF7iBVnMz1boeF4q79+wL8
         1p6NXJdFKR8IqDxMd6E4mYIyLOF//QMbWWvsTKn4+1HNC6obAuNqJ6lQSkSZLeO/tVCB
         ctmHohGmcSoqam8yKvlaPgVNDGCOpBi2qQgMfVX392Y6BXwM6/erxVWc1RXwNu4hPhqY
         fmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393640; x=1775998440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDmw/QSiGpmicKvHs3oRyZcvGRBcNXeGZ4EHaUFkJWQ=;
        b=BHesykLst8/1RhvZFe5vF8hyv/fonSZpSMM/b+h57TcWRSEsPWcZcHdfhhQ3Tl2G2P
         YS5VEE8mEk0qqhrXEUfkR6YYCQxNEd74O23Ub9i2igJLm6WU/a3ZL1yIUamw2eTdNBhX
         ERsu9xPm7+bQe823ulj7pU5ShXn8oML3tLSKGznkXqEbZY88CAsQA1IdekkxxA8bumrB
         6Ydr81CgswQzfLamghjkFCkOBRnG+QsiD7qWMD5XqGVm0f7/EI5ZTAba79T/SBBlLH9d
         UKpVjdZhhtHJDojYMmIiuMAZxEmjBO5B06f1qlcuSO993X+Bk/snSvu10R6J79VdaDls
         1U8g==
X-Forwarded-Encrypted: i=1; AJvYcCXe/nq5SpvQeE5uaZD+1RE31tw/GdF+gD5A39iY5C5kylo8lo3244+rJbW2LEKGfMeRcH6HcnjQBY7GBFM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzEhT7sKFdvx5VEFaNQDkEAz0W200jyQUs8MQL2hSZrveIGC0K
	iFYqvqfTqB4/QT7skBI2Hk0QyJXOUJg3xhMYtOfCUZJW5bX9dJX1Hetw5DiL1rbVLEU=
X-Gm-Gg: AeBDievNDL6iF5wdY50pgQhoL3cvSDCeKGaZyxQMfexnyLgXoSBY/gGnskj6D/hZUdD
	UYK349U2tSaX6AY0qpXVe3rxKtzGICDU5dTc47mTXEE0YhbTIzUOM8DmXRF0PeACMe+Zpp/Xe6e
	Qjq7KwNKXJgWurjBfVvEdVlLoqiWUvGSouX1y8/SWQtEytn1+AkpSKEhr/sRDB8Kerl71/MhAde
	rkeQFI3frKJ4rO7L2lxOg4/XklenFN352KIrtcA+LsRO3+arGjEmQMc/x7Cfzf4rBIeOhgOXwyL
	rMhKZXOs53uHfDxSbccgz6e+W7xq4drYGNPj+l+7c1QdqcROQMSQcE3o4FZ9trzWWJk77mVtRly
	qOOrLc1Rmoprv2cLahOF8f6iO0+NVTE8PrIWqh2MuihpaCsOuKczaMjbBcfoYVz529/16P7Eoof
	rBVqlbH1oaT3YBrGVhEOwuiRso4pzRVBTMQ51URN9aWYo=
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr8490321a91.28.1775393640457;
        Sun, 05 Apr 2026 05:54:00 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:00 -0700 (PDT)
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
Subject: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock migratetype for ZONE_DEVICE compound pages
Date: Sun,  5 Apr 2026 20:51:57 +0800
Message-Id: <20260405125240.2558577-7-songmuchun@bytedance.com>
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

Previously, memmap_init_zone_device() only initialized the migratetype
of the first pageblock of a compound page. If the compound page size
exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
subsequent pageblocks in the compound page would remain uninitialized.

This patch moves the migratetype initialization out of
__init_zone_device_page() and into a separate function
pageblock_migratetype_init_range(). This function iterates over the
entire PFN range of the memory, ensuring that all pageblocks are correctly
initialized.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9a44e8458fed..4936ca78966c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,18 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+						       unsigned long nr_pages,
+						       int migratetype)
+{
+	unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		cond_resched();
+	}
+}
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1023,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
 	 * directly to the driver page allocator which will set the page count
@@ -1122,6 +1119,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1128,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	/*
+	 * Mark the block movable so that blocks are reserved for
+	 * movable at startup. This will force kernel allocations
+	 * to reserve their blocks rather than leaking throughout
+	 * the address space during boot when many long-lived
+	 * kernel allocations are made.
+	 *
+	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
+	 * because this is done early in section_activate()
+	 */
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1


