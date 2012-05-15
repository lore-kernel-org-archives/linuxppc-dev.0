Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3248B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2012 03:12:50 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 15 May 2012 13:12:47 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A0B0A38C8065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 13:04:42 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4FH4gWD092548
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 13:04:42 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4FH4fEx032096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 13:04:41 -0400
Date: Tue, 15 May 2012 10:04:32 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] pseries/iommu: remove default window before attempting DDW
 manipulation
Message-ID: <20120515170432.GB14272@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An upcoming release of firmware will add DDW extensions, in particular
an API to "reset" the DMA window to the original configuration (32-bit,
2GB in size). With that API available, we can safely remove the default
window, increasing the resources available to firmware for creation of
larger windows for the slot in question -- if we encounter an error, we
can use the new API to reset the state of the slot.

Further, this same release of firmware will make it a hard requirement
for OSes to release the existing window before any other windows will be
shown as available, to avoid conflicts in addressing between the two
windows.

In anticipation of these changes, always remove the default window
before we do any DDW manipulations.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0915b1a..526076b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -707,6 +707,21 @@ static int __init disable_ddw_setup(char *str)
 
 early_param("disable_ddw", disable_ddw_setup);
 
+static inline void __remove_ddw(struct device_node *np, const u32 *ddw_avail, u64 liobn)
+{
+	int ret;
+
+	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
+	if (ret)
+		pr_warning("%s: failed to remove DMA window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddw_avail[2], liobn);
+	else
+		pr_debug("%s: successfully removed DMA window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddw_avail[2], liobn);
+}
+
 static void remove_ddw(struct device_node *np)
 {
 	struct dynamic_dma_window_prop *dwp;
@@ -736,15 +751,7 @@ static void remove_ddw(struct device_node *np)
 		pr_debug("%s successfully cleared tces in window.\n",
 			 np->full_name);
 
-	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
-	if (ret)
-		pr_warning("%s: failed to remove direct window: rtas returned "
-			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np->full_name, ret, ddw_avail[2], liobn);
-	else
-		pr_debug("%s: successfully removed direct window: rtas returned "
-			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np->full_name, ret, ddw_avail[2], liobn);
+	__remove_ddw(np, ddw_avail, liobn);
 
 delprop:
 	ret = prom_remove_property(np, win64);
@@ -869,6 +876,35 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	return ret;
 }
 
+static void restore_default_window(struct pci_dev *dev,
+				u32 ddw_restore_token, unsigned long liobn)
+{
+	struct eeh_dev *edev;
+	u32 cfg_addr;
+	u64 buid;
+	int ret;
+
+	/*
+	 * Get the config address and phb buid of the PE window.
+	 * Rely on eeh to retrieve this for us.
+	 * Retrieve them from the pci device, not the node with the
+	 * dma-window property
+	 */
+	edev = pci_dev_to_eeh_dev(dev);
+	cfg_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		cfg_addr = edev->pe_config_addr;
+	buid = edev->phb->buid;
+
+	do {
+		ret = rtas_call(ddw_restore_token, 3, 1, NULL, cfg_addr,
+					BUID_HI(buid), BUID_LO(buid));
+	} while (rtas_busy_delay(ret));
+	dev_info(&dev->dev,
+		"ibm,reset-pe-dma-windows(%x) %x %x %x returned %d\n",
+		 ddw_restore_token, cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -889,9 +925,13 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
 	const u32 *uninitialized_var(ddw_avail);
+	const u32 *uninitialized_var(ddw_extensions);
+	u32 ddw_restore_token = 0;
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
+	const void *dma_window = NULL;
+	unsigned long liobn, offset, size;
 
 	mutex_lock(&direct_window_init_mutex);
 
@@ -911,7 +951,40 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (!ddw_avail || len < 3 * sizeof(u32))
 		goto out_unlock;
 
-       /*
+	/*
+	 * the extensions property is only required to exist in certain
+	 * levels of firmware and later
+	 * the ibm,ddw-extensions property is a list with the first
+	 * element containing the number of extensions and each
+	 * subsequent entry is a value corresponding to that extension
+	 */
+	ddw_extensions = of_get_property(pdn, "ibm,ddw-extensions", &len);
+	if (ddw_extensions) {
+		/*
+		 * each new defined extension length should be added to
+		 * the top of the switch so the "earlier" entries also
+		 * get picked up
+		 */
+		switch (ddw_extensions[0]) {
+			/* ibm,reset-pe-dma-windows */
+			case 1:
+				ddw_restore_token = ddw_extensions[1];
+				break;
+		}
+	}
+
+	/*
+	 * Only remove the existing DMA window if we can restore back to
+	 * the default state. Removing the existing window maximizes the
+	 * resources available to firmware for dynamic window creation.
+	 */
+	if (ddw_restore_token) {
+		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
+		of_parse_dma_window(pdn, dma_window, &liobn, &offset, &size);
+		__remove_ddw(pdn, ddw_avail, liobn);
+	}
+
+	/*
 	 * Query if there is a second window of size to map the
 	 * whole partition.  Query returns number of windows, largest
 	 * block assigned to PE (partition endpoint), and two bitmasks
@@ -920,7 +993,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dn = pci_device_to_OF_node(dev);
 	ret = query_ddw(dev, ddw_avail, &query);
 	if (ret != 0)
-		goto out_unlock;
+		goto out_restore_window;
 
 	if (query.windows_available == 0) {
 		/*
@@ -929,7 +1002,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		 * trading in for a larger page size.
 		 */
 		dev_dbg(&dev->dev, "no free dynamic windows");
-		goto out_unlock;
+		goto out_restore_window;
 	}
 	if (query.page_size & 4) {
 		page_shift = 24; /* 16MB */
@@ -940,7 +1013,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	} else {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
 			  query.page_size);
-		goto out_unlock;
+		goto out_restore_window;
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
@@ -949,14 +1022,14 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
-		goto out_unlock;
+		goto out_restore_window;
 	}
 	len = order_base_2(max_addr);
 	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
 	if (!win64) {
 		dev_info(&dev->dev,
 			"couldn't allocate property for 64bit dma window\n");
-		goto out_unlock;
+		goto out_restore_window;
 	}
 	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
 	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
@@ -1018,6 +1091,10 @@ out_free_prop:
 	kfree(win64->value);
 	kfree(win64);
 
+out_restore_window:
+	if (ddw_restore_token)
+		restore_default_window(dev, ddw_restore_token, liobn);
+
 out_unlock:
 	mutex_unlock(&direct_window_init_mutex);
 	return dma_addr;

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
