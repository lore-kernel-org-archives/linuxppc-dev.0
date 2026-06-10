Return-Path: <linuxppc-dev+bounces-22415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0166CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:23:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb7Lf2sTcz2yfD;
	Thu, 11 Jun 2026 00:23:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781101434;
	cv=none; b=DpPLG4BdP8sc3V1XzXKNr6pSY9/cGTCIKX2oSnbvw5eqlBp9pyjaWNnpL1dpS9fQK6f9ve16riI3VaKcIA5ErgsPdTcnJr8JbhNsjbs5UORxFwYIegHnhaOQD07XCe7Pw3QcOYq4mpnDlR1Pb3BkdgkALHgljuKHhQDyQLjuPHAgpCF+N15D39d+8la1qZguyPdDgIPG+QX45uO4DKo72vPB/zd4BcdEbEz6ymlIZuyhIpsarjxs9E5dHxj0qw1HDbJDi2MzGE2fGT923u9MVbumnENYXHYyhThCPu4GXHTWZe/6I4/2EYV3kTaecLf37WLcLMy4yf16F8Jo2FFS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781101434; c=relaxed/relaxed;
	bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj/mSP3lXwSp91cKzqFz75SARa2BS1jDSndoNrwKNMroUhirqhDObyKxRtErGDi4eKZdy/3mErxhj3TvXCYhQzWdbJK9kPbzUydDutBcwNPC1b3t10nzvIb1FiQSBH7W4bQIRIfxWyEnjiOQNKKrFguqWChTdj5PLo3gM/M5rYFEsYtH9uBHwBWkAloS2W9G5dDeMCg/0h/IXC093WIiQxr4rSvNS9q5P6ffgndcEPIDaSYl1MzsOHyf+4frV4AVEh/0AcjBIzvUn+MU9OR8MLAjLi0+JKY9b7/XBohQ71r+wJYlVMGAsRNP2jE1LFb+7pc3x+bdu/nm8L13wsA36Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OWJ93TvK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OWJ93TvK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb7Lc26Mdz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 00:23:51 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso49372945ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781101428; x=1781706228; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
        b=OWJ93TvKwjFKLzDGF+ICtfUOZkYA7Bc1ctQhIexwXXSot1cNZW5wMp95f3cUYsisV5
         vQ41xbTOi1FM7cQvRU/yfn9PpseUooiTMS2ZqZtQjoNrcec97qUZhikry1olA3o6vWh2
         w2NuDiqn1GD5ZLmE18xz4+66WbtpCTNybXiZzcutVd/9fNg0RPdFne8zZkErotZ0pS+5
         2KMXzrJ020l0Keg+tWzqHsaZfNbkeUTm2mUFgO56MXbp+I7lXmPIn14gI7uqVJdvV/Tp
         pDPc0OtzEbSvclRSj4Qc9klcfRAVpzpOECOrQ2rUQVn9RaBitCxk/XEC0SeBpUbQVdv5
         9CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101428; x=1781706228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
        b=QVqcf5qbLzNjYpVafA4dZtEChNlUxKE6DCzHJLfX3efBbDXWj4eLBVTnGLyI/7c7br
         diE0RjJxPlNfydClJun8P5DjJ552z76jKbp/MCIRwWokrlSWhvd2YVfEnzu+Tp7hCd3I
         PkgqAiCPGk7E8RZ0vieHW9RBKUuRjw6bD8Q+12RftyULkHF2XsPscc72hcDS6gHVvK8h
         vexq0UYngSnVNu10pxFAYvoV8UZIS92Y6mcdDT5fR6mvMIdVZQdY+sw4OAUbN9iCOM8c
         c1xSJUjL8rqm1y4ZuVcaxEAvA0xxf6KYH3/T7xxm+lMb4RwhJrCGS4xztkyEpu09LhEv
         ASoQ==
X-Forwarded-Encrypted: i=1; AFNElJ983msQS8whrllZ+aKaZT05V5wPAeEsszXJJqmv4C1YdrTo9KO7aYsRRKgVoT+LJOGe8aB4z7FN7h804zk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1Up2RasZ7yPzaHfxCYe030qeAmyIoHPy6TWGRnJ/Rc35c+LWv
	BckGYstyUb0MomTiyU4hs3SOuQaTJ8jZa/FVHFXxooqK0BaiCyEfE/q1R+dDGtohA74=
X-Gm-Gg: Acq92OGIRm37p7YfrT4Up6+43Jm6xfcBGPNqxFbOjjibrixSHHUKulOy4tCYaWmGzGk
	dWB+0ZCdJ5278NXK1Q2bPj8LEiWF4I/yQfPUEemceOkpC4k5Ov+nOL/sAzqsJr4sWqkCqrsHsVK
	zDVIZBX3rK72/LZcZf6e3wO+NEZ9Tcj0YwDv7rHV3Qkc6bLkWDt3lXBpytTs5Rg6/fxgHCS810b
	pbgGtroI6yuJXug6IgJb8NzHNZJgMdTCPw+wIkAlIcT3eGqIPqmHI7Vzr2WaBtoskrrLa65dXaP
	kRJ5/zapIRmhpLj4h1l/ihzj+c5BAXVKmnU1DY91DJx5tYk9ggJJ7mvWhMCJZc2TVzmTvRezGSv
	39nG/As2wXm3TInBUkpVsWqE9bd6Gi/jOuFtKwsg76ZVXVgAGojYClSeMCXkTFRot5OfJnO/2kf
	kyLs5Zag0oUohzHut2VORrZ2UIZto/FA49yLG2fWA8ghkaax0h6TQkvQ==
X-Received: by 2002:a17:902:e752:b0:2b2:5515:661c with SMTP id d9443c01a7336-2c1e893d62dmr281727295ad.31.1781101427890;
        Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
Received: from nagraj.tail8a2ac.ts.net ([2406:7400:98:3ab:da47:17e2:32f7:c4d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d318sm265761935ad.15.2026.06.10.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
From: Sumit Semwal <sumit.semwal@linaro.org>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: jgg@ziepe.ca,
	jiri@resnulli.us,
	hch@infradead.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lkp@intel.com,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	linux-s390@vger.kernel.org,
	djbw@kernel.org,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	arnd@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	mripard@kernel.org,
	afd@ti.com,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
Date: Wed, 10 Jun 2026 19:53:29 +0530
Message-ID: <20260610142329.3836808-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.51.1
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

From: Arnd Bergmann <arnd@arndb.de>

While system heap and system_cc_shared heap share a lot of code
and hence the same source file, their users have different needs.

system heap users need it to be a loadable module, while
system_cc_shared heap users don't.

Building as a loadable module breaks system_cc_shared heap on
powerpc and s390 due to un-exported set_memory_encrypted /
set_memory_decrypted functions.

Fix these by reorganising code to put the system_cc_shared heap
under a new Kconfig symbol, which allows either building both
into the kernel, or leave encryption up to the consumers of the
system heap.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
 drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index e273fb18feca..a39decdcf067 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
+config DMABUF_HEAPS_CC_SYSTEM
+	bool "DMA-BUF System Heap for decrypted CoCo VMs"
+	depends on DMABUF_HEAPS && ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
+	help
+	  Choose this option to enable the system_cc_shared dmabuf heap. This
+	  allows allocating shared (decrypted) memory for confidential computing
+	  (CoCo) VMs.
+
 config DMABUF_HEAPS_CMA
 	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c92bdec356fc..71d9028cc3df 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -48,6 +48,9 @@ struct dma_heap_attachment {
 	bool cc_shared;
 };
 
+#define cc_shared_buffer(b) (IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) && \
+				(b)->cc_shared)
+
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
@@ -161,7 +164,7 @@ static struct sg_table *system_heap_map_dma_buf(struct dma_buf_attachment *attac
 	unsigned long attrs;
 	int ret;
 
-	attrs = a->cc_shared ? DMA_ATTR_CC_SHARED : 0;
+	attrs = cc_shared_buffer(a) ? DMA_ATTR_CC_SHARED : 0;
 	ret = dma_map_sgtable(attachment->dev, table, direction, attrs);
 	if (ret)
 		return ERR_PTR(ret);
@@ -233,7 +236,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	int i, ret;
 
 	prot = vma->vm_page_prot;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 
 	for_each_sgtable_sg(table, sg, i) {
@@ -282,7 +285,7 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	}
 
 	prot = PAGE_KERNEL;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 	vaddr = vmap(pages, npages, VM_MAP, prot);
 	vfree(pages);
@@ -349,7 +352,7 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(page))
 			continue;
 
@@ -456,7 +459,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		list_del(&page->lru);
 	}
 
-	if (cc_shared) {
+	if (cc_shared_buffer(buffer)) {
 		for_each_sgtable_sg(table, sg, i) {
 			ret = system_heap_set_page_decrypted(sg_page(sg));
 			if (ret)
@@ -485,7 +488,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(p))
 			continue;
 		__free_pages(p, compound_order(p));
@@ -525,6 +528,7 @@ static int __init system_heap_create(void)
 		return PTR_ERR(sys_heap);
 
 	if (IS_ENABLED(CONFIG_HIGHMEM) ||
+	    !IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) ||
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
-- 
2.43.0


