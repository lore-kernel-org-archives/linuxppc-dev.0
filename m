Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A292DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 07:29:30 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: qe: fix device tree lookup code in qe_muram_init()
Date: Thu, 29 Nov 2007 14:29:20 -0600
Message-Id: <11963681602431-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Function qe_muram_init() was only looking for a node called "data-only",
instead of making sure it is the correct node.  This patch modifies
qe_muram_init() to find the QE node first, then the MURAM node inside it,
and then the data-only node.  It also reports errors.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 3d57d38..298e073 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -282,6 +282,12 @@ static DEFINE_SPINLOCK(qe_muram_lock);
 static rh_block_t qe_boot_muram_rh_block[16];
 static rh_info_t qe_muram_info;
 
+/* Initialize the MURAM remote heap
+ *
+ * This function queries the device tree to obtain the offset within MURAM
+ * to initialize the MURAM remote heap, and then it initializes the remote
+ * heap with that value.
+ */
 static void qe_muram_init(void)
 {
 	struct device_node *np;
@@ -294,15 +300,32 @@ static void qe_muram_init(void)
 		sizeof(qe_boot_muram_rh_block) /
 		sizeof(qe_boot_muram_rh_block[0]), qe_boot_muram_rh_block);
 
-	/* Attach the usable muram area */
-	/* XXX: This is a subset of the available muram. It
-	 * varies with the processor and the microcode patches activated.
-	 */
-	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
-		address = *of_get_address(np, 0, &size, &flags);
-		of_node_put(np);
-		rh_attach_region(&qe_muram_info, address, (int) size);
+	/* Find the data-only node in the QE's muram node */
+	np = of_find_node_by_type(NULL, "qe");
+	if (!np) {
+		printk(KERN_ERR
+			"qe-muram: cannot find 'qe' node in device tree\n");
+		return;
+	}
+
+	np = of_find_node_by_type(np, "muram");
+	if (!np) {
+		printk(KERN_ERR
+			"qe-muram: cannot find 'muram' node in device tree\n");
+		return;
 	}
+
+	np = of_find_node_by_name(np, "data-only");
+	if (!np) {
+		printk(KERN_ERR "qe-muram: "
+			"cannot find 'data-only' node in device tree\n");
+		return;
+	}
+
+	/* Attach the usable muram area */
+	address = *of_get_address(np, 0, &size, &flags);
+	of_node_put(np);
+	rh_attach_region(&qe_muram_info, address, (int) size);
 }
 
 /* This function returns an index into the MURAM area.
-- 
1.5.2.4
