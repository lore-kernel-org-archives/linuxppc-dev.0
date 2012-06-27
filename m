Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69673B6FD5
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:40:07 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:40:05 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B4E743C61D70
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:04:02 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG434P103096
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:04:04 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG28q7004573
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/21] ppc/eeh: I/O enable and log retrival based on PE
Date: Thu, 28 Jun 2012 00:01:45 +0800
Message-Id: <1340812911-6793-16-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch refactors the original implementation in order to enable
I/O and do log retrieval based on PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |    4 ++--
 arch/powerpc/platforms/pseries/eeh.c |   44 +++++++++++++++-------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 5cbe3f2..5e34b10 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -51,8 +51,8 @@ void pci_addr_cache_build(void);
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
 struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
-void eeh_slot_error_detail(struct eeh_dev *edev, int severity);
-int eeh_pci_enable(struct eeh_dev *edev, int function);
+void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
+int eeh_pci_enable(struct eeh_pe *pe, int function);
 int eeh_reset_pe(struct eeh_dev *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 28d0c04..031935d 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -207,22 +207,12 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		}
 	}
 
-	/* Gather status on devices under the bridge */
-	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		struct device_node *child;
-
-		for_each_child_of_node(dn, child) {
-			if (of_node_to_eeh_dev(child))
-				n += eeh_gather_pci_data(of_node_to_eeh_dev(child), buf+n, len-n);
-		}
-	}
-
 	return n;
 }
 
 /**
  * eeh_slot_error_detail - Generate combined log including driver log and error log
- * @edev: device to report error log for
+ * @pe: EEH PE
  * @severity: temporary or permanent error log
  *
  * This routine should be called to generate the combined log, which
@@ -230,17 +220,22 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
  * out from the config space of the corresponding PCI device, while
  * the error log is fetched through platform dependent function call.
  */
-void eeh_slot_error_detail(struct eeh_dev *edev, int severity)
+void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 {
 	size_t loglen = 0;
-	pci_regs_buf[0] = 0;
+	struct eeh_dev *edev;
 
-	eeh_pci_enable(edev, EEH_OPT_THAW_MMIO);
-	eeh_ops->configure_bridge(eeh_dev_to_of_node(edev));
-	eeh_restore_bars(edev);
-	loglen = eeh_gather_pci_data(edev, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
+	eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+	eeh_ops->configure_bridge(pe);
+	eeh_pe_restore_bars(pe);
 
-	eeh_ops->get_log(eeh_dev_to_of_node(edev), severity, pci_regs_buf, loglen);
+	pci_regs_buf[0] = 0;
+	eeh_pe_for_each_dev(pe, edev) {
+		loglen += eeh_gather_pci_data(edev, pci_regs_buf,
+				EEH_PCI_REGS_LOG_LEN);
+        }
+
+	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
 }
 
 /**
@@ -427,23 +422,22 @@ EXPORT_SYMBOL(eeh_check_failure);
 
 /**
  * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
- * @edev: pci device node
+ * @pe: EEH PE
  *
  * This routine should be called to reenable frozen MMIO or DMA
  * so that it would work correctly again. It's useful while doing
  * recovery or log collection on the indicated device.
  */
-int eeh_pci_enable(struct eeh_dev *edev, int function)
+int eeh_pci_enable(struct eeh_pe *pe, int function)
 {
 	int rc;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
 
-	rc = eeh_ops->set_option(dn, function);
+	rc = eeh_ops->set_option(pe, function);
 	if (rc)
-		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
-		        function, rc, dn->full_name);
+		pr_warning("%s: Unexpected state change %d on PHB#%d-PE#%x, err=%d\n",
+			__func__, function, pe->phb->global_number, pe->addr, rc);
 
-	rc = eeh_ops->wait_state(dn, PCI_BUS_RESET_WAIT_MSEC);
+	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
 	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
 	   (function == EEH_OPT_THAW_MMIO))
 		return 0;
-- 
1.7.9.5
