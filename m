Return-Path: <arnd@arndb.de>
Message-Id: <20061127182431.191420000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:57 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 6/9] ps3: multiplatform build fixes
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A few code paths need to check whether or not they are running
on the PS3's LV1 hypervisor before making hcalls. This introduces
a new firmware feature bit for this, FW_FEATURE_PS3_LV1.

Now when both PS3 and IBM_CELL_BLADE are enabled, but not PSERIES,
FW_FEATURE_PS3_LV1 and FW_FEATURE_LPAR get enabled at compile time,
which is a bug. The same problem can also happen for (PPC_ISERIES &&
!PPC_PSERIES && PPC_SOMETHING_ELSE). In order to solve this, I
introduce a new CONFIG_PPC_NATIVE option that is set when at least
one platform is selected that can run without a hypervisor and then
turns the firmware feature check into a run-time option.

The new cell oprofile support that was recently merged does not
work on hypervisor based platforms like the PS3, therefore make
it depend on PPC_CELL_NATIVE instead of PPC_CELL. This may change
if we get oprofile support for PS3.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/include/asm-powerpc/firmware.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/firmware.h
+++ linux-2.6/include/asm-powerpc/firmware.h
@@ -42,6 +42,7 @@
 #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
 #define FW_FEATURE_ISERIES	ASM_CONST(0x0000000000200000)
 #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
+#define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
 
 #ifndef __ASSEMBLY__
 
@@ -58,8 +59,10 @@ enum {
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
-	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR,
-	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR,
+	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
+	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
+	FW_FEATURE_NATIVE_POSSIBLE = 0,
+	FW_FEATURE_NATIVE_ALWAYS = 0,
 	FW_FEATURE_POSSIBLE =
 #ifdef CONFIG_PPC_PSERIES
 		FW_FEATURE_PSERIES_POSSIBLE |
@@ -70,6 +73,9 @@ enum {
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_POSSIBLE |
 #endif
+#ifdef CONFIG_PPC_NATIVE
+		FW_FEATURE_NATIVE_ALWAYS |
+#endif
 		0,
 	FW_FEATURE_ALWAYS =
 #ifdef CONFIG_PPC_PSERIES
@@ -81,6 +87,9 @@ enum {
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_ALWAYS &
 #endif
+#ifdef CONFIG_PPC_NATIVE
+		FW_FEATURE_NATIVE_ALWAYS &
+#endif
 		FW_FEATURE_POSSIBLE,
 
 #else /* CONFIG_PPC64 */
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -390,6 +390,7 @@ config PPC_PSERIES
 	select PPC_RTAS
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
+	select PPC_NATIVE
 	default y
 
 config PPC_ISERIES
@@ -406,6 +407,7 @@ config PPC_CHRP
 	select PPC_RTAS
 	select PPC_MPC106
 	select PPC_UDBG_16550
+	select PPC_NATIVE
 	default y
 
 config PPC_EFIKA
@@ -414,6 +416,7 @@ config PPC_EFIKA
 	select PPC_RTAS
 	select RTAS_PROC
 	select PPC_MPC52xx
+	select PPC_NATIVE
 	default y
 
 config PPC_PMAC
@@ -422,6 +425,7 @@ config PPC_PMAC
 	select MPIC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
+	select PPC_NATIVE
 	default y
 
 config PPC_PMAC64
@@ -441,6 +445,7 @@ config PPC_PREP
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
+	select PPC_NATIVE
 	default y
 
 config PPC_MAPLE
@@ -452,6 +457,7 @@ config PPC_MAPLE
 	select GENERIC_TBSYNC
 	select PPC_UDBG_16550
 	select PPC_970_NAP
+	select PPC_NATIVE
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
@@ -464,6 +470,7 @@ config PPC_PASEMI
 	select MPIC
 	select PPC_UDBG_16550
 	select GENERIC_TBSYNC
+	select PPC_NATIVE
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
@@ -478,6 +485,7 @@ config PPC_CELL_NATIVE
 	select PPC_DCR_MMIO
 	select PPC_OF_PLATFORM_PCI
 	select PPC_INDIRECT_IO
+	select PPC_NATIVE
 	select MPIC
 	default n
 
@@ -490,11 +498,6 @@ config PPC_IBM_CELL_BLADE
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
 
-config UDBG_RTAS_CONSOLE
-	bool "RTAS based debug console"
-	depends on PPC_RTAS
-	default n
-
 config PPC_PS3
 	bool "Sony PS3"
 	depends on PPC_MULTIPLATFORM && PPC64
@@ -503,6 +506,19 @@ config PPC_PS3
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
 
+config PPC_NATIVE
+	bool
+	depends on PPC_MULTIPLATFORM
+	help
+	  Support for running natively on the hardware, i.e. without
+	  a hypervisor. This option is not user-selectable but should
+	  be selected by all platforms that need it.
+
+config UDBG_RTAS_CONSOLE
+	bool "RTAS based debug console"
+	depends on PPC_RTAS
+	default n
+
 config XICS
 	depends on PPC_PSERIES
 	bool
Index: linux-2.6/arch/powerpc/platforms/ps3/mm.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/ps3/mm.c
+++ linux-2.6/arch/powerpc/platforms/ps3/mm.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
 
+#include <asm/firmware.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
 #include <asm/ps3.h>
@@ -293,6 +294,9 @@ static int __init ps3_mm_add_memory(void
 	unsigned long start_pfn;
 	unsigned long nr_pages;
 
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return 0;
+
 	BUG_ON(!mem_init_done);
 
 	start_addr = USE_LPAR_ADDR ? map.r1.base : map.rm.size;
Index: linux-2.6/arch/powerpc/platforms/ps3/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/ps3/setup.c
+++ linux-2.6/arch/powerpc/platforms/ps3/setup.c
@@ -108,7 +108,7 @@ static int __init ps3_probe(void)
 	if (!of_flat_dt_is_compatible(dt_root, "PS3"))
 		return 0;
 
-	powerpc_firmware_features |= FW_FEATURE_LPAR;
+	powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
 
 	ps3_os_area_init();
 	ps3_mm_init();
Index: linux-2.6/drivers/ps3/system-bus.c
===================================================================
--- linux-2.6.orig/drivers/ps3/system-bus.c
+++ linux-2.6/drivers/ps3/system-bus.c
@@ -27,6 +27,7 @@
 #include <asm/udbg.h>
 #include <asm/ps3.h>
 #include <asm/lv1call.h>
+#include <asm/firmware.h>
 
 #define dump_mmio_region(_a) _dump_mmio_region(_a, __func__, __LINE__)
 static void _dump_mmio_region(const struct ps3_mmio_region* r,
@@ -167,6 +168,9 @@ int __init ps3_system_bus_init(void)
 {
 	int result;
 
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return 0;
+
 	result = bus_register(&ps3_system_bus_type);
 	BUG_ON(result);
 	return result;
Index: linux-2.6/arch/powerpc/oprofile/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/Makefile
+++ linux-2.6/arch/powerpc/oprofile/Makefile
@@ -11,7 +11,7 @@ DRIVER_OBJS := $(addprefix ../../../driv
 		timer_int.o )
 
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
-oprofile-$(CONFIG_PPC_CELL) += op_model_cell.o
+oprofile-$(CONFIG_PPC_CELL_NATIVE) += op_model_cell.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
Index: linux-2.6/arch/powerpc/oprofile/common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/common.c
+++ linux-2.6/arch/powerpc/oprofile/common.c
@@ -147,7 +147,7 @@ int __init oprofile_arch_init(struct opr
 
 	switch (cur_cpu_spec->oprofile_type) {
 #ifdef CONFIG_PPC64
-#ifdef CONFIG_PPC_CELL
+#ifdef CONFIG_PPC_CELL_NATIVE
 		case PPC_OPROFILE_CELL:
 			model = &op_model_cell;
 			break;
Index: linux-2.6/arch/powerpc/mm/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/Makefile
+++ linux-2.6/arch/powerpc/mm/Makefile
@@ -8,7 +8,7 @@ endif
 
 obj-y				:= fault.o mem.o lmb.o
 obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o
-hash-$(CONFIG_PPC_MULTIPLATFORM) := hash_native_64.o
+hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= init_64.o pgtable_64.o mmu_context_64.o \
 				   hash_utils_64.o hash_low_64.o tlb_64.o \
 				   slb_low.o slb.o stab.o mmap.o imalloc.o \

--
