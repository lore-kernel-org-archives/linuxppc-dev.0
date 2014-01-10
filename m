Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33FA62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 10:10:52 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Jan 2014 18:10:50 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5D261C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:10:46 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0ANAmCo6881638
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 23:10:48 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0ANAmRv004265
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:10:48 -0500
Date: Fri, 10 Jan 2014 15:10:41 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] Revert "pseries/iommu: Remove DDW on kexec"
Message-ID: <20140110231041.GB12343@linux.vnet.ibm.com>
References: <20140110230938.GA12343@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140110230938.GA12343@linux.vnet.ibm.com>
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

After reverting 25ebc45b93452d0bc60271f178237123c4b26808
("powerpc/pseries/iommu: remove default window before attempting DDW
manipulation"), we no longer remove the base window in enable_ddw.
Therefore, we no longer need to reset the DMA window state in
find_existing_ddw_windows(). We can instead go back to what was done
before, which simply reuses the previous configuration, if any. Further,
this removes the final caller of the reset-pe-dma-windows call, so
remove those functions.

This fixes an EEH on kdump with the ipr driver. The EEH occurs, because
the initcall removes the DDW configuration (64-bit DMA window), but
doesn't ensure the ops are via the IOMMU -- a DMA operation occurs
during probe (still investigating this) and we EEH.

This reverts commit 14b6f00f8a4fdec5ccd45a0710284de301a61628.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ed6e553..dc79e7c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -783,68 +783,33 @@ static u64 find_existing_ddw(struct device_node *pdn)
 	return dma_addr;
 }
 
-static void __restore_default_window(struct eeh_dev *edev,
-						u32 ddw_restore_token)
-{
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
-	cfg_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		cfg_addr = edev->pe_config_addr;
-	buid = edev->phb->buid;
-
-	do {
-		ret = rtas_call(ddw_restore_token, 3, 1, NULL, cfg_addr,
-					BUID_HI(buid), BUID_LO(buid));
-	} while (rtas_busy_delay(ret));
-	pr_info("ibm,reset-pe-dma-windows(%x) %x %x %x returned %d\n",
-		 ddw_restore_token, cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
-}
-
 static int find_existing_ddw_windows(void)
 {
+	int len;
 	struct device_node *pdn;
+	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
-	const u32 *ddw_extensions;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, NULL);
+		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 		if (!direct64)
 			continue;
 
-		/*
-		 * We need to ensure the IOMMU table is active when we
-		 * return from the IOMMU setup so that the common code
-		 * can clear the table or find the holes. To that end,
-		 * first, remove any existing DDW configuration.
-		 */
-		remove_ddw(pdn);
+		window = kzalloc(sizeof(*window), GFP_KERNEL);
+		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
+			kfree(window);
+			remove_ddw(pdn);
+			continue;
+		}
 
-		/*
-		 * Second, if we are running on a new enough level of
-		 * firmware where the restore API is present, use it to
-		 * restore the 32-bit window, which was removed in
-		 * create_ddw.
-		 * If the API is not present, then create_ddw couldn't
-		 * have removed the 32-bit window in the first place, so
-		 * removing the DDW configuration should be sufficient.
-		 */
-		ddw_extensions = of_get_property(pdn, "ibm,ddw-extensions",
-									NULL);
-		if (ddw_extensions && ddw_extensions[0] > 0)
-			__restore_default_window(of_node_to_eeh_dev(pdn),
-							ddw_extensions[1]);
+		window->device = pdn;
+		window->prop = direct64;
+		spin_lock(&direct_window_list_lock);
+		list_add(&window->list, &direct_window_list);
+		spin_unlock(&direct_window_list_lock);
 	}
 
 	return 0;
