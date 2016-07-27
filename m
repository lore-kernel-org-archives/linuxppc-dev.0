Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzzr75QZKzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 01:46:47 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>,
	olof@lixom.net
Date: Wed, 27 Jul 2016 15:41:29 +0100 (BST)
Message-ID: <488c970c5ae.f93db6b@auth.smtp.1and1.co.uk>
Subject: [PATCH] pasemi: Fix coherent_dma_mask for dma engine
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c707e401f754ac2.5c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c707e401f754ac2.5c
Content-Type: text/plain

    Commit 817820b0226a ("powerpc/iommu: Support "hybrid" iommu/direct DMA
    ops for coherent_mask < dma_mask) adds a check of coherent_dma_mask
    for dma allocations.
    Unfortunately current PASemi code does not set this value for the DMA
    engine, which ends up with the default value of 0xffffffff, the result 
    is on a PASemi system with >2Gb ram and iommu enabled the the onboard 
    ethernet stops working due to an inability to allocate memory.
    Add an initialisation to pci_dma_dev_setup_pasemi()
  
    Signed-off-by: Darren Stevens <darren@stevens-zone.net>
  
---

----=_BOUNDARY.6c707e401f754ac2.5c
Content-Type: text/plain;
	name="iommu.patch"
Content-Disposition: attachment;
	filename="iommu.patch";
	size=610

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index c929644..81b334a 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -187,6 +187,11 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
 	    !firmware_has_feature(FW_FEATURE_LPAR)) {
 		dev->dev.archdata.dma_ops = &dma_direct_ops;
+		/*
+		 * Set the coherent DMA mask to prevent the iommu
+		 * being used unnecessarily
+		 */
+		dev->dev.coherent_dma_mask = DMA_BIT_MASK(44);
 		return;
 	}
 #endif

----=_BOUNDARY.6c707e401f754ac2.5c--
