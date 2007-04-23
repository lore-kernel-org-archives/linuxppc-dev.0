Return-Path: <arnd@arndb.de>
Message-Id: <20070423193913.396782839@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:47 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 09/10] cell: enable RTAS-based PTCAL for Cell XDR memory
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>
Enable Periodic Recalibration (PTCAL) support for Cell XDR memory,
using the new ibm,cbe-start-ptcal and ibm,cbe-stop-ptcal RTAS calls.

Tested on QS20 and QS21 (by Thomas Huth). It seems that SLOF has
problems disabling, at least on QS20; this patch should only be
used once these problems have been addressed.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Update: Updated with Michael's feedback, expanded comment.

Index: linux-2.6/arch/powerpc/platforms/cell/ras.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/ras.c
+++ linux-2.6/arch/powerpc/platforms/cell/ras.c
@@ -3,11 +3,13 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
+#include <linux/reboot.h>
 
 #include <asm/reg.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/rtas.h>
 
 #include "ras.h"
 #include "cbe_regs.h"
@@ -82,6 +84,164 @@ static int cbe_machine_check_handler(str
 	return 0;
 }
 
+struct ptcal_area {
+	struct list_head list;
+	int nid;
+	int order;
+	struct page *pages;
+};
+
+static LIST_HEAD(ptcal_list);
+
+static int ptcal_start_tok, ptcal_stop_tok;
+
+static int __init cbe_ptcal_enable_on_node(int nid, int order)
+{
+	struct ptcal_area *area;
+	int ret = -ENOMEM;
+	unsigned long addr;
+
+#ifdef CONFIG_CRASH_DUMP
+	rtas_call(ptcal_stop_tok, 1, 1, NULL, nid);
+#endif
+
+	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	if (!area)
+		goto out_err;
+
+	area->nid = nid;
+	area->order = order;
+	area->pages = alloc_pages_node(area->nid, GFP_KERNEL, area->order);
+
+	if (!area->pages)
+		goto out_free_area;
+
+	addr = __pa(page_address(area->pages));
+
+	ret = -EIO;
+	if (rtas_call(ptcal_start_tok, 3, 1, NULL, area->nid,
+				(unsigned int)(addr >> 32),
+				(unsigned int)(addr & 0xffffffff))) {
+		printk(KERN_ERR "%s: error enabling PTCAL on node %d!\n",
+				__FUNCTION__, nid);
+		goto out_free_pages;
+	}
+
+	list_add(&area->list, &ptcal_list);
+
+	return 0;
+
+out_free_pages:
+	__free_pages(area->pages, area->order);
+out_free_area:
+	kfree(area);
+out_err:
+	return ret;
+}
+
+static int __init cbe_ptcal_enable(void)
+{
+	const u32 *size;
+	struct device_node *np;
+	int order, found_mic = 0;
+
+	np = of_find_node_by_path("/rtas");
+	if (!np)
+		return -ENODEV;
+
+	size = get_property(np, "ibm,cbe-ptcal-size", NULL);
+	if (!size)
+		return -ENODEV;
+
+	pr_debug("%s: enabling PTCAL, size = 0x%x\n", __FUNCTION__, *size);
+	order = get_order(*size);
+	of_node_put(np);
+
+	/* support for malta device trees, with be@/mic@ nodes */
+	for_each_node_by_type(np, "mic-tm") {
+		cbe_ptcal_enable_on_node(of_node_to_nid(np), order);
+		found_mic = 1;
+	}
+
+	if (found_mic)
+		return 0;
+
+	/* support for older device tree - use cpu nodes */
+	for_each_node_by_type(np, "cpu") {
+		const u32 *nid = get_property(np, "node-id", NULL);
+		if (!nid) {
+			printk(KERN_ERR "%s: node %s is missing node-id?\n",
+					__FUNCTION__, np->full_name);
+			continue;
+		}
+		cbe_ptcal_enable_on_node(*nid, order);
+		found_mic = 1;
+	}
+
+	return found_mic ? 0 : -ENODEV;
+}
+
+static int cbe_ptcal_disable(void)
+{
+	struct ptcal_area *area, *tmp;
+	int ret = 0;
+
+	pr_debug("%s: disabling PTCAL\n", __FUNCTION__);
+
+	list_for_each_entry_safe(area, tmp, &ptcal_list, list) {
+		/* disable ptcal on this node */
+		if (rtas_call(ptcal_stop_tok, 1, 1, NULL, area->nid)) {
+			printk(KERN_ERR "%s: error disabling PTCAL "
+					"on node %d!\n", __FUNCTION__,
+					area->nid);
+			ret = -EIO;
+			continue;
+		}
+
+		/* ensure we can access the PTCAL area */
+		memset(page_address(area->pages), 0,
+				1 << (area->order + PAGE_SHIFT));
+
+		/* clean up */
+		list_del(&area->list);
+		__free_pages(area->pages, area->order);
+		kfree(area);
+	}
+
+	return ret;
+}
+
+static int cbe_ptcal_notify_reboot(struct notifier_block *nb,
+		unsigned long code, void *data)
+{
+	return cbe_ptcal_disable();
+}
+
+static struct notifier_block cbe_ptcal_reboot_notifier = {
+	.notifier_call = cbe_ptcal_notify_reboot
+};
+
+int __init cbe_ptcal_init(void)
+{
+	int ret;
+	ptcal_start_tok = rtas_token("ibm,cbe-start-ptcal");
+	ptcal_stop_tok = rtas_token("ibm,cbe-stop-ptcal");
+
+	if (ptcal_start_tok == RTAS_UNKNOWN_SERVICE
+			|| ptcal_stop_tok == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	ret = register_reboot_notifier(&cbe_ptcal_reboot_notifier);
+	if (ret) {
+		printk(KERN_ERR "Can't disable PTCAL, so not enabling\n");
+		return ret;
+	}
+
+	return cbe_ptcal_enable();
+}
+
+arch_initcall(cbe_ptcal_init);
+
 void __init cbe_ras_init(void)
 {
 	unsigned long hid0;

--
