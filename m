Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 7CD3C6829F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 21:06:27 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 16 Sep 2005 13:06:16 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509151803.15301.sr@denx.de> <20050915092555.A27452@cox.net>
In-Reply-To: <20050915092555.A27452@cox.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pcqKDfM0vO9/yW2"
Message-Id: <200509161306.17103.sr@denx.de>
Subject: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better support
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

--Boundary-00=_pcqKDfM0vO9/yW2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add U-Boot support to AMCC PPC405 eval boards (bubinga, sycamore and walnut)
and cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
support U-Boot as bootloader.

Signed-off-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan

--Boundary-00=_pcqKDfM0vO9/yW2
Content-Type: text/x-diff; charset="iso-8859-1"; name="ppc4xx_u-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc4xx_u-boot.patch"

[PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better support U-Boot

Add U-Boot support to AMCC PPC405 eval boards (bubinga, sycamore and walnut)
and cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
support U-Boot as bootloader.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit ca5c0372ee8b8ea6c6090665743cc5fb90eb667d
tree 9306e22f6c382dc54b2b57d14c321a5baf101da7
parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
author Stefan Roese <sr@denx.de> Fri, 16 Sep 2005 12:52:16 +0200
committer Stefan Roese <sr@denx.de> Fri, 16 Sep 2005 12:52:16 +0200

 arch/ppc/platforms/4xx/Kconfig    |   14 +++++++++++---
 arch/ppc/platforms/4xx/bamboo.c   |   14 ++------------
 arch/ppc/platforms/4xx/bubinga.c  |   20 ++++++++++++++++++++
 arch/ppc/platforms/4xx/bubinga.h  |    7 +++++++
 arch/ppc/platforms/4xx/ebony.c    |   13 ++-----------
 arch/ppc/platforms/4xx/luan.c     |   13 ++-----------
 arch/ppc/platforms/4xx/ocotea.c   |   31 +++++++++++--------------------
 arch/ppc/platforms/4xx/sycamore.c |    2 +-
 arch/ppc/platforms/4xx/sycamore.h |    7 +++++++
 arch/ppc/platforms/4xx/walnut.h   |    7 +++++++
 arch/ppc/syslib/ibm44x_common.c   |   35 ++++++++++++++++++++++++++++++++++-
 arch/ppc/syslib/ibm44x_common.h   |    3 ++-
 include/asm-ppc/ppcboot.h         |    4 ++--
 13 files changed, 108 insertions(+), 62 deletions(-)

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -212,10 +212,18 @@ config EMBEDDEDBOOT
 	depends on EP405 || XILINX_ML300
 	default y
 
-config IBM_OPENBIOS
-	bool
+choice
+	prompt "Bootloader support"
 	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
-	default y
+	default IBM_OPENBIOS
+
+config IBM_OPENBIOS
+	bool "IBM OpenBIOS"
+
+config UBOOT
+	bool "U-Boot"
+
+endchoice
 
 config PPC4xx_DMA
 	bool "PPC4xx DMA controller support"
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
diff --git a/arch/ppc/platforms/4xx/bubinga.c b/arch/ppc/platforms/4xx/bubinga.c
--- a/arch/ppc/platforms/4xx/bubinga.c
+++ b/arch/ppc/platforms/4xx/bubinga.c
@@ -89,7 +89,11 @@ bubinga_early_serial_map(void)
           * by 16.
           */
 	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
+#ifdef CONFIG_UBOOT
+	uart_clock = __res.bi_procfreq / uart_div;
+#else
 	uart_clock = __res.bi_pllouta_freq / uart_div;
+#endif
 
 	/* Setup serial port access */
 	memset(&port, 0, sizeof(port));
@@ -218,9 +222,25 @@ bios_fixup(struct pci_controller *hose, 
 void __init
 bubinga_setup_arch(void)
 {
+#ifdef CONFIG_UBOOT
+        struct ocp_def *def;
+        struct ocp_func_emac_data *emacdata;
+#endif
+
 	ppc4xx_setup_arch();
 
+#ifdef CONFIG_UBOOT
+        /* Set mac_addr for each EMAC */
+        def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+        emacdata = def->additions;
+        memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+
+        def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+        emacdata = def->additions;
+        memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+#else
 	ibm_ocp_set_emac(0, 1);
+#endif
 
         bubinga_early_serial_map();
 
diff --git a/arch/ppc/platforms/4xx/bubinga.h b/arch/ppc/platforms/4xx/bubinga.h
--- a/arch/ppc/platforms/4xx/bubinga.h
+++ b/arch/ppc/platforms/4xx/bubinga.h
@@ -18,6 +18,8 @@
 #include <platforms/4xx/ibm405ep.h>
 
 #ifndef __ASSEMBLY__
+
+#ifdef CONFIG_IBM_OPENBIOS
 /*
  * Data structure defining board information maintained by the boot
  * ROM on IBM's evaluation board. An effort has been made to
@@ -36,6 +38,11 @@ typedef struct board_info {
         unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
         unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
 } bd_t;
+#elif CONFIG_UBOOT
+#include <asm/ppcboot.h>
+#else
+#error "Please enable either IBM OpenBIOS or U-Boot bootloader support!"
+#endif
 
 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
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
diff --git a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
--- a/arch/ppc/platforms/4xx/sycamore.c
+++ b/arch/ppc/platforms/4xx/sycamore.c
@@ -100,7 +100,7 @@ sycamore_setup_arch(void)
 
 	ppc4xx_setup_arch();
 
-	ibm_ocp_set_emac(0, 1);
+	ibm_ocp_set_emac(0, 0);
 
 	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
 	if (!kb_data) {
diff --git a/arch/ppc/platforms/4xx/sycamore.h b/arch/ppc/platforms/4xx/sycamore.h
--- a/arch/ppc/platforms/4xx/sycamore.h
+++ b/arch/ppc/platforms/4xx/sycamore.h
@@ -19,6 +19,8 @@
 #include <platforms/4xx/ibm405gpr.h>
 
 #ifndef __ASSEMBLY__
+
+#ifdef CONFIG_IBM_OPENBIOS
 /*
  * Data structure defining board information maintained by the boot
  * ROM on IBM's "Sycamore" evaluation board. An effort has been made to
@@ -36,6 +38,11 @@ typedef struct board_info {
 	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
 	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
 } bd_t;
+#elif CONFIG_UBOOT
+#include <asm/ppcboot.h>
+#else
+#error "Please enable either IBM OpenBIOS or U-Boot bootloader support!"
+#endif
 
 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
diff --git a/arch/ppc/platforms/4xx/walnut.h b/arch/ppc/platforms/4xx/walnut.h
--- a/arch/ppc/platforms/4xx/walnut.h
+++ b/arch/ppc/platforms/4xx/walnut.h
@@ -24,6 +24,8 @@
 #include <platforms/4xx/ibm405gp.h>
 
 #ifndef __ASSEMBLY__
+
+#ifdef CONFIG_IBM_OPENBIOS
 /*
  * Data structure defining board information maintained by the boot
  * ROM on IBM's "Walnut" evaluation board. An effort has been made to
@@ -41,6 +43,11 @@ typedef struct board_info {
 	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
 	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
 } bd_t;
+#elif CONFIG_UBOOT
+#include <asm/ppcboot.h>
+#else
+#error "Please enable either IBM OpenBIOS or U-Boot bootloader support!"
+#endif
 
 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
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
diff --git a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
--- a/include/asm-ppc/ppcboot.h
+++ b/include/asm-ppc/ppcboot.h
@@ -73,8 +73,8 @@ typedef struct bd_info {
 #if defined(CONFIG_HYMOD)
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_44x) || defined(CONFIG_85xx) ||\
-	defined(CONFIG_83xx)
+#if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
+	defined(CONFIG_85xx) ||	defined(CONFIG_83xx)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif



!-------------------------------------------------------------flip-



--Boundary-00=_pcqKDfM0vO9/yW2--
