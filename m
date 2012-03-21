Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F411B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 11:58:59 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 22 Mar 2012 06:28:56 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2M0wmg44124922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 06:28:48 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2M6TGYX023700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 17:29:17 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc/eeh: remove eeh information from pci_dn
Date: Wed, 21 Mar 2012 15:30:28 +0800
Message-Id: <1332315029-29688-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1332315029-29688-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1332315029-29688-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch removes the eeh information from pci_dn since the eeh
device (struct eeh_dev) already contained those information.
Also, the pseries IOMMU mapping functions have been changed
for a little bit to retrieve PE address from eeh device instead
of pci_dn.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h  |    8 --------
 arch/powerpc/platforms/pseries/iommu.c |   29 +++++++++++++----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 21f99ae..ac39e6a 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -156,14 +156,6 @@ struct pci_dn {
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
-	int	class_code;		/* pci device class */
-	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
-	int	eeh_config_addr;
-	int	eeh_pe_config_addr; /* new-style partition endpoint address */
-	int	eeh_check_count;	/* # times driver ignored error */
-	int	eeh_freeze_count;	/* # times this device froze up. */
-	int	eeh_false_positives;	/* # times this device reported #ff's */
-	u32	config_space[16];	/* saved PCI config space */
 #endif
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c442f2b..0915b1a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -809,8 +809,7 @@ machine_arch_initcall(pseries, find_existing_ddw_windows);
 static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 			struct ddw_query_response *query)
 {
-	struct device_node *dn;
-	struct pci_dn *pcidn;
+	struct eeh_dev *edev;
 	u32 cfg_addr;
 	u64 buid;
 	int ret;
@@ -821,12 +820,12 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	 * Retrieve them from the pci device, not the node with the
 	 * dma-window property
 	 */
-	dn = pci_device_to_OF_node(dev);
-	pcidn = PCI_DN(dn);
-	cfg_addr = pcidn->eeh_config_addr;
-	if (pcidn->eeh_pe_config_addr)
-		cfg_addr = pcidn->eeh_pe_config_addr;
-	buid = pcidn->phb->buid;
+	edev = pci_dev_to_eeh_dev(dev);
+	cfg_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		cfg_addr = edev->pe_config_addr;
+	buid = edev->phb->buid;
+
 	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
 		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
 	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
@@ -839,8 +838,7 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 			struct ddw_create_response *create, int page_shift,
 			int window_shift)
 {
-	struct device_node *dn;
-	struct pci_dn *pcidn;
+	struct eeh_dev *edev;
 	u32 cfg_addr;
 	u64 buid;
 	int ret;
@@ -851,12 +849,11 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	 * Retrieve them from the pci device, not the node with the
 	 * dma-window property
 	 */
-	dn = pci_device_to_OF_node(dev);
-	pcidn = PCI_DN(dn);
-	cfg_addr = pcidn->eeh_config_addr;
-	if (pcidn->eeh_pe_config_addr)
-		cfg_addr = pcidn->eeh_pe_config_addr;
-	buid = pcidn->phb->buid;
+	edev = pci_dev_to_eeh_dev(dev);
+	cfg_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		cfg_addr = edev->pe_config_addr;
+	buid = edev->phb->buid;
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-- 
1.7.5.4
