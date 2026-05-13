Return-Path: <linuxppc-dev+bounces-20890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDEECD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3s1H94z2ygg;
	Wed, 13 May 2026 23:11:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677881;
	cv=none; b=mpPa+/PdOgbkJzwxPtRkzIz//vdnZXebuU+HqE+N5DQ4FtxmJ50fgS8NIbTq+mvJpvPi6QUUIK8IPvD+FSspHYyRkIvkqQlWkUckPh32uMUtwskEzghRfpovqbO5pI85WZHqkAmYfPah76hBR79mlote37stf4JdG7eZEJqVqdN8zozADWV7wRxGZjvpsr6KjSTFB2+Ncuuyu9xJ8mZ6ZWMPo3hfgZR1w7h2KC36ikNDLR1f5f595JJju19f5Q9Uf9nUVdjHRRhyWpTGwcwhlIwog6fswJ6lnzkzm1KqByBeHEboqRiNJcjVwvAsk1r5DdKP0pGZS4eOTvuDgP/Wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677881; c=relaxed/relaxed;
	bh=RjQC+d3yUJ1wS02bTAKTrS34AR4NyzrcQRS2dfL6Y70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehp7jL540e7vk5ylZUAf7bBjoN3g1u22mo8K+cKb2Ng1V8RnMwUHkEoT2AiMsCnJ/O9By3wRS5TsdP6dTz8cfx1YqC7CyPG2Bt5xeZ46hVt8WrtbNBEA8rRrETgdYOXmcc31XJsAEiGO0Rt0eh4mu5TTTjKg9WkXRzc+wTQ1TJIr6ZNqhPxSudCyhqQ/hPmxX+9tK3h0B4QJglHG5oiT23dcxihPJcLK2kQTjKSNZTmcrYqTJKM2dhnfCj6IcGPl6CdFsxogXNblqtKrvt2radlUwah1sTxXV8lK6FifehEt5yGCsefjLVeUT+51xRaKc/vNJOlcZFTM/35HyLY6Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GzgxQwqL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GzgxQwqL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3r0yYZz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:20 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so3051413a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677878; x=1779282678; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjQC+d3yUJ1wS02bTAKTrS34AR4NyzrcQRS2dfL6Y70=;
        b=GzgxQwqLPBOm89ESn5h2oSX174v8O1/SsBZYmPCCkBfuG7ESM+9ZJskkeI6R5cOPaA
         VpNnW8eW/KvlxrNIbly4vXKmVvyYQ2Z+r3ay1LY7L9Sc7KPxSwBZQoFFoQ8gOtUYv4DD
         aP5fTU48cd2toszBedz8f3J5+Tw/y++smzoCjVLqp2j5Fxkh9VkEDAjysBuBXEqhASwy
         bCOnxNtUSCGYIhRsxLZZLLKJZnhB67CMs8e1jvY8qoT5RyjGr1Dom2UeTEKY3ZwYOYtI
         im9KFqElyWrjuG/iGETgjKM67EO6C40BQUdR8cO86iPdduofqynidVwShpkjRd8XP0Gm
         hIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677878; x=1779282678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjQC+d3yUJ1wS02bTAKTrS34AR4NyzrcQRS2dfL6Y70=;
        b=Sn+42jrmGoEp3O9haCAND1jFiSD9fZy+5H0FG0zFsjVqTFcrQ9V4DZn6dnwm2CXYy1
         CuEVtp/rY1wKnzVN3REipyaY/ajw3WcEcz5PDGGZ6u4d2xcVhXOlpNUeISAvVHvjMtaw
         7OOQf/P6fzsveVyl8S3lokfQHRny4jIwMg0IuAl/Skd+uJbG6i2RugwOqam5q2Q6Fo7t
         k4ExkAdb/azJWBcaQIbiY8iRMEoKTUvotdmwcHk6bUQRlx7jfTuLebW5MGglVUkwFbV1
         MtUDEncUginJOvWh9eMUbEBshEUM2Ok/c+XO060GTW0JAivlmMGxNTVLCHkHMra2hh7u
         12kA==
X-Forwarded-Encrypted: i=1; AFNElJ9OSMSmp0o6atlY0m0mccq7g0SiA9wPAbyjXHxl3VltzA0yehciFbrb4d8wzGkyT9bwEIa1Pws7YoIUMzo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAh04DRITLYTGQ8TkEW9UmOEAz0Mtiq0EwWEQQjkYsNBSTFWB3
	9xDFw7KgezNdx03eNTIPUG35hyQKjoojnKelaut5ZsGHJy2pEkjHEsGpzI1xMEHLSKw=
X-Gm-Gg: Acq92OGbo4O2fmH6t6Z+5BUnzDjYqetQv9WVztlxLGh4AKM/AHNOoPBGoohMKBMvHvL
	ixNerb7MKhcFN/rSFXK3lTE7vlMZsxrGagDyi8qHtqpGAJm5WwWk4Va/kzGVNnQfjYGubuJBVLY
	22PfDKO7aYJh1QZke6rvIjmnt+xIOf6EpnXsPVxoHGE6qo917JMqEAFx7invsx2U6a7P2o2z5un
	EtJgPkfP9IZ2O5mQqPlU4Gb4OaW+IB/25fdQ1PaSxC72WgJxBjz6V3AOm7EYGZUGvy2CDQEau91
	IPfSQn4ERZUMBC58Sx/fDRW5S+Fomdehe8EOkb4Ur46OlDZaOqCVD13yg+KonRaaZgy3UG86gy1
	epZYYin5h/iyHm27Vk138Df20M+aCuVfJy/+NyeR8F9/0XG8YO3A4J7QtcwzpCyWQZkFfS3eoY+
	KumIA1bABoC6xBWpZzgUWVfCIf9RRk5LkPVf47d0sQHdBEhB9SHTUv2b0i6do=
X-Received: by 2002:a17:902:d2c9:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2bd2ff29802mr31509965ad.30.1778677878094;
        Wed, 13 May 2026 06:11:18 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:17 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 41/69] mm/sparse-vmemmap: Drop the extra tail page from DAX reservation
Date: Wed, 13 May 2026 21:05:09 +0800
Message-ID: <20260513130542.35604-42-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

DAX compound vmemmap population still reserves one extra tail vmemmap
page after the head page, and only maps the remaining tail pages
through the shared tail page.

Drop that extra reservation and let the shared tail page cover all tail
vmemmap pages after the head page, so DAX follows the same reservation
model as HugeTLB.

This reduces the reserved vmemmap pages for optimized DAX mappings to
OPTIMIZED_FOLIO_VMEMMAP_PAGES and removes the now-unneeded first-tail
population from the generic and powerpc paths.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 44 +-----------------------
 include/linux/mm.h                       |  2 +-
 mm/sparse-vmemmap.c                      |  8 +----
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 95e65ac8cdea..fb8738016b30 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1217,39 +1217,6 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int node,
-							 struct vmem_altmap *altmap,
-							 struct page *reuse)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset_k(addr);
-	p4d = p4d_offset(pgd, addr);
-	pud = vmemmap_pud_alloc(p4d, node, addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, addr);
-	if (!pte)
-		return NULL;
-	radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1316,16 +1283,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				/*
-				 * Populate the tail pages vmemmap page
-				 * It can fall in different pmd, hence
-				 * vmemmap_populate_address()
-				 */
-				pte = radix__vmemmap_populate_address(addr + PAGE_SIZE, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-
-				next = addr + 2 * PAGE_SIZE;
+				next = addr + PAGE_SIZE;
 				continue;
 			}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5281f073230c..86d7cecb834e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4898,7 +4898,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
+#define VMEMMAP_RESERVE_NR	OPTIMIZED_FOLIO_VMEMMAP_PAGES
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 0c0b54e94c07..b5c109b8af6f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -473,17 +473,11 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pte)
 			return -ENOMEM;
 
-		/* Populate the tail pages vmemmap page */
-		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-
 		/*
 		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
-		next += PAGE_SIZE;
+		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
 					    page_to_pfn(page));
 		if (rc)
-- 
2.54.0


