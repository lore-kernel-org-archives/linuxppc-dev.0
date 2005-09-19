Return-Path: <sr@denx.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id DBBB268344
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 21:20:18 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Sep 2005 13:20:09 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509151803.15301.sr@denx.de> <20050915092555.A27452@cox.net>
In-Reply-To: <20050915092555.A27452@cox.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p7pLDT7JVysd4gl"
Message-Id: <200509191320.09661.sr@denx.de>
Subject: [PATCH] ppc32: cleanup AMCC PPC44x eval boards to better support
	U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_p7pLDT7JVysd4gl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
support U-Boot as bootloader.

Signed-off-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan

--Boundary-00=_p7pLDT7JVysd4gl
Content-Type: text/x-diff; charset="iso-8859-1"; name="ppc44x_u-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc44x_u-boot.patch"

[PATCH] ppc32: cleanup AMCC PPC44x eval boards to better support U-Boot

Cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
support U-Boot as bootloader.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit bd7c0c4a9e3dac8549cc0c557ab809d4d0785005
tree cb6578ee063c0975a1e951785d6ab18c921d8e62
parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
author Stefan Roese <sr@denx.de> Mon, 19 Sep 2005 13:11:52 +0200
committer Stefan Roese <sr@denx.de> Mon, 19 Sep 2005 13:11:52 +0200

 arch/ppc/platforms/4xx/bamboo.c |   14 ++------------
 arch/ppc/platforms/4xx/ebony.c  |   13 ++-----------
 arch/ppc/platforms/4xx/luan.c   |   13 ++-----------
 arch/ppc/platforms/4xx/ocotea.c |   31 +++++++++++--------------------
 arch/ppc/syslib/ibm44x_common.c |   35 ++++++++++++++++++++++++++++++++++-
 arch/ppc/syslib/ibm44x_common.h |    3 ++-
 6 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/arch/ppc/platforms/4xx/bamboo.c b/arch/ppc/platforms/4xx/bamboo.c
--- a/arch/ppc/platforms/4xx/bamboo.c
+++ b/arch/ppc/platforms/4xx/bamboo.c
@@ -52,7 +52,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -426,17 +426,7 @@ bamboo_setup_arch(void)
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
diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c
+++ b/arch/ppc/platforms/4xx/ebony.c
@@ -55,7 +55,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gp_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -318,16 +318,7 @@ ebony_setup_arch(void)
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
diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -53,7 +53,7 @@
 #include <syslib/ibm440gx_common.h>
 #include <syslib/ibm440sp_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -356,16 +356,7 @@ luan_setup_arch(void)
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
diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -53,7 +53,7 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-bd_t __res;
+extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -287,6 +287,15 @@ ocotea_setup_arch(void)
 
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
@@ -325,25 +334,7 @@ static void __init ocotea_init(void)
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
diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
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
diff --git a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_common.h
--- a/arch/ppc/syslib/ibm44x_common.h
+++ b/arch/ppc/syslib/ibm44x_common.h
@@ -36,7 +36,8 @@ struct ibm44x_clocks {
 };
 
 /* common 44x platform init */
-void ibm44x_platform_init(void) __init;
+void ibm44x_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			  unsigned long r6, unsigned long r7) __init;
 
 /* initialize decrementer and tick-related variables */
 void ibm44x_calibrate_decr(unsigned int freq) __init;

--Boundary-00=_p7pLDT7JVysd4gl--
