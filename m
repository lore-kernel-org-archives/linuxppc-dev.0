Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9342F67C4C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 05:12:44 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads.
Date: Mon, 11 Dec 2006 21:12:26 +0300
Message-Id: <20061211181226.18108.86788.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Recent update of asm-powerpc/io.h caused cpm-related stuff to break in the
current kernel. Current patch fixes it, and includes other overhaul and
improvements (incomplete list is below). Required for proper functioning of
the 8xx stuff as well.

- Updated dts with a chosen node with interrupt controller, 
- fixed messed device IDs among CPM2 SoC devices, 
- corrected odd header name and fixed type in defines,
- Added 82xx subdir to the powerpc/platforms Makefile, new
  solely-powerpc header for 8260 family (was using one from arch/ppc, this
  one cleaned up from the extra stuff).
---

 arch/powerpc/boot/dts/mpc8272ads.dts      |   15 ++++++++++----
 arch/powerpc/platforms/82xx/mpc82xx.c     |    2 +-
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    2 +-
 arch/powerpc/platforms/82xx/pq2ads.h      |    5 +++--
 arch/powerpc/platforms/Makefile           |    1 +
 arch/powerpc/sysdev/cpm2_pic.c            |    1 +
 drivers/net/fs_enet/fs_enet.h             |    1 +
 drivers/serial/cpm_uart/cpm_uart_cpm1.h   |    3 ---
 drivers/serial/cpm_uart/cpm_uart_cpm2.h   |    3 ---
 include/asm-powerpc/fs_pd.h               |    7 ++++++
 include/asm-powerpc/io.h                  |    6 +++++
 include/asm-powerpc/mpc8260.h             |   32 +++++++++++++++++++++++++++++
 12 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 34efdd0..536c1a5 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -53,6 +53,13 @@
                reg = <00000000 4000000 f4500000 00000020>;
        };
 
+       chosen {
+               name = "chosen";
+               linux,platform = <0>;
+               interrupt-controller = <10c00>;
+               linux,phandle = <400>;
+       };
+
        soc8272@f0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
@@ -90,7 +97,7 @@
                        #address-cells = <1>;
                        #size-cells = <0>;
                        device_type = "network";
-                       device-id = <2>;
+                       device-id = <1>;
                        compatible = "fs_enet";
                        model = "FCC";
                        reg = <11300 20 8400 100 11380 30>;
@@ -104,7 +111,7 @@
 
                ethernet@25000 {
                        device_type = "network";
-                       device-id = <3>;
+                       device-id = <2>;
                        compatible = "fs_enet";
                        model = "FCC";
                        reg = <11320 20 8500 100 113b0 30>;
@@ -133,7 +140,7 @@
                                device_type = "serial";
                                compatible = "cpm_uart";
                                model = "SCC";
-                               device-id = <2>;
+                               device-id = <1>;
                                reg = <11a00 20 8000 100>;
                                current-speed = <1c200>;
                                interrupts = <28 2>;
@@ -147,7 +154,7 @@
                                device_type = "serial";
                                compatible = "cpm_uart";
                                model = "SCC";
-                               device-id = <5>;
+                               device-id = <4>;
                                reg = <11a60 20 8300 100>;
                                current-speed = <1c200>;
                                interrupts = <2b 2>;
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index 0f5b30d..74e7892 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -50,7 +50,7 @@ #include <linux/fs_enet_pd.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
-#include "pq2ads_pd.h"
+#include "pq2ads.h"
 
 static int __init get_freq(char *name, unsigned long *val)
 {
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index ea880f1..7334c1a 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -51,7 +51,7 @@ #include <linux/fs_enet_pd.h>
 #include <sysdev/fsl_soc.h>
 #include <../sysdev/cpm2_pic.h>
 
-#include "pq2ads_pd.h"
+#include "pq2ads.h"
 
 #ifdef CONFIG_PCI
 static uint pci_clk_frq;
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index fb2f92b..5b5cca6 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -22,6 +22,7 @@ #ifdef __KERNEL__
 #ifndef __MACH_ADS8260_DEFS
 #define __MACH_ADS8260_DEFS
 
+#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 /* For our show_cpuinfo hooks. */
@@ -46,12 +47,12 @@ #define BCSR1_FETH_RST		((uint)0x0400000
 #define BCSR1_RS232_EN1		((uint)0x02000000)      /* 0 ==enable */
 #define BCSR1_RS232_EN2		((uint)0x01000000)      /* 0 ==enable */
 #define BCSR3_FETHIEN2		((uint)0x10000000)      /* 0 == enable*/
-#define BCSR3_FETH2_RS		((uint)0x80000000)      /* 0 == reset */
+#define BCSR3_FETH2_RST		((uint)0x80000000)      /* 0 == reset */
 
 /* cpm serial driver works with constants below */
 
 #define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define SIU_INT_SMC2i		((uint)0x05+CPM_IRQ_OFFSET)
+#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
 #define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
 #define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
 #define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 961021b..f563212 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_8xx)		+= 8xx/
+obj-$(CONFIG_PPC_82xx)		+= 82xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 46fb0a2..1c50b04 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -36,6 +36,7 @@ #include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/fs_pd.h>
 
 #include "cpm2_pic.h"
 
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index 92590d8..569be22 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -9,6 +9,7 @@ #include <linux/phy.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_enet_pd.h>
+#include <asm/fs_pd.h>
 
 #ifdef CONFIG_CPM1
 #include <asm/commproc.h>
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index 5eb49ea..a99e45e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -20,9 +20,6 @@ #define SCC2_IRQ	(CPM_IRQ_OFFSET + CPMVE
 #define SCC3_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC3)
 #define SCC4_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC4)
 
-/* the CPM address */
-#define CPM_ADDR	IMAP_ADDR
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index 4b77911..1b3219f 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -20,9 +20,6 @@ #define SCC2_IRQ	SIU_INT_SCC2
 #define SCC3_IRQ	SIU_INT_SCC3
 #define SCC4_IRQ	SIU_INT_SCC4
 
-/* the CPM address */
-#define CPM_ADDR	CPM_MAP_ADDR
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 4c3af35..c624915 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -17,6 +17,12 @@ #include <asm/time.h>
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 
+#if defined(CONFIG_8260)
+#include <asm/mpc8260.h>
+#elif defined(CONFIG_85xx)
+#include <asm/mpc85xx.h>
+#endif
+
 #define cpm2_map(member)						\
 ({									\
 	u32 offset = offsetof(cpm2_map_t, member);			\
@@ -37,6 +43,7 @@ #endif
 
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
+#include <asm/mpc8xx.h>
 
 #define immr_map(member)						\
 ({									\
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 1cd5323..301c9bb 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -732,6 +732,12 @@ #define page_to_bus(page)	(page_to_phys(
 
 #endif /* CONFIG_PPC32 */
 
+/* access ports */
+#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
+#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
+#define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
 
 #endif /* __KERNEL__ */
 
diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
new file mode 100644
index 0000000..c2adcb0
--- /dev/null
+++ b/include/asm-powerpc/mpc8260.h
@@ -0,0 +1,32 @@
+/*
+ * Since there are many different boards and no standard configuration,
+ * we have a unique include file for each.  Rather than change every
+ * file that has to include MPC8260 configuration, they all include
+ * this one and the configuration switching is done here.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_PPC_MPC8260_H__
+#define __ASM_PPC_MPC8260_H__
+
+
+#ifdef CONFIG_8260
+
+#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
+#include <platforms/82xx/pq2ads.h>
+#endif
+
+#ifdef CONFIG_PCI_8260
+#include <platforms/82xx/m82xx_pci.h>
+#endif
+
+#ifndef _ISA_MEM_BASE
+#define _ISA_MEM_BASE   0
+#endif
+
+#ifndef PCI_DRAM_OFFSET
+#define PCI_DRAM_OFFSET 0
+#endif
+
+#endif /* CONFIG_8260 */
+#endif /* !__ASM_PPC_MPC8260_H__ */
+#endif /* __KERNEL__ */
