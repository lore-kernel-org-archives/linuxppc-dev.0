Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9D047679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 05:16:54 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j4RJM6W2010994 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 12:22:06 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j4RJIERV015772
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 14:18:15 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
References: <1116607235.29111.20.camel@gleep>
	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
Content-Type: text/plain
Message-Id: <1117221410.26114.95.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 27 May 2005 14:16:51 -0500
Subject: bd_t Cleaning: Board Changes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-26 at 18:08, Kumar Gala wrote:
> Jon,
> 
> Can you break the patch up into a few pieces, it will be easier to 
> review that way.  Here are the following pieces that make sense to me:
> 
> 0. New firmware interface (fw_bdt*, Kconfig, ...)
> 1. board code changes (everything in arch/ppc/platforms/*)
> 2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
> a better list below)
> 3. System changes (files in arch/ppc/syslib and include/asm-ppc)

Part Two of Four, the Board Changes.

 ppc/platforms/4xx/ash.h                 |   21 -
 ppc/platforms/4xx/bubinga.c             |    4 
 ppc/platforms/4xx/bubinga.h             |   23 -
 ppc/platforms/4xx/cpci405.h             |    2 
 ppc/platforms/4xx/ebony.c               |    9 
 ppc/platforms/4xx/ep405.c               |   12 
 ppc/platforms/4xx/ep405.h               |   13 
 ppc/platforms/4xx/luan.c                |    7 
 ppc/platforms/4xx/oak.c                 |   15 
 ppc/platforms/4xx/oak.h                 |   19 -
 ppc/platforms/4xx/oak_setup.h           |    2 
 ppc/platforms/4xx/ocotea.c              |   13 
 ppc/platforms/4xx/redwood5.h            |   13 
 ppc/platforms/4xx/redwood6.c            |   27 -
 ppc/platforms/4xx/redwood6.h            |   13 
 ppc/platforms/4xx/sycamore.h            |   22 -
 ppc/platforms/4xx/walnut.h              |   22 -
 ppc/platforms/4xx/xilinx_ml300.h        |   12 
 ppc/platforms/83xx/mpc834x_sys.c        |   49 +-
 ppc/platforms/83xx/mpc834x_sys.h        |    1 
 ppc/platforms/85xx/mpc8540_ads.c        |   57 ++-
 ppc/platforms/85xx/mpc8560_ads.c        |   21 -
 ppc/platforms/85xx/mpc85xx_ads_common.c |   10 
 ppc/platforms/85xx/mpc85xx_ads_common.h |    1 
 ppc/platforms/85xx/mpc85xx_cds_common.c |   48 +-
 ppc/platforms/85xx/mpc85xx_cds_common.h |    1 
 ppc/platforms/85xx/sbc8560.c            |   19 -
 ppc/platforms/85xx/sbc85xx.c            |   14 
 ppc/platforms/85xx/sbc85xx.h            |    1 
 ppc/platforms/85xx/stx_gp3.c            |   34 -
 ppc/platforms/85xx/stx_gp3.h            |    1 
 ppc/platforms/bseip.h                   |   13 
 ppc/platforms/ccm.h                     |    2 
 ppc/platforms/cpci690.h                 |   10 
 ppc/platforms/est8260.h                 |   18 
 ppc/platforms/fads.h                    |    2 
 ppc/platforms/hdpu.c                    |   13 
 ppc/platforms/hermes.h                  |    2 
 ppc/platforms/ip860.h                   |    2 
 ppc/platforms/ivms8.h                   |    2 
 ppc/platforms/katana.c                  |    6 
 ppc/platforms/lantec.h                  |    2 
 ppc/platforms/lite5200.c                |    9 
 ppc/platforms/lwmon.h                   |    2 
 ppc/platforms/mbx.h                     |   22 -
 ppc/platforms/pcu_e.h                   |    2 
 ppc/platforms/pq2ads.c                  |    1 
 ppc/platforms/pq2ads.h                  |    2 
 ppc/platforms/radstone_ppc7d.c          |   32 -
 ppc/platforms/radstone_ppc7d.h          |    2 
 ppc/platforms/rpx8260.h                 |   19 -
 ppc/platforms/rpxclassic.h              |   13 
 ppc/platforms/rpxlite.h                 |   13 
 ppc/platforms/sandpoint.c               |   11 
 ppc/platforms/sandpoint.h               |    2 
 ppc/platforms/sbc82xx.c                 |    6 
 ppc/platforms/sbc82xx.h                 |    2 
 ppc/platforms/sbs8260.h                 |   18 
 ppc/platforms/spd8xx.h                  |    2 
 ppc/platforms/tqm8260.h                 |    2 
 ppc/platforms/tqm8260_setup.c           |    1 
 ppc/platforms/tqm8xx.h                  |    2 

Index: arch/ppc/platforms/4xx/ash.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/ash.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/ash.h  (mode:100644)
@@ -18,27 +18,6 @@
 #include <platforms/4xx/ibmnp405h.h>
 
 #ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Ash" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[4][6];	/* Local Ethernet MAC address */
-	unsigned char	 bi_pci_enetaddr[6];
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI speed in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
 
 /* Memory map for the IBM "Ash" NP405H evaluation board.
  */
Index: arch/ppc/platforms/4xx/bubinga.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/bubinga.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/bubinga.c  (mode:100644)
@@ -34,6 +34,7 @@
 #include <asm/kgdb.h>
 #include <asm/ocp.h>
 #include <asm/ibm_ocp_pci.h>
+#include <asm/firmware.h>
 
 #include <platforms/4xx/ibm405ep.h>
 
@@ -45,7 +46,6 @@
 #define DBG(x...)
 #endif
 
-extern bd_t __res;
 
 void *bubinga_rtc_base;
 
@@ -89,7 +89,7 @@
           * by 16.
           */
 	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
-	uart_clock = __res.bi_pllouta_freq / uart_div;
+	uart_clock = fw_get_pllouta_freq() / uart_div;
 
 	/* Setup serial port access */
 	memset(&port, 0, sizeof(port));
Index: arch/ppc/platforms/4xx/bubinga.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/bubinga.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/bubinga.h  (mode:100644)
@@ -18,29 +18,6 @@
 #include <platforms/4xx/ibm405ep.h>
 
 #ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-        unsigned char    bi_s_version[4];       /* Version of this structure */
-        unsigned char    bi_r_version[30];      /* Version of the IBM ROM */
-        unsigned int     bi_memsize;            /* DRAM installed, in bytes */
-        unsigned char    bi_enetaddr[2][6];     /* Local Ethernet MAC address */        unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address */
-        unsigned int     bi_intfreq;            /* Processor speed, in Hz */
-        unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
-        unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
-        unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
-        unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 
 /* Memory map for the Bubinga board.
  * Generic 4xx plus RTC.
Index: arch/ppc/platforms/4xx/cpci405.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/cpci405.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/cpci405.h  (mode:100644)
@@ -13,8 +13,6 @@
 /* We have a 405GP core */
 #include <platforms/4xx/ibm405gp.h>
 
-#include <asm/ppcboot.h>
-
 #ifndef __ASSEMBLY__
 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
Index: arch/ppc/platforms/4xx/ebony.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/ebony.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/ebony.c  (mode:100644)
@@ -49,7 +49,7 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
-#include <asm/ppcboot.h>
+#include <asm/firmware.h>
 
 #include <syslib/gen550.h>
 #include <syslib/ibm440gp_common.h>
@@ -61,7 +61,6 @@
  */
 #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
 
-bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -276,13 +275,13 @@
 	emacdata = def->additions;
 	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
 	emacdata->phy_mode = PHY_MODE_RMII;
-	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	memcpy(emacdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
 	emacdata = def->additions;
 	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
 	emacdata->phy_mode = PHY_MODE_RMII;
-	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+	memcpy(emacdata->mac_addr, fw_get_enetaddr(1), 6);
 
 	/*
 	 * Determine various clocks.
@@ -333,7 +332,7 @@
 	 * residual data area.
 	 */
 	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
+		fw_initialize(r3);
 
 	ibm44x_platform_init();
 
Index: arch/ppc/platforms/4xx/ep405.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/ep405.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/ep405.c  (mode:100644)
@@ -20,6 +20,7 @@
 #include <asm/todc.h>
 #include <asm/ocp.h>
 #include <asm/ibm_ocp_pci.h>
+#include <asm/firmware.h>
 
 #undef DEBUG
 #ifdef DEBUG
@@ -62,7 +63,7 @@
 
 	ibm_ocp_set_emac(0, 0);
 
-	if (__res.bi_nvramsize == 512*1024) {
+	if (fw_get_nvram_size() == 512*1024) {
 		/* FIXME: we should properly handle NVRTCs of different sizes */
 		TODC_INIT(TODC_TYPE_DS1557, ep405_nvram, ep405_nvram, ep405_nvram, 8);
 	}
@@ -138,14 +139,15 @@
 void __init
 ep405_map_io(void)
 {
-	bd_t *bip = &__res;
+	unsigned long nvram_size;
 
 	ppc4xx_map_io();
 
 	ep405_bcsr = ioremap(EP405_BCSR_PADDR, EP405_BCSR_SIZE);
 
-	if (bip->bi_nvramsize > 0) {
-		ep405_nvram = ioremap(EP405_NVRAM_PADDR, bip->bi_nvramsize);
+	nvram_size = fw_get_nvram_size();
+	if (nvram_size > 0) {
+		ep405_nvram = ioremap(EP405_NVRAM_PADDR, nvram_size);
 	}
 }
 
@@ -187,7 +189,7 @@
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 
-	if (__res.bi_nvramsize == 512*1024) {
+	if (fw_get_nvram_size() == 512*1024) {
 		ppc_md.time_init = todc_time_init;
 		ppc_md.set_rtc_time = todc_set_rtc_time;
 		ppc_md.get_rtc_time = todc_get_rtc_time;
Index: arch/ppc/platforms/4xx/ep405.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/ep405.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/ep405.h  (mode:100644)
@@ -23,19 +23,6 @@
 
 #include <linux/types.h>
 
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-	unsigned int	 bi_nvramsize;		/* Size of the NVRAM/RTC */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 extern u8 *ep405_bcsr;
 extern u8 *ep405_nvram;
 
Index: arch/ppc/platforms/4xx/luan.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/luan.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/luan.c  (mode:100644)
@@ -47,7 +47,7 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
-#include <asm/ppcboot.h>
+#include <asm/firmware.h>
 
 #include <syslib/ibm44x_common.h>
 #include <syslib/ibm440gx_common.h>
@@ -60,7 +60,6 @@
  */
 #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
 
-bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -137,7 +136,7 @@
 	emacdata = def->additions;
 	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
 	emacdata->phy_mode = PHY_MODE_GMII;
-	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	memcpy(emacdata->mac_addr, fw_get_enetaddr(0), 6);
 }
 
 #define PCIX_READW(offset) \
@@ -370,7 +369,7 @@
 	 * residual data area.
 	 */
 	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
+		fw_initialize(f3);
 
 	ibm44x_platform_init();
 
Index: arch/ppc/platforms/4xx/oak.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/oak.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/oak.c  (mode:100644)
@@ -28,6 +28,7 @@
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
 #include <asm/time.h>
+#include <asm/firmware.h>
 
 #include "oak.h"
 
@@ -35,9 +36,6 @@
 
 extern void abort(void);
 
-/* Global Variables */
-
-unsigned char __res[sizeof(bd_t)];
 
 
 /*
@@ -75,7 +73,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *)__res, (void *)(r3 + KERNELBASE), sizeof(bd_t));
+		fw_initialize(r3);
 	}
 
 #if defined(CONFIG_BLK_DEV_INITRD)
@@ -145,12 +143,10 @@
 int
 oak_show_percpuinfo(struct seq_file *m, int i)
 {
-	bd_t *bp = (bd_t *)__res;
-
 	seq_printf(m, "clock\t\t: %dMHz\n"
 		   "bus clock\t\t: %dMHz\n",
-		   bp->bi_intfreq / 1000000,
-		   bp->bi_busfreq / 1000000);
+		   fw_get_intfreq() / 1000000,
+		   fw_get_busfreq() / 1000000);
 
 	return 0;
 }
@@ -237,9 +233,8 @@
 oak_calibrate_decr(void)
 {
 	unsigned int freq;
-	bd_t *bip = (bd_t *)__res;
 
-	freq = bip->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	decrementer_count = freq / HZ;
 	count_period_num = 1;
Index: arch/ppc/platforms/4xx/oak.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/oak.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/oak.h  (mode:100644)
@@ -44,21 +44,6 @@
 #define	OAKSERIAL_INT		28	/* AIC_INT28 */
 
 #ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Oak" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* Bus speed, in Hz */
-} bd_t;
 
 #ifdef __cplusplus
 extern "C" {
@@ -85,10 +70,6 @@
 }
 #endif
 
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 #define PPC4xx_MACHINE_NAME	"IBM Oak"
 
 #endif /* !__ASSEMBLY__ */
Index: arch/ppc/platforms/4xx/oak_setup.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/oak_setup.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/oak_setup.h  (mode:100644)
@@ -23,8 +23,6 @@
 extern "C" {
 #endif
 
-extern unsigned char	 __res[sizeof(bd_t)];
-
 extern void		 oak_init(unsigned long r3,
 				  unsigned long ird_start,
 				  unsigned long ird_end,
Index: arch/ppc/platforms/4xx/ocotea.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/ocotea.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/ocotea.c  (mode:100644)
@@ -47,7 +47,7 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
-#include <asm/ppcboot.h>
+#include <asm/firmware.h>
 
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
@@ -59,7 +59,6 @@
  */
 #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
 
-bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -134,13 +133,13 @@
 			emacdata->phy_mode = PHY_MODE_RGMII;
 		}
 		if (i == 0)
-			memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+			memcpy(emacdata->mac_addr, fw_get_enetaddr(0), 6);
 		else if (i == 1)
-			memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+			memcpy(emacdata->mac_addr, fw_get_enetaddr(1), 6);
 		else if (i == 2)
-			memcpy(emacdata->mac_addr, __res.bi_enet2addr, 6);
+			memcpy(emacdata->mac_addr, fw_get_enetaddr(2), 6);
 		else if (i == 3)
-			memcpy(emacdata->mac_addr, __res.bi_enet3addr, 6);
+			memcpy(emacdata->mac_addr, fw_get_enetaddr(3), 6);
 	}
 }
 
@@ -335,7 +334,7 @@
 	 * residual data area.
 	 */
 	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
+		fw_initialize(r3);
 
 	/*
 	 * Determine various clocks.
Index: arch/ppc/platforms/4xx/redwood5.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/redwood5.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/redwood5.h  (mode:100644)
@@ -19,19 +19,6 @@
 /* Redwood5 has an STB04xxx core */
 #include <platforms/4xx/ibmstb4.h>
 
-#ifndef __ASSEMBLY__
-typedef struct board_info {
-	unsigned char	bi_s_version[4];	/* Version of this structure */
-	unsigned char	bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	bi_memsize;		/* DRAM installed, in bytes */
-	unsigned int	bi_dummy;		/* field shouldn't exist */
-	unsigned char	bi_enetaddr[6];		/* Ethernet MAC address */
-	unsigned int	bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	bi_busfreq;		/* Bus speed, in Hz */
-	unsigned int	bi_tbfreq;		/* Software timebase freq */
-} bd_t;
-#endif /* !__ASSEMBLY__ */
-
 
 #define SMC91111_BASE_ADDR	0xf2000300
 #define SMC91111_REG_SIZE	16
Index: arch/ppc/platforms/4xx/redwood6.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/redwood6.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/redwood6.c  (mode:100644)
@@ -98,27 +98,34 @@
 #endif
 
 #ifdef DEBUG_BRINGUP
-	bd_t *bip = (bd_t *) __res;
+	{
+	unsigned long memsize = fw_get_memory_size();
+	unsigned char *p_addr = fw_get_enetaddr(0);
+	unsigned long int_freq = fw_get_intfreq();
+	unsigned long bus_freq = fw_get_busfreq();
+	unsigned long tb_freq = fw_get_tbfreq();
+
 	printk("\n");
 	printk("machine\t: %s\n", PPC4xx_MACHINE_NAME);
 	printk("\n");
-	printk("bi_s_version\t %s\n", bip->bi_s_version);
-	printk("bi_r_version\t %s\n", bip->bi_r_version);
-	printk("bi_memsize\t 0x%8.8x\t %dMBytes\n", bip->bi_memsize,
-	       bip->bi_memsize / (1024 * 1000));
+	printk("bi_s_version\t %s\n", fw_get_s_version());
+	printk("bi_r_version\t %s\n", fw_get_r_version());
+	printk("bi_memsize\t 0x%8.8x\t %dMBytes\n",
+	       memsize, memsize / (1024 * 1000));
 	printk("bi_enetaddr %d\t %2.2x%2.2x%2.2x-%2.2x%2.2x%2.2x\n", 0,
-	       bip->bi_enetaddr[0], bip->bi_enetaddr[1], bip->bi_enetaddr[2],
-	       bip->bi_enetaddr[3], bip->bi_enetaddr[4], bip->bi_enetaddr[5]);
+	       p_addr[0], p_addr[1], p_addr[2],
+	       p_addr[3], p_addr[4], p_addr[5]);
 
 	printk("bi_intfreq\t 0x%8.8x\t clock:\t %dMhz\n",
-	       bip->bi_intfreq, bip->bi_intfreq / 1000000);
+	       int_freq, int_freq / 1000000);
 
 	printk("bi_busfreq\t 0x%8.8x\t plb bus clock:\t %dMHz\n",
-	       bip->bi_busfreq, bip->bi_busfreq / 1000000);
+	       bus_freq, bus_freq / 1000000);
 	printk("bi_tbfreq\t 0x%8.8x\t TB freq:\t %dMHz\n",
-	       bip->bi_tbfreq, bip->bi_tbfreq / 1000000);
+	       tb_freq, tb_freq / 1000000);
 
 	printk("\n");
+	}
 #endif
 
 	/* Identify the system */
Index: arch/ppc/platforms/4xx/redwood6.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/redwood6.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/redwood6.h  (mode:100644)
@@ -19,19 +19,6 @@
 /* Redwood6 has an STBx25xx core */
 #include <platforms/4xx/ibmstbx25.h>
 
-#ifndef __ASSEMBLY__
-typedef struct board_info {
-	unsigned char bi_s_version[4];	/* Version of this structure */
-	unsigned char bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int bi_memsize;	/* DRAM installed, in bytes */
-	unsigned int bi_dummy;	/* field shouldn't exist */
-	unsigned char bi_enetaddr[6];	/* Ethernet MAC address */
-	unsigned int bi_intfreq;	/* Processor speed, in Hz */
-	unsigned int bi_busfreq;	/* Bus speed, in Hz */
-	unsigned int bi_tbfreq;	/* Software timebase freq */
-} bd_t;
-#endif				/* !__ASSEMBLY__ */
-
 #define SMC91111_BASE_ADDR	0xf2030300
 #define SMC91111_REG_SIZE	16
 #define SMC91111_IRQ		27
Index: arch/ppc/platforms/4xx/sycamore.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/sycamore.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/sycamore.h  (mode:100644)
@@ -19,28 +19,6 @@
 #include <platforms/4xx/ibm405gpr.h>
 
 #ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Sycamore" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 
 /* Memory map for the IBM "Sycamore" 405GP evaluation board.
  * Generic 4xx plus RTC.
Index: arch/ppc/platforms/4xx/walnut.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/walnut.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/walnut.h  (mode:100644)
@@ -24,28 +24,6 @@
 #include <platforms/4xx/ibm405gp.h>
 
 #ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Walnut" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 
 /* Memory map for the IBM "Walnut" 405GP evaluation board.
  * Generic 4xx plus RTC.
Index: arch/ppc/platforms/4xx/xilinx_ml300.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/4xx/xilinx_ml300.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/4xx/xilinx_ml300.h  (mode:100644)
@@ -22,18 +22,6 @@
 
 #include <linux/types.h>
 
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
 #endif /* !__ASSEMBLY__ */
 
 /* We don't need anything mapped.  Size of zero will accomplish that. */
Index: arch/ppc/platforms/83xx/mpc834x_sys.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
@@ -60,8 +60,6 @@
 
 extern unsigned long total_memory;	/* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
-
 #ifdef CONFIG_PCI
 #error "PCI is not supported"
 /* NEED mpc83xx_map_irq & mpc83xx_exclude_device
@@ -76,12 +74,12 @@
 static void __init
 mpc834x_sys_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	unsigned int immr_base;
 	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	/* Set loops_per_jiffy to a half-way reasonable value,
 	   for use until calibrate_delay gets called. */
@@ -93,22 +91,24 @@
 #endif
 	mpc83xx_early_serial_map();
 
+	immr_base = fw_get_immr_base();
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC83xx_IRQ_EXT1;
 	pdata->phyid = 0;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC2);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC83xx_IRQ_EXT2;
 	pdata->phyid = 1;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -134,11 +134,11 @@
 mpc834x_sys_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	bd_t *binfo = (bd_t *) __res;
-	unsigned int freq;
+	unsigned int core_freq, bus_freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	core_freq = fw_get_intfreq();
+	bus_freq = fw_get_busfreq();
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -147,8 +147,8 @@
 	seq_printf(m, "Machine\t\t: mpc%s sys\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "core clock\t: %d MHz\n"
 			"bus  clock\t: %d MHz\n",
-			(int)(binfo->bi_intfreq / 1000000),
-			(int)(binfo->bi_busfreq / 1000000));
+			(int)(core_freq / 1000000),
+			(int)(bus_freq / 1000000));
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
@@ -157,7 +157,8 @@
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 
 	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", (int)(binfo->bi_memsize / (1024 * 1024)));
+	seq_printf(m, "Memory\t\t: %d MB\n",
+		   (int)(fw_get_memory_size() / (1024 * 1024)));
 
 	return 0;
 }
@@ -166,8 +167,7 @@
 void __init
 mpc834x_sys_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
-
+	unsigned long immr_base;
 	u8 senses[8] = {
 		0,			/* EXT 0 */
 		IRQ_SENSE_LEVEL,	/* EXT 1 */
@@ -179,7 +179,8 @@
 		0,			/* EXT 7 */
 	};
 
-	ipic_init(binfo->bi_immr_base + 0x00700, 0, MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
+	immr_base = fw_get_immr_base();
+	ipic_init(immr_base + 0x00700, 0, MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
@@ -201,8 +202,6 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
-	bd_t *binfo = (bd_t *) __res;
-
 	/* parse_bootinfo must always be called first */
 	parse_bootinfo(find_bootinfo());
 
@@ -211,8 +210,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-		       sizeof (bd_t));
+		fw_initialize(r3);
 	}
 
 #if defined(CONFIG_BLK_DEV_INITRD)
@@ -232,25 +230,28 @@
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
 
-	immrbar = binfo->bi_immr_base;
+	immrbar = fw_get_immr_base();
 
 	mpc834x_sys_set_bat();
 
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	{
 		struct uart_port p;
+		unsigned int busfreq;
+
+		busfreq = fw_get_busfreq();
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
 		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4500);
-		p.uartclk = binfo->bi_busfreq;
+		p.uartclk = busfreq;
 
 		gen550_init(0, &p);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
 		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4600);
-		p.uartclk = binfo->bi_busfreq;
+		p.uartclk = busfreq;
 
 		gen550_init(1, &p);
 	}
Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <syslib/ppc83xx_setup.h>
-#include <asm/ppcboot.h>
 
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
Index: arch/ppc/platforms/85xx/mpc8540_ads.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc8540_ads.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc8540_ads.c  (mode:100644)
@@ -51,6 +51,7 @@
 #include <asm/kgdb.h>
 #include <asm/ppc_sys.h>
 #include <mm/mmu_decl.h>
+#include <asm/firmware.h>
 
 #include <syslib/ppc85xx_setup.h>
 
@@ -62,12 +63,12 @@
 static void __init
 mpc8540ads_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	unsigned int immr_base;
 	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8540ads_setup_arch()", 0);
@@ -85,36 +86,54 @@
 	mpc85xx_early_serial_map();
 #endif
 
+	if (ppc_md.progress)
+		ppc_md.progress("after mpc85xx_early_serial_map()", 0);
+
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
+	immr_base = fw_get_immr_base();
+
+	if (ppc_md.progress)
+		ppc_md.progress("after getting immr base", 0);
+
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 0;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
+
+	if (ppc_md.progress)
+		ppc_md.progress("after enetaddr(0)", 0);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 1;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
+
+	if (ppc_md.progress)
+		ppc_md.progress("after enetaddr(1)", 0);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 	pdata->board_flags = 0;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 3;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(2), 6);
+
+	if (ppc_md.progress)
+		ppc_md.progress("after enetaddr(2)", 0);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -126,6 +145,9 @@
 #else
 		ROOT_DEV = Root_HDA1;
 #endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("leaving mpc8540ads_setup_arch()", 0);
 }
 
 /* ************************************************************************ */
@@ -141,29 +163,30 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-		       sizeof (bd_t));
+		fw_initialize(r3);
 	}
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		unsigned int immr_base;
 		struct uart_port p;
 
+		immr_base = fw_get_immr_base();
+
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
-		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
-			  binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+		settlbcam(NUM_TLBCAMS - 1, immr_base,
+			  immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
-		p.uartclk = binfo->bi_busfreq;
+		p.membase = (void *) immr_base + MPC85xx_UART0_OFFSET;
+		p.uartclk = fw_get_busfreq();
 
 		gen550_init(0, &p);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
-		p.uartclk = binfo->bi_busfreq;
+		p.membase = (void *) immr_base + MPC85xx_UART1_OFFSET;
+		p.uartclk = fw_get_busfreq();
 
 		gen550_init(1, &p);
 	}
Index: arch/ppc/platforms/85xx/mpc8560_ads.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc8560_ads.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc8560_ads.c  (mode:100644)
@@ -51,6 +51,8 @@
 #include <asm/kgdb.h>
 #include <asm/ppc_sys.h>
 #include <asm/cpm2.h>
+#include <asm/firmware.h>
+
 #include <mm/mmu_decl.h>
 
 #include <syslib/cpm2_pic.h>
@@ -68,14 +70,13 @@
 static void __init
 mpc8560ads_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
-	unsigned int freq;
+	unsigned int freq, immr_base;
 	struct gianfar_platform_data *pdata;
 
 	cpm2_reset();
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8560ads_setup_arch()", 0);
@@ -89,22 +90,24 @@
 	mpc85xx_setup_hose();
 #endif
 
+	immr_base = fw_get_immr_base();
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 0;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 1;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -161,9 +164,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-		       sizeof (bd_t));
-
+		fw_initialize(r3);
 	}
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/*
Index: arch/ppc/platforms/85xx/mpc85xx_ads_common.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc85xx_ads_common.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc85xx_ads_common.c  (mode:100644)
@@ -44,6 +44,7 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/ppc_sys.h>
+#include <asm/firmware.h>
 
 #include <mm/mmu_decl.h>
 
@@ -56,7 +57,6 @@
 
 extern unsigned long total_memory;	/* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 
@@ -120,11 +120,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -148,10 +147,9 @@
 void __init
 mpc85xx_ads_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	/* Determine the Physical Address of the OpenPIC regs */
-	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	unsigned int immr_base = fw_get_immr_base();
+	phys_addr_t OpenPIC_PAddr = immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = mpc85xx_ads_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (mpc85xx_ads_openpic_initsenses);
Index: arch/ppc/platforms/85xx/mpc85xx_ads_common.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc85xx_ads_common.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc85xx_ads_common.h  (mode:100644)
@@ -20,7 +20,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
 #define BCSR_ADDR		((uint)0xf8000000)
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -66,7 +66,6 @@
 
 extern unsigned long total_memory;      /* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
 
 static int cds_pci_slot = 2;
 static volatile u8 * cadmus;
@@ -137,11 +136,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -180,10 +178,13 @@
 void __init
 mpc85xx_cds_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
+	phys_addr_t OpenPIC_PAddr;
+	unsigned int immr_base;
+
+	immr_base = fw_get_immr_base();
 
 	/* Determine the Physical Address of the OpenPIC regs */
-	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	OpenPIC_PAddr = immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = mpc85xx_cds_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (mpc85xx_cds_openpic_initsenses);
@@ -299,12 +300,12 @@
 static void __init
 mpc85xx_cds_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
+	unsigned int immr_base;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	printk("mpc85xx_cds_setup_arch\n");
 
@@ -342,22 +343,24 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
+	immr_base = fw_get_immr_base();
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 0;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 1;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
 
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -385,30 +388,33 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-				sizeof (bd_t));
-
+		fw_initialize(r3);
 	}
+
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		unsigned int immr_base;
+		unsigned int busfreq;
 		struct uart_port p;
 
+		immr_base = fw_get_immr_base();
+		busfreq = fw_get_busfreq();
+
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
-		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
-				binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+		settlbcam(NUM_TLBCAMS - 1, immr_base,
+				immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
-		p.uartclk = binfo->bi_busfreq;
+		p.membase = (void *) immr_base + MPC85xx_UART0_OFFSET;
+		p.uartclk = busfreq;
 
 		gen550_init(0, &p);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
-		p.uartclk = binfo->bi_busfreq;
+		p.membase = (void *) immr_base + MPC85xx_UART1_OFFSET;
+		p.uartclk = busfreq;
 
 		gen550_init(1, &p);
 	}
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/mpc85xx_cds_common.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/mpc85xx_cds_common.h  (mode:100644)
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/serial.h>
-#include <asm/ppcboot.h>
 #include <linux/initrd.h>
 #include <syslib/ppc85xx_setup.h>
 
Index: arch/ppc/platforms/85xx/sbc8560.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/sbc8560.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/sbc8560.c  (mode:100644)
@@ -50,6 +50,8 @@
 #include <asm/immap_85xx.h>
 #include <asm/kgdb.h>
 #include <asm/ppc_sys.h>
+#include <asm/firmware.h>
+
 #include <mm/mmu_decl.h>
 
 #include <syslib/ppc85xx_common.h>
@@ -101,12 +103,12 @@
 static void __init
 sbc8560_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	unsigned int immr_base;
 	struct gianfar_platform_data *pdata;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8560_setup_arch()", 0);
@@ -128,22 +130,24 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
+	immr_base = fw_get_immr_base();
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT6;
 	pdata->phyid = 25;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
 	pdata->interruptPHY = MPC85xx_IRQ_EXT7;
 	pdata->phyid = 26;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -170,8 +174,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-		       sizeof (bd_t));
+		fw_initialize(r3);
 	}
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
Index: arch/ppc/platforms/85xx/sbc85xx.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/sbc85xx.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/sbc85xx.c  (mode:100644)
@@ -48,8 +48,6 @@
 
 #include <platforms/85xx/sbc85xx.h>
 
-unsigned char __res[sizeof (bd_t)];
-
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
@@ -120,11 +118,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -148,10 +145,13 @@
 void __init
 sbc8560_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
+	phys_addr_t OpenPIC_PAddr;
+	unsigned long immr_base;
+
+	immr_base = fw_get_immr_base();
+
 	/* Determine the Physical Address of the OpenPIC regs */
-	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	OpenPIC_PAddr = immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = sbc8560_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (sbc8560_openpic_initsenses);
Index: arch/ppc/platforms/85xx/sbc85xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/sbc85xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/sbc85xx.h  (mode:100644)
@@ -19,7 +19,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xff700000)
 #define CCSRBAR_SIZE		((uint)1024*1024)
Index: arch/ppc/platforms/85xx/stx_gp3.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/stx_gp3.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/stx_gp3.c  (mode:100644)
@@ -56,14 +56,13 @@
 #include <asm/immap_cpm2.h>
 #include <asm/mpc85xx.h>
 #include <asm/ppc_sys.h>
+#include <asm/firmware.h>
 
 #include <syslib/cpm2_pic.h>
 #include <syslib/ppc85xx_common.h>
 
 extern void cpm2_reset(void);
 
-unsigned char __res[sizeof(bd_t)];
-
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
@@ -131,14 +130,14 @@
 static void __init
 gp3_setup_arch(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	unsigned long immr_base;
 	struct gianfar_platform_data *pdata;
 
 	cpm2_reset();
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	if (ppc_md.progress)
 		ppc_md.progress("gp3_setup_arch()", 0);
@@ -152,21 +151,23 @@
 	mpc85xx_setup_hose();
 #endif
 
+	immr_base = fw_get_immr_base();
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 /*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 2;
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(0), 6);
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 /*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
 	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 	pdata->phyid = 4;
 	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	pdata->phy_reg_addr += immr_base;
+	memcpy(pdata->mac_addr, fw_get_enetaddr(1), 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -179,7 +180,7 @@
 		ROOT_DEV = Root_HDA1;
 #endif
 
-	printk ("bi_immr_base = %8.8lx\n", binfo->bi_immr_base);
+	printk ("bi_immr_base = %8.8lx\n", immr_base);
 }
 
 static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
@@ -200,16 +201,18 @@
 static void __init
 gp3_init_IRQ(void)
 {
+	unsigned long immr_base;
+	phys_addr_t OpenPIC_PAddr;
 	int i;
-	bd_t *binfo = (bd_t *) __res;
+
+	immr_base = fw_get_immr_base();
 
 	/*
 	 * Setup OpenPIC
 	 */
 
 	/* Determine the Physical Address of the OpenPIC regs */
-	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	OpenPIC_PAddr = immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = gp3_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (gp3_openpic_initsenses);
@@ -238,13 +241,12 @@
 gp3_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	bd_t *binfo = (bd_t *) __res;
 	uint	memsize;
 	unsigned int freq;
 	extern unsigned long total_memory;	/* in mm/init */
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = fw_get_intfreq();
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -309,9 +311,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-		       sizeof (bd_t));
-
+		fw_initialize(r3);
 	}
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/*
Index: arch/ppc/platforms/85xx/stx_gp3.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/85xx/stx_gp3.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/85xx/stx_gp3.h  (mode:100644)
@@ -22,7 +22,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
 #define CCSRBAR_SIZE		((uint)1024*1024)
Index: arch/ppc/platforms/bseip.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/bseip.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/bseip.h  (mode:100644)
@@ -8,19 +8,6 @@
 #define __MACH_BSEIP_DEFS
 
 #ifndef __ASSEMBLY__
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
-
-extern bd_t m8xx_board_info;
 
 /* Memory map is configured by the PROM startup.
  * All we need to get started is the IMMR.
Index: arch/ppc/platforms/ccm.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/ccm.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/ccm.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	CCM_IMMR_BASE    0xF0000000	/* phys. addr of IMMR			*/
 #define	CCM_IMAP_SIZE   (64 * 1024)	/* size of mapped area			*/
 
Index: arch/ppc/platforms/cpci690.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/cpci690.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/cpci690.h  (mode:100644)
@@ -19,16 +19,6 @@
 #ifndef __PPC_PLATFORMS_CPCI690_H
 #define __PPC_PLATFORMS_CPCI690_H
 
-/*
- * Define bd_t to pass in the MAC addresses used by the GT64260's enet ctlrs.
- */
-#define	CPCI690_BI_MAGIC		0xFE8765DC
-
-typedef struct board_info {
-	u32	bi_magic;
-	u8	bi_enetaddr[3][6];
-} bd_t;
-
 /* PCI bus Resource setup */
 #define CPCI690_PCI0_MEM_START_PROC_ADDR	0x80000000
 #define CPCI690_PCI0_MEM_START_PCI_HI_ADDR	0x00000000
Index: arch/ppc/platforms/est8260.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/est8260.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/est8260.h  (mode:100644)
@@ -14,22 +14,4 @@
 #define CPUINFO_VENDOR		"EST Corporation"
 #define CPUINFO_MACHINE		"SBC8260 PowerPC"
 
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
-	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */
-	unsigned int	bi_brgfreq;	/* BRG Freq, in MHz */
-	unsigned int	bi_vco;		/* VCO Out from PLL */
-	unsigned int	bi_baudrate;	/* Default console baud rate */
-	unsigned int	bi_immr;	/* IMMR when called from boot rom */
-	unsigned char	bi_enetaddr[6];
-} bd_t;
-
-extern bd_t m8xx_board_info;
-
 #endif 	/* __EST8260_PLATFORM */
Index: arch/ppc/platforms/fads.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/fads.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/fads.h  (mode:100644)
@@ -10,8 +10,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 /* Memory map is configured by the PROM startup.
  * I tried to follow the FADS manual, although the startup PROM
  * dictates this and we simply have to move some of the physical
Index: arch/ppc/platforms/hdpu.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/hdpu.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/hdpu.c  (mode:100644)
@@ -31,7 +31,8 @@
 #include <asm/machdep.h>
 #include <asm/todc.h>
 #include <asm/mv64x60.h>
-#include <asm/ppcboot.h>
+#include <asm/firmware.h>
+
 #include <platforms/hdpu.h>
 #include <linux/mv643xx.h>
 #include <linux/hdpu_features.h>
@@ -41,7 +42,6 @@
 #define BOARD_VENDOR	"Sky Computers"
 #define BOARD_MACHINE	"HDPU-CB-A"
 
-bd_t ppcboot_bd;
 int ppcboot_bd_valid = 0;
 
 static mv64x60_handle_t bh;
@@ -337,7 +337,7 @@
 
 	pdata->max_idle = 40;
 	if (ppcboot_bd_valid)
-		pdata->default_baud = ppcboot_bd.bi_baudrate;
+		pdata->default_baud = fw_get_baudrate();
 	else
 		pdata->default_baud = HDPU_DEFAULT_BAUD;
 	pdata->brg_clk_src = HDPU_MPSC_CLK_SRC;
@@ -550,7 +550,7 @@
 	ulong freq;
 
 	if (ppcboot_bd_valid)
-		freq = ppcboot_bd.bi_busfreq / 4;
+		freq = fw_get_busfreq() / 4;
 	else
 		freq = 133000000;
 
@@ -567,7 +567,6 @@
 			   unsigned long r4, unsigned long r5,
 			   unsigned long r6, unsigned long r7)
 {
-	bd_t *bd = NULL;
 	char *cmdline_start = NULL;
 	int cmdline_len = 0;
 
@@ -575,9 +574,7 @@
 		if ((r3 & 0xf0000000) == 0)
 			r3 += KERNELBASE;
 		if ((r3 & 0xf0000000) == KERNELBASE) {
-			bd = (void *)r3;
-
-			memcpy(&ppcboot_bd, bd, sizeof(ppcboot_bd));
+			fw_initialize(r3);
 			ppcboot_bd_valid = 1;
 		}
 	}
Index: arch/ppc/platforms/hermes.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/hermes.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/hermes.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	HERMES_IMMR_BASE    0xFF000000	/* phys. addr of IMMR			*/
 #define	HERMES_IMAP_SIZE   (64 * 1024)	/* size of mapped area			*/
 
Index: arch/ppc/platforms/ip860.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/ip860.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/ip860.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	IP860_IMMR_BASE	0xF1000000	/* phys. addr of IMMR			*/
 #define	IP860_IMAP_SIZE	(64 * 1024)	/* size of mapped area			*/
 
Index: arch/ppc/platforms/ivms8.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/ivms8.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/ivms8.h  (mode:100644)
@@ -15,8 +15,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define IVMS_IMMR_BASE	0xFFF00000	/* phys. addr of IMMR */
 #define IVMS_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
 
Index: arch/ppc/platforms/katana.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/katana.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/katana.c  (mode:100644)
@@ -38,8 +38,9 @@
 #include <asm/smp.h>
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
-#include <asm/ppcboot.h>
 #include <asm/mv64x60.h>
+#include <asm/firmware.h>
+
 #include <platforms/katana.h>
 
 static struct		mv64x60_handle bh;
@@ -52,7 +53,6 @@
 
 static u32		katana_bus_frequency;
 
-unsigned char	__res[sizeof(bd_t)];
 
 /* PCI Interrupt routing */
 static int __init
@@ -763,7 +763,7 @@
 	 */
 	if (r3 && r6) {
 		/* copy board info structure */
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		fw_initialize(r3);
 		/* copy command line */
 		*(char *)(r7+KERNELBASE) = 0;
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
Index: arch/ppc/platforms/lantec.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/lantec.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/lantec.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	IMAP_ADDR	0xFFF00000	/* physical base address of IMMR area	*/
 #define IMAP_SIZE	(64 * 1024)	/* mapped size of IMMR area		*/
 
Index: arch/ppc/platforms/lite5200.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/lite5200.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/lite5200.c  (mode:100644)
@@ -35,16 +35,13 @@
 #include <asm/io.h>
 #include <asm/mpc52xx.h>
 #include <asm/ppc_sys.h>
+#include <asm/firmware.h>
 
 #include <syslib/mpc52xx_pci.h>
 
 
 extern int powersave_nap;
 
-/* Board data given by U-Boot */
-bd_t __res;
-EXPORT_SYMBOL(__res);	/* For modules */
-
 
 /* ======================================================================== */
 /* Platform specific code                                                   */
@@ -168,10 +165,8 @@
 	if (bootinfo)
 		parse_bootinfo(bootinfo);
 	else {
-		/* Load the bd_t board info structure */
 		if (r3)
-			memcpy((void*)&__res,(void*)(r3+KERNELBASE),
-					sizeof(bd_t));
+			fw_initialize(r3);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		/* Load the initrd */
Index: arch/ppc/platforms/lwmon.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/lwmon.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/lwmon.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	IMAP_ADDR	0xFFF00000	/* physical base address of IMMR area	*/
 #define IMAP_SIZE	(64 * 1024)	/* mapped size of IMMR area		*/
 
Index: arch/ppc/platforms/mbx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/mbx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/mbx.h  (mode:100644)
@@ -12,28 +12,6 @@
 #define __MACH_MBX_DEFS
 
 #ifndef __ASSEMBLY__
-/* A Board Information structure that is given to a program when
- * EPPC-Bug starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_tag;		/* Should be 0x42444944 "BDID" */
-	unsigned int	bi_size;	/* Size of this structure */
-	unsigned int	bi_revision;	/* revision of this structure */
-	unsigned int	bi_bdate;	/* EPPCbug date, i.e. 0x11061997 */
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned int	bi_clun;	/* Boot device controller */
-	unsigned int	bi_dlun;	/* Boot device logical dev */
-
-	/* These fields are not part of the board information structure
-	 * provided by the boot rom.  They are filled in by embed_config.c
-	 * so we have the information consistent with other platforms.
-	 */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
 
 /* Memory map for the MBX as configured by EPPC-Bug.  We could reprogram
  * The SIU and PCI bridge, and try to use larger MMU pages, but the
Index: arch/ppc/platforms/pcu_e.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/pcu_e.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/pcu_e.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define	PCU_E_IMMR_BASE    0xFE000000	/* phys. addr of IMMR			*/
 #define	PCU_E_IMAP_SIZE   (64 * 1024)	/* size of mapped area			*/
 
Index: arch/ppc/platforms/pq2ads.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/pq2ads.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/pq2ads.c  (mode:100644)
@@ -14,6 +14,7 @@
  * option) any later version.
  */
 
+#include <linux/types.h>
 #include <linux/init.h>
 
 #include <asm/mpc8260.h>
Index: arch/ppc/platforms/pq2ads.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/pq2ads.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/pq2ads.h  (mode:100644)
@@ -11,8 +11,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
  * registers that can be accessed as 8-, 16-, or 32-bit values.
Index: arch/ppc/platforms/radstone_ppc7d.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/radstone_ppc7d.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/radstone_ppc7d.c  (mode:100644)
@@ -60,6 +60,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/mv64x60.h>
 #include <asm/i8259.h>
+#include <asm/firmware.h>
 
 #include "radstone_ppc7d.h"
 
@@ -81,8 +82,6 @@
 #define DS1337_GET_DATE         0
 #define DS1337_SET_DATE         1
 
-/* residual data */
-unsigned char __res[sizeof(bd_t)];
 
 /*****************************************************************************
  * Serial port code
@@ -128,10 +127,10 @@
 
 static unsigned long __init ppc7d_find_end_of_memory(void)
 {
-	bd_t *bp = (bd_t *) __res;
+	unsigned long memsize = fw_get_memory_size();
 
-	if (bp->bi_memsize)
-		return bp->bi_memsize;
+	if (memsize)
+		return memsize;
 
 	return (256 * 1024 * 1024);
 }
@@ -1386,25 +1385,30 @@
 	 * which uses birecs.
 	 */
 	if (r3 && r6) {
-		bd_t *bp = (bd_t *) __res;
+		char *p_addr;
 
 		/* copy board info structure */
-		memcpy((void *)__res, (void *)(r3 + KERNELBASE), sizeof(bd_t));
+		fw_initialize(r3);
+
 		/* copy command line */
 		*(char *)(r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *)(r6 + KERNELBASE));
 
 		printk(KERN_INFO "Board info data:-\n");
 		printk(KERN_INFO "  Internal freq: %lu MHz, bus freq: %lu MHz\n",
-		       bp->bi_intfreq, bp->bi_busfreq);
-		printk(KERN_INFO "  Memory: %lx, size %lx\n", bp->bi_memstart,
-		       bp->bi_memsize);
-		printk(KERN_INFO "  Console baudrate: %lu\n", bp->bi_baudrate);
+		       fw_get_intfreq(),
+		       fw_get_busfreq());
+		printk(KERN_INFO "  Memory: %lx, size %lx\n",
+		       fw_get_memory_start(),
+		       fw_get_memory_size());
+		printk(KERN_INFO "  Console baudrate: %lu\n",
+		       fw_get_baudrate());
+		p_addr = fw_get_enetaddr(0);
 		printk(KERN_INFO "  Ethernet address: "
 		       "%02x:%02x:%02x:%02x:%02x:%02x\n",
-		       bp->bi_enetaddr[0], bp->bi_enetaddr[1],
-		       bp->bi_enetaddr[2], bp->bi_enetaddr[3],
-		       bp->bi_enetaddr[4], bp->bi_enetaddr[5]);
+		       p_addr[0], p_addr[1],
+		       p_addr[2], p_addr[3],
+		       p_addr[4], p_addr[5]);
 	}
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
Index: arch/ppc/platforms/radstone_ppc7d.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/radstone_ppc7d.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/radstone_ppc7d.h  (mode:100644)
@@ -35,8 +35,6 @@
 #ifndef __PPC_PLATFORMS_PPC7D_H
 #define __PPC_PLATFORMS_PPC7D_H
 
-#include <asm/ppcboot.h>
-
 /*****************************************************************************
  * CPU Physical Memory Map setup.
  *****************************************************************************/
Index: arch/ppc/platforms/rpx8260.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/rpx8260.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/rpx8260.h  (mode:100644)
@@ -9,25 +9,6 @@
 #ifndef __ASM_PLATFORMS_RPX8260_H__
 #define __ASM_PLATFORMS_RPX8260_H__
 
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_nvsize;	/* NVRAM size in bytes (can be 0) */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
-	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */
-	unsigned int	bi_brgfreq;	/* BRG Freq, in MHz */
-	unsigned int	bi_vco;		/* VCO Out from PLL */
-	unsigned int	bi_baudrate;	/* Default console baud rate */
-	unsigned int	bi_immr;	/* IMMR when called from boot rom */
-	unsigned char	bi_enetaddr[6];
-} bd_t;
-
-extern bd_t m8xx_board_info;
-
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
  * registers that can be accessed as 8-, 16-, or 32-bit values.
Index: arch/ppc/platforms/rpxclassic.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/rpxclassic.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/rpxclassic.h  (mode:100644)
@@ -11,19 +11,6 @@
 #include <linux/config.h>
 
 #ifndef __ASSEMBLY__
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
-
-extern bd_t m8xx_board_info;
 
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
Index: arch/ppc/platforms/rpxlite.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/rpxlite.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/rpxlite.h  (mode:100644)
@@ -11,19 +11,6 @@
 #include <linux/config.h>
 
 #ifndef __ASSEMBLY__
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
-
-extern bd_t m8xx_board_info;
 
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
Index: arch/ppc/platforms/sandpoint.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/sandpoint.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/sandpoint.c  (mode:100644)
@@ -99,14 +99,13 @@
 #include <asm/mpc10x.h>
 #include <asm/pci-bridge.h>
 #include <asm/kgdb.h>
+#include <asm/firmware.h>
 
 #include "sandpoint.h"
 
 /* Set non-zero if an X2 Sandpoint detected. */
 static int sandpoint_is_x2;
 
-unsigned char __res[sizeof(bd_t)];
-
 static void sandpoint_halt(void);
 static void sandpoint_probe_type(void);
 
@@ -497,10 +496,10 @@
 static unsigned long __init
 sandpoint_find_end_of_memory(void)
 {
-	bd_t *bp = (bd_t *)__res;
+	unsigned long memsize = fw_get_memory_size();
 
-	if (bp->bi_memsize)
-		return bp->bi_memsize;
+	if (memsize)
+		return memsize;
 
 	/* DINK32 13.0 correctly initalizes things, so iff you use
 	 * this you _should_ be able to change this instead of a
@@ -681,7 +680,7 @@
 	 */
 	if (r3 && r6) {
 		/* copy board info structure */
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		fw_initialize(r3);
 		/* copy command line */
 		*(char *)(r7+KERNELBASE) = 0;
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
Index: arch/ppc/platforms/sandpoint.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/sandpoint.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/sandpoint.h  (mode:100644)
@@ -19,8 +19,6 @@
 #ifndef __PPC_PLATFORMS_SANDPOINT_H
 #define __PPC_PLATFORMS_SANDPOINT_H
 
-#include <asm/ppcboot.h>
-
 #if 0
 /* The Sandpoint X3 allows the IDE interrupt to be directly connected
  * from the Windbond (PCI INTC or INTD) to the serial EPIC.  Someday
Index: arch/ppc/platforms/sbc82xx.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/sbc82xx.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/sbc82xx.c  (mode:100644)
@@ -28,11 +28,10 @@
 #include <asm/todc.h>
 #include <asm/immap_cpm2.h>
 #include <asm/pci.h>
+#include <asm/firmware.h>
 
 static void (*callback_init_IRQ)(void);
 
-extern unsigned char __res[sizeof(bd_t)];
-
 extern void (*late_time_init)(void);
 
 #ifdef CONFIG_GEN_RTC
@@ -241,7 +240,8 @@
 {
 	/* u-boot may be using one of the FCC Ethernet devices.
 	   Use the MAC address to the SCC. */
-	__res[offsetof(bd_t, bi_enetaddr[5])] &= ~3;
+	unsigned char *p_addr = fw_get_enetaddr(0);
+	p_addr[5] &= ~3;
 
 	/* Anything special for this platform */
 	callback_init_IRQ	= ppc_md.init_IRQ;
Index: arch/ppc/platforms/sbc82xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/sbc82xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/sbc82xx.h  (mode:100644)
@@ -7,8 +7,6 @@
 #ifndef __PPC_SBC82xx_H__
 #define __PPC_SBC82xx_H__
 
-#include <asm/ppcboot.h>
-
 #define CPM_MAP_ADDR			0xf0000000
 
 #define SBC82xx_TODC_NVRAM_ADDR		0xd0000000
Index: arch/ppc/platforms/sbs8260.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/sbs8260.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/sbs8260.h  (mode:100644)
@@ -7,22 +7,4 @@
 
 #define CPM_MAP_ADDR	((uint)0xfe000000)
 
-
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
-	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */
-	unsigned int	bi_brgfreq;	/* BRG Freq, in MHz */
-	unsigned int	bi_vco;		/* VCO Out from PLL */
-	unsigned int	bi_baudrate;	/* Default console baud rate */
-	unsigned int	bi_immr;	/* IMMR when called from boot rom */
-	unsigned char	bi_enetaddr[6];
-} bd_t;
-
-extern bd_t m8xx_board_info;
 #endif /* !__ASSEMBLY__ */
Index: arch/ppc/platforms/spd8xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/spd8xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/spd8xx.h  (mode:100644)
@@ -10,8 +10,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #ifndef __ASSEMBLY__
 #define SPD_IMMR_BASE	0xFFF00000	/* phys. addr of IMMR */
 #define SPD_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
Index: arch/ppc/platforms/tqm8260.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/tqm8260.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/tqm8260.h  (mode:100644)
@@ -9,8 +9,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #define CPM_MAP_ADDR		((uint)0xFFF00000)
 #define PHY_INTERRUPT		25
 
Index: arch/ppc/platforms/tqm8260_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/tqm8260_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/tqm8260_setup.c  (mode:100644)
@@ -14,6 +14,7 @@
  * option) any later version.
  */
 
+#include <linux/types.h>
 #include <linux/init.h>
 
 #include <asm/immap_cpm2.h>
Index: arch/ppc/platforms/tqm8xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/platforms/tqm8xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/platforms/tqm8xx.h  (mode:100644)
@@ -10,8 +10,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ppcboot.h>
-
 #ifndef __ASSEMBLY__
 #define	TQM_IMMR_BASE	0xFFF00000	/* phys. addr of IMMR */
 #define	TQM_IMAP_SIZE	(64 * 1024)	/* size of mapped area */
