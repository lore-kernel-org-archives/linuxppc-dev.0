Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72C801A0622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:14 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 07/19] cxl: Re-order card init to check the VSEC earlier
Date: Tue, 19 May 2015 21:22:24 +1000
Message-Id: <1432034556-32400-8-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we expose AFUs as virtual PCI devices, they may look like the physical
CAPI PCI card.  ie they may have the same vendor/device IDs.

We want to avoid these AFUs binding to this driver and any init this driver may
do.

Re-order card init to check the VSEC earlier before assigning BARs or
activating CXL.  Also change the dev used in early prints as the adapter struct
may not be inited at this earlier stage.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/pci.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a9c90d2..1ac2ecf 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -884,13 +884,13 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	u16 vseclen;
 
 	if (!(vsec = find_cxl_vsec(dev))) {
-		dev_err(&adapter->dev, "ABORTING: CXL VSEC not found!\n");
+		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
 		return -ENODEV;
 	}
 
 	CXL_READ_VSEC_LENGTH(dev, vsec, &vseclen);
 	if (vseclen < CXL_VSEC_MIN_SIZE) {
-		pr_err("ABORTING: CXL VSEC too short\n");
+		dev_err(&dev->dev, "ABORTING: CXL VSEC too short\n");
 		return -EINVAL;
 	}
 
@@ -927,24 +927,24 @@ static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
 		return -EBUSY;
 
 	if (adapter->vsec_status & CXL_UNSUPPORTED_FEATURES) {
-		dev_err(&adapter->dev, "ABORTING: CXL requires unsupported features\n");
+		dev_err(&dev->dev, "ABORTING: CXL requires unsupported features\n");
 		return -EINVAL;
 	}
 
 	if (!adapter->slices) {
 		/* Once we support dynamic reprogramming we can use the card if
 		 * it supports loadable AFUs */
-		dev_err(&adapter->dev, "ABORTING: Device has no AFUs\n");
+		dev_err(&dev->dev, "ABORTING: Device has no AFUs\n");
 		return -EINVAL;
 	}
 
 	if (!adapter->afu_desc_off || !adapter->afu_desc_size) {
-		dev_err(&adapter->dev, "ABORTING: VSEC shows no AFU descriptors\n");
+		dev_err(&dev->dev, "ABORTING: VSEC shows no AFU descriptors\n");
 		return -EINVAL;
 	}
 
 	if (adapter->ps_size > p2_size(dev) - adapter->ps_off) {
-		dev_err(&adapter->dev, "ABORTING: Problem state size larger than "
+		dev_err(&dev->dev, "ABORTING: Problem state size larger than "
 				   "available in BAR2: 0x%llx > 0x%llx\n",
 			 adapter->ps_size, p2_size(dev) - adapter->ps_off);
 		return -EINVAL;
@@ -993,6 +993,15 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if (!(adapter = cxl_alloc_adapter(dev)))
 		return ERR_PTR(-ENOMEM);
 
+	if ((rc = cxl_read_vsec(adapter, dev)))
+		goto err1;
+
+	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
+		goto err1;
+
+	if ((rc = setup_cxl_bars(dev)))
+		goto err1;
+
 	if ((rc = switch_card_to_cxl(dev)))
 		goto err1;
 
@@ -1002,12 +1011,6 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = dev_set_name(&adapter->dev, "card%i", adapter->adapter_num)))
 		goto err2;
 
-	if ((rc = cxl_read_vsec(adapter, dev)))
-		goto err2;
-
-	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
-		goto err2;
-
 	if ((rc = cxl_update_image_control(adapter)))
 		goto err2;
 
@@ -1092,9 +1095,6 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
-	if ((rc = setup_cxl_bars(dev)))
-		return rc;
-
 	if ((rc = pci_enable_device(dev))) {
 		dev_err(&dev->dev, "pci_enable_device failed: %i\n", rc);
 		return rc;
-- 
2.1.0
