Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 4 May 2007 14:16:32 -0700
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: check cache coherency of kernel vs firmware
Message-ID: <20070504211632.GA4776@xyzzy.farnsworth.org>
References: <20070502215938.GF27253@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070502215938.GF27253@xyzzy.farnsworth.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

check_cache_coherency() verifies that the cache coherency setting of
the kernel (CONFIG_NOT_COHERENT_CACHE) matches that left by the firmware,
as indicated by coherency-off device tree property.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---
New, improved!  Now with matching config var names.  Thanks Stephen.

 arch/powerpc/Kconfig                       |    3 +
 arch/powerpc/kernel/setup-common.c         |   41 +++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 
 3 files changed, 45 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-powerpc-df/arch/powerpc/kernel/setup-common.c
@@ -530,3 +530,44 @@ void __init setup_panic(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
 }
+
+#ifdef CONFIG_CHECK_CACHE_COHERENCY
+/*
+ * For platforms that have configurable cache-coherency.  This function
+ * checks that the cache coherency setting of the kernel matches the setting
+ * left by the firmware, as indicated in the device tree.  Since a mismatch
+ * will eventually result in DMA failures, we print * and error and call
+ * BUG() in that case.
+ */
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define KERNEL_COHERENCY	0
+#else
+#define KERNEL_COHERENCY	1
+#endif
+
+static int __init check_cache_coherency(void)
+{
+	struct device_node *np;
+	const void *prop;
+	int devtree_coherency;
+
+	np = of_find_node_by_path("/");
+	prop = of_get_property(np, "coherency-off", NULL);
+	of_node_put(np);
+
+	devtree_coherency = prop ? 0 : 1;
+
+	if (devtree_coherency != KERNEL_COHERENCY) {
+		printk(KERN_ERR
+			"kernel coherency:%s != device tree_coherency:%s\n",
+			KERNEL_COHERENCY ? "on" : "off",
+			devtree_coherency ? "on" : "off");
+		BUG();
+	}
+
+	return 0;
+}
+
+late_initcall(check_cache_coherency);
+#endif /* CONFIG_CHECK_CACHE_COHERENCY */
Index: linux-2.6-powerpc-df/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/Kconfig
@@ -373,6 +373,9 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || 8xx || E200
 	default y
+
+config CONFIG_CHECK_CACHE_COHERENCY
+	bool
 endmenu
 
 source "init/Kconfig"
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -41,6 +41,7 @@ config MPC10X_BRIDGE
 config MV64X60
 	bool
 	select PPC_INDIRECT_PCI
+	select CONFIG_CHECK_CACHE_COHERENCY
 
 config MPC10X_OPENPIC
 	bool
