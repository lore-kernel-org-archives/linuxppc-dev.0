Return-Path: <linuxppc-dev+bounces-20884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D742ACD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3D3m8Fz2ydQ;
	Wed, 13 May 2026 23:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677848;
	cv=none; b=Ry/P7VUTVc9ZF1/Q6lTBU5/16FH3XEJi+CS5P+s1VtJ+kY0RQMJMNp18j6nF8Ui4srth3fj7g2/pXvZqJyiBn4KUpF53C5RCDf9DD3Zj7M9oE28MQuWlH8QWcLyA5drsTVN/LcU8zHNgxWwVBcwwgZWRW+hWdG7ePt2fnuwVf5t7JM+L81NI0RJHkIb7vozCj0eGf1HJt8Fx/x1luidP8/jwpOy3pNbs6aleaxPrKP48zw1vv39pDuKrzvFVVzH2x/KhKIqTZGwXwLdynTYKVzdMir47HiV54dLdiM4Q4dTTB4DpawlTKicGzTUAg377mS3ZYzLsziSI5Qcq5f7XWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677848; c=relaxed/relaxed;
	bh=K6tm8+Tn6qMHHNbiluBNgNTiouQaD7hYoUCXgTq5wuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDD6sGRpolwNg6EBH9FhjGd/mgdr4qp2zSn3h0VnMcdrvRyo3nQTOcepD0sCSrr/ApSVCgk2iGJ1Gg5QmG4iEp8vheI6SnLvVGznYYOcXXcGL1bNsmHikS6A1VHeS0/GLolFsz/SzgAebEF0b46jnyBi2ZWhW9Sj0BrmVZ+jFyzzbAeyGYFYK4nsFvUR/Tezsj6f3lpDAwIgpFomtK0AYSSG6iyhojkyEMhCrAzl78QF2wY9dJi3Ry7C4hK+zxIUhcD6kt9XBRtuxwxEQILsca67AmOJck7saJ17J38gFu9+8du0aMHJboMmqC5VjnSY/VBnIXhNdx+PERKeCfcxKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VN8K/pLY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VN8K/pLY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3C60Jgz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:47 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so4509590a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677846; x=1779282646; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6tm8+Tn6qMHHNbiluBNgNTiouQaD7hYoUCXgTq5wuU=;
        b=VN8K/pLY8FjrdZNYDG095U31ceZ1PvacGg29faauripeU4F3kgWAz7SIom52wdfxbp
         tNgV2lhydlu8EfW4yV3fu4dU0FsqGmY/d5ndKnlOLyp1Dx4cCiaTOdDIzAPvIqEnWYZi
         dMQGOUe/SOMYtD+zJ+ifRYzlf+7ykOja7m9t3Q9ZWKWBQSHzICeUsJgbnt3flHC5UBzo
         RrLlxPsHDU6agACzXBcFZRNqtA/QHoaZbO+6c2Y2lOD5YtmcrItRV5AAxh0tbMClJoqc
         QDhw0Vyy2Wt1MLm403yYC0Bl1r6L2xwJrJCaxJ5Z/9oaCZO/UfhfD0hoLCHrrKdvxO5+
         DpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677846; x=1779282646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6tm8+Tn6qMHHNbiluBNgNTiouQaD7hYoUCXgTq5wuU=;
        b=Lq+NxMfFdpEhZ3Mu6Xfd+DNp8AnwD81PZo8pVpj/3jCea1Gva60uTJ9WTYvDO8kPSr
         D+lMFd3rZSV3Fy+ZRAIAZfTJrrXgrEfmFfh+oI2OOqX8w3SkW2uyl1lFEsKirn9lhO8P
         o0gmFdqzdlN7UxiSczgzr/08p1TluyIY8R5rt5PxC3w4WMtujmgH96ClYZYXbZtn+6Ja
         myriga9rTKYYmtSnrtrvkURugfXkjJLoF/ixITGRkdscNlKYRyOo4vR2h6dKvW6zldqf
         VL+YbDpr7gm2WqPnz5na1rQkcR/AwqgE/EoTaFtYn57ta4MIbxTAkM0FD+98u7NuWScZ
         0njw==
X-Forwarded-Encrypted: i=1; AFNElJ+4XexZf8JuykuPE//5txXgz2pbHhAlcOqvei403hGENhY7GE1ItU2kmgMzOebV2NuIOJYJPCXmUUdXKYM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzV2VA78Oj4UpeSY7yNtPtZobbAyZIwULuby09Hk1eWlVoFqNCJ
	PAUky+RqiKtHB4eq1MspIyIjxwy7RaOckRPQ7EoKLL0X0UGDNzO3lNMdzyVsNdZCAFA=
X-Gm-Gg: Acq92OEjg59pFESL/yUcIe4C5XYKS5d/yKqSBgdX/55KXMa2eybCa0IQVWmsLK3jNXM
	r0QxdtSSCN3g0sTl6xvOtSbieVSnPvnnu9wEl9yb17BPVh0xZ7E6YuUvK+D0hP+E41pG4KQJeVL
	YN5ok/jLwKfxeme2YhkxhcjUXU55Ir/4nWsu9Q2SO3ljFSUdBuhkKpQr4DbudmqTulhiALOtA3Z
	JoHOpFdF9EW+Qc9fKVpHs6qgjuEFpwnwCEBB6XS/UK+tP3ONkfn40eOiX+7em9iEGw7v/3o6h8G
	HhXsbF8F9CIS3B8t2JvXshmFk6puSgsoOBHicxMKGafib/7Ie6aaip7+jmKyeecQsxBqm9wDr6/
	eM/D7ZASmIcqBbdVPV1kmc3ZdC0SUvw1yrwlo9fW8Eq9YORb5nnb+JgH9BXcXspcd6D8sInR089
	/wbf2eFFVn1u0uatSNkiDBnv2pH25dXPBqrjDN9Axl4SzMkl/wdS6zMWDJllc=
X-Received: by 2002:a17:902:d584:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2bd30210d95mr31196025ad.23.1778677845712;
        Wed, 13 May 2026 06:10:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:45 -0700 (PDT)
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
Subject: [PATCH v2 35/69] mm/hugetlb: Remove HUGE_BOOTMEM_HVO
Date: Wed, 13 May 2026 21:05:03 +0800
Message-ID: <20260513130542.35604-36-songmuchun@bytedance.com>
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

The HUGE_BOOTMEM_HVO flag tracked whether a bootmem huge page had
already gone through the old early vmemmap optimization path.

Now that HugeTLB uses section-based vmemmap optimization, that state is
already reflected in the section order.

Remove HUGE_BOOTMEM_HVO and its helper, and use the section state
directly when deciding whether to mark a folio as vmemmap-optimized.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  5 ++---
 include/linux/mmzone.h  |  7 ++++++-
 mm/hugetlb.c            | 12 +-----------
 mm/hugetlb_vmemmap.c    |  2 --
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index dce8969961ea..18af8f304b95 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -695,9 +695,8 @@ struct huge_bootmem_page {
 	unsigned long flags;
 };
 
-#define HUGE_BOOTMEM_HVO		0x0001
-#define HUGE_BOOTMEM_ZONES_VALID	0x0002
-#define HUGE_BOOTMEM_CMA		0x0004
+#define HUGE_BOOTMEM_ZONES_VALID	BIT(0)
+#define HUGE_BOOTMEM_CMA		BIT(1)
 
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a60fd5785fa5..9b87d798a365 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -117,6 +117,11 @@
 #define NR_OPTIMIZABLE_FOLIO_ORDERS		\
 	(__NR_OPTIMIZABLE_FOLIO_ORDERS > 0 ? __NR_OPTIMIZABLE_FOLIO_ORDERS : 0)
 
+static inline bool order_vmemmap_optimizable(unsigned int order)
+{
+	return order >= OPTIMIZABLE_FOLIO_MIN_ORDER;
+}
+
 enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
@@ -2262,7 +2267,7 @@ static inline bool section_vmemmap_optimizable(const struct mem_section *section
 	if (!is_power_of_2(sizeof(struct page)))
 		return false;
 
-	return section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
+	return order_vmemmap_optimizable(section_order(section));
 }
 
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 080f130017e3..abd79bb85b1c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3169,11 +3169,6 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head(&folio->page, huge_page_order(h));
 }
 
-static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
-{
-	return m->flags & HUGE_BOOTMEM_HVO;
-}
-
 static bool __init hugetlb_bootmem_page_earlycma(struct huge_bootmem_page *m)
 {
 	return m->flags & HUGE_BOOTMEM_CMA;
@@ -3265,12 +3260,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 					   OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES);
 		init_new_hugetlb_folio(folio);
 
-		if (hugetlb_bootmem_page_prehvo(m)) {
-			/*
-			 * If pre-HVO was done, just set the
-			 * flag, the HVO code will then skip
-			 * this folio.
-			 */
+		if (order_vmemmap_optimizable(pfn_to_section_order(folio_pfn(folio)))) {
 			folio_set_hugetlb_vmemmap_optimized(folio);
 			section_set_order_range(folio_pfn(folio), folio_nr_pages(folio), 0);
 		}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 730190390ba9..66362e553870 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -718,8 +718,6 @@ void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 		return;
 
 	section_set_order_range(pfn, pages_per_huge_page(h), huge_page_order(h));
-	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		m->flags |= HUGE_BOOTMEM_HVO;
 }
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.54.0


