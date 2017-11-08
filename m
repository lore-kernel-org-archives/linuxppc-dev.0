Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqqs1dgxzDr79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqqr6LBMz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:24 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqq2vTbz9sPt
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82NqZ8115311
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:19 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e3qx3k70j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:19 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:18 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 11/18] powerpc/vas: Export HVWC to debugfs
Date: Tue,  7 Nov 2017 18:23:51 -0800
In-Reply-To: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1510107838-15181-12-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the VAS Window context information to debugfs.

We need to hold a mutex when closing the window to prevent a race
with the debugfs read(). Rather than introduce a per-instance mutex,
we use the global vas_mutex for now, since it is not heavily contended.

The window->cop field is only relevant to a receive window so we were
not setting it for a send window (which is is paired to a receive window
anyway). But to simplify reporting in debugfs, set the 'cop' field for the
send window also.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v3]:
	- [Michael Ellerman] Fix couple of unininitialized variables
---
 arch/powerpc/platforms/powernv/Makefile     |   3 +-
 arch/powerpc/platforms/powernv/vas-debug.c  | 209 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c |  34 ++++-
 arch/powerpc/platforms/powernv/vas.c        |   6 +-
 arch/powerpc/platforms/powernv/vas.h        |  14 ++
 5 files changed, 257 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/vas-debug.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 7a31c26..3732118 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
-obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o
+obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
+obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
new file mode 100644
index 0000000..ca22f1e
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -0,0 +1,209 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "vas: " fmt
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include "vas.h"
+
+static struct dentry *vas_debugfs;
+
+static char *cop_to_str(int cop)
+{
+	switch (cop) {
+	case VAS_COP_TYPE_FAULT:	return "Fault";
+	case VAS_COP_TYPE_842:		return "NX-842 Normal Priority";
+	case VAS_COP_TYPE_842_HIPRI:	return "NX-842 High Priority";
+	case VAS_COP_TYPE_GZIP:		return "NX-GZIP Normal Priority";
+	case VAS_COP_TYPE_GZIP_HIPRI:	return "NX-GZIP High Priority";
+	case VAS_COP_TYPE_FTW:		return "Fast Thread-wakeup";
+	default:			return "Unknown";
+	}
+}
+
+static int info_dbg_show(struct seq_file *s, void *private)
+{
+	struct vas_window *window = s->private;
+
+	mutex_lock(&vas_mutex);
+
+	/* ensure window is not unmapped */
+	if (!window->hvwc_map)
+		goto unlock;
+
+	seq_printf(s, "Type: %s, %s\n", cop_to_str(window->cop),
+					window->tx_win ? "Send" : "Receive");
+	seq_printf(s, "Pid : %d\n", window->pid);
+
+unlock:
+	mutex_unlock(&vas_mutex);
+	return 0;
+}
+
+static int info_dbg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, info_dbg_show, inode->i_private);
+}
+
+static const struct file_operations info_fops = {
+	.open		= info_dbg_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static inline void print_reg(struct seq_file *s, struct vas_window *win,
+			char *name, u32 reg)
+{
+	seq_printf(s, "0x%016llx %s\n", read_hvwc_reg(win, name, reg), name);
+}
+
+static int hvwc_dbg_show(struct seq_file *s, void *private)
+{
+	struct vas_window *window = s->private;
+
+	mutex_lock(&vas_mutex);
+
+	/* ensure window is not unmapped */
+	if (!window->hvwc_map)
+		goto unlock;
+
+	print_reg(s, window, VREG(LPID));
+	print_reg(s, window, VREG(PID));
+	print_reg(s, window, VREG(XLATE_MSR));
+	print_reg(s, window, VREG(XLATE_LPCR));
+	print_reg(s, window, VREG(XLATE_CTL));
+	print_reg(s, window, VREG(AMR));
+	print_reg(s, window, VREG(SEIDR));
+	print_reg(s, window, VREG(FAULT_TX_WIN));
+	print_reg(s, window, VREG(OSU_INTR_SRC_RA));
+	print_reg(s, window, VREG(HV_INTR_SRC_RA));
+	print_reg(s, window, VREG(PSWID));
+	print_reg(s, window, VREG(LFIFO_BAR));
+	print_reg(s, window, VREG(LDATA_STAMP_CTL));
+	print_reg(s, window, VREG(LDMA_CACHE_CTL));
+	print_reg(s, window, VREG(LRFIFO_PUSH));
+	print_reg(s, window, VREG(CURR_MSG_COUNT));
+	print_reg(s, window, VREG(LNOTIFY_AFTER_COUNT));
+	print_reg(s, window, VREG(LRX_WCRED));
+	print_reg(s, window, VREG(LRX_WCRED_ADDER));
+	print_reg(s, window, VREG(TX_WCRED));
+	print_reg(s, window, VREG(TX_WCRED_ADDER));
+	print_reg(s, window, VREG(LFIFO_SIZE));
+	print_reg(s, window, VREG(WINCTL));
+	print_reg(s, window, VREG(WIN_STATUS));
+	print_reg(s, window, VREG(WIN_CTX_CACHING_CTL));
+	print_reg(s, window, VREG(TX_RSVD_BUF_COUNT));
+	print_reg(s, window, VREG(LRFIFO_WIN_PTR));
+	print_reg(s, window, VREG(LNOTIFY_CTL));
+	print_reg(s, window, VREG(LNOTIFY_PID));
+	print_reg(s, window, VREG(LNOTIFY_LPID));
+	print_reg(s, window, VREG(LNOTIFY_TID));
+	print_reg(s, window, VREG(LNOTIFY_SCOPE));
+	print_reg(s, window, VREG(NX_UTIL_ADDER));
+unlock:
+	mutex_unlock(&vas_mutex);
+	return 0;
+}
+
+static int hvwc_dbg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hvwc_dbg_show, inode->i_private);
+}
+
+static const struct file_operations hvwc_fops = {
+	.open		= hvwc_dbg_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+void vas_window_free_dbgdir(struct vas_window *window)
+{
+	if (window->dbgdir) {
+		debugfs_remove_recursive(window->dbgdir);
+		kfree(window->dbgname);
+		window->dbgdir = NULL;
+		window->dbgname = NULL;
+	}
+}
+
+void vas_window_init_dbgdir(struct vas_window *window)
+{
+	struct dentry *f, *d;
+
+	if (!window->vinst->dbgdir)
+		return;
+
+	window->dbgname = kzalloc(16, GFP_KERNEL);
+	if (!window->dbgname)
+		return;
+
+	snprintf(window->dbgname, 16, "w%d", window->winid);
+
+	d = debugfs_create_dir(window->dbgname, window->vinst->dbgdir);
+	if (IS_ERR(d))
+		goto free_name;
+
+	window->dbgdir = d;
+
+	f = debugfs_create_file("info", 0444, d, window, &info_fops);
+	if (IS_ERR(f))
+		goto remove_dir;
+
+	f = debugfs_create_file("hvwc", 0444, d, window, &hvwc_fops);
+	if (IS_ERR(f))
+		goto remove_dir;
+
+	return;
+
+free_name:
+	kfree(window->dbgname);
+	window->dbgname = NULL;
+
+remove_dir:
+	debugfs_remove_recursive(window->dbgdir);
+	window->dbgdir = NULL;
+}
+
+void vas_instance_init_dbgdir(struct vas_instance *vinst)
+{
+	struct dentry *d;
+
+	if (!vas_debugfs)
+		return;
+
+	vinst->dbgname = kzalloc(16, GFP_KERNEL);
+	if (!vinst->dbgname)
+		return;
+
+	snprintf(vinst->dbgname, 16, "v%d", vinst->vas_id);
+
+	d = debugfs_create_dir(vinst->dbgname, vas_debugfs);
+	if (IS_ERR(d))
+		goto free_name;
+
+	vinst->dbgdir = d;
+	return;
+
+free_name:
+	kfree(vinst->dbgname);
+	vinst->dbgname = NULL;
+	vinst->dbgdir = NULL;
+}
+
+void vas_init_dbgdir(void)
+{
+	vas_debugfs = debugfs_create_dir("vas", NULL);
+	if (IS_ERR(vas_debugfs))
+		vas_debugfs = NULL;
+}
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 23c13a7..c030d4c 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -145,23 +145,37 @@ static void unmap_paste_region(struct vas_window *window)
 }
 
 /*
- * Unmap the MMIO regions for a window.
+ * Unmap the MMIO regions for a window. Hold the vas_mutex so we don't
+ * unmap when the window's debugfs dir is in use. This serializes close
+ * of a window even on another VAS instance but since its not a critical
+ * path, just minimize the time we hold the mutex for now. We can add
+ * a per-instance mutex later if necessary.
  */
 static void unmap_winctx_mmio_bars(struct vas_window *window)
 {
 	int len;
+	void *uwc_map;
+	void *hvwc_map;
 	u64 busaddr_start;
 
-	if (window->hvwc_map) {
+	mutex_lock(&vas_mutex);
+
+	hvwc_map = window->hvwc_map;
+	window->hvwc_map = NULL;
+
+	uwc_map = window->uwc_map;
+	window->uwc_map = NULL;
+
+	mutex_unlock(&vas_mutex);
+
+	if (hvwc_map) {
 		get_hvwc_mmio_bar(window, &busaddr_start, &len);
-		unmap_region(window->hvwc_map, busaddr_start, len);
-		window->hvwc_map = NULL;
+		unmap_region(hvwc_map, busaddr_start, len);
 	}
 
-	if (window->uwc_map) {
+	if (uwc_map) {
 		get_uwc_mmio_bar(window, &busaddr_start, &len);
-		unmap_region(window->uwc_map, busaddr_start, len);
-		window->uwc_map = NULL;
+		unmap_region(uwc_map, busaddr_start, len);
 	}
 }
 
@@ -528,6 +542,9 @@ static void vas_window_free(struct vas_window *window)
 	struct vas_instance *vinst = window->vinst;
 
 	unmap_winctx_mmio_bars(window);
+
+	vas_window_free_dbgdir(window);
+
 	kfree(window);
 
 	vas_release_window_id(&vinst->ida, winid);
@@ -552,6 +569,8 @@ static struct vas_window *vas_window_alloc(struct vas_instance *vinst)
 	if (map_winctx_mmio_bars(window))
 		goto out_free;
 
+	vas_window_init_dbgdir(window);
+
 	return window;
 
 out_free:
@@ -974,6 +993,7 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 		goto put_rxwin;
 	}
 
+	txwin->cop = cop;
 	txwin->tx_win = 1;
 	txwin->rxwin = rxwin;
 	txwin->nx_win = txwin->rxwin->nx_win;
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index cd9a733..c488621 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -22,7 +22,7 @@
 
 #include "vas.h"
 
-static DEFINE_MUTEX(vas_mutex);
+DEFINE_MUTEX(vas_mutex);
 static LIST_HEAD(vas_instances);
 
 static DEFINE_PER_CPU(int, cpu_vas_id);
@@ -86,6 +86,8 @@ static int init_vas_instance(struct platform_device *pdev)
 	list_add(&vinst->node, &vas_instances);
 	mutex_unlock(&vas_mutex);
 
+	vas_instance_init_dbgdir(vinst);
+
 	dev_set_drvdata(&pdev->dev, vinst);
 
 	return 0;
@@ -157,6 +159,8 @@ static int __init vas_init(void)
 	int found = 0;
 	struct device_node *dn;
 
+	vas_init_dbgdir();
+
 	platform_driver_register(&vas_driver);
 
 	for_each_compatible_node(dn, NULL, "ibm,vas") {
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 02d8a31..756cbc5 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -13,6 +13,8 @@
 #include <linux/idr.h>
 #include <asm/vas.h>
 #include <linux/io.h>
+#include <linux/dcache.h>
+#include <linux/mutex.h>
 
 /*
  * Overview of Virtual Accelerator Switchboard (VAS).
@@ -317,6 +319,9 @@ struct vas_instance {
 	struct mutex mutex;
 	struct vas_window *rxwin[VAS_COP_TYPE_MAX];
 	struct vas_window *windows[VAS_WINDOWS_PER_CHIP];
+
+	char *dbgname;
+	struct dentry *dbgdir;
 };
 
 /*
@@ -334,6 +339,9 @@ struct vas_window {
 	pid_t pid;		/* Linux process id of owner */
 	int wcreds_max;		/* Window credits */
 
+	char *dbgname;
+	struct dentry *dbgdir;
+
 	/* Fields applicable only to send windows */
 	void *paste_kaddr;
 	char *paste_addr_name;
@@ -394,7 +402,13 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern struct mutex vas_mutex;
+
 extern struct vas_instance *find_vas_instance(int vasid);
+extern void vas_init_dbgdir(void);
+extern void vas_instance_init_dbgdir(struct vas_instance *vinst);
+extern void vas_window_init_dbgdir(struct vas_window *win);
+extern void vas_window_free_dbgdir(struct vas_window *win);
 
 static inline void vas_log_write(struct vas_window *win, char *name,
 			void *regptr, u64 val)
-- 
2.7.4
