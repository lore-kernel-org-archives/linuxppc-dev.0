Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C42F2C0324
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:13 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:11 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E824C38C8027
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:08 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c8Ae6488364
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:08 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c8DB018616
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:08 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/9] powerpc/powernv: Add /proc/powerpc/eeh_inf_err
Date: Tue, 25 Feb 2014 13:37:49 +0800
Message-Id: <1393306670-17435-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds /proc/powerpc/eeh_inf_err to count the INF errors
happened on PHBs as Ben suggested.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   51 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 2 files changed, 52 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index cd06c52..3ddd706 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -20,6 +20,7 @@
 #include <linux/msi.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
 
 #include <asm/eeh.h>
@@ -35,6 +36,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+static u64 ioda_eeh_ioc_inf_err = 0;
+static int ioda_eeh_proc_init = 0;
 static int ioda_eeh_nb_init = 0;
 
 static int ioda_eeh_event(struct notifier_block *nb,
@@ -114,6 +117,44 @@ DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
 			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PROC_FS
+static int ioda_eeh_proc_show(struct seq_file *m, void *v)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+
+	if (!eeh_enabled()) {
+                seq_printf(m, "EEH Subsystem disabled\n");
+		return 0;
+	}
+
+	seq_printf(m, "EEH Subsystem enabled\n");
+	if (ioda_eeh_ioc_inf_err > 0)
+		seq_printf(m, "\nIOC INF Errors: %llu\n\n",
+			   ioda_eeh_ioc_inf_err);
+
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+		seq_printf(m, "PHB#%d INF Errors: %llu\n",
+			   hose->global_number, phb->inf_err);
+	}
+
+	return 0;
+}
+
+static int ioda_eeh_proc_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, ioda_eeh_proc_show, NULL);
+}
+
+static const struct file_operations ioda_eeh_proc_ops = {
+	.open		= ioda_eeh_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_PROC_FS */
+
 static void ioda_eeh_phb_diag(struct pci_controller *hose, char *buf)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -170,6 +211,14 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 #endif
 
+#ifdef CONFIG_PROC_FS
+	if (!ioda_eeh_proc_init) {
+		ioda_eeh_proc_init = 1;
+		proc_create("powerpc/eeh_inf_err", 0,
+			    NULL, &ioda_eeh_proc_ops);
+	}
+#endif
+
 	phb->flags |= PNV_PHB_FLAG_EEH;
 
 	return 0;
@@ -755,6 +804,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			} else if (severity == OPAL_EEH_SEV_INF) {
 				pr_info("EEH: IOC informative error "
 					"detected\n");
+				ioda_eeh_ioc_inf_err++;
 				ioda_eeh_hub_diag(hose);
 				ret = EEH_NEXT_ERR_NONE;
 			}
@@ -775,6 +825,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				pr_info("EEH: PHB#%x informative error "
 					"detected\n",
 					hose->global_number);
+				phb->inf_err++;
 				ioda_eeh_phb_diag(hose, phb->diag.blob);
 				ret = EEH_NEXT_ERR_NONE;
 			}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3645fc4..64ca719 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -97,6 +97,7 @@ struct pnv_phb {
 	spinlock_t		lock;
 
 #ifdef CONFIG_EEH
+	u64			inf_err;
 	struct pnv_eeh_ops	*eeh_ops;
 #endif
 
-- 
1.7.10.4
