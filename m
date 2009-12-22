Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] of/flattree: use callback to setup initrd from /chosen
Message-Id: <1261474791.289871.854376051633.1.gpush@pororo>
To: Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 22 Dec 2009 17:39:51 +0800
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, the fdt code sets the kernel-wide initrd_start and
initrd_end variables when parsing /chosen. On ARM, we only set these
once the bootmem has been reserved.

This change adds an arch callback to setup the initrd from the device
tree:

 void early_init_dt_setup_initrd_arch(unsigned long start,
				      unsigned long end);

The arch-specific code can then setup the initrd however it likes.

Compiled on powerpc, with CONFIG_BLK_DEV_INITRD=y and =n.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/microblaze/kernel/prom.c |   10 ++++++++++
 arch/powerpc/kernel/prom.c    |   10 ++++++++++
 drivers/of/fdt.c              |   15 +++++----------
 include/linux/of_fdt.h        |   10 ++++++++++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 15853de..4fb5d87 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -101,6 +101,16 @@ void __init early_init_devtree_arch(void)
 	/* No Microblaze specific code here */
 }
 
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init early_init_dt_setup_initrd_arch(unsigned long start,
+		unsigned long end)
+{
+	initrd_start = (unsigned long)__va(start);
+	initrd_end = (unsigned long)__va(end);
+	initrd_below_start_ok = 1;
+}
+#endif
+
 /*******
  *
  * New implementation of the OF "find" APIs, return a refcounted
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6fea025..236b02c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -467,6 +467,16 @@ int __init early_init_dt_scan_memory_arch(unsigned long node, const char *uname,
 }
 #endif /* CONFIG_PPC_PSERIES */
 
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init early_init_dt_setup_initrd_arch(unsigned long start,
+		unsigned long end)
+{
+	initrd_start = (unsigned long)__va(start);
+	initrd_end = (unsigned long)__va(end);
+	initrd_below_start_ok = 1;
+}
+#endif
+
 void __init early_reserve_mem(void)
 {
 	u64 base, size;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7cb386c..ad0b09a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -398,28 +398,23 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
  */
 void __init early_init_dt_check_for_initrd(unsigned long node)
 {
-	unsigned long len;
+	unsigned long start, end, len;
 	__be32 *prop;
 
 	pr_debug("Looking for initrd properties... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &len);
 	if (prop) {
-		initrd_start = (unsigned long)
-				__va(of_read_ulong(prop, len/4));
+		start = of_read_ulong(prop, len/4);
 
 		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &len);
 		if (prop) {
-			initrd_end = (unsigned long)
-				__va(of_read_ulong(prop, len/4));
-			initrd_below_start_ok = 1;
-		} else {
-			initrd_start = 0;
+			end = of_read_ulong(prop, len/4);
+			early_init_dt_setup_initrd_arch(start, end);
 		}
 	}
 
-	pr_debug("initrd_start=0x%lx  initrd_end=0x%lx\n",
-		 initrd_start, initrd_end);
+	pr_debug("initrd_start=0x%lx  initrd_end=0x%lx\n", start, end);
 }
 #else
 inline void early_init_dt_check_for_initrd(unsigned long node)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 77ae0a4..4aba9a6 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -81,6 +81,16 @@ extern void early_reserve_mem(void);
 extern void early_init_devtree_arch(void);
 extern u64 dt_mem_next_cell(int s, __be32 **cellp);
 
+/*
+ * If BLK_DEV_INITRD, the fdt early init code will call this function,
+ * to be provided by the arch code. start and end are specified as
+ * physical addresses.
+ */
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void early_init_dt_setup_initrd_arch(unsigned long start,
+					    unsigned long end);
+#endif
+
 /* With CONFIG_HAVE_LMB, we can just use the lmb_ functions to add & allocate
  * memory; otherwise, the arch has to provide its own functions to do this.
  */
