Return-Path: <linuxppc-dev+bounces-20867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C2CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:09:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1R1pdQz2ySD;
	Wed, 13 May 2026 23:09:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677755;
	cv=none; b=DNbh+5xhzP+xlU39BC2/S1TK91fubs1/1LJE+nSMiX5E0to/0CSXAF5HxOCrKtUgJT5W2UlqBbT7mlqvu0uZdd7tQguqqBydDCyk3V2o07PFyCmqKgmEZupWH3bz+Fu7+0oIXEJ7l1N2flUjKPEd/Hy06v8mbGCukKsbF8FR5sHUd4BOzlKgeyIhpV2JNZimdSEdhS3fy2IsiXrSjnmUbmGkq5PqRzA7QAC4gUDlq5bzUBwGRHjTNQVshQ5g+ByLWKaZ2LtXTXP7NTrphfke4yLpMdl83OyMelBh06IXecLUPnVmtSsJf06NS8k3lQk3DIXH70zNvGOLBaH1UzLUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677755; c=relaxed/relaxed;
	bh=QXUIDcJ+Gk/7y1fx1IgYV+5y2e2wzxCiGEVbnTW1zss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQb5QSbU6tZw6C+yqIkSkI9abcj6XUDIXsaYqJsfPd0rPfezLQYjjBPwDhRyVtWcuK2PxxyOz6dsyOWhMZoDbKgtiq8Y7YqnjmrwsboQoumGFoQI9ej2lJu2gbvL55Etl9vMqL7Ku7YIrBzaNN0U5l5EVbgK42dTvPrSyEMqN9QbPU/h4jy7sU+m0r8K+tv6Bk7nHdK0D7I9IPHeh4NuFTcfmrfDp1lUn5Y15Cud1//Hjcb4uxsr723bcFEZhedaqFogxsj6rDno1nTp4Y69+bvvSbqzSZxiOiu54irk3zPV0W91lruIfyqRX4aJwnYvPNiJtBB5XlhEh2Tl7XCU6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QTkd1pru; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QTkd1pru;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1Q2HcPz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:14 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2b4583f0a1aso44250175ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677752; x=1779282552; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXUIDcJ+Gk/7y1fx1IgYV+5y2e2wzxCiGEVbnTW1zss=;
        b=QTkd1pruIKx0yLD+yh4hfT/IwCIkeAebuI/gD0GVpJ0362iXQ9o9ovdlo2i4cnXQSn
         Nhia+kHVosTbrimHWCfKaswBYwCRkt90iDY3aTY2wxVdZLI2StNxs8WB7VANhf5MZ1+T
         K978Vmj2z9u4guuAd0yvrOHwkqFhvteVtj3uACCThtzJ/dXTlaUCm0QulIBia0BUnCVX
         1EcRjJeWiMUOa8GShppFgLdzjwfOo5CKLQXQgMCSl9csja5yfFwfObt2cjP03ynHZml/
         BVu8OmbOKMDwl0SXEg9H7eGLkTTeY+CQTGVOUVKp7RRAvOjXBBbfYVVDHw7KX+s8pmh0
         EuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677752; x=1779282552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXUIDcJ+Gk/7y1fx1IgYV+5y2e2wzxCiGEVbnTW1zss=;
        b=GF9ShFzUe3+ar/ceuurIPO//tXd4rzXUAM6Smzj1L9NbI5/XEmUI85ijVJIq62JoPW
         cvGjAkJX3RnyRoEnUEK2c6OmkH72zkVwvnQO/vU8zRqfjcr7v8uCP5CnNwV4oLOQ9UbM
         DERDJXtgzN1Rl7pXpIcjbDK4hMrqHbxAbr2VEZMsyOUcMkyz//otojlXlgQwUEA94RJc
         /zOVqTi2Pw2hH6nEkhnFq/s3tQLdKOO4FsEEnLs7bzHYUckqen721NbbsDlcg/bKvb/R
         /odpncHWSc2GDrsWTRY46HmF588stHPM/qZkaT+7511xc0odIbs5T3OI6d/XjRqD6DGu
         dTxw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ux3NVK0lqhXtgh4lPDOejMsrNARNNcY7C/FNw6/UCxuHWRvCCjya3FeV2gfse/AuG4TWkxfp+A9vEd6U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOlQ1uNytVJxDQ+PcdKO8yRlOib18PvV+zwJnxl/5Bq1Ma2BnO
	bZ/BTrJNIzZByGFptGcc0B7TQtuILw2rkjmeOUejJUA/i+XQt9u6YwB8bqsXJG15pZY=
X-Gm-Gg: Acq92OERN/zH1P7BhNfNF+GTHUheND4fUzO+wQQrXhPVloaTi7He0STCrbrl2D78/Uy
	0bOIbuH2SEI6Dv3GjMyO7jncF7OMJHGyp4ym1iA7mOlHwvvmnYbNo6Yk0Yfmyap2Q4fQ59v3UcU
	hsh3L7+h0YNy4/K7b7n7GCW9OKQU5Uox8ipoZbW5axq9qRb68y0yTiznblBAq21tAKowXrBXFfY
	yn82FrujZDgaa8SZrYkRIYhZ5iEqZdDR+7cGvJGF6Evmj/1VPC1bTe29ex8SETxd3WooEQ2tXcx
	5DkS7Zqw0CJP/5TZ+g9W/W5PL6D3Tqjp1ur/0sbr0otFsVL8+X7fJiZ0Sn1bIpnPVlRVU31nFZ5
	0CRUeU3ejg0QB6XDkvkQKCLT53GIqBcFDzgT1I5byEhAXXKcPkcpHqf7RzK1/9tPw85KSc6/m9s
	PH/zHpfAcUFfz4vV7dKmhm/ltkxb1n32tR96gVB1bZ2SfgyP+97WtMXY0dvzk=
X-Received: by 2002:a17:902:7d88:b0:2ae:54b2:27c7 with SMTP id d9443c01a7336-2bd2772c78bmr26046865ad.39.1778677752045;
        Wed, 13 May 2026 06:09:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:11 -0700 (PDT)
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
Subject: [PATCH v2 18/69] mm/hugetlb: Remove unused bootmem cma field
Date: Wed, 13 May 2026 21:04:46 +0800
Message-ID: <20260513130542.35604-19-songmuchun@bytedance.com>
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

struct huge_bootmem_page no longer needs to keep the CMA pointer. The
bootmem path only needs to remember whether a huge page came from CMA,
which is already encoded in the flags field.

Set HUGE_BOOTMEM_CMA when the page is allocated and drop the unused cma
field together with the redundant assignments.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  1 -
 mm/hugetlb.c            |  5 +----
 mm/hugetlb_cma.c        | 27 ++++++++++-----------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ece4e6a4a4c6..fd901bb3630c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -694,7 +694,6 @@ struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
 	unsigned long flags;
-	struct cma *cma;
 };
 
 #define HUGE_BOOTMEM_HVO		0x0001
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dcf8e09ec6be..1f0a0e31d624 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3093,10 +3093,7 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	 */
 	INIT_LIST_HEAD(&m->list);
 	m->hstate = h;
-	if (!hugetlb_early_cma(h)) {
-		m->cma = NULL;
-		m->flags = 0;
-	}
+	m->flags = hugetlb_early_cma(h) ? HUGE_BOOTMEM_CMA : 0;
 
 	/* CMA pages: zone-crossing is validated in hugetlb_cma_reserve(). */
 	if (!hugetlb_early_cma(h) &&
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 6b5c2aec4449..fbe5ed7ffaa7 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -65,26 +65,19 @@ hugetlb_cma_alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 
 	cma = hugetlb_cma[nid];
 	m = cma_reserve_early(cma, huge_page_size(h));
-	if (!m) {
-		if (node_exact)
-			return NULL;
+	if (m || node_exact)
+		return m;
 
-		for_each_node_mask(node, hugetlb_bootmem_nodes) {
-			cma = hugetlb_cma[node];
-			if (!cma || node == nid)
-				continue;
-			m = cma_reserve_early(cma, huge_page_size(h));
-			if (m)
-				break;
-		}
-	}
-
-	if (m) {
-		m->flags = HUGE_BOOTMEM_CMA;
-		m->cma = cma;
+	for_each_node_mask(node, hugetlb_bootmem_nodes) {
+		cma = hugetlb_cma[node];
+		if (!cma || node == nid)
+			continue;
+		m = cma_reserve_early(cma, huge_page_size(h));
+		if (m)
+			return m;
 	}
 
-	return m;
+	return NULL;
 }
 
 static int __init cmdline_parse_hugetlb_cma(char *p)
-- 
2.54.0


