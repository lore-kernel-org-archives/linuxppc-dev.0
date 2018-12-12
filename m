Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F1C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:31:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38D420849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38D420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FK5271z3zDqVf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 01:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FJkn4fR7zDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:16:00 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C6EA868D8D; Wed, 12 Dec 2018 15:15:56 +0100 (CET)
Date: Wed, 12 Dec 2018 15:15:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181212141556.GA4801@lst.de>
References: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Thanks for bisecting.  I've spent some time going over the conversion
but can't really pinpoint it.  I have three little patches that switch
parts of the code to the generic version.  This is on top of the
last good commmit (977706f9755d2d697aa6f45b4f9f0e07516efeda).

Can you check with whіch one things stop working?



--Qxx1br4bt0+wmkIi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-get_required_mask.patch"

From 83a4b87de6bc6a75b500c9959de88e2157fbcd7c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Dec 2018 15:07:49 +0100
Subject: get_required_mask

---
 arch/powerpc/kernel/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 5b15e53ee43d..2e682004959f 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -152,7 +152,7 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 		return 0;
 
 	if (dev_is_pci(dev)) {
-		u64 bypass_mask = dma_nommu_get_required_mask(dev);
+		u64 bypass_mask = dma_direct_get_required_mask(dev);
 
 		if (dma_iommu_bypass_supported(dev, bypass_mask))
 			return bypass_mask;
-- 
2.19.2


--Qxx1br4bt0+wmkIi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-swiotlb-dma_supported.patch"

From c2579a3619575397929781a14895966cbc1d217b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Dec 2018 15:08:52 +0100
Subject: swiotlb dma_supported

---
 arch/powerpc/kernel/dma-swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index aa11625c6691..52ee531c1a0d 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -36,7 +36,7 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.free = __dma_nommu_free_coherent,
 	.map_sg = swiotlb_map_sg_attrs,
 	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.dma_supported = swiotlb_dma_supported,
+	.dma_supported = dma_direct_supported,
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-- 
2.19.2


--Qxx1br4bt0+wmkIi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-nommu-dma_supported.patch"

From 0105db9e6d8d031b4295116630fd0318fd146737 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Dec 2018 15:10:36 +0100
Subject: nommu dma_supported

---
 arch/powerpc/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index a6590aa77181..f53d11d35230 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -179,7 +179,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.alloc				= __dma_nommu_alloc_coherent,
 	.free				= __dma_nommu_free_coherent,
 	.map_sg				= dma_nommu_map_sg,
-	.dma_supported			= dma_nommu_dma_supported,
+	.dma_supported			= dma_direct_supported,
 	.map_page			= dma_nommu_map_page,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
-- 
2.19.2


--Qxx1br4bt0+wmkIi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0004-alloc-free.patch"

From 4c5dd4d4a4b4e63be722fd29ada896c5962072b8 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Dec 2018 15:11:38 +0100
Subject: alloc/free

---
 arch/powerpc/kernel/dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index f53d11d35230..d3db6d879559 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -176,8 +176,13 @@ static inline void dma_nommu_sync_single(struct device *dev,
 #endif
 
 const struct dma_map_ops dma_nommu_ops = {
+#ifdef CONFIG_NOT_COHERENT_CACHE
 	.alloc				= __dma_nommu_alloc_coherent,
 	.free				= __dma_nommu_free_coherent,
+#else
+	.alloc				= dma_direct_alloc,
+	.free				= dma_direct_free,
+#endif
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_direct_supported,
 	.map_page			= dma_nommu_map_page,
-- 
2.19.2


--Qxx1br4bt0+wmkIi--
