Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0985172bce73e36071c221bfdc5e1b28b474b308.1182300841.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] Make the debugfs "powerpc" dir globally accessible
Date: Wed, 20 Jun 2007 10:54:19 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The prom.c debugging code creates a "powerpc" directory in debugfs,
which is nice, but doesn't allow any other debugging code to stick things
under "powerpc" in debugfs. So make it global.

While we're there we should make the prom.c debugging code depend on
CONFIG_DEBUG_FS, because it doesn't work otherwise.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

I should probably mention, if the root creation fails we'll end up with
the "flat-device-tree" file sitting in the root of debugfs, which is not
quite what we wanted - but good enough.


 arch/powerpc/kernel/prom.c         |    9 +++------
 arch/powerpc/kernel/setup-common.c |   13 +++++++++++++
 include/asm-powerpc/system.h       |    2 ++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index af42dda..e36b21c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -52,6 +52,7 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
 #include <asm/kexec.h>
+#include <asm/system.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) printk(KERN_ERR fmt)
@@ -1716,22 +1717,18 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 }
 EXPORT_SYMBOL(of_get_cpu_node);
 
-#ifdef DEBUG
+#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
 static struct debugfs_blob_wrapper flat_dt_blob;
 
 static int __init export_flat_device_tree(void)
 {
 	struct dentry *d;
 
-	d = debugfs_create_dir("powerpc", NULL);
-	if (!d)
-		return 1;
-
 	flat_dt_blob.data = initial_boot_params;
 	flat_dt_blob.size = initial_boot_params->totalsize;
 
 	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
-				d, &flat_dt_blob);
+				powerpc_debugfs_root, &flat_dt_blob);
 	if (!d)
 		return 1;
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ed07a19..3a08f4e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -32,6 +32,7 @@
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/debugfs.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -571,3 +572,15 @@ static int __init check_cache_coherency(void)
 
 late_initcall(check_cache_coherency);
 #endif /* CONFIG_CHECK_CACHE_COHERENCY */
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *powerpc_debugfs_root;
+
+static int powerpc_debugfs_init(void)
+{
+	powerpc_debugfs_root = debugfs_create_dir("powerpc", NULL);
+
+	return powerpc_debugfs_root == NULL;
+}
+arch_initcall(powerpc_debugfs_init);
+#endif
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 09621f6..464b9c5 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -559,5 +559,7 @@ static inline void create_function_call(unsigned long addr, void * func)
 extern void account_system_vtime(struct task_struct *);
 #endif
 
+extern struct dentry *powerpc_debugfs_root;
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SYSTEM_H */
-- 
1.5.1.3.g7a33b
