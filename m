Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-245.msk.skylink.ru
	[83.217.41.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B663DDFD5
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 12:12:38 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 4/5] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads
Date: Sat, 13 Jan 2007 03:42:20 +0300
Message-ID: <20070113004220.1224.80646.stgit@localhost.localdomain>
In-Reply-To: <20070113004150.1224.58427.stgit@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
current kernel. Current patch fixes it, as well as other inconsistencies
expressed, that do not permit targets from working properly:
 
- Updated dts with a chosen node with interrupt controller,
- fixed messed device IDs among CPM2 SoC devices,
- corrected odd header name and fixed type in defines,
- Added 82xx subdir to the powerpc/platforms Makefile, new
  solely-powerpc header file for 8260 family (was using one from arch/ppc, this
  one cleaned up from the extra stuff).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/platforms/82xx/mpc82xx.c     |    2 +-
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    2 +-
 arch/powerpc/platforms/82xx/pq2ads.h      |    5 +++--
 arch/powerpc/platforms/Makefile           |    1 +
 drivers/net/fs_enet/fs_enet.h             |    1 +
 drivers/serial/cpm_uart/cpm_uart_cpm1.h   |    3 ---
 drivers/serial/cpm_uart/cpm_uart_cpm2.h   |    3 ---
 include/asm-powerpc/fs_pd.h               |    6 ++++++
 include/asm-powerpc/io.h                  |    6 ++++++
 9 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index 0f5b30d..74e7892 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -50,7 +50,7 @@
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
@@ -51,7 +51,7 @@
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
@@ -22,6 +22,7 @@
 #ifndef __MACH_ADS8260_DEFS
 #define __MACH_ADS8260_DEFS
 
+#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 /* For our show_cpuinfo hooks. */
@@ -46,12 +47,12 @@
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
index 507d1b9..f750212 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -8,6 +8,7 @@ endif
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_PPC_82xx)		+= 82xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index 92590d8..569be22 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_enet_pd.h>
+#include <asm/fs_pd.h>
 
 #ifdef CONFIG_CPM1
 #include <asm/commproc.h>
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index 5eb49ea..a99e45e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -20,9 +20,6 @@
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
@@ -20,9 +20,6 @@
 #define SCC3_IRQ	SIU_INT_SCC3
 #define SCC4_IRQ	SIU_INT_SCC4
 
-/* the CPM address */
-#define CPM_ADDR	CPM_MAP_ADDR
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 3d0e819..2ba51b9 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -25,6 +25,12 @@ static inline int uart_clock(void)
         return ppc_proc_freq;
 }
 
+#if defined(CONFIG_8260)
+#include <asm/mpc8260.h>
+#elif defined(CONFIG_85xx)
+#include <asm/mpc85xx.h>
+#endif
+
 #define cpm2_map(member)						\
 ({									\
 	u32 offset = offsetof(cpm2_map_t, member);			\
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 1cd5323..301c9bb 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -732,6 +732,12 @@ static inline void * bus_to_virt(unsigned long address)
 
 #endif /* CONFIG_PPC32 */
 
+/* access ports */
+#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
+#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
+#define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
 
 #endif /* __KERNEL__ */
 
