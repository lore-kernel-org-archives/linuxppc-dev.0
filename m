Return-Path: <gorcunov@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id 306DBDDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 07:04:19 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so3500088mue
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 12:04:17 -0800 (PST)
Date: Thu, 22 Nov 2007 22:54:23 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PPC: CHRP - fix possible NULL pointer dereference
Message-ID: <20071122195423.GA9877@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

This patch does fix possible NULL pointer dereference
inside of strncmp() if of_get_property() failed.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/platforms/chrp/setup.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 5930626..e3f276d 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -115,7 +115,7 @@ void chrp_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 
 	/* longtrail (goldengate) stuff */
-	if (!strncmp(model, "IBM,LongTrail", 13)) {
+	if (model && !strncmp(model, "IBM,LongTrail", 13)) {
 		/* VLSI VAS96011/12 `Golden Gate 2' */
 		/* Memory banks */
 		sdramen = (in_le32(gg2_pci_config_base + GG2_PCI_DRAM_CTRL)
@@ -203,16 +203,19 @@ static void __init sio_fixup_irq(const char *name, u8 device, u8 level,
 static void __init sio_init(void)
 {
 	struct device_node *root;
+	const char *model = NULL;
 
-	if ((root = of_find_node_by_path("/")) &&
-	    !strncmp(of_get_property(root, "model", NULL),
-			"IBM,LongTrail", 13)) {
-		/* logical device 0 (KBC/Keyboard) */
-		sio_fixup_irq("keyboard", 0, 1, 2);
-		/* select logical device 1 (KBC/Mouse) */
-		sio_fixup_irq("mouse", 1, 12, 2);
-	}
-	of_node_put(root);
+	root = of_find_node_by_path("/");
+	if (root) {
+		model = of_get_property(root, "model", NULL);
+		if (model && !strncmp(model,"IBM,LongTrail", 13)) {
+			/* logical device 0 (KBC/Keyboard) */
+			sio_fixup_irq("keyboard", 0, 1, 2);
+			/* select logical device 1 (KBC/Mouse) */
+			sio_fixup_irq("mouse", 1, 12, 2);
+		}
+		of_node_put(root);
+ 	}
 }
 
 
