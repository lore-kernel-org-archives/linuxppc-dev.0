Return-Path: <linuxppc-dev+bounces-20849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8BDCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFtzf1GLGz2xn3;
	Wed, 13 May 2026 23:07:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677662;
	cv=none; b=VFkswSi2F4HiO1tftzZwpiHO4mYhxCSGmJYXMUn+XH1aRIrGb5odoIv7LtAWXvNz/6sA/YbJT5F0l0lolXnZ5mHv7voGCBpRh3cNyOttsGaV3mx5ZYy1/OpxzlcWS2/R7x2aAH+UZtWv5s5S1neQfPg3j1td3Bhj/9aUhAHLsTD1cuEEIHgsdRfJe8PBBQT4+TlhRCrcXthUaLe6jjAqk0XLY27x3Y1wWJF34whjX7VGSnxKOyireXm+N+WtM9MyCl0EbYJJtn9cQWRmRzc0egqiUyQ0itBSdlgu3x1JTprLbEg6EiXm3GGwqjD0xcB4WqL3Sj+NgPY42Qznd3PucA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677662; c=relaxed/relaxed;
	bh=glZCSgCcQPUR5mPOULt0p1weLkVndlFTk9nY8tD6isc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUbjP4/etSBpivwHHoGaNpZpCwaQMeooNwwRHh8jjBMNNuJQIJY0mA5ggxYt0OgXNvXTEKG3a6w9IvCBNayaaPgjV1RkdXsRFzMz2/DbTLFoBZMs21Ho/LNtcIGuCPNuqOvpNWYbKvkSX8HtCjJUKLxhx4ATiOgCjLRlMngoqWv5UgyrPJSLcbJ2WtTd8QKhf48xBQzf4xbqC9ZBrL5xSpHUBWsJKUzz+uFj2ne36nh2HX8JwiUdUmtUX7W2Kh30SeiLAz/JX4dydVwEEj9ihalMp5RZX5hBh+bjK9UmvmK1cYTCNpmjz03lcq6mQYsjza9J7GL3KNzD5ho+t38OdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S7KEWUMy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S7KEWUMy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFtzd2QhZz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:07:41 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2bcd3ac3307so19190005ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677659; x=1779282459; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glZCSgCcQPUR5mPOULt0p1weLkVndlFTk9nY8tD6isc=;
        b=S7KEWUMylbi26brgV/OM/s/2fS1esVFiYB9WLqdXpie6fUSCiazk0XkqwWlQ4G65Ax
         cUTX5q1hqCRGKw+4FHesMlSvbu6nT9DDDSnVqKxfEhjRfx3nu/tMDYgZHJyqyp9Rm81R
         BDQdTUgXQEla+/4RsStR/DhOqzkwDrzeJY9JkQXim0rQPPjIzDyvOoc9iepC17e7SA4M
         8oUUO78ez9Xjs4yvDdgCXPGVj3Uz7vIknNAGukmsYkHSPXtGlrvn/nIeDvddH5NdRAfh
         dHlW05seKs/fFyXH2tJIo/OxEL837SphTtQAK1xPW0lFwFgNRkmlKztwlWsH0d6iRW6n
         gfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677659; x=1779282459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glZCSgCcQPUR5mPOULt0p1weLkVndlFTk9nY8tD6isc=;
        b=J0eR7X1WlJD03UaPH6svmaTy0t5uFUrOhYpaWmFGf0IaeDJ7qv9iFCYeNk3UcAJJrw
         1U+ypPja5rhNg6sdzsOzElh2vmqQN6aF9h/1i/3/rIQg/V53kimbQ2g7TbyUYbIb22nQ
         v759VRZj3Vx3jNva0Qs9RrFsN51rOo5oRRwJP698l03cq+WuMDcGBbkWppKUQmbW7CAn
         uNY82aKwkQcu7lYvgMESXfHGI/B3nE2rL3r1pvdRpsMiyWTCa4EUOCgE0UF3DocWdpNx
         b6nX+1at0AukInjtM3eD8H0C+yBiFU3/ufvnHwF5WB1bxb4qvB5KOBTZbwOIYEVFQ5U3
         Kk7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8c7SWWlVRnqB4BhmVx9pf3WYO3lsnszBQfNWpBSwV8nbTpamI2u8fB92ntgV66v5GFfm6hgyB8BkhN+Uw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3sFXsHNSK3OvhqL5R+L0GATCBm3CQXaio61BUeqmL3Tcbtlhp
	XSE9IkzvQf/dG3IsmTMQQSB16vSK1XRKNzPxsPavAkLcm+jrJgx14nRAz6hZCqCiAwM=
X-Gm-Gg: Acq92OGMiKn1/X65eh+9r0xJYvqoxDpaRLaUOOGSgtcggn+WX3kBr0qfXzaZmrwWTw8
	WSPrS6z8/zn8jPXitjMf8eAZt9dhrfvSvo5ANzoqBf2aBbetkI+efzup/ADSEOzwVFmtwfDHAiw
	/h10xXKyjzXS8K+9SQuxtuDZJs8Xnmnf2nlamBwEh3lvrZhN2dI8OXYSltY442yTgs8DJomt21U
	6HZrDUCiMy7gvUasFkZ9nmiQzxuu8zWljAMM4NF0POJVJYGuUAkFUEqM+7KaeHdRe41ydgXFTgk
	QzmrppO7g2NixoVcXGclHoTuOKDzdbNVO+6nQQCia0AL2f9sABb50DANrEwAdh6734hDai6tkqK
	hgOd3AlTYWLYq4P1AvYdjapiqNLTJ2BtNasQogN1TNen063EDLv7SZdy+gbdGmGd+0FZNlPkASB
	EM47lYULDKy4zTC27k+0aZMTa6OWUrjkpVNROCJ8xHD5Y9xZtixQcCXE4wWDY=
X-Received: by 2002:a17:903:907:b0:2bc:e216:db47 with SMTP id d9443c01a7336-2bd2713c36cmr35966965ad.8.1778677658559;
        Wed, 13 May 2026 06:07:38 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:38 -0700 (PDT)
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
Subject: [PATCH v2 01/69] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
Date: Wed, 13 May 2026 21:04:29 +0800
Message-ID: <20260513130542.35604-2-songmuchun@bytedance.com>
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

Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].

Those shared tail pages were initialized in hugetlb_vmemmap_init(), but
bootmem HugeTLB folios are prepared earlier from gather_bootmem_prealloc().
With hugetlb_free_vmemmap=on, prep_and_add_bootmem_folios() can access
pageblock flags on bootmem HugeTLB pages whose mirrored tail struct pages
already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
get_pfnblock_bitmap_bitidx() then dereferences the still-uninitialized
shared tail page and can panic during boot.

Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), before
bootmem HugeTLB folios are processed, and drop the later initialization
from hugetlb_vmemmap_init().

This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
assertion is evaluated.

Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c | 17 -----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 31b34ca0f402..d22683ab30a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3382,6 +3382,25 @@ static void __init gather_bootmem_prealloc(void)
 		.max_threads	= num_node_state(N_MEMORY),
 		.numa_aware	= true,
 	};
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
+			struct page *tail, *p;
+			unsigned int order;
+
+			tail = zone->vmemmap_tails[i];
+			if (!tail)
+				continue;
+
+			order = i + VMEMMAP_TAIL_MIN_ORDER;
+			p = page_to_virt(tail);
+			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
+				init_compound_tail(p + j, NULL, order, zone);
+		}
+	}
+#endif
 
 	padata_do_multithreaded(&job);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4a077d231d3a..62e61af18c9a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -870,27 +870,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static int __init hugetlb_vmemmap_init(void)
 {
 	const struct hstate *h;
-	struct zone *zone;
 
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
-	for_each_zone(zone) {
-		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
-			struct page *tail, *p;
-			unsigned int order;
-
-			tail = zone->vmemmap_tails[i];
-			if (!tail)
-				continue;
-
-			order = i + VMEMMAP_TAIL_MIN_ORDER;
-			p = page_to_virt(tail);
-			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
-				init_compound_tail(p + j, NULL, order, zone);
-		}
-	}
-
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
 			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
-- 
2.54.0


