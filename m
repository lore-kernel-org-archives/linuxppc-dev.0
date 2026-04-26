Return-Path: <linuxppc-dev+bounces-20114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D6FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Lv50d0Qz2yps;
	Sun, 26 Apr 2026 19:27:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195633;
	cv=none; b=Nz1jLoCOC/14HG8UaMGB1dB8YYZGPO+4vi5mBbRXub2p78rkbl0D/u6NFVzN0Q9duLGxgLxN40Cy7Gt5IVOD2jPBEZGdSYXBgcxboh7y4ze7c1Ypah10p4EgpbHkq4xE+VlYK6VkJoWicIKZBIxFkNJ8pXcV04rw5A9DJoIz1a5uzzFH0pArHqBG7pWrUJIWy29of17Y/u2eevCG976Dr4eUi4LUO2tWwK+DFt9ioQCQBwsH9O7ceeMDvpwU+uIQ3vNHaUCITH+B4M7Uc/QHN5BIYM6MDG5hUJL8Ms2em10i7NSZxCnINPwIedCPDunlXa6QbIEMm4JOVK+U+OG1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195633; c=relaxed/relaxed;
	bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtzBXVhyO2A4wnWCbQHJU3JiENONVldc+LScFD2VVFfvNlZwwKi0wG/nmvzHQ1Oyi4063e7ya3+i2rz4du+tpf0HE9lZZVPByeARPlENu9kYfzGXFoc5w4zu9wCgtNj8fzU9/hGJZjtiMQnQzzlDHtYwhqCQx5WVfejJWbCSVrvB6UlGLj/JQX56Rnve1swh4tI94Zs9YcZyk//1TolP81lNyTzgQqmN6HJptgnxj9C/8aFeNlzOaFDXpPdOvM64AToa1MwUN6G1CPl2sVoxl5ku7f8UCxRMTiFSnPJ2Ce/DMOe492aSSfyu/OI+0mvP+otsIVv9/bsTLCLh0lUEBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=c1DgFjBX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=c1DgFjBX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Lv436mDz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:12 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2b788a98557so41725055ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195630; x=1777800430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=c1DgFjBXQ5gqWxfQfbeP0x6IjL7OeAtr2qNrBgdXxQ0WeVWsTT/+34kllwwmTJ4h1x
         MQGmQZNh9LRAX4dUJFcBzTx1xHP51gOPUNksUdOFPgoVj8muTnugxCUtTftGDkP3pR/4
         1NqyB+bmfsd/yuWYB2vXDi9YtSC0Yv3ofYwEEB4t+F1eQk0PbJLAbFywJbIVwQjWwX6q
         bqYWSGUNgSpW5Go2MxOXqJGW8sMCjUkq/ja5KrSkA8OkSnA58uG9IX468Dg3pAVb0tPu
         lvywgbq0iSKjZuj0KEaGzBQdFHDkXCRL3vIN8JGtgrgwR6Xh/hgUBGkLQpHzvSekDNHF
         rnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195630; x=1777800430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=IxBgSXeSz7F47TV5jytOPAGcnfdPgCtJB3RmykNDScgmSjHcPBulQ27Ubqsr7fma+Q
         tS831LiNe7zJAnP9jc7F3QGhjF5DSQWvDkhEDu0e0m7vWkRCa5GqLPIHjjkWUqCxWIH8
         1mZCRf/81vpki+Bx+SN6MHXBheuICnKjtKrxB2UOUE5aDc9pf0+DdN9jFlnPiqby1KCU
         ySXEl+uW7eSquDvJlTuzwGfhJu+MyPgYro4vmSu7EUmm7mUg14GSGcp0ZpbMHIT7D8KG
         BhIkpQxuADhmsElhuisYLKc+VE3UREEoiguimk74VW3nwmRMCCIsujPEFruGbpWYlLlq
         kieQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y/Bg4tTYfLXuHwvLxBAncSDeeonZK9EKxIewd5sErRZcu0lxuZmwA0jWuKDCSnjrYbgh6o4yPfo1Hed0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypG5Lqs1xDPVY/Vl7fcfGDzG08Gwl9ucdzC+rrpWaq2kVunxxF
	AGvAo23rTIKGAxHeST6uJ9KPquCPw05P4vENik6rJP+Lk2PUV1zDcHEs2iFQTklJ4Ww=
X-Gm-Gg: AeBDies2BgdhXVxzdeD9u0zXjeljYyeAfBNzJxSwSEHFve8BT8bMHMG4AzKIvfBolKi
	hh2CnQ7c82fZFvh01o28dAwKjnEnp8gZF77O8UxbByngRZDg/p/KVD7Da939F6E+FL8gi0JcMlw
	K9KiRCORXcfqEBEO02eYpDNOmWTShKgFeCA7DukJqENuEG1bdXUaQowij+pSw3zztiqf7GO9TRE
	CenqdZSzI12l4jvIDE1bNeylk97SJwP6e+gCVOGVW8lZQrZRAxTkqrDXY1nVs0GuP5fwlTtlGsD
	ikrnltNbjxwikAN69QgHyAbpvax6ko6KchW1Cxf1B0j7+pPiBve094tDkhHpnFIGSzCGcMMUvrL
	oRlGaq4PKlY2DJUGvwenArRb0BMN/BjOGCLdJe0gAnXZjf3tod5rOyvRqq5ob/+BF66gtPEIUIq
	kD2bXKgSaGFLs2LxzVxwp0lJC8xsKB
X-Received: by 2002:a17:902:cf0f:b0:2b7:a1ff:b239 with SMTP id d9443c01a7336-2b7a1ffb4b5mr144455245ad.14.1777195630176;
        Sun, 26 Apr 2026 02:27:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:09 -0700 (PDT)
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
Subject: [PATCH v7 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Sun, 26 Apr 2026 17:26:35 +0800
Message-Id: <20260426092640.375967-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
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


