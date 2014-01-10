Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1EFA2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 10:09:50 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Jan 2014 16:09:48 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 677126E803C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:09:41 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0AN9jnu524570
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 23:09:45 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0AN9it8018934
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:09:44 -0500
Date: Fri, 10 Jan 2014 15:09:38 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] Revert "powerpc/pseries/iommu: remove default window before
 attempting DDW manipulation"
Message-ID: <20140110230938.GA12343@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben rightfully pointed out that there is a race in the "newer" DDW code.
Presuming we are running on recent enough firmware that supports the
"reset" DDW manipulation call, we currently always remove the base
32-bit DMA window in order to maximize the resources for Phyp when
creating the 64-bit window. However, this can be problematic for the
case where multiple functions are in the same PE (partitionable
endpoint), where some funtions might be 32-bit DMA only. All of a
sudden, the only functional DMA window for such functions is gone. We
will have serious errors in such situations. The best solution is simply
to revert the extension to the DDW code where we ever remove the base
DMA window.

This reverts commit 25ebc45b93452d0bc60271f178237123c4b26808.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f253361..ed6e553 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -717,21 +717,6 @@ static int __init disable_ddw_setup(char *str)
 
 early_param("disable_ddw", disable_ddw_setup);
 
-static inline void __remove_ddw(struct device_node *np, const u32 *ddw_avail, u64 liobn)
-{
-	int ret;
-
-	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
-	if (ret)
-		pr_warning("%s: failed to remove DMA window: rtas returned "
-			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np->full_name, ret, ddw_avail[2], liobn);
-	else
-		pr_debug("%s: successfully removed DMA window: rtas returned "
-			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np->full_name, ret, ddw_avail[2], liobn);
-}
-
 static void remove_ddw(struct device_node *np)
 {
 	struct dynamic_dma_window_prop *dwp;
@@ -761,7 +746,15 @@ static void remove_ddw(struct device_node *np)
 		pr_debug("%s successfully cleared tces in window.\n",
 			 np->full_name);
 
-	__remove_ddw(np, ddw_avail, liobn);
+	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
+	if (ret)
+		pr_warning("%s: failed to remove direct window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddw_avail[2], liobn);
+	else
+		pr_debug("%s: successfully removed direct window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddw_avail[2], liobn);
 
 delprop:
 	ret = of_remove_property(np, win64);
@@ -921,12 +914,6 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	return ret;
 }
 
-static void restore_default_window(struct pci_dev *dev,
-					u32 ddw_restore_token)
-{
-	__restore_default_window(pci_dev_to_eeh_dev(dev), ddw_restore_token);
-}
-
 struct failed_ddw_pdn {
 	struct device_node *pdn;
 	struct list_head list;
@@ -954,13 +941,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
 	const u32 *uninitialized_var(ddw_avail);
-	const u32 *uninitialized_var(ddw_extensions);
-	u32 ddw_restore_token = 0;
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
-	const void *dma_window = NULL;
-	unsigned long liobn, offset, size;
 	struct failed_ddw_pdn *fpdn;
 
 	mutex_lock(&direct_window_init_mutex);
@@ -991,42 +974,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 */
 	ddw_avail = of_get_property(pdn, "ibm,ddw-applicable", &len);
 	if (!ddw_avail || len < 3 * sizeof(u32))
-		goto out_unlock;
-
-	/*
-	 * the extensions property is only required to exist in certain
-	 * levels of firmware and later
-	 * the ibm,ddw-extensions property is a list with the first
-	 * element containing the number of extensions and each
-	 * subsequent entry is a value corresponding to that extension
-	 */
-	ddw_extensions = of_get_property(pdn, "ibm,ddw-extensions", &len);
-	if (ddw_extensions) {
-		/*
-		 * each new defined extension length should be added to
-		 * the top of the switch so the "earlier" entries also
-		 * get picked up
-		 */
-		switch (ddw_extensions[0]) {
-			/* ibm,reset-pe-dma-windows */
-			case 1:
-				ddw_restore_token = ddw_extensions[1];
-				break;
-		}
-	}
+		goto out_failed;
 
-	/*
-	 * Only remove the existing DMA window if we can restore back to
-	 * the default state. Removing the existing window maximizes the
-	 * resources available to firmware for dynamic window creation.
-	 */
-	if (ddw_restore_token) {
-		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
-		of_parse_dma_window(pdn, dma_window, &liobn, &offset, &size);
-		__remove_ddw(pdn, ddw_avail, liobn);
-	}
-
-	/*
+       /*
 	 * Query if there is a second window of size to map the
 	 * whole partition.  Query returns number of windows, largest
 	 * block assigned to PE (partition endpoint), and two bitmasks
@@ -1035,7 +985,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dn = pci_device_to_OF_node(dev);
 	ret = query_ddw(dev, ddw_avail, &query);
 	if (ret != 0)
-		goto out_restore_window;
+		goto out_failed;
 
 	if (query.windows_available == 0) {
 		/*
@@ -1044,7 +994,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		 * trading in for a larger page size.
 		 */
 		dev_dbg(&dev->dev, "no free dynamic windows");
-		goto out_restore_window;
+		goto out_failed;
 	}
 	if (be32_to_cpu(query.page_size) & 4) {
 		page_shift = 24; /* 16MB */
@@ -1055,7 +1005,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	} else {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
 			  query.page_size);
-		goto out_restore_window;
+		goto out_failed;
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
@@ -1064,14 +1014,14 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
-		goto out_restore_window;
+		goto out_failed;
 	}
 	len = order_base_2(max_addr);
 	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
 	if (!win64) {
 		dev_info(&dev->dev,
 			"couldn't allocate property for 64bit dma window\n");
-		goto out_restore_window;
+		goto out_failed;
 	}
 	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
 	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
@@ -1133,9 +1083,7 @@ out_free_prop:
 	kfree(win64->value);
 	kfree(win64);
 
-out_restore_window:
-	if (ddw_restore_token)
-		restore_default_window(dev, ddw_restore_token);
+out_failed:
 
 	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
 	if (!fpdn)
