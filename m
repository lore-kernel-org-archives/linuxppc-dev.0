Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 37CF314017E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B2C012CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dQoK67043536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80SPS014928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 12/25] powerpc/eeh: Allow to disable EEH
Date: Thu, 24 Apr 2014 18:00:18 +1000
Message-Id: <1398326431-24305-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces bootarg "eeh=off" to disable EEH functinality.
Also, it creates /sys/kerenl/debug/powerpc/eeh_enable to disable
or enable EEH functionality. By default, we have the functionality
enabled.

For PowerNV platform, we will restore to have the conventional
mechanism of clearing frozen PE during PCI config access if we're
going to disable EEH functionality. Conversely, we will rely on
EEH for error recovery.

The patch also fixes the issue that we missed to cover the case
of disabled EEH functionality in function ioda_eeh_event(). Those
events driven by interrupt should be cleared to avoid endless
reporting.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 | 47 ++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/eeh-ioda.c | 29 +++++++++++++++----
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 06d2b7c..1e409a2 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/debugfs.h>
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -132,6 +133,15 @@ static struct eeh_stats eeh_stats;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
+static int __init eeh_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		eeh_subsystem_flags |= EEH_FORCE_DISABLED;
+
+	return 1;
+}
+__setup("eeh=", eeh_setup);
+
 /**
  * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
  * @edev: device to report data for
@@ -1117,10 +1127,45 @@ static const struct file_operations proc_eeh_operations = {
 	.release   = single_release,
 };
 
+#ifdef CONFIG_DEBUG_FS
+static int eeh_enable_dbgfs_set(void *data, u64 val)
+{
+	if (val)
+		eeh_subsystem_flags &= ~EEH_FORCE_DISABLED;
+	else
+		eeh_subsystem_flags |= EEH_FORCE_DISABLED;
+
+	/* Notify the backend */
+	if (eeh_ops->post_init)
+		eeh_ops->post_init();
+
+	return 0;
+}
+
+static int eeh_enable_dbgfs_get(void *data, u64 *val)
+{
+	if (eeh_enabled())
+		*val = 0x1ul;
+	else
+		*val = 0x0ul;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
+			eeh_enable_dbgfs_set, "0x%llx\n");
+#endif
+
 static int __init eeh_init_proc(void)
 {
-	if (machine_is(pseries) || machine_is(powernv))
+	if (machine_is(pseries) || machine_is(powernv)) {
 		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
+#ifdef CONFIG_DEBUG_FS
+		debugfs_create_file("eeh_enable", 0600,
+                                    powerpc_debugfs_root, NULL,
+                                    &eeh_enable_dbgfs_ops);
+#endif
+	}
+
 	return 0;
 }
 __initcall(eeh_init_proc);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 6bdae8d..35ec394 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -42,11 +42,19 @@ static int ioda_eeh_event(struct notifier_block *nb,
 {
 	uint64_t changed_evts = (uint64_t)change;
 
-	/* We simply send special EEH event */
-	if ((changed_evts & OPAL_EVENT_PCI_ERROR) &&
-	    (events & OPAL_EVENT_PCI_ERROR) &&
-	    eeh_enabled())
+	/*
+	 * We simply send special EEH event if EEH has
+	 * been enabled, or clear pending events in
+	 * case that we enable EEH soon
+	 */
+	if (!(changed_evts & OPAL_EVENT_PCI_ERROR) ||
+	    !(events & OPAL_EVENT_PCI_ERROR))
+		return 0;
+
+	if (eeh_enabled())
 		eeh_send_failure_event(NULL);
+	else
+		opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
 	return 0;
 }
@@ -141,7 +149,9 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	if (phb->dbgfs) {
+	if (!phb->has_dbgfs && phb->dbgfs) {
+		phb->has_dbgfs = 1;
+
 		debugfs_create_file("err_injct_outbound", 0600,
 				    phb->dbgfs, hose,
 				    &ioda_eeh_outb_dbgfs_ops);
@@ -154,7 +164,14 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 #endif
 
-	phb->flags |= PNV_PHB_FLAG_EEH;
+	/* If EEH is enabled, we're going to rely on that.
+	 * Otherwise, we restore to conventional mechanism
+	 * to clear frozen PE during PCI config access.
+	 */
+	if (eeh_enabled())
+		phb->flags |= PNV_PHB_FLAG_EEH;
+	else
+		phb->flags &= ~PNV_PHB_FLAG_EEH;
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 94e3495..39ec697 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -101,6 +101,7 @@ struct pnv_phb {
 #endif
 
 #ifdef CONFIG_DEBUG_FS
+	int			has_dbgfs;
 	struct dentry		*dbgfs;
 #endif
 
-- 
1.8.3.2
