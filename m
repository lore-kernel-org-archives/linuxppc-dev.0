Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACCC3B6FCF
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:29 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:27 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cP4s3403838
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:25 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cOi3024608
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:25 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 21/21] pSeries platform config space access in EEH
Date: Fri, 24 Feb 2012 17:38:18 +0800
Message-Id: <1330076298-7006-22-git-send-email-shangw@linux.vnet.ibm.com>
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

With the original EEH implementation, the access to config space of
the corresponding PCI device is done by RTAS sensitive function. That
depends on pci_dn heavily. That would limit EEH extension to other
platforms like powernv because other platforms might have different
ways to access PCI config space.

The patch splits those functions used to access PCI config space
and implement them in platform related EEH component. It would be
helpful to support EEH on multiple platforms simutaneously in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    2 +
 arch/powerpc/platforms/pseries/eeh.c         |   32 ++++++++++----------
 arch/powerpc/platforms/pseries/eeh_pseries.c |   40 +++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 226c9a5..121fa54 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -96,6 +96,8 @@ struct eeh_ops {
 	int (*wait_state)(struct device_node *dn, int max_wait);
 	int (*get_log)(struct device_node *dn, int severity, char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct device_node *dn);
+	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
+	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 };
 
 /*
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index a8a8c27..899df26 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -127,11 +127,11 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
 	printk(KERN_WARNING "EEH: of node=%s\n", dn->full_name);
 
-	rtas_read_config(PCI_DN(dn), PCI_VENDOR_ID, 4, &cfg);
+	eeh_ops->read_config(dn, PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
 
-	rtas_read_config(PCI_DN(dn), PCI_COMMAND, 4, &cfg);
+	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
 
@@ -142,11 +142,11 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 
 	/* Gather bridge-specific registers */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		rtas_read_config(PCI_DN(dn), PCI_SEC_STATUS, 2, &cfg);
+		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
 		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
 
-		rtas_read_config(PCI_DN(dn), PCI_BRIDGE_CONTROL, 2, &cfg);
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
 		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
 	}
@@ -154,11 +154,11 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	/* Dump out the PCI-X command and status regs */
 	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (cap) {
-		rtas_read_config(PCI_DN(dn), cap, 4, &cfg);
+		eeh_ops->read_config(dn, cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
 		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
 
-		rtas_read_config(PCI_DN(dn), cap+4, 4, &cfg);
+		eeh_ops->read_config(dn, cap+4, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
 		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
 	}
@@ -171,7 +171,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		       "EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
-			rtas_read_config(PCI_DN(dn), cap+4*i, 4, &cfg);
+			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
@@ -183,7 +183,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 			       "EEH: PCI-E AER capability register set follows:\n");
 
 			for (i=0; i<14; i++) {
-				rtas_read_config(PCI_DN(dn), cap+4*i, 4, &cfg);
+				eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
 			}
@@ -732,28 +732,28 @@ static inline void eeh_restore_one_device_bars(struct eeh_dev *edev)
 		return;
 
 	for (i=4; i<10; i++) {
-		rtas_write_config(PCI_DN(dn), i*4, 4, edev->config_space[i]);
+		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
 	}
 
 	/* 12 == Expansion ROM Address */
-	rtas_write_config(PCI_DN(dn), 12*4, 4, edev->config_space[12]);
+	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
 
 #define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
 #define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
 
-	rtas_write_config(PCI_DN(dn), PCI_CACHE_LINE_SIZE, 1,
+	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
 	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
 
-	rtas_write_config(PCI_DN(dn), PCI_LATENCY_TIMER, 1,
+	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
 	            SAVED_BYTE(PCI_LATENCY_TIMER));
 
 	/* max latency, min grant, interrupt pin and line */
-	rtas_write_config(PCI_DN(dn), 15*4, 4, edev->config_space[15]);
+	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
 
 	/* Restore PERR & SERR bits, some devices require it,
 	 * don't touch the other command bits
 	 */
-	rtas_read_config(PCI_DN(dn), PCI_COMMAND, 4, &cmd);
+	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
 	if (edev->config_space[1] & PCI_COMMAND_PARITY)
 		cmd |= PCI_COMMAND_PARITY;
 	else
@@ -762,7 +762,7 @@ static inline void eeh_restore_one_device_bars(struct eeh_dev *edev)
 		cmd |= PCI_COMMAND_SERR;
 	else
 		cmd &= ~PCI_COMMAND_SERR;
-	rtas_write_config(PCI_DN(dn), PCI_COMMAND, 4, cmd);
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
 }
 
 /**
@@ -804,7 +804,7 @@ static void eeh_save_bars(struct eeh_dev *edev)
 	dn = EEH_DEV_TO_OF_NODE(edev);
 	
 	for (i = 0; i < 16; i++)
-		rtas_read_config(PCI_DN(dn), i * 4, 4, &edev->config_space[i]);
+		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
 }
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a3345c2..841738e 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -503,6 +503,42 @@ static int pseries_eeh_configure_bridge(struct device_node *dn)
 	return ret;
 }
 
+/**
+ * pseries_eeh_read_config - Read PCI config space
+ * @dn: device node
+ * @where: PCI address
+ * @size: size to read
+ * @val: return value
+ *
+ * Read config space from the speicifed device
+ */
+static int pseries_eeh_read_config(struct device_node *dn, int where, int size, u32 *val)
+{
+	struct pci_dn *pdn;
+
+	pdn = PCI_DN(dn);
+
+	return rtas_read_config(pdn, where, size, val);
+}
+
+/**
+ * pseries_eeh_write_config - Write PCI config space
+ * @dn: device node
+ * @where: PCI address
+ * @size: size to write
+ * @val: value to be written
+ *
+ * Write config space to the specified device
+ */
+static int pseries_eeh_write_config(struct device_node *dn, int where, int size, u32 val)
+{
+	struct pci_dn *pdn;
+
+	pdn = PCI_DN(dn);
+
+	return rtas_write_config(pdn, where, size, val);
+}
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
@@ -512,7 +548,9 @@ static struct eeh_ops pseries_eeh_ops = {
 	.reset			= pseries_eeh_reset,
 	.wait_state		= pseries_eeh_wait_state,
 	.get_log		= pseries_eeh_get_log,
-	.configure_bridge	= pseries_eeh_configure_bridge
+	.configure_bridge       = pseries_eeh_configure_bridge,
+	.read_config		= pseries_eeh_read_config,
+	.write_config		= pseries_eeh_write_config
 };
 
 /**
-- 
1.7.5.4
