Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30ADF2C00A5
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 18:25:33 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 00:25:31 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 74B1D3E40040
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:28 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C7P7V36816042
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 08:25:07 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C7PCV5000825
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:12 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/eeh: Cleanup on eeh_subsystem_enabled
Date: Wed, 12 Feb 2014 15:24:55 +0800
Message-Id: <1392189896-18882-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1392189896-18882-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1392189896-18882-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch cleans up variable eeh_subsystem_enabled so that we needn't
refer the variable directly from external. Instead, we will use
function eeh_enabled() and eeh_set_enable() to operate the variable.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   21 +++++++++++++++++++--
 arch/powerpc/kernel/eeh.c                    |   12 ++++++------
 arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9e39ceb..d4dd41f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -172,10 +172,20 @@ struct eeh_ops {
 };
 
 extern struct eeh_ops *eeh_ops;
-extern int eeh_subsystem_enabled;
+extern bool eeh_subsystem_enabled;
 extern raw_spinlock_t confirm_error_lock;
 extern int eeh_probe_mode;
 
+static inline bool eeh_enabled(void)
+{
+	return eeh_subsystem_enabled;
+}
+
+static inline void eeh_set_enable(bool mode)
+{
+	eeh_subsystem_enabled = mode;
+}
+
 #define EEH_PROBE_MODE_DEV	(1<<0)	/* From PCI device	*/
 #define EEH_PROBE_MODE_DEVTREE	(1<<1)	/* From device tree	*/
 
@@ -246,7 +256,7 @@ void eeh_remove_device(struct pci_dev *);
  * If this macro yields TRUE, the caller relays to eeh_check_failure()
  * which does further tests out of line.
  */
-#define EEH_POSSIBLE_ERROR(val, type)	((val) == (type)~0 && eeh_subsystem_enabled)
+#define EEH_POSSIBLE_ERROR(val, type)	((val) == (type)~0 && eeh_enabled())
 
 /*
  * Reads from a device which has been isolated by EEH will return
@@ -257,6 +267,13 @@ void eeh_remove_device(struct pci_dev *);
 
 #else /* !CONFIG_EEH */
 
+static inline bool eeh_enabled(void)
+{
+        return false;
+}
+
+static inline void eeh_set_enable(bool mode) { }
+
 static inline int eeh_init(void)
 {
 	return 0;
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 148db72..f22f7b6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -89,7 +89,7 @@
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
 
-int eeh_subsystem_enabled;
+bool eeh_subsystem_enabled = false;
 EXPORT_SYMBOL(eeh_subsystem_enabled);
 
 /*
@@ -364,7 +364,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 
 	eeh_stats.total_mmio_ffs++;
 
-	if (!eeh_subsystem_enabled)
+	if (!eeh_enabled())
 		return 0;
 
 	if (!edev) {
@@ -822,7 +822,7 @@ int eeh_init(void)
 			return ret;
 	}
 
-	if (eeh_subsystem_enabled)
+	if (eeh_enabled())
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
 		pr_warning("EEH: No capable adapters found\n");
@@ -897,7 +897,7 @@ void eeh_add_device_late(struct pci_dev *dev)
 	struct device_node *dn;
 	struct eeh_dev *edev;
 
-	if (!dev || !eeh_subsystem_enabled)
+	if (!dev || !eeh_enabled())
 		return;
 
 	pr_debug("EEH: Adding device %s\n", pci_name(dev));
@@ -1005,7 +1005,7 @@ void eeh_remove_device(struct pci_dev *dev)
 {
 	struct eeh_dev *edev;
 
-	if (!dev || !eeh_subsystem_enabled)
+	if (!dev || !eeh_enabled())
 		return;
 	edev = pci_dev_to_eeh_dev(dev);
 
@@ -1045,7 +1045,7 @@ void eeh_remove_device(struct pci_dev *dev)
 
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
-	if (0 == eeh_subsystem_enabled) {
+	if (!eeh_enabled()) {
 		seq_printf(m, "EEH Subsystem is globally disabled\n");
 		seq_printf(m, "eeh_total_mmio_ffs=%llu\n", eeh_stats.total_mmio_ffs);
 	} else {
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a79fddc..a59788e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -145,7 +145,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * Enable EEH explicitly so that we will do EEH check
 	 * while accessing I/O stuff
 	 */
-	eeh_subsystem_enabled = 1;
+	eeh_set_enable(true);
 
 	/* Save memory bars */
 	eeh_save_bars(edev);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 9ef3cc8..8a8f047 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -265,7 +265,7 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 			enable = 1;
 
 		if (enable) {
-			eeh_subsystem_enabled = 1;
+			eeh_set_enable(true);
 			eeh_add_to_parent_pe(edev);
 
 			pr_debug("%s: EEH enabled on %s PHB#%d-PE#%x, config addr#%x\n",
-- 
1.7.10.4
