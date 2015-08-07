Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97E921A1D41
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:20:59 +1000 (AEST)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1075B1402B0
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:20:59 +1000 (AEST)
Received: by pawu10 with SMTP id u10so77676306paw.1
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:20:57 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/4] cxl: sparse: Flag iomem pointers properly
Date: Fri,  7 Aug 2015 13:18:19 +1000
Message-Id: <1438917500-12100-3-git-send-email-dja@axtens.net>
In-Reply-To: <1438917500-12100-1-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse identifies the following address space issues:
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17: warning: incorrect type in assignment (different address spaces)
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    expected void volatile [noderef] <asn:2>*<noident>
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:125:17:    got void *<noident>
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23: warning: incorrect type in assignment (different address spaces)
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    expected void [noderef] <asn:2>*cfg_data
/scratch/dja/linux-capi/drivers/misc/cxl/vphb.c:220:23:    got void *<noident>

Fix those by flagging __iomem in the relevant casts.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/vphb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 2eba002b580b..a7b55772a91c 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -122,7 +122,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
 
-	*ioaddr = (void *)(addr & ~0x3ULL);
+	*ioaddr = (void __iomem *)(addr & ~0x3ULL);
 	*shift = ((addr & 0x3) * 8);
 	switch (len) {
 	case 1:
@@ -217,7 +217,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	/* Setup the PHB using arch provided callback */
 	phb->ops = &cxl_pcie_pci_ops;
 	phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
-	phb->cfg_data = (void *)(u64)afu->crs_len;
+	phb->cfg_data = (void __iomem *)(u64)afu->crs_len;
 	phb->private_data = afu;
 	phb->controller_ops = cxl_pci_controller_ops;
 
-- 
2.1.4
