Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E01C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8E0214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8ufiRGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8E0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Q7Pq1b5zzDqFw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 09:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8ufiRGV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8ufiRGV"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Q79Z5GQXzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 09:36:18 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 42CB521741;
 Wed, 26 Dec 2018 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545863776;
 bh=4pzUIZcmGPbKIBxRMj3DZ4ii155quo0oCW54jDXQ2eA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R8ufiRGVmfhUVrLAcbchVxHZWFwO0OHYXLGbPlouAuusM/t11Kq3YuNUFc59h/8/s
 0rm7AcDh+opGZN5Hecly525+epdtK5oxERIQztOut75Du1u4nyU9KGvenGZUoFN18p
 Ycz2AuUPP2mXmsAmoPIlDmN/yXq9tUlxy7pT1CUQ=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/97] powerpc/mm: Fallback to RAM if the altmap
 is unusable
Date: Wed, 26 Dec 2018 17:34:32 -0500
Message-Id: <20181226223557.149329-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Oliver O'Halloran <oohall@gmail.com>

[ Upstream commit 9ef34630a4614ee1cd478f9859ebea55d55f10ec ]

The "altmap" is used to provide a pool of memory that is reserved for
the vmemmap backing of hot-plugged memory. This is useful when adding
large amount of ZONE_DEVICE memory to a system with a limited amount of
normal memory.

On ppc64 we use huge pages to map the vmemmap which requires the backing
storage to be contigious and aligned to the hugepage size. The altmap
implementation allows for the altmap provider to reserve a few PFNs at
the start of the range for it's own uses and when this occurs the
first chunk of the altmap is not usable for hugepage mappings. On hash
there is no sane way to fall back to a normal sized page mapping so we
fail the allocation. This results in memory hotplug failing with
ENOMEM when the new range doesn't fall into an existing vmemmap block.

This patch handles this case by falling back to using system memory
rather than failing if we cannot allocate from the altmap. This
fallback should only ever be used for the first vmemmap block so it
should not cause excess memory consumption.

Fixes: 7b73d978a5d0 ("mm: pass the vmem_altmap to vmemmap_populate")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/init_64.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7a9886f98b0c..a5091c034747 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -188,15 +188,20 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
 
 	for (; start < end; start += page_size) {
-		void *p;
+		void *p = NULL;
 		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
 
+		/*
+		 * Allocate from the altmap first if we have one. This may
+		 * fail due to alignment issues when using 16MB hugepages, so
+		 * fall back to system memory if the altmap allocation fail.
+		 */
 		if (altmap)
 			p = altmap_alloc_block_buf(page_size, altmap);
-		else
+		if (!p)
 			p = vmemmap_alloc_block_buf(page_size, node);
 		if (!p)
 			return -ENOMEM;
@@ -255,8 +260,15 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 	unsigned long page_order = get_order(page_size);
+	unsigned long alt_start = ~0, alt_end = ~0;
+	unsigned long base_pfn;
 
 	start = _ALIGN_DOWN(start, page_size);
+	if (altmap) {
+		alt_start = altmap->base_pfn;
+		alt_end = altmap->base_pfn + altmap->reserve +
+			  altmap->free + altmap->alloc + altmap->align;
+	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
@@ -280,8 +292,9 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 		page = pfn_to_page(addr >> PAGE_SHIFT);
 		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
+		base_pfn = PHYS_PFN(addr);
 
-		if (altmap) {
+		if (base_pfn >= alt_start && base_pfn < alt_end) {
 			vmem_altmap_free(altmap, nr_pages);
 		} else if (PageReserved(page)) {
 			/* allocated from bootmem */
-- 
2.19.1

