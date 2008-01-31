Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 508B1DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 17:41:21 +1100 (EST)
Date: Thu, 31 Jan 2008 00:41:30 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Set dma_data correctly for direct_ops on pasemi
Message-ID: <20080131064130.GA32344@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

More late-caught fallout from the mainline merge. The patch:

[POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset

"Now that all platforms using dma_direct_offset setup the
archdata.dma_data correctly, ..."

Nope -- the pasemi iommu setup code that disables translation on the
DMA pci device didn't set dma_data correctly.

The below patch is needed, please merge as soon as practical. Thanks!


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 9916a0f..c5cfd4b 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -182,8 +182,10 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	 * CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE at build time.
 	 */
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
-	    !firmware_has_feature(FW_FEATURE_LPAR))
+	    !firmware_has_feature(FW_FEATURE_LPAR)) {
 		dev->dev.archdata.dma_ops = &dma_direct_ops;
+		dev->dev.archdata.dma_data = 0;
+	}
 #endif
 
 	dev->dev.archdata.dma_data = &iommu_table_iobmap;
