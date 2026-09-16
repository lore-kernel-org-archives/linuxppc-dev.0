Return-Path: <linuxppc-dev+bounces-27467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B508CC88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8Wb1MJ4z2yqx;
	Wed, 16 Sep 2026 16:44:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.227.140
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541083;
	cv=none; b=T/FnwhP3k/TR33Fa6b+v037u1xrfjEfqmCBEvJwel3xbW7cupRhbBPcdgGkLkmEys0Y4jpxtjAOXQFHYEW1+ez7h4EqGHitZ3mdaQ3QvCeMWA0/x3Odivoi5SKWXByltTkSeGIj5hpzI2hwWzml4VAwgrxDnzJoX5KG5qea5jT3IGyYAk8cngw3KFP2COXGh3aHxCRLVJa1UfISbecuYgFggQ0mNMQRH6JMB14PRF31Ton4OrQJJaAPwIJ54HjYc30+ql4w4I3PBQrQNAs6YSY9Q4fTBCpzP8VdTbwzJa+V11Xz7LhF4IPBnrJuMvRAeR+Tor2yoA/GQpmQZtZBfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541083; c=relaxed/relaxed;
	bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFo5tMBgB43j7e1x2NIbiAoaDeMtYqIxMiKWU6xjcJ/nIZ+9XjOOrPa4+7Ah/M1yYzpwCQeu7O9wdmXEj/bEyQyhFXK2CttNXMxCPvvUASQNPp3RGsBrxit3PrGtXcUOCywKh9NomEr/s07sMyeuOyCLLkuDJNDzpHi9lA9ZFUbpA/MGG6qpYcRuyo77zRgZKU/d/gh/RyEcJ0ipnSRHH6/86TEAGLOzeBh/mtthmB3j8zaPoArdvPR4S3uz13nDxyS1MiCIuo+k0YxbS7AMNMN21lOOH+nTv7/2GjN1vsJ37mg8kv8GJ75dFcJSQ+Nt/N5J3zIe+79i+8/idBKOZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lu8SxDF7; dkim-atps=neutral; spf=pass (client-ip=74.125.227.140; helo=mail-pj2-f12.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lu8SxDF7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=74.125.227.140; helo=mail-pj2-f12.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8WZ3lFBz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:42 +1000 (AEST)
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso5293275ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541080; x=1790145880; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
        b=lu8SxDF7B/pDuPLbjM9Ptf+ZMQC5nX1aXyv+QLJDkADhRCI2bA2mrxryi6xX8ME0Yr
         hecl8ChOItR5NHzBBLj4YnS+qnydaHp2XStk5RoPItDRjrmf0sEgop1Zkw2fWYDIu/To
         4Qbr87kOPVxaRJFkuF1eLVpbZLsO+FCmR1f5fQTqqMUDH3P8M9Hts4UAVrZm54DoW9JD
         tKM8p7bynVPggQZceJx8cpqqItrAspo/oZ+4Acyd93ARIBaFxVh5SmiU7d17IsWG95ye
         mHB26Po9i+fuV1HA60EPCwUGFLrbWYWTNuPGDO20ZN0bUZmEhmoaDN1aWOKnoQLSe9N0
         qDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541080; x=1790145880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iM8j8Wu3fwHIWd8x6lR8eMq2Esw45qvi78c+WOmPzrM=;
        b=E+OuvoyvOkJwr50ucMyd8cNo1Pvz1DLa2pAPgZICZdtoMZ22Z1zUNWTUj1/Xf91pS3
         BGrSblUOgNYZbjxEDUzDHeO5FFiJTiSg3sdfaHKCyyCQNlrwzzWl9nPqPlrgRHKud9ea
         RZgBRY3SG9xovI/Ab9jmaCgPlM7bfrRYZwboZ5Q2LlSEEVhxwSbY5E3PyhBmAG9MlNzH
         BwLO/QEkFV+g1oyY7NFfCLIdUo3TNw80tYg0zMA8IuhsW/eICJJAUxQditvksN1fwirC
         9kGjW97s0b6iWKLD6pmVY4w1pj/Q677mASqlOZ5xeVs+7s3I58XipoqFXkdvX7WA6TWK
         J2dA==
X-Forwarded-Encrypted: i=1; AKwUvBziHZP2HJGluxZj2negG1HggUzxbASwS8aXoG6MjQAi9X6QzI/LVthJ0F2z4NLcK9w6tGDXA0zHeA2q04Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kkU8Cj1MNQo6CGZug5jy02YZ6RsJVtD6EOPdzFlqa5vpnHmRFF
	+bvULAfuMReT7FGmk8be8nPOhDEsdJV1JWUOlSoGi2JozGGbOzSAvUOJIsLEDq+xl1I=
X-Gm-Gg: AYBFou0iaR722xNomakcsyaUwA3r+kP2eJnmxWtdyD0HeHK+4WAQk5ZCWGhJ3NyScI/
	bJ5L2wBIgo9MOIhCkll2aMmWaGztnILI5JeUwGjE5EpyEZS0TFZMcN8/QCXulYNrHi3e5UioQpo
	yXtO1NpTqqJ3lrWU1g1qQhrRdCxHR24JfSLB0gfFPh0dxJosYRh5C8k6Uoiz3/b7NeAz7Ucu6s/
	NNKOtWSMV4z3yzmmbDYIQncqyRwxAvu+O98bBYaF9V5ZKU2lCN/1rgym9JBDqjGwYDk8lnsxO8C
	GMp4d3PWYmCMnDdSIHAD1rKmWsCx7C1BT1U8zYl2wWyuFkiuLT54UabyyU8eHnbaxT8Eahf/6K4
	uV8IkVoEe8CUAdV1Yi0Zj/0eQK18NaK1cfxJWEfTcovOHf/GtJUqT1RpM59javClp+C3F0qP/8N
	I14Kr+L5wJR62URLhB0gy7y27sCPvMLikmcKVpIFXFyoRWHy7M7SssqO5xXA+zA84lrd+P+qHzp
	/2buPIswtlNI04LbtbhkyfBVbNmjQ==
X-Received: by 2002:a17:902:c94a:b0:2d8:d4cc:be68 with SMTP id d9443c01a7336-2dd8e7b5ca2mr29021055ad.21.1789541079708;
        Tue, 15 Sep 2026 23:44:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:39 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 10/11] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Wed, 16 Sep 2026 14:43:40 +0800
Message-ID: <20260916064341.1825793-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 39f0cfeefc6a..96506f594924 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -131,8 +131,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_compound_order(ms);
@@ -637,7 +636,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -648,7 +647,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -658,8 +657,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index cc28bb41fdb1..b75921c622ed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -250,8 +250,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
diff --git a/mm/sparse.h b/mm/sparse.h
index a5111087ee3a..530692cdd516 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -70,12 +70,10 @@ static inline void sparse_sections_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_init_subsection_map(void) {}
-static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 }
-- 
2.54.0


