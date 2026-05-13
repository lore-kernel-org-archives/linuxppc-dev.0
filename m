Return-Path: <linuxppc-dev+bounces-20861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94595CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0n6Sxqz2yLH;
	Wed, 13 May 2026 23:08:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677721;
	cv=none; b=aQh6u+T9Sqa/suCIyp6HNdNWso0fNqx3oAS1UDLsumKMriGtjX0MQjjJ57EAe8cEsKpk7w3TrpG1JQQ/OSs6mJ8O3/nYCRKbmCsMmESBWQkvb8MQe8DJh2vPdgcRMdarLtil0rys9n16sOZh9HU1neoKl2rfV+4ZlaqMGhQRTWY0Pl7Wl1CJQ1izeJ2/JKxxidJsKwzkms8dBHMhEmG10bt8E5Mew9h9Nld3x4hk58EC6azxpjpxU0hLv1+ka79Nrqq6RHN8PqJw3QWxFB+54LjJgTJ5pzYbf9s+UZCVu83w5c/KdQ4l1V2EZDeEmU9CQ/f4fc4HorIfzf5m216+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677721; c=relaxed/relaxed;
	bh=ryF8YQ2n+wDSXZLLv2wjofP7Z1dSt9c7zUzJLRCYPQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUp+u2DSnjd2pRGc9UjiXX1TBhn+E06PmeK6koMpveNjm5zrG/Nw3urdnFIW/xwqCodTyCE4j/YMG+MYca41gzb/fo0Sa/klVl41+6fyvcBKae9ysYvUpsrzBFNsWsCNxgvjRreHWe1m39kREIfes9xn1aLzhg5/qy0diB/D43sGSBP5gV0F+j23pPs1Ml7uJfqbID+5TytH9w8+TfZ3tJ12k6HY1oJB4vlDTYupyfKYmGSn5yuN6SwdrjYTyi6Efd50s0NZmIKqWXc5+tYgrgedMnglfZvcxWpQwoRgF7fSco741xjlqblKFylcsLw4YYB9NLNlWzNd9dhq6ptnUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TVSV1DI9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TVSV1DI9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0n1nxHz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:41 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2bd2c147abaso5474745ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677719; x=1779282519; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryF8YQ2n+wDSXZLLv2wjofP7Z1dSt9c7zUzJLRCYPQ4=;
        b=TVSV1DI9bTRSzQwJy0jHTxysiEZT30hwOoi1V49fZw+LDMYpMo/LlrdGwpTMszxYRA
         UECPHSQBsiIYnWKaV+yZOqdorGA5Kt/xgaNpcALBPgph4z42wA6/k8SqxPAUnjZrEreg
         tkRTjOZyHN+UMqVt62FnRXJ6SAx/9EuXyqhQeAmocdKtay9DAytsayW8jvJEBoK/FD1i
         dVLPVskXCguaru2wU8hvoj5Uj6AFlmdvCcoH9lMjN1Zr8ldo+c0s5C1Sm7K3Qu9wWdPH
         6VUfvpe72NEImn/lWyU6NUDm9QvKNw2qWSYUjnMyKjaf0MbfxbknoslWGonXE/4eNaDX
         OLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677719; x=1779282519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryF8YQ2n+wDSXZLLv2wjofP7Z1dSt9c7zUzJLRCYPQ4=;
        b=bkAkEEijsiUBZldnfgMrlbGFGoexPFCOn5ru2R0BZgMLeTJm6u76BO6edsRKAnXqVH
         tUFPn2uA6qEhtjjGvrD5j+2YxHJ/PIz8fCzugV3j9GZF915nAG+7eubxyXMvFdEuVnOA
         t6Xd47PDhF9zcgglTHnnisOG3E9LvnKNYcxEItxa+VHaEBrFMnlN4W0ZneSP3w9nH/Ro
         ElEA25KUY3B6hzH/MNw/ouU2jNMmIb+/tqD2t/KsTXnSBcbX9qmmcNz3UkxHAL40Van1
         hKha1MgFwTaHcoVffxXG2tufoVC95vO6tapYXPNC/J7mTECYgjBxH6ffNUiJ+/tvqMDx
         Ag9g==
X-Forwarded-Encrypted: i=1; AFNElJ+7byXYf82AwwKjkhC++tRszwBlCq4nE3ijuZyZOHAbZ9ZJQ+usoJYyW8XHjCujNbNdnkNCFVbGFbFkJgg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4ZnepAiyNqjFXmUv1xyBBS4S59uRKKQLUymk10mHyvY964FLq
	gML5/FtckfaleGjj5EZqD/IYIzBpZARjJupTMUT9mbrW+E1KN2KaTIkwRX6Qrgx1REk=
X-Gm-Gg: Acq92OHcy+mKmUf68OdIWN6GP5vZ02WlbZ5CvaelPmrUJzvW3juuCW4PFhdAOfiv+//
	2cwsmWeWwBvTepoBzXjufX6UD1c8qfGQpq93L35k7T1Q68T8cf04sYwuYUcrmhKMrdrdGj6thp+
	ZwR5OgLQM7U3MdG+YN32AJYrMIMzMwQgprQcu6jR7UtUS5ZmgGvDQjjDv1rVITBW7cnevbp/E8u
	+/JS5/PIaJn5pO+gDlI1tVAWoGyLfCVbp35rFF5pLzdLjaaV6ARb53E/pWvhWiePgIwzLVl5NXe
	YHvLyIh2q3c/l9jBknMjU1XnjssfszPf4RgaWEKpGH8gA0QBmJ5LA1H+ABZDsmfIMXr0nBGDJiH
	7F6KXiwldVZfpVIg8zoBYGrCaOt8vneHsCOpgBWkWNCRmVwExjzTjGT9z1e+hm3ttFBIlWUVIDC
	9NgrrO8JkIx6kBhK9So7iNFSlE30Q8KOZ6b9hGPo6hnghsUNSq6TigbbhWDNM=
X-Received: by 2002:a17:902:8601:b0:2ba:839e:15cb with SMTP id d9443c01a7336-2bd275cd01amr24527775ad.27.1778677718942;
        Wed, 13 May 2026 06:08:38 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:38 -0700 (PDT)
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
Subject: [PATCH v2 12/69] mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
Date: Wed, 13 May 2026 21:04:40 +0800
Message-ID: <20260513130542.35604-13-songmuchun@bytedance.com>
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

Hugetlb CMA allocation currently has to cope with CMA areas that span
multiple zones.

Validate the reserved CMA range up front in hugetlb_cma_reserve() so
later hugetlb CMA allocations can assume a zone-consistent area.

Also drop the pfn_valid() check from cma_validate_zones(). mem_section
is not fully initialized at this point, so the check can trigger false
warnings. Keep the sanity check in cma_activate_area() instead.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v1->v2:
- Update the warning message for zone validation failures
- Add Acked-by from Mike Rapoport
---
 mm/cma.c         | 3 ++-
 mm/hugetlb_cma.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..0369f04c7ba5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -126,7 +126,6 @@ bool cma_validate_zones(struct cma *cma)
 		 * to be in the same zone. Simplify by forcing the entire
 		 * CMA resv range to be in the same zone.
 		 */
-		WARN_ON_ONCE(!pfn_valid(base_pfn));
 		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
 			set_bit(CMA_ZONES_INVALID, &cma->flags);
 			return false;
@@ -165,6 +164,8 @@ static void __init cma_activate_area(struct cma *cma)
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
 		}
 
+		WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
+
 		for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 7693ccefd0c6..57a7b3acc758 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -234,9 +234,11 @@ void __init hugetlb_cma_reserve(void)
 		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
 					HUGETLB_PAGE_ORDER, name,
 					&hugetlb_cma[nid], nid);
-		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
+		if (res || !cma_validate_zones(hugetlb_cma[nid])) {
+			pr_warn("hugetlb_cma: %s: err %d, node %d\n",
+				res ? "reservation failed" : "reserved area spans zones",
 				res, nid);
+			hugetlb_cma[nid] = NULL;
 			continue;
 		}
 
-- 
2.54.0


