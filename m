Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D51ADDE02B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 03:39:51 +1100 (EST)
Date: Thu, 31 Jan 2008 10:25:39 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] [POWERPC] Set dma_data correctly for direct_ops on pasemi
Message-ID: <20080131162539.GB10340@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
	<20080131064130.GA32344@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080131064130.GA32344@lixom.net>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


More fallout from the merge:

[POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset

"Now that all platforms using dma_direct_offset setup the
archdata.dma_data correctly, ..."

Nope -- the pasemi iommu setup code that disables translation on the DMA
pci device still set dma_data to point at the table. The below patch is
needed, please merge asap.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 9916a0f..5803f11 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -182,8 +182,10 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	 * CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE at build time.
 	 */
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
-	    !firmware_has_feature(FW_FEATURE_LPAR))
+	    !firmware_has_feature(FW_FEATURE_LPAR)) {
 		dev->dev.archdata.dma_ops = &dma_direct_ops;
+		return;
+	}
 #endif
 
 	dev->dev.archdata.dma_data = &iommu_table_iobmap;
