Return-Path: <linuxppc-dev+bounces-22540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05C8CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Q74sDMz3c7j;
	Fri, 12 Jun 2026 14:00:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236815;
	cv=none; b=ZPnkek8uTbKGnpl8Vk45VG1c3JT15Dryj33/Lmnv4hDW3fUCThNYKSHUxjxxHssi+kZ7mcIKQ5W+gpG8pJ8+pr+YTCwWug9QDk4FxBTf9YVUxYwJ+Uv/jwWupjyI3W8mjqwXvbDuUkJFoI/YxK+aa5Usir+3Hf/tGhEWPW/bI7VjhZ6I4IqzE4VYSw3ZzQ/Ga4mpzYbGBZonCKMQY7rGUyzIWLs/4wh4CxL+3mQ85Fjrtg0dKjDoUq5k/2JDaWhN3lRYXAxuQa02bkcOhFkhxFcx8dFkzzsmxathvwUo8QPtps7RvQ7MLy9b4yP+dx4wv2DHY8aNhMP2QsdrTGAh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236815; c=relaxed/relaxed;
	bh=Mz1pkfZLBXPZiMkWew4YPl94Bxp7XZrjgH0nwtCkmEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n88ZL7b67/YEe/7e2HDxQNeyJhCG3YpHogzEQMdIep1r4Mf+z/dcM7qU+bn6n8m7iCvGYQsRuyHs6ekEJfGgl8YVXJBpc0iuM2kdCPL/ZM4yyXxwTJ5akyTJdyVaPiBV7DbPhpHNeXYpL0D5+L8lAbk593eb32cI9MnnykvFECUCFdxRB78kFPIHFTnSTe/OLdQIkjVBtXyMkEUnqgWTI2yVGEzMP3Vy+le/0csIU4R0/ywQflT+0WI4qToaeJV9x4/uma//87+SaZc/cGNE3IzOMzFOvi+m1ljDsYXyco4D9gTM3TEKyd3L7aUIa9W/lhBBEXKf7e1SbzzJN5rceA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cYFYtTIp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cYFYtTIp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Q63MbBz3c7M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:14 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso353317a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236812; x=1781841612; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz1pkfZLBXPZiMkWew4YPl94Bxp7XZrjgH0nwtCkmEk=;
        b=cYFYtTIp03cKhBrq5P9JO3oaetEclYCzIHerwiQKfIftLgFJOfLadvO103JW4SZ42G
         tsJA1ktyFSn35M/4Zql17nzJNpbUDL/RqdfI34IDs3Mh6JQCTxt9dMD5+zZZvi0UHiVP
         E29ajkWXG2zBa8Y5xZo8da7i7dV97g3jXaYgeKIML5d8N8pbpti6mpCkBNqA5AdA4DmV
         Ek6bpRparsQ0QAAlPMFAphwfwUqjPLLfSQOLj2Waie1q3Uh3BIHIQwcFQF7QxzZ3oPRx
         lZGDp31vrmWdVW3vnXOsCrRb855PterSyNjYa0q9s87KuBlO+luNVgY0VZK275r3a77Q
         cj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236812; x=1781841612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mz1pkfZLBXPZiMkWew4YPl94Bxp7XZrjgH0nwtCkmEk=;
        b=PJ/yVOZogV84OJpXPFHlmzCnTw1j30aAjVgB+sr8r6KlUwc3iEjeA3zHgUoheiT0Hu
         HWX0fVY6uFRmeIF0eQfIAtoIVpEDUKcRTdfv7enb4cyD6wzasclpeQjLYSBq3yPIwHfj
         MYSV4gsOroSPIGqVHmU0misBt2k3P6sfVY9g6LNXk83RB3t0GcO1Q2U25k2/3jBF2T/u
         Yf3zVLQ9kzBkhhPR5849uo9q5D5gxXy1Tdet/bI0bmdnc6F1bTQdAYco2Si74LC9265a
         /ihsOENng+q0ldzYvwimQkkXGz28fisbo0scmMErTSH66Hqiwe4CtutWBhtrtKiGKJMd
         23pw==
X-Forwarded-Encrypted: i=1; AFNElJ9iMgXIQDxkW71m/OuU62mZhNjQ8Dk0nerDAy6yzc0kEPwtrniwN7G7K/XGuWyJIYbNYg9A+SEmdxiJYio=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw14UkbmnRJA1M6Q91J3owOf3inXzw02r24cb3Atsb+4OmiNk6u
	CEzLW34TcEOuJ0+CJLLrttj2npwzilQ+rsuYaGsHYJs08C5I3O1lK8PfKRqWavWKhXHAZJxY7s2
	qptCue/+NRA==
X-Gm-Gg: Acq92OHumaeJweVPCLX2bbnh7DB1qzoQ4VHPAIzDKC+xyGLNuM4WtS30L2APku1QQdT
	ISy8aq+6T0CxpEcsKUpqk+TtSFuUq7MEAM3Pdrj+/0dEW/KGsnSRsDwCsvFLpk293cUUxmkzDTo
	Ulfarjn7hx3mM+RhtZ43tixb2xbrPGxKM6W5FXJpg4iHy3VUsh2SdBn6So2/7H0jxXgXW+sBAWq
	38IOgRsh8jYLhw1iverQscG+7tGh2OHLmwvYu1eLhtUZt/OETjs0t95mHmicYlRgDCfstJ/YDuJ
	BYXl+H4nQy/6rW0k3IiyYBSZ0cvHHGISx6IhKBV8X8sLKxnU63kUGQvW6J4iuFAZqk2mM7nHGVV
	jmuy8XRtj780Zntv7abTjga3xirA2QD/p0/+dheeRdJWuJn5uWJG8XzY1xK/G2C88dOwysASy+o
	7E7q0hr0bCqk1OIk7oLLDymqJ55T+9n4asfsaix/Pf7xc=
X-Received: by 2002:a05:6a00:228f:b0:842:46a6:e2db with SMTP id d2e1a72fcca58-8434cd377f0mr1142768b3a.19.1781236811996;
        Thu, 11 Jun 2026 21:00:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:11 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 12/19] mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
Date: Fri, 12 Jun 2026 11:58:56 +0800
Message-ID: <20260612035903.2468601-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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
Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>
---
 mm/cma.c         | 3 ++-
 mm/hugetlb_cma.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a13ce4999b39..31073738f2ac 100644
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
index 39344d6c78d8..ce999391cc14 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -231,9 +231,11 @@ void __init hugetlb_cma_reserve(void)
 		res = cma_declare_contiguous_multi(size, gigantic_page_size,
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


