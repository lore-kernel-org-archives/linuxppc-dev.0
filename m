Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F5606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bp8XCpcl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHWV49Yfz2yPR;
	Sun, 08 Nov 2026 00:51:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059462;
	cv=none; b=m9v54KOwAzfFLElIFsG06i5oF+6i/HBUmDA8jNM8Ou79OzHg0ywXKv/w4AbQUBEwAjet9DSGt7ac72SxDzoBK/iUI9veYk9m5/tjdXzwAkB5EcuTdQ/JVTGZwbWTKeaFr6i7ns5cyIoTwY1gn0Ivfkz8sV1e7Plw5QiBA04FyYjzrrijcN8NQxd70CQbJQF56t15MXmEO+W/SYvxGPsl3o3UAjgR1OAVDCj3Wwlol+CCvdezqFbjMDfqmdcrL/wW9Gf1fKb4Ntp/tRTjWj+/S9Zs3I1cSYR987Nhgmk8raqotfcSAqEi0K8F40+Gz1SHK4TzZ8EmBs5LxBA3LDaQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059462; c=relaxed/relaxed;
	bh=vHl/pcUk1PujjHCFvfmAUSYKKFrTIfDLlcd8di49U6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0L1RdSSg3Hsfw+2Uj0JL4CqLwr3TSsQvueM58vr9UulrKAPV69R9y1cHOmFR1y6Eh3SJWWfL8YLLNrd5kBsMWkgytItbGDqGfZZL8Wu/HoFUIfCkTDiXZdQvVUBIKRrWh1LC7WlzHEPigI80zHT65yjEC5gBlOp8rb3z/xoUazEqNyWSKNBTDIgwJEwSbw0KWWu+qDN/00HTgCPbdHOyN2ZksDDzOuEwGintvPeyhyuLp8Fx8ksJ+wEZUqMmm0grDRgWE/wz8TpYY6xi+sqS6pqk5G2SC4lqb+SFDP/xZyXHulavGpsgZrjxD/9uUvVYrgDzzsUkSu3bx1UWhbvUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bp8XCpcl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bp8XCpcl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHWT6krkz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:51:01 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2076011eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059460; x=1794664260; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHl/pcUk1PujjHCFvfmAUSYKKFrTIfDLlcd8di49U6U=;
        b=bp8XCpclCMbmK5/Zd+RS+DJwi+0SciXug3inFvxSHru20AP/DF82SO3+nw8L16x46C
         al7/K+lTQyDfBD+iVtvm5hhnDQR23ZfXXkiqF9K2DbLkN2nKtAKIpnrWGCJkaYTpH/CU
         TG9HnxvoPjx08B5jCEnngg2g7DPcHEa1SFjsYtlCqsxeM8HQGDo71saMKtaMezJJvbB/
         X46kLbwC8YpdHxp2O4UpqtcT+xKw6BHW3OrDl3HOXen5XQAnhzE6UIuQRSJM2pCgMpw+
         ZzoB9g9fc9ZJTSz9EGKi7LzVz6LcQ3RWiV9T1wz2IIrldg/f4hUiE2hg51i+40J5y8/E
         WBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059460; x=1794664260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHl/pcUk1PujjHCFvfmAUSYKKFrTIfDLlcd8di49U6U=;
        b=Dx/a1916wRSHmtdjCxRZ0ycDSaG1CHE/iHOVbLZSExMqHIvAUZ0aYEq8TC2LmSkNJ2
         7XewH3Liw91K1O0st0jt8W2yniCgLE9BqlJmeuypxB/CppZx7CrQkgZ8x10uHq0FmrLy
         M60hQ7M6WdRLOXHrvy24Ha3Bmh53lfkXmLjDRfAgKrz1TSnP6EhLPHO7ShukrdGO5Arf
         uZ1YFX6GXAOkljDCGDi3EBdHCHBIFQBUsXZ60/sBcBz+aLLvl/pN42ZK/wYjcqPCjymH
         rQzzasfw0l8gJyxrFdlxNOtT8Di/CXxT3BTSsoDnRr0++dEUdvvd90KOHUddieMtsTIh
         L8IA==
X-Forwarded-Encrypted: i=1; AL+hErE81T2V07OdkPnOsBXG0y4zBsw0F2S1HEvB1/JSxz6pLzA7GzA1YDOww1X0sKiXp4VCw8gEB4ozkidMaoE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8rch6XTe8TsaJ8XobWlmG2cq9ed7RUWpFsnoS4+waDRW6zK77Q
	5BdcnT37tKUacsMXG5CzxlNSW9K0hW8AGXhEDm+jOTeuSQ8P8ADXUXgp
X-Gm-Gg: AYBFou0UONFyBrhIMUZyHlPtdhYdgNgt56d2BrIyTbq7/eqQHjLla89zxL+Tnk7p7mh
	zlnCWMG9AiG4jpbDkFm/KUP23E4FXQCNMgGZTjySJSs4IhPcM/UucT+Al3BH1d55rkAD5+YXud4
	60YxkmjtJzRBX3PMKjXigJDHk1X6VbkYXIE98mYT7/s9JfXlEYeZ5xQQwtbOKnBMRq0TifQuXLm
	h4ONrpDd7B4ZPSpjA+p7vATK/lgS1+P0GJbBgdKRJAG78pw5heo65qL4n9XJP/x5UpMTCOT/g46
	Y3//iTzWvys2AmLQMk0LwX1i2B0ZhdikqcFNSeigTp51zOGLjCUmCgTElyjzV3mXYpoA7VSF6mb
	2yK0xPBq8kvLeGLVRSr16Q4aPQtQA2X4uTOiwiYR906V/Rqo6CHk5kYnZALYH8FwrMmPJJu6vSC
	NKEIGleggIXRksLz+nsV7BzfCSiT6Mv2tdvyn+w2GWY0ugOiJjY43SAMJbaN25b2S9Hkpt5XqiE
	jDAWhH6eXyux/Cv4+a9rlKfkz+qnkv1iakbe1e93mWySWTYw8TcflwDxElMkX0XmbP0SnZNklzV
	b93spZSsofpEhEQQ0SDXIOxS8BMeE3antQkxwLfZdY9yIM+mQ16c31krRw==
X-Received: by 2002:a05:7301:6285:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36f76f0e752mr7696943eec.38.1794059459921;
        Sat, 07 Nov 2026 05:50:59 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:59 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 09/10] mm/vmalloc: map contiguous pages in batches for vmap() if possible
Date: Sat,  7 Nov 2026 21:49:52 +0800
Message-Id: <20261107134953.748622-10-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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

With large mappings, vmap_try_huge_pmd() may free an empty PTE table
left behind by an earlier vunmap() and install a PMD while vread_iter()
walks the same range without the mmap lock. Set VM_UNINITIALIZED on the
area until the mapping is complete, as __vmalloc_node_range_noprof()
already does, so that vread_iter() skips it.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
Co-developed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 884e178405171..5b898da0826ad 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3617,6 +3617,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
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
@@ -3655,13 +3734,13 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	size = (unsigned long)count << PAGE_SHIFT;
-	area = get_vm_area_caller(size, flags, __builtin_return_address(0));
+	area = get_vm_area_caller(size, flags | VM_UNINITIALIZED,
+				  __builtin_return_address(0));
 	if (!area)
 		return NULL;
 
 	addr = (unsigned long)area->addr;
-	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
-				pages, PAGE_SHIFT) < 0) {
+	if (vmap_pages_range_batched(addr, addr + size, pgprot_nx(prot), pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
@@ -3670,6 +3749,9 @@ void *vmap(struct page **pages, unsigned int count,
 		area->pages = pages;
 		area->nr_pages = count;
 	}
+
+	clear_vm_uninitialized_flag(area);
+
 	return area->addr;
 }
 EXPORT_SYMBOL(vmap);
-- 
2.34.1


