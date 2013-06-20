Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D728B2C02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:40 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 23:21:38 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 297991FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:16:22 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LaZP113034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LZLt015385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:35 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/31] powerpc/eeh: EEH core to handle special event
Date: Thu, 20 Jun 2013 13:21:04 +0800
Message-Id: <1371705681-24632-15-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, the EEH event caused by interrupt won't have
binding PE. The patch enables EEH core to handle the special event.
To avoid the current logic we have, The eeh_handle_event() is renamed
to eeh_handle_normal_event(), and the eeh_handle_special_event() is
introduced. The function eeh_handle_event() dispatches to above two
functions according to the input parameter. Besides, new backend
"next_error" added to eeh_ops and it's expected to have following
return values:

        4 - Dead IOC           3 - Dead PHB
        2 - Fenced PHB         1 - Frozen PE
        0 - No error found

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    2 +
 arch/powerpc/kernel/eeh_driver.c |  128 ++++++++++++++++++++++++++++++++-----
 2 files changed, 112 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 0c0ac93..a0b11fb 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -53,6 +53,7 @@ struct device_node;
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
+#define EEH_PE_PHB_DEAD		(1 << 2)	/* Dead PHB		*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
@@ -145,6 +146,7 @@ struct eeh_ops {
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
+	int (*next_error)(struct eeh_pe **pe);
 };
 
 extern struct eeh_ops *eeh_ops;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 678bc6c..0974e13 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -399,24 +399,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
  */
 #define MAX_WAIT_FOR_RECOVERY 150
 
-/**
- * eeh_handle_event - Reset a PCI device after hard lockup.
- * @pe: EEH PE
- *
- * While PHB detects address or data parity errors on particular PCI
- * slot, the associated PE will be frozen. Besides, DMA's occurring
- * to wild addresses (which usually happen due to bugs in device
- * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
- * #PERR or other misc PCI-related errors also can trigger EEH errors.
- *
- * Recovery process consists of unplugging the device driver (which
- * generated hotplug events to userspace), then issuing a PCI #RST to
- * the device, then reconfiguring the PCI config space for all bridges
- * & devices under this slot, and then finally restarting the device
- * drivers (which cause a second set of hotplug events to go out to
- * userspace).
- */
-void eeh_handle_event(struct eeh_pe *pe)
+static void eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *frozen_bus;
 	int rc = 0;
@@ -554,3 +537,112 @@ perm_error:
 	if (frozen_bus)
 		pcibios_remove_pci_devices(frozen_bus);
 }
+
+static void eeh_handle_special_event(void)
+{
+	struct eeh_pe *pe, *phb_pe;
+	struct pci_bus *bus;
+	struct pci_controller *hose, *tmp;
+	unsigned long flags;
+	int rc = 0;
+
+	/*
+	 * The return value from next_error() has been classified as follows.
+	 * It might be good to enumerate them. However, next_error() is only
+	 * supported by PowerNV platform for now. So it would be fine to use
+	 * integer directly:
+	 *
+	 * 4 - Dead IOC           3 - Dead PHB
+	 * 2 - Fenced PHB         1 - Frozen PE
+	 * 0 - No error found
+	 *
+	 */
+	rc = eeh_ops->next_error(&pe);
+	if (rc <= 0)
+		return;
+
+	switch (rc) {
+	case 4:
+		/* Mark all PHBs in dead state */
+		eeh_serialize_lock(&flags);
+		list_for_each_entry_safe(hose, tmp,
+				&hose_list, list_node) {
+			phb_pe = eeh_phb_pe_get(hose);
+			if (!phb_pe) continue;
+
+			eeh_pe_state_mark(phb_pe,
+				EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+		}
+		eeh_serialize_unlock(flags);
+
+		/* Purge all events */
+		eeh_remove_event(NULL);
+		break;
+	case 3:
+	case 2:
+	case 1:
+		/* Mark the PE in fenced state */
+		eeh_serialize_lock(&flags);
+		if (rc == 3)
+			eeh_pe_state_mark(pe,
+				EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+		else
+			eeh_pe_state_mark(pe,
+				EEH_PE_ISOLATED | EEH_PE_RECOVERING);
+		eeh_serialize_unlock(flags);
+
+		/* Purge all events of the PHB */
+		eeh_remove_event(pe);
+		break;
+	default:
+		pr_err("%s: Invalid value %d from next_error()\n",
+		       __func__, rc);
+		return;
+	}
+
+	/*
+	 * For fenced PHB and frozen PE, it's handled as normal
+	 * event. We have to remove the affected PHBs for dead
+	 * PHB and IOC
+	 */
+	if (rc == 2 || rc == 1)
+		eeh_handle_normal_event(pe);
+	else {
+		list_for_each_entry_safe(hose, tmp,
+			&hose_list, list_node) {
+			phb_pe = eeh_phb_pe_get(hose);
+			if (!phb_pe || !(phb_pe->state & EEH_PE_PHB_DEAD))
+				continue;
+
+			bus = eeh_pe_bus_get(phb_pe);
+			/* Notify all devices that they're about to go down. */
+			eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
+			pcibios_remove_pci_devices(bus);
+		}
+	}
+}
+
+/**
+ * eeh_handle_event - Reset a PCI device after hard lockup.
+ * @pe: EEH PE
+ *
+ * While PHB detects address or data parity errors on particular PCI
+ * slot, the associated PE will be frozen. Besides, DMA's occurring
+ * to wild addresses (which usually happen due to bugs in device
+ * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
+ * #PERR or other misc PCI-related errors also can trigger EEH errors.
+ *
+ * Recovery process consists of unplugging the device driver (which
+ * generated hotplug events to userspace), then issuing a PCI #RST to
+ * the device, then reconfiguring the PCI config space for all bridges
+ * & devices under this slot, and then finally restarting the device
+ * drivers (which cause a second set of hotplug events to go out to
+ * userspace).
+ */
+void eeh_handle_event(struct eeh_pe *pe)
+{
+	if (pe)
+		eeh_handle_normal_event(pe);
+	else
+		eeh_handle_special_event();
+}
-- 
1.7.5.4
