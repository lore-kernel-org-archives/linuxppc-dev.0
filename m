Return-Path: <linuxppc-dev+bounces-28734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC80CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:11:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx30q3tGGz30VT;
	Fri, 02 Oct 2026 19:10:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932251;
	cv=none; b=fZ2+DR0FinwP555t8gr+Di+DOesGy3nSXo9pZy0J8xLD54X3jOBZQdHDbRPikrJ6LlsRIHd9wocKCKsNH2/Tp8o9SAAPJ5OSw+1U8oJYT1Mh4pZP1ipaRf/wBbJMZ1U+C8c3k9TIlIkGFLYLbVdnMszyugiXp4ztF+qZtap4oUP6Q4pEZXvXI6iASXXjOiyP0lzK45z0Bo29iCy9Kd3rExGh7zyGQaT7JjbADCWwjZHFZMWMlR/R1vMxvIpFFkYxJyMx6BTm1hiBRgG7uZLmt1UOMiEi/LXcpTaOZXMYA3e7S3YFoqb4U8ZdCeIaP/c4cgps36x0XpU2kRwxvWlTog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932251; c=relaxed/relaxed;
	bh=5SdFF897J19vB9gXlitk0PJAT4sCzBncom/C0yG9+Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujg1Ai1OEOzb5+S2aCg/QCBVXnz3IgJ3ljNID4CeH9foQ4gZOO+aujIbvG/VbA9uNYuRU2IenqoyGF54a6aZJMJCzdUkjk60UPCMgR5msapVO2RjukV9F9BhL3fORQrdLf0DGztUqGWw0xnMDB0IH4A/uiAEJDKfoIkuLsLrpipsTWNYpUxQP07EEyTY/3A3p7g9nncsVMvJURSlS6eah8THzB3nezztIuywpQzhOVamYLDD8u7SYAH5uVLR0FeL29o/rJojl2vnH9jUvo10iZ7OrhhhVXcsVI/Tr0XcVcypolfwuxyhh3KHhcoIfP31ODqRU4J6hax55tkhRi1XEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aufrxIWZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aufrxIWZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0d.google.com (mail-pj2-x0d.google.com [IPv6:2607:f8b0:4864:39::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx30p5Stdz30VQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:50 +1000 (AEST)
Received: by mail-pj2-x0d.google.com with SMTP id d9443c01a7336-2e4ba8555fdso120155ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932249; x=1791537049; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SdFF897J19vB9gXlitk0PJAT4sCzBncom/C0yG9+Zg=;
        b=aufrxIWZwlkHT49mNSHa8Q49lIGyIjpA9c/06II9eVtK8dvovQwH8DWU7tZqLagWpU
         UKNAyLdlg7M7y5/5HAhq3og0XzRDsgOib6lrcUHnXnaglkBFQ5QJ4xilqFyLIkiK3/lB
         H9l7KrMTxUxwvWOkLUwbCG9UA69NWwoDVfkD+9eidWRxkcZZe/+qya28ByQhjH0FVPKJ
         PM4mJQUCeTYY4UcV/SRiops8F+UBj2oyMXEXPSR/WJKznyycOA7kxPaZQMJoMS5SawDQ
         zSt9HQDv1NbBfikjheR3e9goyWPjYEeTLNnV6YntEvYx2mxFT7zabjot1EdK/b81/auZ
         0neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932249; x=1791537049;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SdFF897J19vB9gXlitk0PJAT4sCzBncom/C0yG9+Zg=;
        b=Xdt5YheHTuGiw9g+0h8vkN3VvscEw2x4L0m+0ie3U7YXAcjv+mwkaCGBQBKAAVdDjb
         ubkSmLqPk5BM5jWRuiqEg2lgncNkxx6AhGOGzW0qlGzZ7Qv7WIYj3bGmwzMUG7O8sVz4
         LaQv5FNtWoZWlyNXC1eayQ/z7pWPAejWEPzoqhZ9toW+2xteqPTAgxj8KSl9BWVITX0w
         RAXIGqTKEZUGozVFLMcFBgUHRvbNb7tGfVuJllvrjsqb1JE9wPyVzWjHcCRjq2e5fCFN
         2WY+QkWYzYgk17m03fy3k7n9BXLIrW4a5kNHoVi69HPbYCGAA12gYllypkv66NvN4PxT
         kSLA==
X-Forwarded-Encrypted: i=1; AKwUvBwf3s6IQbQhSkidv8yUJciBrz6QqELwZUsaZ/rdYp9tiJSsHIRvoLjRVjXhWcT1uPhQCEv47ypHgcGwD9Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIQTRYBtOifRFcLOFT9sUCMCcA/eD4gNtwMguLvwhhRx5gnxZvD
	wwqsvncKkeBsabVc4vPOHUXhwB9drsyIXcOgN3jVxKb065iSWWsVMH4R
X-Gm-Gg: AYBFou1pDIFntsiHU7Ary9DxQrAKmnKBPEVM5q4ZEa05+CGBITVsgNYRyEwr+I06AZj
	e+Ju0U+HBaTBCVneJZwxspb+tk4LYFSBNWlDsPKsmiQQ4TfNx+847LnEwz19hRhCky3u4p95vKb
	RJb3exYxpi4S5zbFX/qG9d2DxFyIGFIxmJfMbjPqUWA6xFFi0Djn8zOSodG1kP1J+ZV0cIYmPue
	pSQ3uRy6HlCognnxn8XWLuVJkdwz2hPNsLW6sNkn2yy3peb+yZvfB3syr8NkG2BBiSRKm7Tkoft
	Sku7OhAgj0nicu8l0N4tJG/zGujqs8Va+B2D9lEn//8paMb+b+qvXrHqnCvE9AdsG/ProQvUVOt
	NJ+STd90vpyn7TvYpLpVnbrYlMZQDDfJn7tGRUp2QCOZhMgLESDzzdSti3K4JOoD6H6jUwERnvk
	o4KBRuPbruMV8zWKXSpK4qNH4/wyrngVSTMpZZlgsJbCHnRWChpeMKmLR3WFy3uuoGIWRRe4TuL
	b75qUar5QVD6gYjnUibMA==
X-Received: by 2002:a17:903:b87:b0:2e2:f379:82b9 with SMTP id d9443c01a7336-2e49b821f87mr17258575ad.61.1790932248559;
        Fri, 02 Oct 2026 02:10:48 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:48 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
X-Google-Original-From: Wen Jiang <jiangwen6@xiaomi.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v10 09/10] mm/vmalloc: map contiguous pages in batches for vmap() if possible
Date: Fri,  2 Oct 2026 17:09:46 +0800
Message-Id: <20261002090947.869220-10-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002090947.869220-1-jiangwen6@xiaomi.com>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Barry Song (Xiaomi)" <baohua@kernel.org>

In many cases, the pages passed to vmap() may include high-order
pages. For example, the systemheap often allocates pages in descending
order: order 8, then 4, then 0. Currently, vmap() iterates over every
page individually—even pages inside a high-order block are handled
one by one.

This patch detects physically contiguous pages (regardless of whether
they are compound or non-compound) by scanning with
num_pages_contiguous(), and maps them as a single contiguous block
whenever possible. The mapping order is determined by taking the
minimum of the contiguous page count and the pfn alignment, allowing
graceful degradation when pfn alignment is less than the contiguous
range.

Pages with the same page_shift are coalesced and mapped via
vmap_pages_range_noflush_walk() to avoid page table rewalk.

As users typically allocate memory in descending orders (e.g.
8 → 4 → 0), once an order-0 page is encountered, we stop scanning
for contiguous pages since subsequent pages are likely order-0 as well.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aae6141aaebf5..4acd1ec27604b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3576,6 +3576,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
 	return arch_vmap_pte_supported_shift(size);
 }
 
+static inline int get_vmap_mapping_order(struct page **pages,
+		pgprot_t prot, unsigned int nr_pages)
+{
+	unsigned long pfn;
+	unsigned int nr_contig;
+	int order;
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+		return 0;
+
+	/* Limit nr_pages by pfn alignment */
+	pfn = page_to_pfn(*pages);
+	if (pfn > 0)
+		nr_pages = min_t(size_t, nr_pages, 1UL << __ffs(pfn));
+
+	nr_contig = num_pages_contiguous(pages, nr_pages);
+	if (nr_contig < 2)
+		return 0;
+
+	order = ilog2(nr_contig);
+
+	if (vm_shift(prot, PAGE_SIZE << order) == PAGE_SHIFT)
+		return 0;
+
+	return order;
+}
+
+static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages)
+{
+	const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
+	unsigned int prev_shift = 0, batch_idx = 0;
+	unsigned long batch_start = addr, batch_end = addr;
+	int err;
+
+	err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
+					     PAGE_SHIFT, GFP_KERNEL);
+
+	if (err)
+		goto out;
+
+	for (unsigned int i = 0; i < nr_pages; ) {
+		unsigned int shift = PAGE_SHIFT +
+			get_vmap_mapping_order(pages + i, prot, nr_pages - i);
+
+		if (!i)
+			prev_shift = shift;
+
+		if (shift != prev_shift) {
+			err = vmap_pages_range_noflush_walk(batch_start, batch_end,
+					prot, pages + batch_idx, prev_shift);
+			if (err)
+				goto out;
+			prev_shift = shift;
+			batch_start = batch_end;
+			batch_idx = i;
+		}
+
+		/*
+		 * Once we fail to batch pages, we expect to fail batching
+		 * for all remaining pages, so just give up.
+		 */
+		if (shift == PAGE_SHIFT)
+			break;
+
+		batch_end += 1UL << shift;
+		i += 1U << (shift - PAGE_SHIFT);
+	}
+
+	/* Remaining */
+	if (batch_start < end)
+		err = vmap_pages_range_noflush_walk(batch_start, end, prot,
+				pages + batch_idx, prev_shift);
+
+out:
+	flush_cache_vmap(addr, end);
+	return err;
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
@@ -3619,8 +3698,7 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	addr = (unsigned long)area->addr;
-	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
-				pages, PAGE_SHIFT) < 0) {
+	if (vmap_pages_range_batched(addr, addr + size, pgprot_nx(prot), pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
-- 
2.34.1


