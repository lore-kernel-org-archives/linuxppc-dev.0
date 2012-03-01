Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B2FCB6F62
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2012 12:47:52 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 1 Mar 2012 01:41:22 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q211gIpK2379980
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2012 12:42:18 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q211llhO026953
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2012 12:47:47 +1100
Received: from shangw (shangw.cn.ibm.com [9.125.213.205])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with SMTP id
 q211lkjj026926
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2012 12:47:46 +1100
Date: Thu, 1 Mar 2012 09:47:45 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH - Reworked
Message-ID: <20120301014745.GA29331@shangw>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
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

It's the rework on the corresponding v5 patch. According to
the comments from David Laight, the EEH global statistics have
been changed for a litte bit so that they have fixed-type of
"u64". Also, the format used to print them has been changed to
"%llu" based on David's suggestion. Also, the output format of
EEH global statistics should be kept as intacted according to
Michael's suggestion that there might be tools parsing them.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |   65 ++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 9b1fd0c..1d08cd7 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -102,14 +102,22 @@ static DEFINE_RAW_SPINLOCK(confirm_error_lock);
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
+/*
+ * The struct is used to maintain the EEH global statistic
+ * information. Besides, the EEH global statistics will be
+ * exported to user space through procfs
+ */
+struct eeh_stats {
+	u64 no_device;		/* PCI device not found		*/
+	u64 no_dn;		/* OF node not found		*/
+	u64 no_cfg_addr;	/* Config address not found	*/
+	u64 ignored_check;	/* EEH check skipped		*/
+	u64 total_mmio_ffs;	/* Total EEH checks		*/
+	u64 false_positives;	/* Unnecessary EEH checks	*/
+	u64 slot_resets;	/* PE reset			*/
+};
+
+static struct eeh_stats eeh_stats;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
@@ -392,13 +400,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
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
@@ -407,14 +415,14 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
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
 
@@ -460,13 +468,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
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
@@ -513,7 +521,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_addr_cache_get_device(addr);
 	if (!dev) {
-		no_device++;
+		eeh_stats.no_device++;
 		return val;
 	}
 
@@ -1174,21 +1182,24 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (0 == eeh_subsystem_enabled) {
 		seq_printf(m, "EEH Subsystem is globally disabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", total_mmio_ffs);
+		seq_printf(m, "eeh_total_mmio_ffs=%llu\n", eeh_stats.total_mmio_ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
 		seq_printf(m,
-				"no device=%ld\n"
-				"no device node=%ld\n"
-				"no config address=%ld\n"
-				"check not wanted=%ld\n"
-				"eeh_total_mmio_ffs=%ld\n"
-				"eeh_false_positives=%ld\n"
-				"eeh_slot_resets=%ld\n",
-				no_device, no_dn, no_cfg_addr, 
-				ignored_check, total_mmio_ffs, 
-				false_positives,
-				slot_resets);
+				"no device=%llu\n"
+				"no device node=%llu\n"
+				"no config address=%llu\n"
+				"check not wanted=%llu\n"
+				"eeh_total_mmio_ffs=%llu\n"
+				"eeh_false_positives=%llu\n"
+				"eeh_slot_resets=%llu\n",
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
