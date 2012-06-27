Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 517E2100A92
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:06:23 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:06:19 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6527238C814A
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:02 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG30ip163446
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:01 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG2BFZ005012
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/21] ppc/eeh: move stats to PE
Date: Thu, 28 Jun 2012 00:01:49 +0800
Message-Id: <1340812911-6793-20-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch removes the eeh related statistics for eeh device since
they have been maintained by the corresponding eeh PE. Also, the
flags used to trace the state of eeh device and PE have been reworked
for a little bit.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h              |    9 +--------
 arch/powerpc/platforms/pseries/eeh.c        |   13 +++----------
 arch/powerpc/platforms/pseries/eeh_cache.c  |    3 +--
 arch/powerpc/platforms/pseries/eeh_driver.c |    6 +++---
 arch/powerpc/platforms/pseries/eeh_sysfs.c  |    9 ---------
 5 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e07ece1..b7ac3f7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -77,20 +77,13 @@ struct eeh_pe {
  * another tree except the currently existing tree of PCI
  * buses and PCI devices
  */
-#define EEH_MODE_SUPPORTED	(1<<0)	/* EEH supported on the device	*/
-#define EEH_MODE_NOCHECK	(1<<1)	/* EEH check should be skipped	*/
-#define EEH_MODE_ISOLATED	(1<<2)	/* The device has been isolated	*/
-#define EEH_MODE_RECOVERING	(1<<3)	/* Recovering the device	*/
-#define EEH_MODE_IRQ_DISABLED	(1<<4)	/* Interrupt disabled		*/
+#define EEH_DEV_IRQ_DISABLED	(1<<0)	/* Interrupt disabled		*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
 	int class_code;			/* Class code of the device	*/
 	int config_addr;		/* Config address		*/
 	int pe_config_addr;		/* PE config address		*/
-	int check_count;		/* Times of ignored error	*/
-	int freeze_count;		/* Times of froze up		*/
-	int false_positives;		/* Times of reported #ff's	*/
 	u32 config_space[16];		/* Saved PCI config space	*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index d855c20..1438c4e 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -537,7 +537,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	 * pci slot reset line is dropped. Make sure we don't miss
 	 * these, and clear the flag now.
 	 */
-	eeh_pe_state_clear(pe, EEH_MODE_ISOLATED);
+	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 
 	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 
@@ -625,9 +625,6 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 
 	edev->class_code = 0;
 	edev->mode = 0;
-	edev->check_count = 0;
-	edev->freeze_count = 0;
-	edev->false_positives = 0;
 
 	if (!of_device_is_available(dn))
 		return NULL;
@@ -637,10 +634,8 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 		return NULL;
 
 	/* There is nothing to check on PCI to ISA bridges */
-	if (dn->type && !strcmp(dn->type, "isa")) {
-		edev->mode |= EEH_MODE_NOCHECK;
+	if (dn->type && !strcmp(dn->type, "isa"))
 		return NULL;
-	}
 	edev->class_code = *class_code;
 
 	/* Ok... see if this device supports EEH.  Some do, some don't,
@@ -679,7 +674,6 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 
 		if (enable) {
 			eeh_subsystem_enabled = 1;
-			edev->mode |= EEH_MODE_SUPPORTED;
 
 			eeh_pe_create(edev);
 
@@ -692,9 +686,8 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			 * EEH parent, in which case we mark it as supported.
 			 */
 			if (dn->parent && of_node_to_eeh_dev(dn->parent) &&
-			    (of_node_to_eeh_dev(dn->parent)->mode & EEH_MODE_SUPPORTED)) {
+			    of_node_to_eeh_dev(dn->parent)->pe) {
 				/* Parent supports EEH. */
-				edev->mode |= EEH_MODE_SUPPORTED;
 				edev->config_addr = of_node_to_eeh_dev(dn->parent)->config_addr;
 				edev->pe_config_addr = of_node_to_eeh_dev(dn->parent)->pe_config_addr;
 
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index f50b717..a191057 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -192,8 +192,7 @@ static void __pci_addr_cache_insert_device(struct pci_dev *dev)
 	}
 
 	/* Skip any devices for which EEH is not enabled. */
-	if (!(edev->mode & EEH_MODE_SUPPORTED) ||
-	    edev->mode & EEH_MODE_NOCHECK) {
+	if (!edev->pe) {
 #ifdef DEBUG
 		pr_info("PCI: skip building address cache for=%s - %s\n",
 			pci_name(dev), dn->full_name);
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 343c807..8370ce7 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -93,7 +93,7 @@ static void eeh_disable_irq(struct pci_dev *dev)
 	if (!irq_has_action(dev->irq))
 		return;
 
-	edev->mode |= EEH_MODE_IRQ_DISABLED;
+	edev->mode |= EEH_DEV_IRQ_DISABLED;
 	disable_irq_nosync(dev->irq);
 }
 
@@ -108,8 +108,8 @@ static void eeh_enable_irq(struct pci_dev *dev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 
-	if ((edev->mode) & EEH_MODE_IRQ_DISABLED) {
-		edev->mode &= ~EEH_MODE_IRQ_DISABLED;
+	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
+		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
 		enable_irq(dev->irq);
 	}
 }
diff --git a/arch/powerpc/platforms/pseries/eeh_sysfs.c b/arch/powerpc/platforms/pseries/eeh_sysfs.c
index 243b351..d377083 100644
--- a/arch/powerpc/platforms/pseries/eeh_sysfs.c
+++ b/arch/powerpc/platforms/pseries/eeh_sysfs.c
@@ -53,9 +53,6 @@ static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
 EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
 EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
 EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
-EEH_SHOW_ATTR(eeh_check_count,     check_count,     "%d"  );
-EEH_SHOW_ATTR(eeh_freeze_count,    freeze_count,    "%d"  );
-EEH_SHOW_ATTR(eeh_false_positives, false_positives, "%d"  );
 
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
@@ -64,9 +61,6 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_check_count);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_false_positives);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_freeze_count);
 
 	if (rc)
 		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
@@ -77,8 +71,5 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_check_count);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_false_positives);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_freeze_count);
 }
 
-- 
1.7.9.5
