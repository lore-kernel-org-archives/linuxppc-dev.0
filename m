Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB4606A834
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=duOTzUmK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkzs1KR6z2y2B;
	Tue, 03 Nov 2026 21:18:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701097;
	cv=none; b=VqRQPjxgHvUqWr7iuwFlS2oebA486hvKtvRfOUMM2ZhPZINN8huh1A2ULmbar9JVpsV9rtGCpUucoJ9yyTyvrWJN/j8jeHOY5GpAmTQeEsq81Zjn7tUQy16jrbaWXULzzD5Rp8OgfrzRtW0REO1opj+Tmfb1X0CX4DsijyU1hlfF7JO3rA/8EBfCq+e7KcISTiokgbehu080DFKjVbDEeiqTdKvmux+Ly6+nBe1+eLRWLQBDYvklTj6mGuGIglsPq/AtcUuiO+zIvyvIcD8Nd/wzY6+Mcznz6ZXmol944iVBOvp/dNKH5XoXN23K31ca7P9uDiFtbIxwAsKZPgzYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701097; c=relaxed/relaxed;
	bh=RHjaZF/zEkaSXrLeJORF1ZXTNpz5Xq3a/jlyVJC+lRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRO2JfeiVTEJHIybltxw+jzWbLAACIiAA/WuZysqKQRuLlctKfIulh/epeyO9oEln36/qs3wBtkedyyluxXlcnh3VKnEPmicDiQ+FZkHbNMVdxQO6BP/b6ZWr2HZKRVr/+1TcP8+SU7All5huyK/nTWMFzNX5OTkeCD+J9uy4uBSK5d7H1/bl4BuRKVxkZF2nX7yqOXslFXVpVURxoldvySmacGRCwAohFzJrlZjbXmfvENCfYZRfz9+GLHxdAarNNBqoPYoK7ZaQ6YkKtVVa8fyMW49RVVwhGSksCxS1FLBu1k2oIqc3z4UO12bVBJgPEGtEMqJ4JcFZW+0gvP3Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=duOTzUmK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=duOTzUmK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkzr402Wz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:18:16 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-33fb4680717so6561566eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701094; x=1794305894; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHjaZF/zEkaSXrLeJORF1ZXTNpz5Xq3a/jlyVJC+lRo=;
        b=duOTzUmKVaiGvAtroyTFM1xXPGitxmAk2MiU5S60nkuHHHOSK4pA7Swr1wSIRzxE+q
         n95eh4k1p25nOHFt63/k4VgEAqw96qehAdZcOcy7zInXZyBZxmttErDnnKAA6bcAaBm9
         IlwsviUnBkaoxump/Xi7iEXWDsVVUQ/zNtaCFWT5ylww92ZVbO5L8zeUvd7uyClTsGBW
         18sl+lsWJRLQ3xOXiZROOH0drHrxMfPzgPZsbgynL3zn3WHrylEaUtt/OQiEGBg/OBZK
         0ZMyU7PnI8s06EbhX95MqI48ApnCiP/mnQ2kzTZfuu4sQoOzEWwyoVBfGkGBIXeWG1qW
         Ur/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701094; x=1794305894;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHjaZF/zEkaSXrLeJORF1ZXTNpz5Xq3a/jlyVJC+lRo=;
        b=bk+5Sv1r6OOFiO6UdOAz6xE2bys5rfdUmbJhn0ETxV2jjVAtLhsPOwcub+7C+JM0RO
         zlFJgTen4jN7g6HBiWaOqpjV9Kp1yZahTtXsfjVJfoE6eAnON+uVvRGu+S8GX1UBfcvI
         qYDA198Y+ofrrJqydu5nJbWE2yX1O3fnW7/UAjCHNns+11LQBtn6a+hIa52nTXP9f2B+
         Di3M4QORXVLzBDLyY7Sxs+nuJSkn/nNg1tLPqPh8q41y80rputXeq6A5tLTVUeRHajXr
         J8Vp2eixPVVhHPnq+X2ppz4n4qw7reojkldtcqb8xcHRZrrzgu9GJQ8OCNMdTRp3owkn
         yIBg==
X-Forwarded-Encrypted: i=1; AKwUvBzCFsF/HB9Mq8AWfCQ4K+jewqZaUR16NOVqnjdQzvkOut+ihU6lvdQQI2nkb9sSoARBVAQehZlQXUr7Oq0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z98N20/Sb3eIKzdnKboN2CwCgwwNMtYeyO6cmfGw00OlO7Xf9O0
	W1x/lZIyQ0EibcXu7bEYPIO+0U8AnHs86NHYhjzhvamRb68UXaU8OmxJgq+u3vPL
X-Gm-Gg: AYBFou2GvOw74mWSZm7tTmwg2AMzAeBDm+8fhnxs8FzmdUMH4O1LADdkyysnhL/5+jX
	D40SONy6tE1EDq8bsio3cEuTfDoOUsdK5+EQDx3RgUWHSpraQUqZ2x+9mmU8xe8WM0kTgQgJ1EN
	INdVU/a2vPl0A7tls+blxFnK+pNhAykUJQWUH0xzwsJwmpntCpPDIja6ULmdrS+0T4pDS9Y+uPe
	ioLHUrPKwljj1WqZbjpIhhXh/9xkT+pWVahvJc3FOOE/s+drdcM5XCbb5IZLBNDNtO2851YGjgM
	gXz3Waw2AyAR/vDCRVsnWxRzhQx2sicqznLrMKZ3iuxURk03gfBohXuCUKxLre50wNcc+yKVBEV
	YbITs/5Ea7IJgnI3N8XGql930s543WKJxUO95LPYYKXAFfonkkiy8h1OUPxNd6m2m6ZOH6aOSsK
	y+fdGe+YUi1IdEtWqinN3HSuDmHdDkANkWF2Dz4/T343ByAW3r/mM1YILJs1/IDLKohzTdSYeiT
	qYtGG3GqIgt0H7c9Q5M3s7g8fQBePF326YkH1UWLBh5fqsftlkWlPUyWlMZMhEJPrznqNTPXUZT
	fZAGRxnQyW5aKjgU63uCHH1AVbDWfg==
X-Received: by 2002:a05:7301:18af:b0:36c:9b35:5d45 with SMTP id 5a478bee46e88-36c9b356dd1mr806355eec.25.1793701094017;
        Tue, 03 Nov 2026 02:18:14 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:18:13 -0800 (PST)
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
Subject: [PATCH v11 09/10] mm/vmalloc: map contiguous pages in batches for vmap() if possible
Date: Tue,  3 Nov 2026 18:16:57 +0800
Message-Id: <20261103101658.766905-10-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Sashiko review: flagged a potential NULL pointer dereference -- with
HUGE_VMAP enabled, a NULL entry in the pages array reaches
page_to_pfn()/num_pages_contiguous() in get_vmap_mapping_order() before
the WARN_ON(!page) safeguard in vmap_pages_pte_range() runs.

This is not a bug: vmap()'s contract requires the caller to pass an
array of valid pages. The WARN_ON(!page) is a defensive sanity check,
not part of the API contract -- passing NULL pages has always been a
caller bug. get_vmap_mapping_order() runs on the same pages array that
vmap() received, so a caller passing NULL pages is already broken
regardless of whether we batch.

 mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ee2c1ec4ff1f..42b3addd20f9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3613,6 +3613,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
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
@@ -3656,8 +3735,7 @@ void *vmap(struct page **pages, unsigned int count,
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


