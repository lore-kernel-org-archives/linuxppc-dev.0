From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 14 Mar 2003 23:19:11 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: patch: add API to set gt64260 mac addresses
Message-ID: <20030315061911.GA10210@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is currently no API for setting the mac addresses for the
gt64260 enet ports.  They can only be set via ppcboot or via
the cmdline.  This patch, relative to linuxppc_2_4_devel, adds
gt64260_set_mac_addr() to enable the mac addresses to be
initialized by board-specific code.

Thanks,
-Dale

Add gt64260_set_mac_addr() to enable the mac addresses of the
gt64260 ethernet ports to be initialized by board-specific code.

include/asm-ppc/gt64260.h:
Add declarations for gt64260_mac_addrs and gt64260_set_mac_addr().

arch/ppc/kernel/gt64260_common.c:
Move gt64260_mac_addrs from gt64260_eth.c and change it from
12 ascii hex characters to 6 binary characters.
Add gt64260_set_mac_addr() to initialize gt64260_mac_addrs.

drivers/net/gt64260_eth.c:
Move gt64260_mac_addrs to gt64260_common.c and change it from
12 ascii hex characters to 6 binary characters.

===== include/asm-ppc/gt64260.h 1.15 vs edited =====
--- 1.15/include/asm-ppc/gt64260.h	Thu Mar 13 12:30:11 2003
+++ edited/include/asm-ppc/gt64260.h	Fri Mar 14 18:57:44 2003
@@ -31,6 +31,7 @@
 extern u32     gt64260_irq_base;     /* We handle the next 96 IRQs from here */
 extern u32     gt64260_revision;
 extern u8      gt64260_pci_exclude_bridge;
+extern u8      gt64260_mac_addrs[3][6];		/* Up to 3 Ethernet ports */

 extern spinlock_t gt64260_lock;
 extern spinlock_t gt64260_rmw_lock;
@@ -354,5 +355,7 @@
 void gt64260_set_intr_mask_reg_offsets(int cpu,
 					u32 lo_reg_offset,
 					u32 hi_reg_offset);
+
+void gt64260_set_mac_addr(int selector, unsigned char *mac_addr);

 #endif /* __ASMPPC_GT64260_H */
===== arch/ppc/kernel/gt64260_common.c 1.14 vs edited =====
--- 1.14/arch/ppc/kernel/gt64260_common.c	Fri Feb 28 10:31:00 2003
+++ edited/arch/ppc/kernel/gt64260_common.c	Fri Mar 14 18:10:22 2003
@@ -40,6 +40,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/string.h>

 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -55,6 +56,8 @@
 u32	gt64260_revision; /* Revision of the chip */
 u8	gt64260_pci_exclude_bridge = TRUE;

+u8	gt64260_mac_addrs[3][6];	/* Up to 3 Ethernet ports */
+
 spinlock_t gt64260_lock = SPIN_LOCK_UNLOCKED;
 spinlock_t gt64260_rmw_lock = SPIN_LOCK_UNLOCKED;

@@ -1804,6 +1807,18 @@

 	return total;
 } /* gt64260_get_mem_size() */
+
+/*
+ * gt64260_set_mac_addr()
+ *
+ * Sets the mac address for one of the 3 gt64260 ethernet ports.
+ */
+void
+gt64260_set_mac_addr(int port, unsigned char *mac_addr)
+{
+    	memcpy(gt64260_mac_addrs[port], mac_addr, 6);
+}
+

 #if defined(CONFIG_SERIAL_TEXT_DEBUG)
 /*
===== drivers/net/gt64260_eth.c 1.10 vs edited =====
--- 1.10/drivers/net/gt64260_eth.c	Tue Jan 14 09:17:38 2003
+++ edited/drivers/net/gt64260_eth.c	Fri Mar 14 18:10:17 2003
@@ -68,7 +68,6 @@

 static const char *version = "gt64260_eth.c: v0.09";

-static unsigned char gt64260_mac_addrs[3][12];	/* Will be init'd to 0's */
 static unsigned char null_mac[6];		/* Will be init'd to 0's */

 /* set port config value */
@@ -623,22 +622,12 @@
 {
 }

-/*
- * ----------------------------------------------------------------------------
- *  First function called after registering the network device.
- *  It's purpose is to initialize the device as an ethernet device,
- *  fill the structure that was given in registration with pointers
- *  to functions, and setting the MAC address of the interface
- *
- *  Input : pointer to network device structure to be filled
- *  Output : -ENONMEM if failed, 0 if success
- */
 void
 gt64260_eth_str2mac(char *str, unsigned char *mac)
 {
 	int i;

-	for (i = 0; i < 12; i += 2) {
+	for (i = 0; i < 12 && str[i] && str[i+1]; i += 2) {
 		mac[i / 2] = ((isdigit(str[i]) ?
 			       str[i] - '0' :
 			       (toupper(str[i]) - 'A' + 10)) << 4) |
@@ -649,6 +638,16 @@
 	return;
 }

+/*
+ * ----------------------------------------------------------------------------
+ *  First function called after registering the network device.
+ *  It's purpose is to initialize the device as an ethernet device,
+ *  fill the structure that was given in registration with pointers
+ *  to functions, and setting the MAC address of the interface
+ *
+ *  Input : pointer to network device structure to be filled
+ *  Output : -ENONMEM if failed, 0 if success
+ */
 s32
 gt64260_eth_init(struct net_device * dev)
 {
@@ -725,8 +724,7 @@
 	case 0:
 		if (!gt64260_eth0_initialized) {
 			if (memcmp(gt64260_mac_addrs[0],null_mac,6) != 0) {
-				gt64260_eth_str2mac(gt64260_mac_addrs[0],
-							dev->dev_addr);
+			    	memcpy(dev->dev_addr, gt64260_mac_addrs[0], 6);
 			}
 #ifndef	CONFIG_USE_PPCBOOT
 			else {
@@ -769,8 +767,7 @@
 	case 1:
 		if (!gt64260_eth1_initialized) {
 			if (memcmp(gt64260_mac_addrs[1],null_mac,6) != 0) {
-				gt64260_eth_str2mac(gt64260_mac_addrs[1],
-							dev->dev_addr);
+			    	memcpy(dev->dev_addr, gt64260_mac_addrs[1], 6);
 			}
 #ifndef	CONFIG_USE_PPCBOOT
 			else {
@@ -809,8 +806,7 @@
 	case 2:
 		if (!gt64260_eth2_initialized) {
 			if (memcmp(gt64260_mac_addrs[2],null_mac,6) != 0) {
-				gt64260_eth_str2mac(gt64260_mac_addrs[2],
-							dev->dev_addr);
+			    	memcpy(dev->dev_addr, gt64260_mac_addrs[2], 6);
 			}
 #ifndef	CONFIG_USE_PPCBOOT
 			else {
@@ -1930,21 +1926,21 @@
 static int __init
 gt_mac0_setup(char *mac_addr)
 {
-	strncpy(gt64260_mac_addrs[0], mac_addr, 12);
+	gt64260_eth_str2mac(mac_addr, gt64260_mac_addrs[0]);
 	return 0;
 }

 static int __init
 gt_mac1_setup(char *mac_addr)
 {
-	strncpy(gt64260_mac_addrs[1], mac_addr, 12);
+	gt64260_eth_str2mac(mac_addr, gt64260_mac_addrs[1]);
 	return 0;
 }

 static int __init
 gt_mac2_setup(char *mac_addr)
 {
-	strncpy(gt64260_mac_addrs[2], mac_addr, 12);
+	gt64260_eth_str2mac(mac_addr, gt64260_mac_addrs[2]);
 	return 0;
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
