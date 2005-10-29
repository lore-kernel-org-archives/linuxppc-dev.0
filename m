Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kiJc029997@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:14 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sr@denx.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 04/43] ppc32: Cleanup AMCC PPC44x eval board U-Boot support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Matt Porter <mporter@kernel.crashing.org>

Cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
support U-Boot as bootloader.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/4xx/bamboo.c |   14 ++------------
 arch/ppc/platforms/4xx/ebony.c  |   13 ++-----------
 arch/ppc/platforms/4xx/luan.c   |   13 ++-----------
 arch/ppc/platforms/4xx/ocotea.c |   31 +++++++++++--------------------
 arch/ppc/syslib/ibm44x_common.c |   35 ++++++++++++++++++++++++++++++++++-
 arch/ppc/syslib/ibm44x_common.h |    3 ++-
 6 files changed, 53 insertions(+), 56 deletions(-)

diff -puN arch/ppc/platforms/4xx/bamboo.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/platforms/4xx/bamboo.c
--- devel/arch/ppc/platforms/4xx/bamboo.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/4xx/bamboo.c	2005-10-28 17:44:02.000000000 -0700
@@ -51,7 +51,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -425,17 +425,7 @@ bamboo_setup_arch(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
-
-	/*
-	 * If we were passed in a board information, copy it into the
-	 * residual data area.
-	 */
-	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
-
-
-	ibm44x_platform_init();
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
 
 	ppc_md.setup_arch = bamboo_setup_arch;
 	ppc_md.show_cpuinfo = bamboo_show_cpuinfo;
diff -puN arch/ppc/platforms/4xx/ebony.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/platforms/4xx/ebony.c
--- devel/arch/ppc/platforms/4xx/ebony.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/4xx/ebony.c	2005-10-28 17:44:02.000000000 -0700
@@ -54,7 +54,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gp_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -317,16 +317,7 @@ ebony_setup_arch(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
-
-	/*
-	 * If we were passed in a board information, copy it into the
-	 * residual data area.
-	 */
-	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
-
-	ibm44x_platform_init();
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
 
 	ppc_md.setup_arch = ebony_setup_arch;
 	ppc_md.show_cpuinfo = ebony_show_cpuinfo;
diff -puN arch/ppc/platforms/4xx/luan.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/platforms/4xx/luan.c
--- devel/arch/ppc/platforms/4xx/luan.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/4xx/luan.c	2005-10-28 17:44:02.000000000 -0700
@@ -52,7 +52,7 @@
 #include <syslib/ibm440gx_common.h>
 #include <syslib/ibm440sp_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -355,16 +355,7 @@ luan_setup_arch(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
-
-	/*
-	 * If we were passed in a board information, copy it into the
-	 * residual data area.
-	 */
-	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
-
-	ibm44x_platform_init();
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
 
 	ppc_md.setup_arch = luan_setup_arch;
 	ppc_md.show_cpuinfo = luan_show_cpuinfo;
diff -puN arch/ppc/platforms/4xx/ocotea.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/platforms/4xx/ocotea.c
--- devel/arch/ppc/platforms/4xx/ocotea.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/4xx/ocotea.c	2005-10-28 17:44:02.000000000 -0700
@@ -52,7 +52,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -286,6 +286,15 @@ ocotea_setup_arch(void)
 
 	ibm440gx_tah_enable();
 
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
 	/* Setup TODC access */
 	TODC_INIT(TODC_TYPE_DS1743,
 			0,
@@ -324,25 +333,7 @@ static void __init ocotea_init(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo(find_bootinfo());
-
-	/*
-	 * If we were passed in a board information, copy it into the
-	 * residual data area.
-	 */
-	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
-
-	/*
-	 * Determine various clocks.
-	 * To be completely correct we should get SysClk
-	 * from FPGA, because it can be changed by on-board switches
-	 * --ebs
-	 */
-	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
-	ocp_sys_info.opb_bus_freq = clocks.opb;
-
-	ibm44x_platform_init();
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
 
 	ppc_md.setup_arch = ocotea_setup_arch;
 	ppc_md.show_cpuinfo = ocotea_show_cpuinfo;
diff -puN arch/ppc/syslib/ibm44x_common.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/syslib/ibm44x_common.c
--- devel/arch/ppc/syslib/ibm44x_common.c~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/ibm44x_common.c	2005-10-28 17:44:02.000000000 -0700
@@ -27,9 +27,14 @@
 #include <asm/time.h>
 #include <asm/ppc4xx_pic.h>
 #include <asm/param.h>
+#include <asm/bootinfo.h>
+#include <asm/ppcboot.h>
 
 #include <syslib/gen550.h>
 
+/* Global Variables */
+bd_t __res;
+
 phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
 {
 	phys_addr_t page_4gb = 0;
@@ -150,8 +155,36 @@ static unsigned long __init ibm44x_find_
 	return mem_size;
 }
 
-void __init ibm44x_platform_init(void)
+void __init ibm44x_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+				 unsigned long r6, unsigned long r7)
 {
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif  /* CONFIG_BLK_DEV_INITRD */
+
+	/* Copy the kernel command line arguments to a safe place. */
+
+	if (r6) {
+		*(char *) (r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+	}
+
 	ppc_md.init_IRQ = ppc4xx_pic_init;
 	ppc_md.find_end_of_memory = ibm44x_find_end_of_memory;
 	ppc_md.restart = ibm44x_restart;
diff -puN arch/ppc/syslib/ibm44x_common.h~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support arch/ppc/syslib/ibm44x_common.h
--- devel/arch/ppc/syslib/ibm44x_common.h~ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/ibm44x_common.h	2005-10-28 17:44:02.000000000 -0700
@@ -36,7 +36,8 @@ struct ibm44x_clocks {
 };
 
 /* common 44x platform init */
-void ibm44x_platform_init(void) __init;
+void ibm44x_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			  unsigned long r6, unsigned long r7) __init;
 
 /* initialize decrementer and tick-related variables */
 void ibm44x_calibrate_decr(unsigned int freq) __init;
_
