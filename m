Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54C15B6F86
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 03:38:36 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 11:38:33 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DACCDC93A51
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG28l3145704
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG27en010687
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 13:02:08 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/21] ppc/eeh: trace error based on PE from beginning
Date: Thu, 28 Jun 2012 00:01:42 +0800
Message-Id: <1340812911-6793-13-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're 2 conditions to trigger EEH error detection: invalid value
returned from reading I/O or config space. On each case, the function
eeh_dn_check_failure will be called to initialize EEH event and put
it into the poll for further processing.

The patch changes the function for a little bit so that the EEH error
will be traced based on PE instead of EEH device any more. Also, the
function eeh_find_device_pe() has been removed since the eeh device
is tracing the PE by struct eeh_dev::pe.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |    1 -
 arch/powerpc/platforms/pseries/eeh.c |   51 +++++++++++++---------------------
 arch/powerpc/platforms/pseries/msi.c |    6 +++-
 3 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index c7e5bd6..3e301b1 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -59,7 +59,6 @@ int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
 void eeh_pe_state_clear(struct eeh_pe *pe, int state);
-struct device_node *eeh_find_device_pe(struct device_node *dn);
 
 void eeh_sysfs_add_device(struct pci_dev *pdev);
 void eeh_sysfs_remove_device(struct pci_dev *pdev);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index c527c46..341ba1a 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -264,21 +264,6 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 }
 
 /**
- * eeh_find_device_pe - Retrieve the PE for the given device
- * @dn: device node
- *
- * Return the PE under which this device lies
- */
-struct device_node *eeh_find_device_pe(struct device_node *dn)
-{
-	while (dn->parent && of_node_to_eeh_dev(dn->parent) &&
-	       (of_node_to_eeh_dev(dn->parent)->mode & EEH_MODE_SUPPORTED)) {
-		dn = dn->parent;
-	}
-	return dn;
-}
-
-/**
  * eeh_dn_check_failure - Check if all 1's data is due to EEH slot freeze
  * @dn: device node
  * @dev: pci device, if known
@@ -297,6 +282,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	unsigned long flags;
+	struct eeh_pe *pe;
 	struct eeh_dev *edev;
 	int rc = 0;
 	const char *location;
@@ -306,23 +292,26 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	if (!eeh_subsystem_enabled)
 		return 0;
 
-	if (!dn) {
+	if (dn) {
+		edev = of_node_to_eeh_dev(dn);
+	} else if (dev) {
+		edev = pci_dev_to_eeh_dev(dev);
+		dn = pci_device_to_OF_node(dev);
+	} else {
 		eeh_stats.no_dn++;
 		return 0;
 	}
-	dn = eeh_find_device_pe(dn);
-	edev = of_node_to_eeh_dev(dn);
+	pe = edev->pe;
 
 	/* Access to IO BARs might get this far and still not want checking. */
-	if (!(edev->mode & EEH_MODE_SUPPORTED) ||
-	    edev->mode & EEH_MODE_NOCHECK) {
+	if (!pe) {
 		eeh_stats.ignored_check++;
-		pr_debug("EEH: Ignored check (%x) for %s %s\n",
-			edev->mode, eeh_pci_name(dev), dn->full_name);
+		pr_debug("EEH: Ignored check for %s %s\n",
+			eeh_pci_name(dev), dn->full_name);
 		return 0;
 	}
 
-	if (!edev->config_addr && !edev->pe_config_addr) {
+	if (!pe->addr && !pe->config_addr) {
 		eeh_stats.no_cfg_addr++;
 		return 0;
 	}
@@ -335,13 +324,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 */
 	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	rc = 1;
-	if (edev->mode & EEH_MODE_ISOLATED) {
-		edev->check_count++;
-		if (edev->check_count % EEH_MAX_FAILS == 0) {
+	if (pe->state & EEH_PE_ISOLATED) {
+		pe->check_count++;
+		if (pe->check_count % EEH_MAX_FAILS == 0) {
 			location = of_get_property(dn, "ibm,loc-code", NULL);
 			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
-				edev->check_count, location,
+				pe->check_count, location,
 				eeh_driver_name(dev), eeh_pci_name(dev));
 			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
 				eeh_driver_name(dev));
@@ -357,7 +346,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 * function zero of a multi-function device.
 	 * In any case they must share a common PHB.
 	 */
-	ret = eeh_ops->get_state(dn, NULL);
+	ret = eeh_ops->get_state(pe, NULL);
 
 	/* Note that config-io to empty slots may fail;
 	 * they are empty when they don't have children.
@@ -370,7 +359,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
 	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
 		eeh_stats.false_positives++;
-		edev->false_positives ++;
+		pe->false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
@@ -381,10 +370,10 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 * with other functions on this device, and functions under
 	 * bridges.
 	 */
-	eeh_mark_slot(dn, EEH_MODE_ISOLATED);
+	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event(edev);
+	eeh_send_failure_event(pe);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 109fdb7..c8534fa 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -210,6 +210,7 @@ static struct device_node *find_pe_total_msi(struct pci_dev *dev, int *total)
 static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 {
 	struct device_node *dn;
+	struct eeh_dev *edev;
 
 	/* Found our PE and assume 8 at that point. */
 
@@ -217,7 +218,10 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 	if (!dn)
 		return NULL;
 
-	dn = eeh_find_device_pe(dn);
+	/* Get the top level device in the PE */
+	edev = of_node_to_eeh_dev(dn);
+	edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
+	dn = eeh_dev_to_of_node(edev);
 	if (!dn)
 		return NULL;
 
-- 
1.7.9.5
