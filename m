Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] of/flattree: merge early_init_dt_scan_memory() common code
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	monstr@monstr.eu, sfr@canb.auug.org.au,
	jeremy.kerr@canonical.com, benh@kernel.crashing.org
Date: Wed, 03 Feb 2010 12:01:04 -0700
Message-ID: <20100203190101.26862.94771.stgit@angua>
In-Reply-To: <20100203185753.26862.6818.stgit@angua>
References: <20100203185753.26862.6818.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge common code between PowerPC and Microblaze architectures.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   51 +-----------------------------
 arch/powerpc/kernel/prom.c    |   69 +++++++++++------------------------------
 drivers/of/fdt.c              |   50 ++++++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    3 ++
 4 files changed, 73 insertions(+), 100 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index f7bd0ee..459c32e 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -45,61 +45,14 @@
 /* export that to outside world */
 struct device_node *of_chosen;
 
-#define early_init_dt_scan_drconf_memory(node) 0
-
 void __init early_init_dt_scan_chosen_arch(unsigned long node)
 {
 	/* No Microblaze specific code here */
 }
 
-static int __init early_init_dt_scan_memory(unsigned long node,
-				const char *uname, int depth, void *data)
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	__be32 *reg, *endp;
-	unsigned long l;
-
-	/* Look for the ibm,dynamic-reconfiguration-memory node */
-/*	if (depth == 1 &&
-		strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
-		return early_init_dt_scan_drconf_memory(node);
-*/
-	/* We are scanning "memory" nodes only */
-	if (type == NULL) {
-		/*
-		 * The longtrail doesn't have a device_type on the
-		 * /memory node, so look for the node called /memory@0.
-		 */
-		if (depth != 1 || strcmp(uname, "memory@0") != 0)
-			return 0;
-	} else if (strcmp(type, "memory") != 0)
-		return 0;
-
-	reg = (__be32 *)of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-	if (reg == NULL)
-		reg = (__be32 *)of_get_flat_dt_prop(node, "reg", &l);
-	if (reg == NULL)
-		return 0;
-
-	endp = reg + (l / sizeof(__be32));
-
-	pr_debug("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
-		uname, l, reg[0], reg[1], reg[2], reg[3]);
-
-	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
-		u64 base, size;
-
-		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-		size = dt_mem_next_cell(dt_root_size_cells, &reg);
-
-		if (size == 0)
-			continue;
-		pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
-			(unsigned long long)size);
-
-		lmb_add(base, size);
-	}
-	return 0;
+	lmb_add(base, size);
 }
 
 #ifdef CONFIG_EARLY_PRINTK
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 28be19a..e0f368f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -483,64 +483,31 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 #define early_init_dt_scan_drconf_memory(node)	0
 #endif /* CONFIG_PPC_PSERIES */
 
-static int __init early_init_dt_scan_memory(unsigned long node,
-					    const char *uname, int depth, void *data)
+static int __init early_init_dt_scan_memory_ppc(unsigned long node,
+						const char *uname,
+						int depth, void *data)
 {
-	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	__be32 *reg, *endp;
-	unsigned long l;
-
-	/* Look for the ibm,dynamic-reconfiguration-memory node */
 	if (depth == 1 &&
 	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
 		return early_init_dt_scan_drconf_memory(node);
+	
+	return early_init_dt_scan_memory(node, uname, depth, data);
+}
 
-	/* We are scanning "memory" nodes only */
-	if (type == NULL) {
-		/*
-		 * The longtrail doesn't have a device_type on the
-		 * /memory node, so look for the node called /memory@0.
-		 */
-		if (depth != 1 || strcmp(uname, "memory@0") != 0)
-			return 0;
-	} else if (strcmp(type, "memory") != 0)
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-	if (reg == NULL)
-		reg = of_get_flat_dt_prop(node, "reg", &l);
-	if (reg == NULL)
-		return 0;
-
-	endp = reg + (l / sizeof(__be32));
-
-	DBG("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
-	    uname, l, reg[0], reg[1], reg[2], reg[3]);
-
-	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
-		u64 base, size;
-
-		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-		size = dt_mem_next_cell(dt_root_size_cells, &reg);
-
-		if (size == 0)
-			continue;
-		DBG(" - %llx ,  %llx\n", (unsigned long long)base,
-		    (unsigned long long)size);
-#ifdef CONFIG_PPC64
-		if (iommu_is_off) {
-			if (base >= 0x80000000ul)
-				continue;
-			if ((base + size) > 0x80000000ul)
-				size = 0x80000000ul - base;
-		}
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+#if defined(CONFIG_PPC64)
+	if (iommu_is_off) {
+		if (base >= 0x80000000ul)
+			return;
+		if ((base + size) > 0x80000000ul)
+			size = 0x80000000ul - base;
+	}
 #endif
-		lmb_add(base, size);
 
-		memstart_addr = min((u64)memstart_addr, base);
-	}
+	lmb_add(base, size);
 
-	return 0;
+	memstart_addr = min((u64)memstart_addr, base);
 }
 
 static void __init early_reserve_mem(void)
@@ -706,7 +673,7 @@ void __init early_init_devtree(void *params)
 	/* Scan memory nodes and rebuild LMBs */
 	lmb_init();
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
 	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7f88611..f84152d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
+
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
 #endif /* CONFIG_PPC */
@@ -443,6 +444,55 @@ u64 __init dt_mem_next_cell(int s, u32 **cellp)
 	return of_read_number(p, s);
 }
 
+/**
+ * early_init_dt_scan_memory - Look for an parse memory nodes
+ */
+int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	__be32 *reg, *endp;
+	unsigned long l;
+
+	/* We are scanning "memory" nodes only */
+	if (type == NULL) {
+		/*
+		 * The longtrail doesn't have a device_type on the
+		 * /memory node, so look for the node called /memory@0.
+		 */
+		if (depth != 1 || strcmp(uname, "memory@0") != 0)
+			return 0;
+	} else if (strcmp(type, "memory") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+	if (reg == NULL)
+		reg = of_get_flat_dt_prop(node, "reg", &l);
+	if (reg == NULL)
+		return 0;
+
+	endp = reg + (l / sizeof(__be32));
+
+	pr_debug("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
+	    uname, l, reg[0], reg[1], reg[2], reg[3]);
+
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		u64 base, size;
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (size == 0)
+			continue;
+		pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
+		    (unsigned long long)size);
+
+		early_init_dt_add_memory_arch(base, size);
+	}
+
+	return 0;
+}
+
 int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index fbf2961..bf26bd5 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -75,6 +75,9 @@ extern void early_init_dt_scan_chosen_arch(unsigned long node);
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern void early_init_dt_check_for_initrd(unsigned long node);
+extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
+				     int depth, void *data);
+extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, u32 **cellp);
 
 /* Early flat tree scan hooks */
