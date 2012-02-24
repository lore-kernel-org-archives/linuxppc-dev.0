Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2ABDB6FDD
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:35 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 10:29:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9X0Tu2625738
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:33:00 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cNGk007734
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:23 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/21] pSeries platform EEH configure bridge
Date: Fri, 24 Feb 2012 17:38:08 +0800
Message-Id: <1330076298-7006-12-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to enable particular PCI device, which has been included
in the parent PE. The involved PCI bridges should be enabled explicitly
if there has. On pSeries platform, there're dedicated RTAS calls
to fulfil the purpose.

The patch implements the function of configuring PCI bridges through
the dedicated RTAS calls. Besides, the function has been abstracted
by struct eeh_ops::configure_bridge so that the EEH core components
could support multiple platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h           |    1 -
 arch/powerpc/platforms/pseries/eeh.c         |   44 +-------------------------
 arch/powerpc/platforms/pseries/eeh_driver.c  |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   29 ++++++++++++++++-
 4 files changed, 30 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index bd1a84f..b4b18d8 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -57,7 +57,6 @@ void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 int eeh_pci_enable(struct pci_dn *pdn, int function);
 int eeh_reset_pe(struct pci_dn *);
 void eeh_restore_bars(struct pci_dn *);
-void eeh_configure_bridge(struct pci_dn *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_mark_slot(struct device_node *dn, int mode_flag);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 39fcecb..bd4ed83 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -86,10 +86,6 @@
 /* Time to wait for a PCI slot to report status, in milliseconds */
 #define PCI_BUS_RESET_WAIT_MSEC (60*1000)
 
-/* RTAS tokens */
-static int ibm_configure_bridge;
-static int ibm_configure_pe;
-
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
 
@@ -229,7 +225,7 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 	pci_regs_buf[0] = 0;
 
 	eeh_pci_enable(pdn, EEH_OPT_THAW_MMIO);
-	eeh_configure_bridge(pdn);
+	eeh_ops->configure_bridge(pdn->node);
 	eeh_restore_bars(pdn);
 	loglen = eeh_gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
 
@@ -810,41 +806,6 @@ static void eeh_save_bars(struct pci_dn *pdn)
 }
 
 /**
- * eeh_configure_bridge - Configure PCI bridges for the indicated PE
- * @pdn: PCI device node
- *
- * PCI bridges might be included in PE. In order to make the PE work
- * again. The included PCI bridges should be recovered after the PE
- * encounters frozen state.
- */
-void eeh_configure_bridge(struct pci_dn *pdn)
-{
-	int config_addr;
-	int rc;
-	int token;
-
-	/* Use PE configuration address, if present */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
-
-	/* Use new configure-pe function, if supported */
-	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE)
-		token = ibm_configure_pe;
-	else
-		token = ibm_configure_bridge;
-
-	rc = rtas_call(token, 3, 1, NULL,
-	               config_addr,
-	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid));
-	if (rc) {
-		printk(KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n",
-		        rc, pdn->node->full_name);
-	}
-}
-
-/**
  * eeh_early_enable - Early enable EEH on the indicated device
  * @dn: device node
  * @data: BUID
@@ -1027,9 +988,6 @@ void __init eeh_init(void)
 	if (np == NULL)
 		return;
 
-	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
-	ibm_configure_pe = rtas_token("ibm,configure-pe");
-
 	/* Enable EEH for all adapters.  Note that eeh requires buid's */
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 6840357..61450e1 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -295,7 +295,7 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 		struct pci_dn *ppe = PCI_DN(dn);
 		/* On Power4, always true because eeh_pe_config_addr=0 */
 		if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
-			eeh_configure_bridge(ppe);
+			eeh_ops->configure_bridge(dn);
 			eeh_restore_bars(ppe);
  		}
 		dn = dn->sibling;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 7c8434f..4ed06b2 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -473,7 +473,34 @@ static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_l
  */
 static int pseries_eeh_configure_bridge(struct device_node *dn)
 {
-	return 0;
+	struct pci_dn *pdn;
+	int config_addr;
+	int ret;
+
+	/* Figure out the PE address */
+	pdn = PCI_DN(dn);
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	/* Use new configure-pe function, if supported */
+	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
+		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
+				config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid));
+	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
+		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
+				config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid));
+	} else {
+		return -EFAULT;
+	}
+
+	if (ret)
+		pr_warning("%s: Unable to configure bridge %d for %s\n",
+			__func__, ret, dn->full_name);
+
+	return ret;
 }
 
 static struct eeh_ops pseries_eeh_ops = {
-- 
1.7.5.4
