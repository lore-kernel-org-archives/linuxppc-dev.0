Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 May 2006 18:00:52 +1000
Subject: [PATCH 5/5] powerpc: Move crashkernel= handling into the kernel.
In-Reply-To: <1147852841.148164.91320074069.qpush@concordia>
Message-Id: <20060517080054.963CC67A0E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we parse crashkernel= in prom_init.c, which means for other boot
loaders to support Kdump they also need to parse the command line and setup
the appropriate crash kernel properties.

With early param parsing done earlier we can do crashkernel= parsing in the
early kernel code and avoid the need for every bootloader to do it for us.

We still support the device tree properties if they're specified by firmware,
however the command line overrides anything we find there.

Tested on P5 LPAR.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/machine_kexec_64.c |   94 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom.c             |    1 
 arch/powerpc/kernel/prom_init.c        |   54 ------------------
 include/asm-powerpc/kexec.h            |    2 
 4 files changed, 97 insertions(+), 54 deletions(-)

Index: to-merge/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ to-merge/arch/powerpc/kernel/machine_kexec_64.c
@@ -21,6 +21,7 @@
 #include <asm/machdep.h>
 #include <asm/cacheflush.h>
 #include <asm/paca.h>
+#include <asm/lmb.h>
 #include <asm/mmu.h>
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
@@ -335,9 +336,102 @@ static void __init export_htab_values(vo
 	of_node_put(node);
 }
 
+static struct property crashk_base_prop = {
+	.name = "linux,crashkernel-base",
+	.length = sizeof(unsigned long),
+	.value = (unsigned char *)&crashk_res.start,
+};
+
+static unsigned long crashk_size;
+
+static struct property crashk_size_prop = {
+	.name = "linux,crashkernel-size",
+	.length = sizeof(unsigned long),
+	.value = (unsigned char *)&crashk_size,
+};
+
+static void __init export_crashk_values(void)
+{
+	struct device_node *node;
+	struct property *prop;
+
+	node = of_find_node_by_path("/chosen");
+	if (!node)
+		return;
+
+	/* There might be existing crash kernel properties, but we can't
+	 * be sure what's in them, so remove them. */
+	prop = of_find_property(node, "linux,crashkernel-base", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	prop = of_find_property(node, "linux,crashkernel-size", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	if (crashk_res.start != 0) {
+		prom_add_property(node, &crashk_base_prop);
+		crashk_size = crashk_res.end - crashk_res.start + 1;
+		prom_add_property(node, &crashk_size_prop);
+	}
+
+	of_node_put(node);
+}
+
 void __init kexec_setup(void)
 {
 	export_htab_values();
+	export_crashk_values();
+}
+
+static int __init early_parse_crashk(char *p)
+{
+	unsigned long size;
+
+	if (!p)
+		return 1;
+
+	size = memparse(p, &p);
+
+	if (*p == '@')
+		crashk_res.start = memparse(p + 1, &p);
+	else
+		crashk_res.start = KDUMP_KERNELBASE;
+
+	crashk_res.end = crashk_res.start + size - 1;
+
+	return 0;
+}
+early_param("crashkernel", early_parse_crashk);
+
+void __init reserve_crashkernel(void)
+{
+	unsigned long size;
+
+	if (crashk_res.start == 0)
+		return;
+
+	/* We might have got these values via the command line or the
+	 * device tree, either way sanitise them now. */
+
+	size = crashk_res.end - crashk_res.start + 1;
+
+	if (crashk_res.start != KDUMP_KERNELBASE)
+		printk("Crash kernel location must be 0x%x\n",
+				KDUMP_KERNELBASE);
+
+	crashk_res.start = KDUMP_KERNELBASE;
+	size = PAGE_ALIGN(size);
+	crashk_res.end = crashk_res.start + size - 1;
+
+	/* Crash kernel trumps memory limit */
+	if (memory_limit && memory_limit <= crashk_res.end) {
+		memory_limit = crashk_res.end + 1;
+		printk("Adjusted memory limit for crashkernel, now 0x%lx\n",
+				memory_limit);
+	}
+
+	lmb_reserve(crashk_res.start, size);
 }
 
 int overlaps_crashkernel(unsigned long start, unsigned long size)
Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -1327,6 +1327,7 @@ void __init early_init_devtree(void *par
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	reserve_kdump_trampoline();
+	reserve_crashkernel();
 	early_reserve_mem();
 
 	lmb_enforce_memory_limit(memory_limit);
Index: to-merge/arch/powerpc/kernel/prom_init.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom_init.c
+++ to-merge/arch/powerpc/kernel/prom_init.c
@@ -200,11 +200,6 @@ static unsigned long __initdata alloc_bo
 static unsigned long __initdata rmo_top;
 static unsigned long __initdata ram_top;
 
-#ifdef CONFIG_KEXEC
-static unsigned long __initdata prom_crashk_base;
-static unsigned long __initdata prom_crashk_size;
-#endif
-
 static struct mem_map_entry __initdata mem_reserve_map[MEM_RESERVE_MAP_SIZE];
 static int __initdata mem_reserve_cnt;
 
@@ -591,35 +586,6 @@ static void __init early_cmdline_parse(v
 			RELOC(iommu_force_on) = 1;
 	}
 #endif
-
-#ifdef CONFIG_KEXEC
-	/*
-	 * crashkernel=size@addr specifies the location to reserve for
-	 * crash kernel.
-	 */
-	opt = strstr(RELOC(prom_cmd_line), RELOC("crashkernel="));
-	if (opt) {
-		opt += 12;
-		RELOC(prom_crashk_size) = 
-			prom_memparse(opt, (const char **)&opt);
-
-		if (ALIGN(RELOC(prom_crashk_size), 0x1000000) !=
-			RELOC(prom_crashk_size)) {
-			prom_printf("Warning: crashkernel size is not "
-					"aligned to 16MB\n");
-		}
-
-		/*
-		 * At present, the crash kernel always run at 32MB.
-		 * Just ignore whatever user passed.
-		 */
-		RELOC(prom_crashk_base) = 0x2000000;
-		if (*opt == '@') {
-			prom_printf("Warning: PPC64 kdump kernel always runs "
-					"at 32 MB\n");
-		}
-	}
-#endif
 }
 
 #ifdef CONFIG_PPC_PSERIES
@@ -1122,12 +1088,6 @@ static void __init prom_init_mem(void)
 	prom_printf("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
 	prom_printf("  rmo_top      : %x\n", RELOC(rmo_top));
 	prom_printf("  ram_top      : %x\n", RELOC(ram_top));
-#ifdef CONFIG_KEXEC
-	if (RELOC(prom_crashk_base)) {
-		prom_printf("  crashk_base  : %x\n",  RELOC(prom_crashk_base));
-		prom_printf("  crashk_size  : %x\n", RELOC(prom_crashk_size));
-	}
-#endif
 }
 
 
@@ -2187,10 +2147,6 @@ unsigned long __init prom_init(unsigned 
 	 */
 	prom_init_mem();
 
-#ifdef CONFIG_KEXEC
-	if (RELOC(prom_crashk_base))
-		reserve_mem(RELOC(prom_crashk_base), RELOC(prom_crashk_size));
-#endif
 	/*
 	 * Determine which cpu is actually running right _now_
 	 */
@@ -2243,16 +2199,6 @@ unsigned long __init prom_init(unsigned 
 	}
 #endif
 
-#ifdef CONFIG_KEXEC
-	if (RELOC(prom_crashk_base)) {
-		prom_setprop(_prom->chosen, "/chosen", "linux,crashkernel-base",
-			PTRRELOC(&prom_crashk_base),
-			sizeof(RELOC(prom_crashk_base)));
-		prom_setprop(_prom->chosen, "/chosen", "linux,crashkernel-size",
-			PTRRELOC(&prom_crashk_size),
-			sizeof(RELOC(prom_crashk_size)));
-	}
-#endif
 	/*
 	 * Fixup any known bugs in the device-tree
 	 */
Index: to-merge/include/asm-powerpc/kexec.h
===================================================================
--- to-merge.orig/include/asm-powerpc/kexec.h
+++ to-merge/include/asm-powerpc/kexec.h
@@ -133,6 +133,8 @@ static inline int overlaps_crashkernel(u
 	return 0;
 }
 
+static inline void reserve_crashkernel(void) { ; }
+
 #endif /* CONFIG_KEXEC */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
