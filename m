Return-Path: <linuxppc-dev+bounces-27471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AD2C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:36:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlC0r4FFjz2y2W;
	Wed, 16 Sep 2026 18:36:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789547804;
	cv=none; b=hCVU4fCdzw04f/w1rs7530MI8ihGuykGaKN6VkiPt4FD6Ka12vxshuSwtSsXKsiXHgmS9SW0j01gZcqBdwi8VYlPVtcTkgAvDzd8u04ZtrlROUwfqGpICG+/tCVT/ZoYl74zxRGEs21sOQk/5zsL+PmmWXSUtrj1xnLzNARfmZ1mOqA9/k1NJpHQ2KwXSdCkFGNIHi2GV5DEGs/3WUzJO+JopouoTgoXoH9yWnSAuvpiSnZOuqLjqlkbGXDLWEUr2EOAppI3sO5qFmyoofU3Vt2394me5XwzS2+Ehj6I5+4HG3uvjVmrHDIchLVa1dYoyMLA8qtYID8tbonfgESLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789547804; c=relaxed/relaxed;
	bh=/Ky/jym2qeoiedQ+4uP+uRv23sKBrOXkwKGv1IN5HSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhcsKvpFpUaS4kx3AEmQ58l64JYRUI2nUGltxsVzyEscM7MiesTIR+AASExPdEGSWlWxPP8e3RU2FP3KG8VUEiLdmWBDcQ4s4m3EWHchgw2Wy/DG4Y1eRPiwCkWFg0HBVe6/ruAtxb790BvFrBbTJBZjeq8BqI7m0UDFffYujRASNJ8uhzlysNMNE6/spYcWUG7IrDSX9OLoiLCMeNWm6faW/3LxEPoReifD0CqihpgAJ+cLC72Kri6uKPpF6cnuD1PkITTbJCy1eE3fzA4BDWYt4kE448OcxQHT8rDPknPAy8TZlvt2aBGa/zL/pgGIloEX2ktSdx38K1c0fGbE/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EJ4cRbBx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EJ4cRbBx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlC0p0vbKz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 18:36:40 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id d9443c01a7336-2d747ed6d6eso5583055ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789547798; x=1790152598; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Ky/jym2qeoiedQ+4uP+uRv23sKBrOXkwKGv1IN5HSI=;
        b=EJ4cRbBxmNRTYIa9pCjHPi/FmRK0KWdYKiAZaGs51DgrcUjb9GLBXdwt5uzTB/eHcV
         dDPFiK28WK2kB1Q9vil3hj7qNi1W0SZOxHd06yLqQXijVNynOPQG7tOBBzbLlQH6jzpa
         h7u6jF4YaVrdBERl2xTRk/cwk6Jb/IuscW16JCW2kuct6hd+ktv21oOjrffcb5fA6PWY
         lrRUgcWXRCtXxOBMyKWLirrEquxSNdh1bgm7tvMRjPcaNYQGCBeQBgO+Ip95odw3ESAC
         q6+jEE5lzjplBqwHGpijUylVDI8DyP6aZ40Q1gw0vsN/i74gGSTyz5rKCOV+0HrdOERg
         IgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789547798; x=1790152598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Ky/jym2qeoiedQ+4uP+uRv23sKBrOXkwKGv1IN5HSI=;
        b=gwhmPNUg+QGy2D2wFdwvTLvmMtI+qAvXEUSt/9clsM4KzrRn9TIlU6evQB9FAb3Bpa
         9npitdZWmRqkb+jUPHrBTVSRKE3vZ5FUaGKxY5CBb5bGIA77kU07VZOH4gj8MUgVUM0j
         GVdz1W872nxAomHTx8Tly5MoTZmSZZkVgVAxODcGkNHWXUXNmpz02dcVQZH8GhuJrYsX
         iSnFA7gommjUv6Eup7RlNx8N+cH2nGxFOVczot0YCbhb5IF/HnwiFxyJ2JScQGxl3QZp
         Go6BnkoPnhFDWrMijLb5Fr4UExVAgs3lHkhyMfH8ODT9A3wtAnNthbeEQdcdQFGmyOk5
         3C9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxonmFRT5Wx6qReQVwix2+WTLXh3MiX3VbwsXg3WbwuPfq09gtIedGANby+UnKOTC5iXBIy8X9G10zXDY8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mAZN75l72VrlOaDFCtOZo22dKMl3C6Uk2coFmY75bOJghV6o2j
	WeCG+bo7SmG1b++C8hyx3rEr8nW7jpSCrETa/yeGSlVeRmtxdEGAJkfABK4grjiPvjs=
X-Gm-Gg: AYBFou1oxeZ/Lt7mguVTj0A65d/cFdMa7by4PpASw45CpGc2EbH/xZK35HWPt4jbIuM
	mLzL8C6wEWj1Wc4XLI6eOokXwxra5SXFFNoP7r4MYOeyoYsz5epEwRoWHTpN8NZz1etdJxH6+PZ
	ymU7t+gtfvqijQBKq5P/6fQlucHfT9OmJKZc//g3SIX+nqHESLQPZURu83ux7H9/JY1a159N+Tj
	cPFIBhHTtFNI21Sf6UUTtcgX7KBQq8euZiGI6HekN3+bLFYvxQofglhbcKjl/ItNc0aVFkxVVUq
	l3l1l52VQ4hWXZ/IJHqHPjIXhXOIHHeqZDuBUXcGp7s9NdQc9CcPsK05iqGbLpNm/CHUTlBEcsf
	CA5XZoHz5mVP65GTgnFrLywEptRiLLEhxgmUCJdwkoCCa97TLbwq6xDTJU+Gwy2B0C47+sm4G4k
	sA3kbOKdN18NYPQWO9AEhsErce9zuzVTK75ySbJUQEq7aVXTezB4lNW+MYeduUeI2yU/HmRjUVd
	pNa1GDpp2migHaszR3N
X-Received: by 2002:a17:903:ac4:b0:2db:63cb:1b17 with SMTP id d9443c01a7336-2dd8e633554mr35455145ad.18.1789547797988;
        Wed, 16 Sep 2026 01:36:37 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d9007csm7646915ad.5.2026.09.16.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:36:37 -0700 (PDT)
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
Subject: [PATCH] fixup! mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
Date: Wed, 16 Sep 2026 16:36:27 +0800
Message-ID: <20260916083627.2145779-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-2-songmuchun@bytedance.com>
References: <20260916064341.1825793-2-songmuchun@bytedance.com>
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

The section-based vmemmap optimization infrastructure is guarded by
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, but it can also be used by
ZONE_DEVICE users that set dev_pagemap::vmemmap_shift. Introduce
CONFIG_VMEMMAP_OPTIMIZATION as a common config for the shared
infrastructure.

Select the new option from HUGETLB_PAGE_OPTIMIZE_VMEMMAP and from
ZONE_DEVICE when the architecture opts in to DAX vmemmap optimization,
and use it to guard the generic sparse-vmemmap state and helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Note: When folding this fix into
"mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION",
please use this commit message for the resulting patch.

v5:
- Select VMEMMAP_OPTIMIZATION from ZONE_DEVICE instead of DEV_DAX,
  covering all users of dev_pagemap::vmemmap_shift, reported by
  Sashiko.
- Drop the DEV_DAX dependency on ZONE_DEVICE added in v2, as it is
  no longer needed by this patch.

v4:
- Rename SPARSEMEM_VMEMMAP_OPTIMIZATION to VMEMMAP_OPTIMIZATION
  (suggested by Mike Rapoport)
- Collect Acked-by from Mike Rapoport

v2:
- Fix SPARSEMEM_VMEMMAP_OPTIMIZATION being selected without
  SPARSEMEM_VMEMMAP, reported by Sashiko.
- Add an explicit DEV_DAX dependency on ZONE_DEVICE
- Collect Acked-by from Qi Zheng
---
 drivers/dax/Kconfig | 2 --
 mm/Kconfig          | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index f50c6b32d826..602f9a0839a9 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -8,8 +8,6 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
-	depends on ZONE_DEVICE
-	select VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/mm/Kconfig b/mm/Kconfig
index 0fa2eb76e4f2..30170a936f1f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1224,6 +1224,7 @@ config ZONE_DMA32
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
 	depends on MEMORY_HOTREMOVE
+	select VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select XARRAY_MULTI
 
 	help
-- 
2.54.0


