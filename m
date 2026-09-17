Return-Path: <linuxppc-dev+bounces-27550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F2C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:42:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll4g4fbhz30T6;
	Thu, 17 Sep 2026 15:41:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623047;
	cv=none; b=crUomZeJEbgua3ZqvjPr+xylKif69AxNKnuPW5H4kqPmElkOlW4G92gXWFMqCYjVTI2dxtYzl5L4rkonEZ5ePG6jWCbkcIfLPd+NhO72DxLN0aaQ8SYdfO1tfpYA4YOTOXFc3WIVq0yeShuYyvZl22I3cWf++AP5nF7EcjkZ/j4975WLVr6O5fwbNdPIve2OVHd7iG1Jlkg60ROgXQIm+2l3EHnM3W3gD2IzOlmLkUazn9h8V1U7ClHNHR+Mbx8KTndobD/yxrrQgvYdg82fNpjdQ0hXE/II8NQWsTAJTi/WXZhIPNAaq1cn//a3MkKbWK/a8XJUPyNqZIEZpof93w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623047; c=relaxed/relaxed;
	bh=yJbFWtXzdjoxqLLRP1e19uuFJMa1NhU30c4WN8jSX0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0FSollhfpZoUdl2HAa8X72pgrQIHjsoaxJJSTASmy3aqrEu1M0I1ttcvuzqBHeMEeAO2MhHsFs7PK1PmkDDvlz3efauJQipnyWQrbcz+0wLn4l29CbjVxL35mkofEiGfBNeDP2PBhnSIZVMMl5VVt6jcJxxU3ZN3rO6NL2Xh1hhsmxmnR0FaXErgt36yQ6jkji/Ghj0kyJ8rXS1Sm4WS6p9Ursqmh8nWD63fq2URFRMhbfNPWugPzk4mHSKDKh2eusyyJ5QyKOTzZ9f+66wy1lc4PziNVM+lEZGK3Tf5sc9pH55/22qV6AA2mJhsZI33FqcGbSWOW1q5NXo+qZuYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mmgmnL2A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mmgmnL2A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkqp68THz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:46 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so341710a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623045; x=1790227845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJbFWtXzdjoxqLLRP1e19uuFJMa1NhU30c4WN8jSX0Q=;
        b=mmgmnL2AxyiF0Y35GwSFzPamxnkKeDr+dQqymI1IAojpodySTqmPeIbX2etrr/OKiy
         u2DMWtnn7sQgzqM1Y7doWTO+9zDRYuMSncdmidWMAyN3lmCuscAdZCjdayQdaHReQXEb
         NB999cBcug+D/SHZu4/CgSS7nro0tjLC5MpmA5BLXp8k1VVw4N721YFw1hfKTzQaVVdE
         WjOZqMHAP/aKCgWecWtG3thB5yAs5ndQN3VOejkRCFclFB++0ILew1JURtJAMzFVFL2z
         ZCODrFPRXPxS/HwNdzheXHFvS4og2MZ5m1l+hVoyo8LV/o9X9jzZheNV97hIN5gLHMTX
         v+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623045; x=1790227845;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJbFWtXzdjoxqLLRP1e19uuFJMa1NhU30c4WN8jSX0Q=;
        b=lu19ERkZ0C5NFS7gcUNkJcFKL9QKPVDJ0XZZVWO7w1Lw0HkV8jH8JpbGcQGGC9XBEz
         s3eNHw2/h/Qi2Xi/cHr0O9XT32QagcjDObv1qoltY/Lp8Rlh8FotjJ4ZagI1PmBN/FGW
         eCi9sCuIJIte4vNk/RzG6X78+r9zZJ4swv3jyMThjspHuZZn7pwnkRGfphQ+IOkVANs0
         TVQnZ4TorekMtq1auvER9H8COT3yOPmPcmOGgVGI4t3mCND07sJ/gwFxUmBCtci5eCfu
         2J1N376owYNS8nhvJbFHe89cCyEBCSh6W/tRZqm0WdW+OOf2DQ50k0Go9CIkkdloxXbF
         hTRg==
X-Forwarded-Encrypted: i=1; AKwUvByjUr27h9o8P6LHRzPcuNC5rAwr0aTjLRwqakANbDf0aor13aldlmMpDqcCshBIJDyuYnU7XfR4GqWpOSQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ntFpB2/0DlnUi925TtOfzKPkimp/Kuw5gan9eeO7Z2dZfQ5ECP
	xuHMUu8iiX2drp8V4aej7MMh3nF+ef8CzMvmSH1i9XjoGhNefHJOMt+0
X-Gm-Gg: AYBFou1hH+okLQjhbCU/oD1UQFnEfl7kN1SF4Lc0vTmE/uLNsD+MMs09KDhVwXjt5/Y
	0YfSB2Xw5olCcCpCmfdNLDqw6Bd8iRqQFUjVLrmD+2D+2fe1FWOxwMvvvDtA9jdtLJQf1aXhBlA
	yrrHnS1hJBmAEvbCjdUr2Re31jEl8c3qbdLBdRBtGxQhk3bvU9t9VN68eIB3oWL3hJS26GtIOuk
	dbXBcHJ2XkSo1wCbcpIVn3w0WInVXj3yYH3LcV31JN+d6J7KJJkTvPqmfH4iZGXwqe6brI8rUQl
	4HSLWMcJPkzhDftaX9aNzteU0TvxhB0k+AqGcBDuG2KG7vZ6XT4rLmblCffkVCGqc4tTTUPcTPc
	Pd00LqJIuTB1NSic2uqWsl3tjjP+KaVRl4YCpE3qOD7UuEu8hbJZZZHsx9qLuAkUng2indh2jWM
	3dqIBFg0sq/G4CdholYZh/P2WTXFc1pyZ5U5Ag/mQUg1xvRztYn0RiLuva/S8PdOfxrKiLfbt7Z
	5Y7W6vUbGf8q5Bd3pM5wdIModQ=
X-Received: by 2002:a17:90b:4d07:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-39e1e2ee113mr11267726a91.9.1789623044645;
        Wed, 16 Sep 2026 22:30:44 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:30:44 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
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
	ryan.roberts@arm.com,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v8 09/10] mm/vmalloc: map contiguous pages in batches for vmap() if possible
Date: Thu, 17 Sep 2026 13:29:32 +0800
Message-Id: <20260917052933.188679-10-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
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
---
 mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ed868afd8194d..bce2d2c09f546 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3540,6 +3540,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
 	return arch_vmap_pte_supported_shift(size);
 }
 
+static inline int get_vmap_batch_order(struct page **pages,
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
+			get_vmap_batch_order(pages + i, prot, nr_pages - i);
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
@@ -3583,8 +3662,7 @@ void *vmap(struct page **pages, unsigned int count,
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


