Return-Path: <linuxppc-dev+bounces-27974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4958C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRrv1jBHz30V2;
	Wed, 23 Sep 2026 16:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144975;
	cv=none; b=DfY+WB3jMdr7Zc1q8BrcBB/gphAu/sR7Hrg4bRhYGHm52sH/SL64DEDZwbXSnxXf0LGuMYbpdwbe+q5JdyTHL+g8wpFwg5SdxfS9ONSd52pd1xmQ5J01Ao27HZusUX0Y9PJznnoLW/3zLLdOSoP1NK3BSIMyPZgMJAvf5ZytBRJzk171RkJEInHi1D2ulJLyTQkkvHqIsD0KUVbXXgv1iNCfGUgZCvD+oUaWmHVi++Bli+CPqpWN+oGofTYS+yOKF9vtOBrWGNwT1L+lRFdynyrUrVWCMh33mT7I/UAYxUOxQjNKQIMUaQUzuj88NWIpYWTYxaJpgbAFt7V/58rMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144975; c=relaxed/relaxed;
	bh=dEaCg+SoOuqpLOGmqy1zgShmdKDFtyrROF+HoSyjUpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU0xLJPCUfs9+7we+S0fUCU3FmzQp+ybkEGkHK1B3BrjmAm5lQEC3j5OqRrW0f1HVS1Dtaj4YpWOEeZJSEmiQXdNiYQ5tEM4RY5nEtJXDaXmWvLhExUKHSfOfEu1b1coj/+yj5+vpPRRCanOTG8CVeejafnYFIEErQxkENG25imGxqJiXaeT2hdKyP7m4rCeSJHtQXsdMtSvnyoW/xHnsMmr/m5JtBdEasPOf+ZfC0Nm5gE6rTVj0D64zWzCGKFQ8J5DUlDA68iNwkW8uDSGgTIrXIdnTdcEPwmUDUjyx+HTi1Hcz03+fTPgLYzTFpNPRSZGvVearrjinKWO3fk8yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PZ7Kwl8Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PZ7Kwl8Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRrt4CNMz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:29:34 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747ed1368so3508715ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144972; x=1790749772; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEaCg+SoOuqpLOGmqy1zgShmdKDFtyrROF+HoSyjUpM=;
        b=PZ7Kwl8YOVFrxmbHK+6EBBvCNJuazOebj+jaWaOAXhIpr8rrJCs3CHab7anG5nW+xF
         KVxpl/1gjBNLpna+Pffp4zOszJKYbH21ORoGDt8yDynG0OwvYOSifbDpyqjvKJiv0Tbz
         NksHPeyYXb3P326jrnMxonzfwxxo/i/1fjXjm0TRFYPTsrzGUbE1JWCQ3++5IbfPHW/L
         v0v9O+rBLm+49tHXklKOPs9NH8EFrfDKQkAqgqvv6YgASfqkYCY6qqlvrC9527U82xVk
         EQWfqyfh+Fe91cKw5WYOykJ5jV+HO+Iq83/rcmbIP9c5SBkF9skmEPDtWHvau3PHkJbp
         0thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144972; x=1790749772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEaCg+SoOuqpLOGmqy1zgShmdKDFtyrROF+HoSyjUpM=;
        b=iXNfo66teObadw+V6FpD1fewPG0JdlMMyn3yvvfCxHj0kcETTr9C2SeFmQKrkRoXRR
         P2UGSr2ph7UbK0IqWDr6SSiifkY0kcC7ALG8aCMdD9DlBGAokT6IDLKkb8MpxeV8fqu3
         maoc4H6BWJwI1wwL6hkPLd6o3VdmcOm6lmzBA/N527Ujuq975td53oDXj/wNDMRWCalT
         BG2N9c7uT1W5XPXr7oNavQgVmmf189RQ6DB/mVUlYmkQYNmzJYyLF+gPi8m6PubnnIG6
         Ni7MWGiHAVvOesoFsQD4vd7hSZQoi4aUrP9j384M7hS4VhF+t+VchQ7O/yuNNWPXP/5Z
         55dg==
X-Forwarded-Encrypted: i=1; AKwUvBzpFNM4HY4uT3NKMAjtCZjnUdZQ0f4JFHb0ja20DDr5YFPe3xGwaawlvZng0OwTDVw6bxv5Rw07mQhhJnM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lwk9hsJKSNFBRWVexozN+kLA+iBuDaFobM7FUIR3Z5kO/mW+bm
	DwDmoHd80RkGnE3sk6T4OtY96Mu+T9jREi6BwQK2bQ3JGc7SnPd3uDkf
X-Gm-Gg: AYBFou2Im3ShUhwg3VAS6he0QMFXtEKC1DUGFXViPfR8A5yYRRHHByfEE2DZHfUsAO+
	rKCTyaUmrJssbJrMleJXpUuEpgAsjewKJOGOQQShr690upXMIeB9Pa99vcrIgf1p7T9/ES1IXiD
	pzdQ0hxRXdpntYpn05tcZ3ogdi/TEAM8z2PSu64072INsljqXf7m8xo8klZluMpLbAidwEtOucs
	RzkaGNSDykF501/xALNOZS3Gn52hilVIYneastJR3LseTj9lBEi/A+bTmMN/vFCDX0ekG2yW52I
	5QOrr43HY3ShytIYZmz/57sCLD7OdD4aIQBMMCsElfBTfzhmqa5U0UPlEVtOpSQvr2YwlYjazw1
	nWua0bR3+KjjziTGD4CUi4ZOoM2S3WtoUHFuXwnEvs/PpEEWRaQmS1K1bM6YmCWNVH2h+V25TW5
	u/bEFPAIhKTCXMvZPfDTMYaRkC/QCVNWuPcf6B/vpU+LaSNDUvOYV15tD6qj0AsawXaMKkVd/Hy
	DMPo51eP67Gnj3fvLbh8A==
X-Received: by 2002:a17:902:db0b:b0:2dd:c100:b2c2 with SMTP id d9443c01a7336-2df69e01d0cmr15666125ad.45.1790144972237;
        Tue, 22 Sep 2026 23:29:32 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:31 -0700 (PDT)
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
Subject: [PATCH v9 09/10] mm/vmalloc: map contiguous pages in batches for vmap() if possible
Date: Wed, 23 Sep 2026 14:28:31 +0800
Message-Id: <20260923062832.479455-10-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923062832.479455-1-jiangwen6@xiaomi.com>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
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
index a43965016eb4d..37cddb7f45a4f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3576,6 +3576,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
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


