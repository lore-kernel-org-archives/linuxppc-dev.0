Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0A181A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:04 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E26614021A
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8F1442CE8040
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3krBZ37617670
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kRPS005742
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/10] powerpc/powernv: Drop PHB operation post_init()
Date: Mon, 16 Feb 2015 14:45:41 +1100
Message-Id: <1424058348-28951-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation post_init() and merge its logic
to eeh_ops::post_init().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 193 ---------------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 184 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h         |   1 -
 3 files changed, 179 insertions(+), 199 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index dd154cf..bd509ad 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -34,198 +34,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-static int ioda_eeh_nb_init = 0;
-
-static int ioda_eeh_event(struct notifier_block *nb,
-			  unsigned long events, void *change)
-{
-	uint64_t changed_evts = (uint64_t)change;
-
-	/*
-	 * We simply send special EEH event if EEH has
-	 * been enabled, or clear pending events in
-	 * case that we enable EEH soon
-	 */
-	if (!(changed_evts & OPAL_EVENT_PCI_ERROR) ||
-	    !(events & OPAL_EVENT_PCI_ERROR))
-		return 0;
-
-	if (eeh_enabled())
-		eeh_send_failure_event(NULL);
-	else
-		opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
-
-	return 0;
-}
-
-static struct notifier_block ioda_eeh_nb = {
-	.notifier_call	= ioda_eeh_event,
-	.next		= NULL,
-	.priority	= 0
-};
-
-#ifdef CONFIG_DEBUG_FS
-static ssize_t ioda_eeh_ei_write(struct file *filp,
-				 const char __user *user_buf,
-				 size_t count, loff_t *ppos)
-{
-	struct pci_controller *hose = filp->private_data;
-	struct eeh_dev *edev;
-	struct eeh_pe *pe;
-	int pe_no, type, func;
-	unsigned long addr, mask;
-	char buf[50];
-	int ret;
-
-	if (!eeh_ops || !eeh_ops->err_inject)
-		return -ENXIO;
-
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
-	if (!ret)
-		return -EFAULT;
-
-	/* Retrieve parameters */
-	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
-		     &pe_no, &type, &func, &addr, &mask);
-	if (ret != 5)
-		return -EINVAL;
-
-	/* Retrieve PE */
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev)
-		return -ENOMEM;
-	edev->phb = hose;
-	edev->pe_config_addr = pe_no;
-	pe = eeh_pe_get(edev);
-	kfree(edev);
-	if (!pe)
-		return -ENODEV;
-
-	/* Do error injection */
-	ret = eeh_ops->err_inject(pe, type, func, addr, mask);
-	return ret < 0 ? ret : count;
-}
-
-static const struct file_operations ioda_eeh_ei_fops = {
-	.open   = simple_open,
-	.llseek = no_llseek,
-	.write  = ioda_eeh_ei_write,
-};
-
-static int ioda_eeh_dbgfs_set(void *data, int offset, u64 val)
-{
-	struct pci_controller *hose = data;
-	struct pnv_phb *phb = hose->private_data;
-
-	out_be64(phb->regs + offset, val);
-	return 0;
-}
-
-static int ioda_eeh_dbgfs_get(void *data, int offset, u64 *val)
-{
-	struct pci_controller *hose = data;
-	struct pnv_phb *phb = hose->private_data;
-
-	*val = in_be64(phb->regs + offset);
-	return 0;
-}
-
-static int ioda_eeh_outb_dbgfs_set(void *data, u64 val)
-{
-	return ioda_eeh_dbgfs_set(data, 0xD10, val);
-}
-
-static int ioda_eeh_outb_dbgfs_get(void *data, u64 *val)
-{
-	return ioda_eeh_dbgfs_get(data, 0xD10, val);
-}
-
-static int ioda_eeh_inbA_dbgfs_set(void *data, u64 val)
-{
-	return ioda_eeh_dbgfs_set(data, 0xD90, val);
-}
-
-static int ioda_eeh_inbA_dbgfs_get(void *data, u64 *val)
-{
-	return ioda_eeh_dbgfs_get(data, 0xD90, val);
-}
-
-static int ioda_eeh_inbB_dbgfs_set(void *data, u64 val)
-{
-	return ioda_eeh_dbgfs_set(data, 0xE10, val);
-}
-
-static int ioda_eeh_inbB_dbgfs_get(void *data, u64 *val)
-{
-	return ioda_eeh_dbgfs_get(data, 0xE10, val);
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_outb_dbgfs_ops, ioda_eeh_outb_dbgfs_get,
-			ioda_eeh_outb_dbgfs_set, "0x%llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbA_dbgfs_ops, ioda_eeh_inbA_dbgfs_get,
-			ioda_eeh_inbA_dbgfs_set, "0x%llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
-			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
-#endif /* CONFIG_DEBUG_FS */
-
-
-/**
- * ioda_eeh_post_init - Chip dependent post initialization
- * @hose: PCI controller
- *
- * The function will be called after eeh PEs and devices
- * have been built. That means the EEH is ready to supply
- * service with I/O cache.
- */
-static int ioda_eeh_post_init(struct pci_controller *hose)
-{
-	struct pnv_phb *phb = hose->private_data;
-	int ret;
-
-	/* Register OPAL event notifier */
-	if (!ioda_eeh_nb_init) {
-		ret = opal_notifier_register(&ioda_eeh_nb);
-		if (ret) {
-			pr_err("%s: Can't register OPAL event notifier (%d)\n",
-			       __func__, ret);
-			return ret;
-		}
-
-		ioda_eeh_nb_init = 1;
-	}
-
-#ifdef CONFIG_DEBUG_FS
-	if (!phb->has_dbgfs && phb->dbgfs) {
-		phb->has_dbgfs = 1;
-
-		debugfs_create_file("err_injct", 0200,
-				    phb->dbgfs, hose,
-				    &ioda_eeh_ei_fops);
-
-		debugfs_create_file("err_injct_outbound", 0600,
-				    phb->dbgfs, hose,
-				    &ioda_eeh_outb_dbgfs_ops);
-		debugfs_create_file("err_injct_inboundA", 0600,
-				    phb->dbgfs, hose,
-				    &ioda_eeh_inbA_dbgfs_ops);
-		debugfs_create_file("err_injct_inboundB", 0600,
-				    phb->dbgfs, hose,
-				    &ioda_eeh_inbB_dbgfs_ops);
-	}
-#endif
-
-	/* If EEH is enabled, we're going to rely on that.
-	 * Otherwise, we restore to conventional mechanism
-	 * to clear frozen PE during PCI config access.
-	 */
-	if (eeh_enabled())
-		phb->flags |= PNV_PHB_FLAG_EEH;
-	else
-		phb->flags &= ~PNV_PHB_FLAG_EEH;
-
-	return 0;
-}
-
 /**
  * ioda_eeh_set_option - Set EEH operation or I/O setting
  * @pe: EEH PE
@@ -1094,7 +902,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 }
 
 struct pnv_eeh_ops ioda_eeh_ops = {
-	.post_init		= ioda_eeh_post_init,
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index df33daa..641ba33 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -38,6 +39,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+static bool pnv_eeh_nb_init = false;
+
 /**
  * pnv_eeh_init - EEH platform dependent initialization
  *
@@ -85,6 +88,139 @@ static int pnv_eeh_init(void)
 	return 0;
 }
 
+static int pnv_eeh_event(struct notifier_block *nb,
+			 unsigned long events, void *change)
+{
+	uint64_t changed_evts = (uint64_t)change;
+
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
+		eeh_send_failure_event(NULL);
+	else
+		opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
+
+	return 0;
+}
+
+static struct notifier_block pnv_eeh_nb = {
+	.notifier_call	= pnv_eeh_event,
+	.next		= NULL,
+	.priority	= 0
+};
+
+#ifdef CONFIG_DEBUG_FS
+static ssize_t pnv_eeh_ei_write(struct file *filp,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct pci_controller *hose = filp->private_data;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int pe_no, type, func;
+	unsigned long addr, mask;
+	char buf[50];
+	int ret;
+
+	if (!eeh_ops || !eeh_ops->err_inject)
+		return -ENXIO;
+
+	/* Copy over argument buffer */
+	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	if (!ret)
+		return -EFAULT;
+
+	/* Retrieve parameters */
+	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
+		     &pe_no, &type, &func, &addr, &mask);
+	if (ret != 5)
+		return -EINVAL;
+
+	/* Retrieve PE */
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
+	edev->phb = hose;
+	edev->pe_config_addr = pe_no;
+	pe = eeh_pe_get(edev);
+	kfree(edev);
+	if (!pe)
+		return -ENODEV;
+
+	/* Do error injection */
+	ret = eeh_ops->err_inject(pe, type, func, addr, mask);
+	return ret < 0 ? ret : count;
+}
+
+static const struct file_operations pnv_eeh_ei_fops = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
+	.write	= pnv_eeh_ei_write,
+};
+
+static int pnv_eeh_dbgfs_set(void *data, int offset, u64 val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	out_be64(phb->regs + offset, val);
+	return 0;
+}
+
+static int pnv_eeh_dbgfs_get(void *data, int offset, u64 *val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	*val = in_be64(phb->regs + offset);
+	return 0;
+}
+
+static int pnv_eeh_outb_dbgfs_set(void *data, u64 val)
+{
+	return pnv_eeh_dbgfs_set(data, 0xD10, val);
+}
+
+static int pnv_eeh_outb_dbgfs_get(void *data, u64 *val)
+{
+	return pnv_eeh_dbgfs_get(data, 0xD10, val);
+}
+
+static int pnv_eeh_inbA_dbgfs_set(void *data, u64 val)
+{
+	return pnv_eeh_dbgfs_set(data, 0xD90, val);
+}
+
+static int pnv_eeh_inbA_dbgfs_get(void *data, u64 *val)
+{
+	return pnv_eeh_dbgfs_get(data, 0xD90, val);
+}
+
+static int pnv_eeh_inbB_dbgfs_set(void *data, u64 val)
+{
+	return pnv_eeh_dbgfs_set(data, 0xE10, val);
+}
+
+static int pnv_eeh_inbB_dbgfs_get(void *data, u64 *val)
+{
+	return pnv_eeh_dbgfs_get(data, 0xE10, val);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_outb_dbgfs_ops, pnv_eeh_outb_dbgfs_get,
+			pnv_eeh_outb_dbgfs_set, "0x%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_inbA_dbgfs_ops, pnv_eeh_inbA_dbgfs_get,
+			pnv_eeh_inbA_dbgfs_set, "0x%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_inbB_dbgfs_ops, pnv_eeh_inbB_dbgfs_get,
+			pnv_eeh_inbB_dbgfs_set, "0x%llx\n");
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * pnv_eeh_post_init - EEH platform dependent post initialization
  *
@@ -99,16 +235,54 @@ static int pnv_eeh_post_init(void)
 	struct pnv_phb *phb;
 	int ret = 0;
 
+	/* Register OPAL event notifier */
+	if (!pnv_eeh_nb_init) {
+		ret = opal_notifier_register(&pnv_eeh_nb);
+		if (ret) {
+			pr_warn("%s: Can't register OPAL event notifier (%d)\n",
+				__func__, ret);
+			return ret;
+		}
+
+		pnv_eeh_nb_init = true;
+	}
+
 	list_for_each_entry(hose, &hose_list, list_node) {
 		phb = hose->private_data;
 
-		if (phb->eeh_ops && phb->eeh_ops->post_init) {
-			ret = phb->eeh_ops->post_init(hose);
-			if (ret)
-				break;
-		}
+		/*
+		 * If EEH is enabled, we're going to rely on that.
+		 * Otherwise, we restore to conventional mechanism
+		 * to clear frozen PE during PCI config access.
+		 */
+		if (eeh_enabled())
+			phb->flags |= PNV_PHB_FLAG_EEH;
+		else
+			phb->flags &= ~PNV_PHB_FLAG_EEH;
+
+		/* Create debugfs entries */
+#ifdef CONFIG_DEBUG_FS
+		if (phb->has_dbgfs || !phb->dbgfs)
+			continue;
+
+		phb->has_dbgfs = 1;
+		debugfs_create_file("err_injct", 0200,
+				    phb->dbgfs, hose,
+				    &pnv_eeh_ei_fops);
+
+		debugfs_create_file("err_injct_outbound", 0600,
+				    phb->dbgfs, hose,
+				    &pnv_eeh_outb_dbgfs_ops);
+		debugfs_create_file("err_injct_inboundA", 0600,
+				    phb->dbgfs, hose,
+				    &pnv_eeh_inbA_dbgfs_ops);
+		debugfs_create_file("err_injct_inboundB", 0600,
+				    phb->dbgfs, hose,
+				    &pnv_eeh_inbB_dbgfs_ops);
+#endif /* CONFIG_DEBUG_FS */
 	}
 
+
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a9f2362..c7e047f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,7 +78,6 @@ struct pnv_ioda_pe {
 /* IOC dependent EEH operations */
 #ifdef CONFIG_EEH
 struct pnv_eeh_ops {
-	int (*post_init)(struct pci_controller *hose);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
-- 
1.8.3.2
