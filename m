Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D6BF514011F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AB34F3578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dPMr7995830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Rb6017449
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 09/25] powerpc/eeh: Cleanup eeh_gather_pci_data()
Date: Thu, 24 Apr 2014 18:00:15 +1000
Message-Id: <1398326431-24305-10-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch replaces printk(KERN_WARNING ...) with pr_warn() in the
function eeh_gather_pci_data().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 25f3753..c6d8f7e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -151,18 +151,18 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	int n = 0;
 
 	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
-	printk(KERN_WARNING "EEH: of node=%s\n", dn->full_name);
+	pr_warn("EEH: of node=%s\n", dn->full_name);
 
 	eeh_ops->read_config(dn, PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
-	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
+	pr_warn("EEH: PCI device/vendor: %08x\n", cfg);
 
 	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
-	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
+	pr_warn("EEH: PCI cmd/status register: %08x\n", cfg);
 
 	if (!dev) {
-		printk(KERN_WARNING "EEH: no PCI device for this of node\n");
+		pr_warn("EEH: no PCI device for this of node\n");
 		return n;
 	}
 
@@ -170,11 +170,11 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
 		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
-		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
+		pr_warn("EEH: Bridge secondary status: %04x\n", cfg);
 
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
-		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
+		pr_warn("EEH: Bridge control: %04x\n", cfg);
 	}
 
 	/* Dump out the PCI-X command and status regs */
@@ -182,35 +182,34 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	if (cap) {
 		eeh_ops->read_config(dn, cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
-		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
+		pr_warn("EEH: PCI-X cmd: %08x\n", cfg);
 
 		eeh_ops->read_config(dn, cap+4, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
-		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
+		pr_warn("EEH: PCI-X status: %08x\n", cfg);
 	}
 
 	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
 	if (pci_is_pcie(dev)) {
 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
-		printk(KERN_WARNING
-		       "EEH: PCI-E capabilities and status follow:\n");
+		pr_warn("EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
 			eeh_ops->read_config(dn, dev->pcie_cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
+			pr_warn("EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
 
 		cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		if (cap) {
 			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
-			printk(KERN_WARNING
-			       "EEH: PCI-E AER capability register set follows:\n");
+			pr_warn("EEH: PCI-E AER capability register "
+				"set follows:\n");
 
 			for (i=0; i<14; i++) {
 				eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
+				pr_warn("EEH: PCI-E AER %02x: %08x\n", i, cfg);
 			}
 		}
 	}
-- 
1.8.3.2
