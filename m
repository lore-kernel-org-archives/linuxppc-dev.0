Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08259B6FBA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:32 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:31 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cPQR2859028
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:25 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cOD2008275
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:25 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 20/21] Introduce struct eeh_stats for EEH
Date: Fri, 24 Feb 2012 17:38:17 +0800
Message-Id: <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
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

With the original EEH implementation, the EEH global statistics
are maintained by individual global variables. That makes the
code a little hard to maintain.

The patch introduces extra struct eeh_stats for the EEH global
statistics so that it can be maintained in collective fashion.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |   15 +++++++++++++
 arch/powerpc/platforms/pseries/eeh.c |   37 +++++++++++++++------------------
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1310971..226c9a5 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -98,6 +98,21 @@ struct eeh_ops {
 	int (*configure_bridge)(struct device_node *dn);
 };
 
+/*
+ * The struct is used to maintain the EEH global statistic
+ * information. Besides, the EEH global statistics will be
+ * exported to user space through procfs
+ */
+struct eeh_stats {
+	unsigned long no_device;	/* PCI device not found		*/
+	unsigned long no_dn;		/* OF node not found		*/
+	unsigned long no_cfg_addr;	/* Config address not found	*/
+	unsigned long ignored_check;	/* EEH check skipped		*/
+	unsigned long total_mmio_ffs;	/* Total EEH checks		*/
+	unsigned long false_positives;	/* Unnecessary EEH checks	*/
+	unsigned long slot_resets;	/* PE reset			*/
+};
+
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
 
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 759d5af..a8a8c27 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -102,14 +102,8 @@ static DEFINE_RAW_SPINLOCK(confirm_error_lock);
 #define EEH_PCI_REGS_LOG_LEN 4096
 static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
 
-/* System monitoring statistics */
-static unsigned long no_device;
-static unsigned long no_dn;
-static unsigned long no_cfg_addr;
-static unsigned long ignored_check;
-static unsigned long total_mmio_ffs;
-static unsigned long false_positives;
-static unsigned long slot_resets;
+/* EEH global statiscs */
+static struct eeh_stats eeh_stats;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
@@ -392,13 +386,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	int rc = 0;
 	const char *location;
 
-	total_mmio_ffs++;
+	eeh_stats.total_mmio_ffs++;
 
 	if (!eeh_subsystem_enabled)
 		return 0;
 
 	if (!dn) {
-		no_dn++;
+		eeh_stats.no_dn++;
 		return 0;
 	}
 	dn = eeh_find_device_pe(dn);
@@ -407,14 +401,14 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(edev->mode & EEH_MODE_SUPPORTED) ||
 	    edev->mode & EEH_MODE_NOCHECK) {
-		ignored_check++;
+		eeh_stats.ignored_check++;
 		pr_debug("EEH: Ignored check (%x) for %s %s\n",
 			edev->mode, eeh_pci_name(dev), dn->full_name);
 		return 0;
 	}
 
 	if (!edev->config_addr && !edev->pe_config_addr) {
-		no_cfg_addr++;
+		eeh_stats.no_cfg_addr++;
 		return 0;
 	}
 
@@ -460,13 +454,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	    (ret == EEH_STATE_NOT_SUPPORT) ||
 	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
 	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
-		false_positives++;
+		eeh_stats.false_positives++;
 		edev->false_positives ++;
 		rc = 0;
 		goto dn_unlock;
 	}
 
-	slot_resets++;
+	eeh_stats.slot_resets++;
  
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
@@ -513,7 +507,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_addr_cache_get_device(addr);
 	if (!dev) {
-		no_device++;
+		eeh_stats.no_device++;
 		return val;
 	}
 
@@ -1174,7 +1168,7 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (0 == eeh_subsystem_enabled) {
 		seq_printf(m, "EEH Subsystem is globally disabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", total_mmio_ffs);
+		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", eeh_stats.total_mmio_ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
 		seq_printf(m,
@@ -1185,10 +1179,13 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 				"eeh_total_mmio_ffs=%ld\n"
 				"eeh_false_positives=%ld\n"
 				"eeh_slot_resets=%ld\n",
-				no_device, no_dn, no_cfg_addr, 
-				ignored_check, total_mmio_ffs, 
-				false_positives,
-				slot_resets);
+				eeh_stats.no_device,
+				eeh_stats.no_dn,
+				eeh_stats.no_cfg_addr,
+				eeh_stats.ignored_check,
+				eeh_stats.total_mmio_ffs,
+				eeh_stats.false_positives,
+				eeh_stats.slot_resets);
 	}
 
 	return 0;
-- 
1.7.5.4
