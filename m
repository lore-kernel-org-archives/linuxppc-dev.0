Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 17:40:41 +1000
Subject: [PATCH] powerpc: Export flat device tree via debugfs for debugging
Message-Id: <20060501074044.D552967B55@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If DEBUG is turned on in prom.c, export the flat device tree via debugfs.
This has been handy on several occasions.

To look at it:
 # mount -t debugfs none /sys/kernel/debug
 # od -a /sys/kernel/debug/powerpc/flat-device-tree
 and/or
 # dtc -fI dtb /sys/kernel/debug/powerpc/flat-device-tree -O dts

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -30,6 +30,7 @@
 #include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
+#include <linux/debugfs.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -2009,3 +2010,27 @@ void kdump_move_device_tree(void)
 	/* XXX should we unreserve the old DT? */
 }
 #endif /* CONFIG_KEXEC */
+
+#ifdef DEBUG
+static struct debugfs_blob_wrapper flat_dt_blob;
+
+static int __init export_flat_device_tree(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("powerpc", NULL);
+	if (!d)
+		return 1;
+
+	flat_dt_blob.data = initial_boot_params;
+	flat_dt_blob.size = initial_boot_params->totalsize;
+
+	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
+				d, &flat_dt_blob);
+	if (!d)
+		return 1;
+
+	return 0;
+}
+__initcall(export_flat_device_tree);
+#endif
