Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B4471A039F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 14:30:13 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D2B514030D
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2015 14:30:13 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 28 Oct 2015 13:30:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C02AA2BB003F
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2015 14:30:10 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S3TuKq32833766
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2015 14:30:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S3TbM3024771
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2015 14:29:38 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, dja@axtens.net
Subject: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
Date: Wed, 28 Oct 2015 14:29:39 +1100
Message-Id: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sparse identifies the following issues:

  drivers/misc/cxl/vphb.c:131:17: warning: incorrect type in assignment
    (different address spaces)
  drivers/misc/cxl/vphb.c:131:17:    expected void volatile [noderef]
    <asn:2>*<noident>
  drivers/misc/cxl/vphb.c:131:17:    got void *<noident>
  drivers/misc/cxl/vphb.c:252:23: warning: incorrect type in assignment
    (different address spaces)
  drivers/misc/cxl/vphb.c:252:23:    expected void [noderef]
    <asn:2>*cfg_data
  drivers/misc/cxl/vphb.c:252:23:    got void *<noident>

Add __iomem annotations and remove unnecessary casts to clear up these
warnings.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

This patch is a respin of https://patchwork.ozlabs.org/patch/504976/,
incorporating comments from mpe.

As with the old patch, this patch doesn't make any changes to the return
type of cxl_pcie_cfg_addr() and casts to an __iomem type when we use it in
cxl_pcie_config_info(). cxl_pcie_cfg_addr() returns an unsigned long,
rather than a pointer type, as we use its return value in bitwise
operations. If there's a better way to handle this I'd like to know.
---
 drivers/misc/cxl/vphb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index c241e15..588bfc0 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -128,7 +128,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
 
-	*ioaddr = (void *)(addr & ~0x3ULL);
+	*ioaddr = (void __iomem *)(addr & ~0x3ULL);
 	*shift = ((addr & 0x3) * 8);
 	switch (len) {
 	case 1:
@@ -249,7 +249,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	/* Setup the PHB using arch provided callback */
 	phb->ops = &cxl_pcie_pci_ops;
 	phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
-	phb->cfg_data = (void *)(u64)afu->crs_len;
+	phb->cfg_data = (void __iomem *)afu->crs_len;
 	phb->private_data = afu;
 	phb->controller_ops = cxl_pci_controller_ops;
 
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
