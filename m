Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6CC32C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 13:04:09 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Jan 2013 21:04:07 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3F2ACC9004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 21:04:03 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0T243Ak305434
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 21:04:03 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0T242qd007387
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 00:04:02 -0200
Date: Mon, 28 Jan 2013 18:03:58 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 2/2] pseries/iommu: remove DDW on kexec
Message-ID: <20130129020357.GB12156@linux.vnet.ibm.com>
References: <20130129020245.GA12156@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130129020245.GA12156@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 miltonm@bga.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/iommu: remove DDW on kexec
    
We currently insert a property in the device-tree when we successfully
configure DDW for a given slot. This was meant to be an optimization to
speed up kexec/kdump, so that we don't need to make the RTAS calls again
to re-configured DDW in the new kernel.
    
However, we end up tripping a plpar_tce_stuff failure on kexec/kdump
because we unconditionally parse the ibm,dma-window property for the
node at bus/dev setup time. This property contains the 32-bit DMA window
LIOBN, which is distinct from the DDW window's. We pass that LIOBN (via
iommu_table_init -> iommu_table_clear -> tce_free ->
tce_freemulti_pSeriesLP) to plpar_tce_stuff, which fails because that
32-bit window is no longer present after
25ebc45b93452d0bc60271f178237123c4b26808 ("powerpc/pseries/iommu: remove
default window before attempting DDW manipulation").
    
I believe the simplest, easiest-to-maintain fix is to just change our
initcall to, rather than detecting and updating the new kernel's DDW
knowledge, just remove all DDW configurations. When the drivers
re-initialize, we will set everything back up as it was before.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a8e99f9..1b2a174 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -787,33 +787,68 @@ static u64 find_existing_ddw(struct device_node *pdn)
 	return dma_addr;
 }
 
+static void __restore_default_window(struct eeh_dev *edev,
+						u32 ddw_restore_token)
+{
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
+	cfg_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		cfg_addr = edev->pe_config_addr;
+	buid = edev->phb->buid;
+
+	do {
+		ret = rtas_call(ddw_restore_token, 3, 1, NULL, cfg_addr,
+					BUID_HI(buid), BUID_LO(buid));
+	} while (rtas_busy_delay(ret));
+	pr_info("ibm,reset-pe-dma-windows(%x) %x %x %x returned %d\n",
+		 ddw_restore_token, cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
+}
+
 static int find_existing_ddw_windows(void)
 {
-	int len;
 	struct device_node *pdn;
-	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
+	const u32 *ddw_extensions;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
+		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, NULL);
 		if (!direct64)
 			continue;
 
-		window = kzalloc(sizeof(*window), GFP_KERNEL);
-		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
-			kfree(window);
-			remove_ddw(pdn);
-			continue;
-		}
+		/*
+		 * We need to ensure the IOMMU table is active when we
+		 * return from the IOMMU setup so that the common code
+		 * can clear the table or find the holes. To that end,
+		 * first, remove any existing DDW configuration.
+		 */
+		remove_ddw(pdn);
 
-		window->device = pdn;
-		window->prop = direct64;
-		spin_lock(&direct_window_list_lock);
-		list_add(&window->list, &direct_window_list);
-		spin_unlock(&direct_window_list_lock);
+		/*
+		 * Second, if we are running on a new enough level of
+		 * firmware where the restore API is present, use it to
+		 * restore the 32-bit window, which was removed in
+		 * create_ddw.
+		 * If the API is not present, then create_ddw couldn't
+		 * have removed the 32-bit window in the first place, so
+		 * removing the DDW configuration should be sufficient.
+		 */
+		ddw_extensions = of_get_property(pdn, "ibm,ddw-extensions",
+									NULL);
+		if (ddw_extensions && ddw_extensions[0] > 0)
+			__restore_default_window(of_node_to_eeh_dev(pdn),
+							ddw_extensions[1]);
 	}
 
 	return 0;
@@ -886,30 +921,7 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 static void restore_default_window(struct pci_dev *dev,
 					u32 ddw_restore_token)
 {
-	struct eeh_dev *edev;
-	u32 cfg_addr;
-	u64 buid;
-	int ret;
-
-	/*
-	 * Get the config address and phb buid of the PE window.
-	 * Rely on eeh to retrieve this for us.
-	 * Retrieve them from the pci device, not the node with the
-	 * dma-window property
-	 */
-	edev = pci_dev_to_eeh_dev(dev);
-	cfg_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		cfg_addr = edev->pe_config_addr;
-	buid = edev->phb->buid;
-
-	do {
-		ret = rtas_call(ddw_restore_token, 3, 1, NULL, cfg_addr,
-					BUID_HI(buid), BUID_LO(buid));
-	} while (rtas_busy_delay(ret));
-	dev_info(&dev->dev,
-		"ibm,reset-pe-dma-windows(%x) %x %x %x returned %d\n",
-		 ddw_restore_token, cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
+	__restore_default_window(pci_dev_to_eeh_dev(dev), ddw_restore_token);
 }
 
 /*
