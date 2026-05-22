Return-Path: <linuxppc-dev+bounces-21363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CF4CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:31:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC5v1BY0z3bsY;
	Fri, 22 May 2026 14:31:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424291;
	cv=none; b=mbQ7lWgC/qfo/k3Y5zh7+a37DwqJcfpKndI05UuJVE86RBUDCuJq5EuZox7Haxya52n8DmTTLog1vlg2UZvsGOJmbIFSab58hyjFHA92BcPtZ3CpAZu0I8hnXU723sHVKuro7SdTDBcRiz6bVH9yhQVHdohf44EQGeDFN+Hu1GjHqPZ+SrDhBNGYC3XUdwr0jvKmaVts7Pm64RX5b99pJw+hNWRnDbhjEZpJnhS1pqbveNfsZrQbbyu/GlVdApCgzLZAFkOljdmrj8zIEu3tewOlvM90KHGlQHDtejLdM/RWoZWqIQ2xMzpf2IAjHqfA1iDpj+IoP17UInQYFDHEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424291; c=relaxed/relaxed;
	bh=UPVhX+V6bjt+jEYXx2EEvMCCL/8FtnLC6xq+shkO+d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsiTGSEyqUNNyZ77sIePbEGrxcuLrjpWGVnKhsl46FwNykq25EJy467D74EHQwk+gxliR2eA/kRX8aqp3GYAk66ILbULlo9ltkyWspuVL5i5knHZZThvbuOoCvjxJK9Bvayt6tHIsuPAcWGXSgPlO+Yi6gxYlLW9ZgW7m3kuRhP536EM0E5CZIPK5lvSgPNtHm2gjWxxuNkribYnNZG3FB3akk7mo42+t41mavzsTdQa2yDEF5V+zxe4YKkYLeEuCMmuqvrhCgSEK2nmdTUJc292TWrV/tbQJd51oNaqCq3FXQlCghLjyZvQPlnCRWWfH7wgaFTYhz20imxTtrNqMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6H9Hzej; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6H9Hzej;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC5s6hk9z2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:31:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1457F60172;
	Fri, 22 May 2026 04:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1386E1F000E9;
	Fri, 22 May 2026 04:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424287;
	bh=UPVhX+V6bjt+jEYXx2EEvMCCL/8FtnLC6xq+shkO+d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6H9HzejgTanmuvGyP7VJaa5Gx2QiHLNOK3GFUWd0ZZvC/lxq60uptNh63/1uLIDF
	 r8wOVVv3MLgOfgtVaDvbHBKq/7aCkp+YcjtPbsHLYs4a4pvyalLKpsZmd4QVqtaVBo
	 ztu2tfrIP3SjlJHE/nZDZaIUOFbCXMNTz7XX0a9hxs+SPMzy3P+vjSWis5FZbQpnkF
	 2B4rv2K5RaDKUOhKP4Q1Uiz5kc6EXjJNFu59BnZUUT3xzNpn6oTaNK9i8YJixThzJJ
	 kGgq4gQihEdciMu0b4qIrYdc0g8hTxmYnnJfk3XnhnXtdq9j98LguDscHIfx4bYYHk
	 qBbfoTpTTqZ1Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 15/20] dma-direct: return struct page from dma_direct_alloc_from_pool()
Date: Fri, 22 May 2026 09:58:10 +0530
Message-ID: <20260522042815.370873-16-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
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

Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
helper") changed dma_direct_alloc_from_pool() to return the CPU address
from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
dma_direct_alloc_pages() also uses the helper and expects a struct page *.

Fix this by making dma_direct_alloc_from_pool() return the struct page *
again, and pass the CPU address back through an out-parameter for the
dma_direct_alloc() caller.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Cc: stable@vger.kernel.org

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6b00c7f4a78b..907c6084c616 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -157,24 +157,24 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
+		unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
 				   dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * the atomic pools instead if we aren't allowed block.
 	 */
 	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  gfp, attrs);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size,
+					dma_handle, &cpu_addr,
+					gfp, attrs);
+		return page ? cpu_addr : NULL;
+	}
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
@@ -445,7 +448,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-						  gfp, attrs);
+						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
-- 
2.43.0


