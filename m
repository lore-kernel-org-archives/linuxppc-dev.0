Return-Path: <linuxppc-dev+bounces-20881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B1CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2w1Gskz2xqn;
	Wed, 13 May 2026 23:10:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677832;
	cv=none; b=k8g7AY/zE0E9DHf/PAoGEvek4nibveJfiaBQm3F/KWbJqsnCcnA7H7Y7SvZV7l6z2UDGjrVExm8Gxhe4yvba/is+Z5DqFdsCXTzNyUl+f/et5WXq8Mgt6f5yo4rRIiLwz3bnffJYkMrLOr0uzBOdOE8c9bwHOpAc5ybAxa3hgGrpBj4DeILT7MVZcjt/WXtWT1iQ6j16LO3UyH03pjOWUKBW+5MGsMvwKeEdZng5ZgSxcdYZHnn/5IN15F4PPmJ/jrSVEAkcuWbRdbxJuDFe4ucC60bVH34Vjow3HbcoBi8/bKca+b2ECK+tvY2UvHLZVIgQxXUjBujPPxoZFD0aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677832; c=relaxed/relaxed;
	bh=u1XolciG0Jcg/XeXppdFYJHitey8LmRb9A3PbbH2+hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMqbl0khaFD1bP1uEy47UMiYNQpGRZ89NAomq0/1BGoQWaozhaeL/euFjzipttjmG1Q50X2591iiXbE6vN5fn+CSeKriwjgPns1JA3j/QLllCkUNIOYHxq5/p+ZkTre+r5TsN0GMHwB2uTTxA85y4ZLYsyr9ZuBwYoaVLab0H7l/CvGADOKP6sMMT11WoeKif+qe5KRyN9KK8MpGMoo5FPozmCC9mMyb2Zl2W6Qu89/L7vk63RFgCfrKjErpr2wThzvLgqh5i4pDpu8gLNNaJwGb+KvvyIz4WFrPtG4R5MS4dfFm/6cOyckuCsbkPm7bJA/ljqD5yQ62o8phygEddQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LYmNfEFG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LYmNfEFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2v3Ckfz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:31 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2baef9f5ecdso41265485ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677830; x=1779282630; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1XolciG0Jcg/XeXppdFYJHitey8LmRb9A3PbbH2+hw=;
        b=LYmNfEFGlt2GjGCWyZeEmCg7tu+eS/3ol7wtM+bj+yBbfYaLzM62RyhWOnHN1r1VXd
         qYjIokDjCHROZOHpCrIpcV3pEawW46Ew6F8GfSuAXtwxYgL5wiihllRpBZKN+fmna426
         elh/VQaKyIXNcz7DjafMsNgo0mEVvPd4zL4FpPZA3kQxqgei0EyJtcP3Zs2Oe+dj/Nj0
         yJBUWulbDuMeTX1saCQ8ZmlKiDNRK/JsVShvdE9HH4Ms7Cehp+RzyDbYMslpHC4tQn5x
         rW0c0JjNWcjmnK0GJHGmPMZAUmXl6Og77zrxqWGtG+zzuEW36NHTii5GOwpbEoHu4lL8
         aL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677830; x=1779282630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1XolciG0Jcg/XeXppdFYJHitey8LmRb9A3PbbH2+hw=;
        b=kcJ0DRlv+gCjeH+jcsRdjwpq8by/h7HUiHEpwY/LB9VtBPwNhTlyUhH/Y94MOdhXZq
         kdQ+R+oZqRm3K36mgMpZDVhqwaMg2IIxoNlNBmg1swUIg6k/GV1C3FqxGxi1p9qZDZvx
         /rtXJ/nfFMt5Md6SO6blkZ1ZKJ3TENgxsObukomD+hJHPZQ40SV8Tf9O6HO/xqnyzh+6
         nkw8lR83ERvfzF3RIM8iX1uMxMpYtRdp6B3QF5PZPOFn7TTsqHux5rgo9BtCZJYi9Nts
         cGJy0DrOoGhvRjvhqlsr/TEu7xZE6Qsp3NAWAO1TdyfoZh3NCg86ao3SGYRyyKSd3nGe
         umoQ==
X-Forwarded-Encrypted: i=1; AFNElJ++ygFyvvd5oMq5qInGvd+Js0gJq7CRmF6/k37AWQn3DZeDOU3C8bNYVBrkHG3uMUnart1Vg+flqfyLmhE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyORnh5uCATbr55IaVI2Coz0g7Qnrkqg1YiQtqgmxShwpfL8tdq
	4ZdoHIu/fnq6caOclwHNcEVXoeMeb6bHwQepFtokvi+BUS4/SmcDYmp4ucNGi7Wnwvo=
X-Gm-Gg: Acq92OHR5/Pc+cagD793x6djEURWYOIToSKVq6YxXsdfYZI98zTcwNuzm3ZbBWNujzi
	jULq3ztO0I/8cfEk9Y/afgq65fzrWyRd1qczLeQu7qTRRNyHmehvsUKRN2+OOjCsdW5DQQ2MYRo
	MwFWKQwWDhNh3EXCWXm2Sq6kflLjcf85RgfTPi0hyhm6wM5hg8dpMwgLlyKaJm658uBEBzseVKr
	VgrZZLqEN8wl08KP+AHsHCa/wgTtL8E2XWh4dM5FSyBCCONNv1fTW6K4uAqhSHWcCbrE2UyFBhk
	z1GHsIJWcyegY3Cv3Z67LgQZHWl0KSzUT4xgNFGTydiK9wIY4YMT0TUA3mncdNUYBlHJuuRpoWT
	RYWEyjKuaRmvJ3Su4BJNx8CERyBNZ9n8EEtI63BhUdB4bh2CHvbPpqCOt2viFa6SZTqi1s3LIbb
	IqAlC6BdsKsvg5QOxdF5m24gL+4nnCFtfc6z7EoDcIsKOK0tjVP1k3d92uM8U=
X-Received: by 2002:a17:903:17c6:b0:2bc:8f62:990b with SMTP id d9443c01a7336-2bd2773e38fmr35514035ad.41.1778677829549;
        Wed, 13 May 2026 06:10:29 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:29 -0700 (PDT)
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
Subject: [PATCH v2 32/69] mm/mm_init: Factor out pfn_to_zone() as a shared helper
Date: Wed, 13 May 2026 21:05:00 +0800
Message-ID: <20260513130542.35604-33-songmuchun@bytedance.com>
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

pfn_to_zone() in sparse-vmemmap.c duplicates the zone lookup logic in
__init_page_from_nid().

Move it to mm_init.c, declare it in mm/internal.h, and reuse it from
__init_page_from_nid() instead of open-coding the zone walk there.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  1 +
 mm/mm_init.c        | 28 ++++++++++++++++------------
 mm/sparse-vmemmap.c | 14 --------------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bf30617c78d8..18276cd15622 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1354,6 +1354,7 @@ static inline bool deferred_pages_enabled(void)
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+struct zone *pfn_to_zone(unsigned long pfn, int nid);
 void init_deferred_page(unsigned long pfn, int nid);
 
 enum mminit_level {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6723c604eefd..35c99e5c215c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -686,25 +686,29 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
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
+	struct zone *zone = pfn_to_zone(pfn, nid);
 
+	__init_single_page(pfn_to_page(pfn), pfn, zone_idx(zone), nid);
 	if (pageblock_aligned(pfn)) {
 		enum migratetype mt =
 			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b86634903fc0..f1c3b2d0f23c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -138,20 +138,6 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
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
2.54.0


