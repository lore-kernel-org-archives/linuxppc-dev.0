Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 18 Oct 2006 15:53:20 +1000
Subject: [PATCH] Move iSeries initrd logic into device tree
Message-Id: <20061018055321.300B967C2B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the iSeries initrd logic, instead just store the initrd location and
size in the device tree so generic code can do the rest for us.

The iSeries code had a "feature" which the generic code lacks, ie. if the
compressed initrd is bigger than the configured ram disk size, we make
the ram disk size bigger. That's bogus, as the compressed size of the initrd
tells us nothing about how big the ram disk needs to be. If the ram disk
isn't big enough you just need to make CONFIG_BLK_DEV_RAM_SIZE larger.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/dt.c    |   15 +++++++++++++--
 arch/powerpc/platforms/iseries/setup.c |   32 --------------------------------
 2 files changed, 13 insertions(+), 34 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/dt.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/dt.c
+++ to-merge/arch/powerpc/platforms/iseries/dt.c
@@ -41,6 +41,7 @@
 #include "call_pci.h"
 #include "pci.h"
 #include "it_exp_vpd_panel.h"
+#include "naca.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -205,13 +206,11 @@ static void __init dt_prop_u32(struct is
 	dt_prop(dt, name, &data, sizeof(u32));
 }
 
-#ifdef notyet
 static void __init dt_prop_u64(struct iseries_flat_dt *dt, const char *name,
 		u64 data)
 {
 	dt_prop(dt, name, &data, sizeof(u64));
 }
-#endif
 
 static void __init dt_prop_u64_list(struct iseries_flat_dt *dt,
 		const char *name, u64 *data, int n)
@@ -306,6 +305,17 @@ static void __init dt_model(struct iseri
 	dt_prop_u32(dt, "ibm,partition-no", HvLpConfig_getLpIndex());
 }
 
+static void __init dt_initrd(struct iseries_flat_dt *dt)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (naca.xRamDisk) {
+		dt_prop_u64(dt, "linux,initrd-start", (u64)naca.xRamDisk);
+		dt_prop_u64(dt, "linux,initrd-end",
+			(u64)naca.xRamDisk + naca.xRamDiskSize * HW_PAGE_SIZE);
+	}
+#endif
+}
+
 static void __init dt_do_vdevice(struct iseries_flat_dt *dt,
 		const char *name, u32 reg, int unit,
 		const char *type, const char *compat, int end)
@@ -641,6 +651,7 @@ void * __init build_flat_dt(unsigned lon
 	/* /chosen */
 	dt_start_node(iseries_dt, "chosen");
 	dt_prop_str(iseries_dt, "bootargs", cmd_line);
+	dt_initrd(iseries_dt);
 	dt_end_node(iseries_dt);
 
 	dt_cpus(iseries_dt);
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -21,7 +21,6 @@
 #include <linux/smp.h>
 #include <linux/param.h>
 #include <linux/string.h>
-#include <linux/initrd.h>
 #include <linux/seq_file.h>
 #include <linux/kdev_t.h>
 #include <linux/major.h>
@@ -80,8 +79,6 @@ extern void iSeries_pci_final_fixup(void
 static void iSeries_pci_final_fixup(void) { }
 #endif
 
-extern int rd_size;		/* Defined in drivers/block/rd.c */
-
 extern unsigned long iSeries_recal_tb;
 extern unsigned long iSeries_recal_titan;
 
@@ -295,24 +292,6 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-#if defined(CONFIG_BLK_DEV_INITRD)
-	/*
-	 * If the init RAM disk has been configured and there is
-	 * a non-zero starting address for it, set it up
-	 */
-	if (naca.xRamDisk) {
-		initrd_start = (unsigned long)__va(naca.xRamDisk);
-		initrd_end = initrd_start + naca.xRamDiskSize * HW_PAGE_SIZE;
-		initrd_below_start_ok = 1;	// ramdisk in kernel space
-		ROOT_DEV = Root_RAM0;
-		if (((rd_size * 1024) / HW_PAGE_SIZE) < naca.xRamDiskSize)
-			rd_size = (naca.xRamDiskSize * HW_PAGE_SIZE) / 1024;
-	} else
-#endif /* CONFIG_BLK_DEV_INITRD */
-	{
-	    /* ROOT_DEV = MKDEV(VIODASD_MAJOR, 1); */
-	}
-
 	iSeries_recal_tb = get_tb();
 	iSeries_recal_titan = HvCallXm_loadTod();
 
@@ -331,17 +310,6 @@ static void __init iSeries_init_early(vo
 
 	mf_init();
 
-	/* If we were passed an initrd, set the ROOT_DEV properly if the values
-	 * look sensible. If not, clear initrd reference.
-	 */
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start >= KERNELBASE && initrd_end >= KERNELBASE &&
-	    initrd_end > initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-		initrd_start = initrd_end = 0;
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 	DBG(" <- iSeries_init_early()\n");
 }
 
