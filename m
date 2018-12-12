Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81142C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:38:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C144B20839
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C144B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FKDS3NbbzDqVY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 01:38:16 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FKB01sq5zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:36:08 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id E5EB668D8D; Wed, 12 Dec 2018 15:36:04 +0100 (CET)
Date: Wed, 12 Dec 2018 15:36:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 12/34] powerpc/cell: move dma direct window setup out
 of dma_configure
Message-ID: <20181212143604.GA5137@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-13-hch@lst.de> <871s6r3sno.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s6r3sno.fsf@concordia.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 09, 2018 at 09:23:39PM +1100, Michael Ellerman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Configure the dma settings at device setup time, and stop playing games
> > with get_pci_dma_ops.  This prepares for using the common dma_configure
> > code later on.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/powerpc/platforms/cell/iommu.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> This one's crashing, haven't dug into why yet:

Can you provide a gdb assembly of the exact crash site?  This looks
like for some odd reason the DT structures aren't fully setup by the
time we are probing the device, which seems odd.

Either way, something like the patch below would ensure we call
cell_iommu_get_fixed_address from a similar context as before, can you
check if that fixes the issue?

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 93c7e4aef571..4891b338bf9f 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -569,19 +569,12 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 	return &window->table;
 }
 
-static u64 cell_iommu_get_fixed_address(struct device *dev);
-
 static void cell_dma_dev_setup(struct device *dev)
 {
-	if (cell_iommu_enabled) {
-		u64 addr = cell_iommu_get_fixed_address(dev);
-
-		if (addr != OF_BAD_ADDR)
-			set_dma_offset(dev, addr + dma_iommu_fixed_base);
+	if (cell_iommu_enabled)
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
-	} else {
+	else
 		set_dma_offset(dev, cell_dma_nommu_offset);
-	}
 }
 
 static void cell_pci_dma_dev_setup(struct pci_dev *dev)
@@ -865,8 +858,16 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 
 static bool cell_pci_iommu_bypass_supported(struct pci_dev *pdev, u64 mask)
 {
-	return mask == DMA_BIT_MASK(64) &&
-		cell_iommu_get_fixed_address(&pdev->dev) != OF_BAD_ADDR;
+	if (mask == DMA_BIT_MASK(64)) {
+		u64 addr = cell_iommu_get_fixed_address(&pdev->dev);
+
+		if (addr != OF_BAD_ADDR) {
+			set_dma_offset(&pdev->dev, dma_iommu_fixed_base + addr);
+			return true;
+		}
+	}
+
+	return true;
 }
 
 static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
