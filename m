Return-Path: <linuxppc-dev+bounces-19359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7336AF3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXL2g5Pz2yvB;
	Sun, 05 Apr 2026 22:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393794;
	cv=none; b=TvcGafOOi9MLAqXNQpo6XbHM+YtlJK/RNokl9LSBnCVpu8HvF7QJy6wjeygbF4KHLMYXZmqR6EF3I2qG8Yxe+bjHxU3PgtmzBaE9nudGLqIU3nfHrvsjg++qpQnxQx9UPZrqgMuQ2s+HocRj7QyG8e66/uswPmANjziJw2ouN/vTDB3nPL397YPwqTOqU5wTun9Pvad2yJgOa8mRC9//UF7qtNrnlpPFTDTlGdjXX4+xdii2qio5QiDne+Ds690ZuQqxy5STq95Q5gWT0HHNJVpcdweIaZTd5Kd0/6NbT4BwVzResOoecPM2ZoFo5sFSohZbNwNbhbeqSHTiThTYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393794; c=relaxed/relaxed;
	bh=cxlpdrP2oi+I/kPwst+8wcAG9djYXbVqK5QGAlYJoDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWrI0x2wLOySawEFFaVS1gQGP+h1ROELT2dWBAM85qW4MhZRF6TTcE3wIkGyxeXKujAQpj8U42coyMjpdFqS8La3KkfI5ta2AkchTfyOLh/jUsqYCcFXsFO0rcxgqnm21jpFgxnBfPZLaAQa3AhmL/CLvE15h+XH1pr5ZBsJwA7S3NtEia/M/Pqtibk8gYx5gL34l5hY8lji2ayL7o8rHH+/xzatyslCcBp0mvxGLCSCyP/LzIlT5f4gFIgaHAQWj2SzC/YPOFijj0m9byXeqgFGseqH1zTwK71AF/rpNfeAjaBym/iq5fXPtxv8MA4CWZ30PzRm5U5DPqit7bNdrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aPmGIggU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aPmGIggU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXK59Jjz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:33 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35c124d2613so1750634a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393792; x=1775998592; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxlpdrP2oi+I/kPwst+8wcAG9djYXbVqK5QGAlYJoDc=;
        b=aPmGIggUjV3p7yrOhHRvN0Tg2/qO15jqWBIYr+BvCkH/tWgg//VAYANgJy0MZ6342v
         GlpOB9xKhsK/bAOo9VpwG7aNxmcGA8KLvaff8oGS1fmwF1xKUIsRdikYTIRvip/MZvoT
         3cqOx7ItyDVSQQm1q1LZ+04tRQzuoxER8Ut7sjNejvmZoWT40OHmSEKfE34Xry+P6fSq
         1kz4sD6AKxmXannFhRrguAchULJ2WKR2BUBjTtJIeRxWsMKXrTieUrQnVtFpXrrN7SQx
         YiJSGCfczAoYbZTaLb0g+XxqBTceC7dIvAEmgrIusTr2MyJMGozQkD31JMt/C08EyE3f
         jm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393792; x=1775998592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cxlpdrP2oi+I/kPwst+8wcAG9djYXbVqK5QGAlYJoDc=;
        b=J2sF/ZZH5WfSkgn38H6E6bG0YiJV9tC4MC5Jzt7wXbs3qwYE6k8hlyNCRnb/qsLjq6
         NZpeo4kcpsJtQclIc0Tlcj020NB7P7Z3P+6PkpGwAJFyy2miS583IzCi1WnFPKeZbdmD
         tGUb7rujgeGxJDJEqKD17PNuUyVABCj/XkuJe14BKlhZOstQF91LASuA5iLM2bZJC3Ki
         4oNRfsSdB3Tin84EBjhl6y6KOy1Yyjg4XtXrKzqbVtyxcn/4DzdCRGGMBMlO8QjOGOF3
         2+w1SdCeihuNfkxXdqtK+zpRASpmMnb5LrJBQVzYqh1r8wDh5SDv5DWdJemqCHiOXdwk
         mWMA==
X-Forwarded-Encrypted: i=1; AJvYcCVU3rKjccIhlOE6I0vmaJhlaCMebuZdXKqLXKtuWLNfQihZBaJYXTTGmJ3Kk659bGD+FuiDSR80dGrikgg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0lwplehjHuL9diCIctPk/JDnwsChjm8O+aNTjtIxqsGoLGtWu
	6f4a+CUuNoNIezrd2O3WCmTnvZ9suj+is2T0IS9Jy3NGb6LPGjDLv2B/j0Eqd1PXqCE=
X-Gm-Gg: AeBDieujUm/O3vV3EeBKDFO7U5KEpY0sGKCsqqI4IPj2a9twkAZrihVrKVfzpBr8SsH
	Rha7JPtBr686Sn0hZT6OfyD35q5HphoBoLcgcVrnlyv4VhjAKdgq6XL4LIyjM7qBdSAM6kdRPbG
	3U+0GkX///oY6TriiAQvqgjpdatHlHKMWwL0z/6Hn8tXH+X1delV06FBSCxwm3f6j6qkpX8t5Or
	1BvRLqaKWKCqxXOLzFGtvcH6q5yu7JtaNIWofhE9jr+W4h2XkmpBrhL1DJm/WleyaPOMZcz24W8
	zgkLA1Ygb1kTwuoLGukUMBksyxQ9I/ghhBgF/n6VthzCByhCO9HJIvL8ngmk8uImA6tAAIg9r4i
	K9StstHKGPaZcsBeDZ6zlgefoBCLXe/4y3VGE4uKR7ieQzxpCF3jvbYBVA/wvyaFZ93DCdKW88y
	8sASpHz2HZAQgMWR4RrCkLCwkYDB0MuJxGH65WGhUax7Q=
X-Received: by 2002:a17:90b:52c7:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-35de69702cdmr7776655a91.24.1775393791575;
        Sun, 05 Apr 2026 05:56:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:31 -0700 (PDT)
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
Subject: [PATCH 29/49] mm: extract pfn_to_zone() helper
Date: Sun,  5 Apr 2026 20:52:20 +0800
Message-Id: <20260405125240.2558577-30-songmuchun@bytedance.com>
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

Extract pfn_to_zone() from sparse-vmemmap.c to mm_init.c and use it
in __init_page_from_nid(). This removes duplicated code for finding
the zone for a given PFN.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  1 +
 mm/mm_init.c        | 28 ++++++++++++++++------------
 mm/sparse-vmemmap.c | 14 --------------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 27c06250d6b8..b569d8309f4d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1350,6 +1350,7 @@ static inline bool deferred_pages_enabled(void)
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+struct zone *pfn_to_zone(unsigned long pfn, int nid);
 void init_deferred_page(unsigned long pfn, int nid);
 
 enum mminit_level {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index b47f65425bc1..e47d08b63154 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -687,24 +687,28 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
 	}
 }
 
+struct zone __meminit *pfn_to_zone(unsigned long pfn, int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (enum zone_type zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
+		struct zone *zone = &pgdat->node_zones[zone_type];
+
+		if (zone_spans_pfn(zone, pfn))
+			return zone;
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
 static void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 {
-	pg_data_t *pgdat;
-	int zid;
-
-	pgdat = NODE_DATA(nid);
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *zone = &pgdat->node_zones[zid];
-
-		if (zone_spans_pfn(zone, pfn))
-			break;
-	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	__init_single_page(pfn_to_page(pfn), pfn,
+			   zone_idx(pfn_to_zone(pfn, nid)), nid);
 
 	if (pageblock_aligned(pfn))
 		init_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d266bcf45b5c..9da49b0d03f0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -143,20 +143,6 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-static struct zone __meminit *pfn_to_zone(unsigned long pfn, int nid)
-{
-	pg_data_t *pgdat = NODE_DATA(nid);
-
-	for (enum zone_type zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		struct zone *zone = &pgdat->node_zones[zone_type];
-
-		if (zone_spans_pfn(zone, pfn))
-			return zone;
-	}
-
-	return NULL;
-}
-
 static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone);
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-- 
2.20.1


