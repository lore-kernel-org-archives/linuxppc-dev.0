Return-Path: <linuxppc-dev+bounces-27190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3FFC88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:41:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMFF6DF5z2yLg;
	Sun, 13 Sep 2026 18:41:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288865;
	cv=none; b=a2cGifqpyU5SsHxOD19aHk0V/oU9t/kwHtUSLNCYeidClQKYTDI1QVYOGcCBkXBsTGmXx2v6EaePqPqgifqFc3uorkVDs8UbQVAb9Ze7JE+Q3D4lUvDhMuhaO6hz6rDpg+N0UBcgGlBUNa35dBCVvrZtcj1OFOXxFBUv4cl7xwT5BRthnDccz4ZZuP1TxVyvjNqVsyskT1YtUXekliI/zLvntIE4eE0id+Q4A5qEjkiYSDILwPZSsEZ8/sSAkoLRkgm+UnD8Lc3a4BH5fa87kNI70R5GJ4uYFer5ClhltiPfj8RNzmqTdz0MtJNGbJou7gRTiVF6nnxRdaXUP+CXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288865; c=relaxed/relaxed;
	bh=NjqOF/lS/S8Rdm36whah2xYfroMiTrYUBQ+49bShAw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8wt3EDa5VgDd2jWMglSYvBsZqiU7XvscjgiNIFrvSHY5byuIKPdYtTnjmd5xi/3EHOnoNRs+xCfMRqPaISkGhD4w7gRMox/BWl7r+WkfW7f9p88Dkny6nJ8p2maRlSyl+pifrvEnmJziA+xsmIxmEPQOxKS3HZ3GanMwVoFiAkhwNgNWPC4JBOPlTDYUX2KweO0YVM42IKcvxpHTnQIFzPTv0lWV+9mel+c2UE2Wsvc2RHNXK6xjRDaBboejrWZJsX9T7wYI7n5PnDQMxOUQxggbBvdPnlEfE493d+K1h3SaBn2ClPTSMQAVTSebZdqmsl3izK4fMLzX0MCxHFglg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LJyJzcO+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LJyJzcO+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMFF0jRVz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:41:05 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8625b35df89so54092b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288863; x=1789893663; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjqOF/lS/S8Rdm36whah2xYfroMiTrYUBQ+49bShAw0=;
        b=LJyJzcO+lwRSxSi2CbT3BcOTp44NC6qktoDNOiC+yYkxu5zZNaol7LrUqSgy4AfZMX
         +huzGeQyR/gn6UEPC+4yOeNEgrNsRZ75ZcnNFfiNXSXPjuLgQ4PqxZGchHJiFoxVUoPO
         tb8ZZxHuwtoM6+tAUyxb2ykz/Mn+n3DXE1858Bs0uRV2GV15cae7EldZvgti1Fcdd+cG
         PS3TbmTJUZhVlTQkI+XJr/iYomMvYyu7WA5SeELkBlcc7xJtYdA3tZmuhOhVtwV4Pqnn
         Tsw2dbHX6SJhOm2i4x2Izfv4g18aK31xsl3T0YxXyXvsdaE4PcwZoRWKuvlz2D/ITqQU
         6UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288863; x=1789893663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjqOF/lS/S8Rdm36whah2xYfroMiTrYUBQ+49bShAw0=;
        b=XdWn+3lmgBOQoVFbmJVG3RpCfV19xT9eU8iXrXYPlSDtLz3W2p8sjHWDXWCrbh8xBs
         50qRrwDmTqeHio7bMDVHbP4TtcdhBVitocRjGlrWGp/IKNWzfegtgeDiQrYOPP/zfsCD
         grhJPsB9Z9ipobwLsEZvZcRQqaDTwfKXaZ5drYFyngsz7NLbrlFaCsCHXP0DSwFYFgdQ
         +u3S8LjguCuN+heV8tByNd3amntOD9p4I0GaJ9m50CB/ff7MHPIZQb5IaxIud+Pur46p
         y1jKEqLz8AWQ0PMX6sBN1cXcSzNDG6taFrEgz2jI9R0wzqqOaEJrthvj9eZqlf/pSekc
         IxMA==
X-Forwarded-Encrypted: i=1; AKwUvByFHEUsSlanWWViSkvm5I0rGfrAwNgAMlXkZr13iemNKN/jCNgL1HpkGAcZbM5ofbYkMiK8C5j9S5Y3oAE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lCgia6axvk/SDKM33cuUbZWFIVDS09CWm5pNNRjzSG8bWo3oJ+
	aHBuGjPB8fuSoMmgMPuG7+euaEedrx5QsF+bKv0TN/EnC4AQezhDdXXIK2EWMb6xfNc=
X-Gm-Gg: AYBFou0MlMLmOMplI9Vl/jbeezXJOmDU0P7F4nR2IFfPt19BtwhCI/n2wrMZoY9koiU
	Tar836lMIR+Q/u0tIvS0znVUVSMXsXQZlgX5sCGjLA02yXwH+K2vKM1wDSGEsXBjxvd564AgqX8
	yN5rCcFU/oEW4b2JOIBfa5GN0C4JI64jnIvGs8lAYw4U83YIb7IgcPm90jdI6e4+hisfU/YrmbB
	1MylokhsAcjZ00x5iR7FD0AinZaLcqjU7JW8vpcTan0C23GHkZh3xytt21lnKc5Tb3+wWJlK4B8
	87usZOzBZi7t8jMLWOVBV1ZII0MTPy9Yv26rhtMKS5RXBBeJGDSWzI5ndsNylWBw2WvlUjhNKf0
	9ekTUNXgcWO+RcwEOeVNseZshAOsxc/rAi6UXpmUTs1VVQIpapaD9Wlc0MD3+1DywoM167wPgkl
	TgDNW4zuIh9TdXnMtCwyv8hBi2h8I9H2U8wVVeCwOEr67G5BPXEfss0TaTIO5YeRM2LP5fpUDUN
	YRJ4vfvPn4GptxMwaXOOgD+rx8=
X-Received: by 2002:a05:6a00:428e:b0:851:8bde:7861 with SMTP id d2e1a72fcca58-86e2a4c9a44mr1541510b3a.1.1789288863105;
        Sun, 13 Sep 2026 01:41:03 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:41:02 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 5/6] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Sun, 13 Sep 2026 16:37:33 +0800
Message-ID: <20260913083734.86802-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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

vmemmap_populate_compound_pages() is no longer used outside
radix_pgtable.c.

Make it static and drop the unused dev_pagemap argument from
its only remaining caller to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..8452a2714cb1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -356,11 +356,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cb72d9ccf747..ee121cb4fc12 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1110,7 +1110,9 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1125,7 +1127,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
 	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		return vmemmap_populate_compound_pages(pfn, start, end, node);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1221,10 +1223,9 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node)
 {
 	/*
 	 * we want to map things as base page size mapping so that
-- 
2.54.0


