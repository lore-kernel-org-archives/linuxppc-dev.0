Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C6135DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:52:06 +1100 (EST)
Date: Fri, 21 Dec 2007 15:52:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] eeh.c: use for_each_child_of_node
Message-Id: <20071221155207.86a200d6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/eeh.c |   43 ++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index aa14a85..9eb539e 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -29,6 +29,8 @@
 #include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
+
 #include <asm/atomic.h>
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
@@ -169,7 +171,6 @@ static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
  */
 static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 {
-	struct device_node *dn;
 	struct pci_dev *dev = pdn->pcidev;
 	u32 cfg;
 	int cap, i;
@@ -243,12 +244,12 @@ static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 
 	/* Gather status on devices under the bridge */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		dn = pdn->node->child;
-		while (dn) {
+		struct device_node *dn;
+
+		for_each_child_of_node(pdn->node, dn) {
 			pdn = PCI_DN(dn);
 			if (pdn)
 				n += gather_pci_data(pdn, buf+n, len-n);
-			dn = dn->sibling;
 		}
 	}
 
@@ -372,7 +373,7 @@ struct device_node * find_device_pe(struct device_node *dn)
 	return dn;
 }
 
-/** Mark all devices that are peers of this device as failed.
+/** Mark all devices that are children of this device as failed.
  *  Mark the device driver too, so that it can see the failure
  *  immediately; this is critical, since some drivers poll
  *  status registers in interrupts ... If a driver is polling,
@@ -380,9 +381,11 @@ struct device_node * find_device_pe(struct device_node *dn)
  *  an interrupt context, which is bad.
  */
 
-static void __eeh_mark_slot (struct device_node *dn, int mode_flag)
+static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 {
-	while (dn) {
+	struct device_node *dn;
+
+	for_each_child_of_node(parent, dn) {
 		if (PCI_DN(dn)) {
 			/* Mark the pci device driver too */
 			struct pci_dev *dev = PCI_DN(dn)->pcidev;
@@ -392,10 +395,8 @@ static void __eeh_mark_slot (struct device_node *dn, int mode_flag)
 			if (dev && dev->driver)
 				dev->error_state = pci_channel_io_frozen;
 
-			if (dn->child)
-				__eeh_mark_slot (dn->child, mode_flag);
+			__eeh_mark_slot(dn, mode_flag);
 		}
-		dn = dn->sibling;
 	}
 }
 
@@ -415,19 +416,19 @@ void eeh_mark_slot (struct device_node *dn, int mode_flag)
 	if (dev)
 		dev->error_state = pci_channel_io_frozen;
 
-	__eeh_mark_slot (dn->child, mode_flag);
+	__eeh_mark_slot(dn, mode_flag);
 }
 
-static void __eeh_clear_slot (struct device_node *dn, int mode_flag)
+static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
 {
-	while (dn) {
+	struct device_node *dn;
+
+	for_each_child_of_node(parent, dn) {
 		if (PCI_DN(dn)) {
 			PCI_DN(dn)->eeh_mode &= ~mode_flag;
 			PCI_DN(dn)->eeh_check_count = 0;
-			if (dn->child)
-				__eeh_clear_slot (dn->child, mode_flag);
+			__eeh_clear_slot(dn, mode_flag);
 		}
-		dn = dn->sibling;
 	}
 }
 
@@ -444,7 +445,7 @@ void eeh_clear_slot (struct device_node *dn, int mode_flag)
 
 	PCI_DN(dn)->eeh_mode &= ~mode_flag;
 	PCI_DN(dn)->eeh_check_count = 0;
-	__eeh_clear_slot (dn->child, mode_flag);
+	__eeh_clear_slot(dn, mode_flag);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
@@ -849,11 +850,8 @@ void eeh_restore_bars(struct pci_dn *pdn)
 	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
 		__restore_bars (pdn);
 
-	dn = pdn->node->child;
-	while (dn) {
+	for_each_child_of_node(pdn->node, dn)
 		eeh_restore_bars (PCI_DN(dn));
-		dn = dn->sibling;
-	}
 }
 
 /**
@@ -1131,7 +1129,8 @@ static void eeh_add_device_early(struct device_node *dn)
 void eeh_add_device_tree_early(struct device_node *dn)
 {
 	struct device_node *sib;
-	for (sib = dn->child; sib; sib = sib->sibling)
+
+	for_each_child_of_node(dn, sib)
 		eeh_add_device_tree_early(sib);
 	eeh_add_device_early(dn);
 }
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
