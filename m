Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:01 +1000
Subject: [PATCH 1/7] iseries: Use device tree /system-id in
	/proc/iSeries/config
Message-Id: <1152777121.430402.3949688126.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We export a bunch of info in /proc/iSeries/config. Currently we pull it
directly out of some iSeries specific structs, but we could use the device
tree instead, this saves decoding it twice and is a little neater.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/viopath.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/viopath.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/viopath.c
+++ to-merge/arch/powerpc/platforms/iseries/viopath.c
@@ -41,8 +41,8 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/prom.h>
 #include <asm/iseries/hv_types.h>
-#include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/mf.h>
@@ -116,6 +116,7 @@ static int proc_viopath_show(struct seq_
 	dma_addr_t handle;
 	HvLpEvent_Rc hvrc;
 	DECLARE_MUTEX_LOCKED(Semaphore);
+	struct device_node *node;
 
 	buf = kmalloc(HW_PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -143,20 +144,26 @@ static int proc_viopath_show(struct seq_
 
 	buf[HW_PAGE_SIZE-1] = '\0';
 	seq_printf(m, "%s", buf);
-	seq_printf(m, "AVAILABLE_VETH=%x\n", vlanMap);
-	seq_printf(m, "SRLNBR=%c%c%c%c%c%c%c\n",
-		   e2a(xItExtVpdPanel.mfgID[2]),
-		   e2a(xItExtVpdPanel.mfgID[3]),
-		   e2a(xItExtVpdPanel.systemSerial[1]),
-		   e2a(xItExtVpdPanel.systemSerial[2]),
-		   e2a(xItExtVpdPanel.systemSerial[3]),
-		   e2a(xItExtVpdPanel.systemSerial[4]),
-		   e2a(xItExtVpdPanel.systemSerial[5]));
 
 	dma_unmap_single(iSeries_vio_dev, handle, HW_PAGE_SIZE,
 			 DMA_FROM_DEVICE);
 	kfree(buf);
 
+	seq_printf(m, "AVAILABLE_VETH=%x\n", vlanMap);
+
+	node = of_find_node_by_path("/");
+	buf = NULL;
+	if (node != NULL)
+		buf = get_property(node, "system-id", NULL);
+
+	if (buf == NULL)
+		seq_printf(m, "SRLNBR=<UNKNOWN>\n");
+	else
+		/* Skip "IBM," on front of serial number, see dt.c */
+		seq_printf(m, "SRLNBR=%s\n", buf + 4);
+
+	of_node_put(node);
+
 	return 0;
 }
 
