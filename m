Return-Path: <linuxppc-dev+bounces-20908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F66ECD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJS3lqyz305P;
	Wed, 13 May 2026 23:22:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678536;
	cv=none; b=TKIHHL+yxUC1TZT1nihBFf0fj9c2cA//wV4AxKBAwdkCQNApoUbY2nDIxzM4FkOOWeZ8aQs6gIG5BemAu7bBfU5c3dQp/nJWShgUeuRO1WTFnbt9gw+yKURQbA36dBZt2AVQ3zSaORvW8U9Tr0393bzLLRgqfzZlRLbWd7g8TYXTWvuBYXQ2PxX+9s/2XzuXYH3bri9yeV/uMTYBDNek2d+alIFq0mjh74tOs2htCaC8f8ZMGCrYmKI4CFgGPmthzdVn8y4AL/Pqc82yKZKKSZt6diM3Y3aTFSBQadbjuu4f5xPXUwfM8lej8+4/kTOmdDDFCI5FpVJboL/eypU6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678536; c=relaxed/relaxed;
	bh=VZDeIIjrnNpMULL+G/A/MulBde5nkuD9M1+mQAv5l6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju/SQxEGsjWNYWbTr64cCm4LvDqzbW16N0bzYojBo+oBfTUmdpQwWX/hdwghDkWx6uOrWFgEJPAcQLGcdDtdpEaJVkVW+Ba+0gn3NVZ70Rl22JaOQ6bJkhw2qgQLmz3WIieOl8MnWad+2GYc0R8BRv7Fc8oNc7u84wSL09a0BuVjnEA44swdSoR90e+A7/8wMB0KNnAijUH00buzRSViEIjT6Z1NDN6VH/zeGoD30miGlI5PLK5QgxftqcA8wxlHSuAYIlk3pCvX77UyADm9KayIm46bUERb06BrY0qGHI3ucEKRPdinBlsF3u/dubnDUVZOFnehGNYJzG7CEkivfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K0NpTwA4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K0NpTwA4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJR6M2Bz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:15 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso2512271a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678534; x=1779283334; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZDeIIjrnNpMULL+G/A/MulBde5nkuD9M1+mQAv5l6w=;
        b=K0NpTwA4At24Ix47hm3dvI/JXZDZ64efpU9C5M9LVP5x4D6G02t1LylAv4Q+uYY//t
         l9m2dIg2kl3JLE2z3Jw0Uib9mKQDzWYKnUHlVnjGwLGvaagcR2sWe/sHJhJrqAtPa4+h
         YYDFHWDKVRfl+bwycLcUAgpvoWE19GfotO7VTuudOIXJ20rTxrMqrMBfkfj1pyGPbRGy
         MZ/IW0MDuXVQ9VQBy5ixzTGU0aATGe7R2jv7FWzquxEB0jrl9hYDNtpUeqG0v+VYVTJp
         KLslnUPWSvX7FkwjTscipw56t1j9FH8lxCcysqJu8vYqJ69wc7ciFxC6tX79AAQXPvBf
         jtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678534; x=1779283334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZDeIIjrnNpMULL+G/A/MulBde5nkuD9M1+mQAv5l6w=;
        b=mzpSADGTPubfWQD80bX0uOTwzlvY2V6lNgLAj/pjRqgFT+fzmDBEk21a4zCKCHsOyT
         MNVMODh5GDxRHEKAfUbT3DT/UCNJIdXcw3uzufc6NnSwR0lNjJTqIpkSqQjzvQVvovxF
         70rWOvUw3Z3ftDwQ+SHa19SUg22U+jn4cmE71RoVMatUaSaoYri/VcHDDnkrwLk3nTh2
         0YdZnz+YOWzmUCEljcuEIuwyMH3P/UrPVAKQR+Yb0AT/kDfHnshjd5pd1k7irRtYHABa
         bXFEenaZkSzOZpwE9ganhFHIycaIo72y62qhPpcpblzW2tu+Gf0VuoxLIfKP18fczteI
         sKKA==
X-Forwarded-Encrypted: i=1; AFNElJ83X64b+62zVHEEKxDM/DTXCtUAAdBcmS+Dw8hWS/+fjV2J6D1sz6vmgafWm+UIzfQ8CiAXQvdvi+pzf9Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxb24ikApJC0weyXA+Za/AtvL5DfMwPKJ/BsycSY+khajNCjmz8
	RrXSkyKIUFobBdze5Y3Ujmms5rQeySa/HYpwoB+W60eDWhtgN2YQi23XPPHCNLhz0dg=
X-Gm-Gg: Acq92OFeq6vbNTobx1FWgSivWJiFi7ZeBy2akr9kMMHo1jhqoqYmkbrhvy/0QMYrJNH
	L3E3Hyq5Frz0b1bCWTpSGI50ZtwZ+POHXwGA+ifoS+OCIbdg7R2H6QBrxmQAgu+MB5IIcdwWNlP
	18Gwmqx0Q38e0Q4ul3OfJiHwlc1P/lmvDQ9bH1StrMQ9fzr7x6dBIjD9MzLI9DGT7SWynC2yA1k
	AEUzNZow5jHG3/0fYW39BOc5iCvMrMBn8eIjzoydGjLXQJksIctJZSjSEo5oT4Y8qVp1ikTt55d
	fMdVRUXhXLcAdzu4V5aOkK3ZKGhHJPW6oxe3/tQgXAZTRczl58Y6JJ25pSvJwMe/Yaz9sPAsyrm
	XNn8uiL4FlIjlSqaIIw+xVQOF+UFwM5fg6/i068NqlPjj9B7n34Aaer/vTfw5T2/K0vSVnsYS4R
	7iHqHiPeXjtv9wpKXt5GW3HCeZDNCK2q1hV22VGS/AyqJq/iFVxU/avFKVowYo
X-Received: by 2002:a17:90b:43:b0:368:1064:62f7 with SMTP id 98e67ed59e1d1-368f77f6824mr3031213a91.6.1778678533741;
        Wed, 13 May 2026 06:22:13 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:13 -0700 (PDT)
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
Subject: [PATCH v2 59/69] mm/sparse-vmemmap: Localize init_compound_tail()
Date: Wed, 13 May 2026 21:20:24 +0800
Message-ID: <20260513132044.41690-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

init_compound_tail() is only used in mm/sparse-vmemmap.c, so there is no
need to keep it in mm/internal.h.

The helper is only used for SPARSEMEM_VMEMMAP_OPTIMIZATION, where passing
NULL as the compound head is valid. Keeping it visible outside makes that
usage look more generally applicable than it really is, which increases
the chance of misuse.

Move it into mm/sparse-vmemmap.c so the helper stays tied to the only
context where its NULL head argument is valid.

No functional change intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  9 ---------
 mm/sparse-vmemmap.c | 12 +++++++++++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index afdae79640b5..aff7cebb1da4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -907,15 +907,6 @@ static inline void prep_compound_tail(struct page *tail,
 	set_page_private(tail, 0);
 }
 
-static inline void init_compound_tail(struct page *tail,
-		const struct page *head, unsigned int order, struct zone *zone)
-{
-	atomic_set(&tail->_mapcount, -1);
-	set_page_node(tail, zone_to_nid(zone));
-	set_page_zone(tail, zone_idx(zone));
-	prep_compound_tail(tail, head, order);
-}
-
 void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 667424aadd6b..38777e4952e1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -265,6 +265,16 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
+static void init_compound_tail(struct page *page, unsigned int order, struct zone *zone)
+{
+	BUILD_BUG_ON(!IS_ENABLED(SPARSEMEM_VMEMMAP_OPTIMIZATION));
+
+	atomic_set(&page->_mapcount, -1);
+	set_page_node(page, zone_to_nid(zone));
+	set_page_zone(page, zone_idx(zone));
+	prep_compound_tail(page, NULL, order);
+}
+
 struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
 	void *addr;
@@ -286,7 +296,7 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		page = (struct page *)addr + i;
 		if (zone_is_zone_device(zone))
 			__SetPageReserved(page);
-		init_compound_tail(page, NULL, order, zone);
+		init_compound_tail(page, order, zone);
 	}
 
 	page = virt_to_page(addr);
-- 
2.54.0


