Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F40CDDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 08:39:10 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/2] POWERPC: Remove global CPM2 mappings
Date: Tue, 24 Apr 2007 02:39:05 +0400
Message-ID: <20070423223905.4955.12021.stgit@localhost.localdomain>
In-Reply-To: <20070423223649.4955.77579.stgit@localhost.localdomain>
References: <20070423223649.4955.77579.stgit@localhost.localdomain>
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


Gets rid or direct IMMR accesses/dereferences for PQ2 SoC targets and
relevant drivers. 

Previous approach was to setup the specific immr offset early and make whole immr structure open via global variable/define. Now in order to access some specific immr part it has to be mapped. Along with the clarity, it deprecates many board-specific ifdefs from common drivers code as well as platform header files.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    6 +++-
 arch/powerpc/platforms/82xx/pq2ads.h      |    4 ---
 arch/powerpc/sysdev/cpm2_common.c         |   17 +-----------
 arch/powerpc/sysdev/fsl_soc.c             |   42 ++++++++++++++++++++++++-----
 arch/powerpc/sysdev/fsl_soc.h             |    1 +
 drivers/net/fs_enet/fs_enet-main.c        |    8 +++---
 drivers/net/fs_enet/mac-fcc.c             |    3 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.h   |   12 ++++----
 include/asm-powerpc/fs_pd.h               |   14 ++++------
 9 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 47cb09f..4902e70 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -46,6 +46,7 @@
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
+#include <asm/fs_pd.h>
 #include <linux/fs_enet_pd.h>
 
 #include <sysdev/fsl_soc.h>
@@ -615,13 +616,14 @@ static int __init mpc82xx_ads_probe(void)
 static void m82xx_restart(char *cmd)
 {
 	__volatile__ unsigned char dummy;
+	car_cpm2_t *clk = cpm2_map(im_clkrst);
 
 	local_irq_disable();
-	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
+	setbits32(&clk->car_rmr, RMR_CSRE);
 
 	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
 	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
-	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
+	dummy = in_8(&clk->res[0]);
 	printk("Restart failed\n");
 	while (1) ;
 }
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 5b5cca6..f0cd179 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -29,10 +29,6 @@
 #define CPUINFO_VENDOR		"Freescale Semiconductor"
 #define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
 
-/* Backword-compatibility stuff for the drivers */
-#define CPM_MAP_ADDR		((uint)0xf0000000)
-#define CPM_IRQ_OFFSET 0
-
 /* The ADS8260 has 16, 32-bit wide control/status registers, accessed
  * only on word boundaries.
  * Not all are used (yet), or are interesting to us (yet).
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index ec26599..229a4c0 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -45,31 +45,16 @@
 #include <sysdev/fsl_soc.h>
 
 static void cpm2_dpinit(void);
-cpm_cpm2_t	*cpmp;		/* Pointer to comm processor space */
-
-/* We allocate this here because it is used almost exclusively for
- * the communication processor devices.
- */
-cpm2_map_t *cpm2_immr;
 intctl_cpm2_t *cpm2_intctl;
 
-#define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
-					   of space for CPM as it is larger
-					   than on PQ2 */
-
 void
 cpm2_reset(void)
 {
-	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
 	cpm2_intctl = cpm2_map(im_intctl);
 
 	/* Reclaim the DP memory for our use.
 	 */
 	cpm2_dpinit();
-
-	/* Tell everyone where the comm processor resides.
-	 */
-	cpmp = &cpm2_immr->im_cpm;
 }
 
 /* Set a baud rate generator.  This needs lots of work.  There are
@@ -234,7 +219,7 @@ static void cpm2_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
-	im_dprambase = ioremap(CPM_MAP_ADDR, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
+	im_dprambase = ioremap(get_cpmbase(), FCC_MEM_OFFSET(4));
 
 	/* initialize the info header */
 	rh_init(&cpm_dpmem_info, 1,
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 8a123c7..3c09b28 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -35,7 +35,7 @@
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
-#include <asm/cpm2.h>
+#include <asm/fs_pd.h>
 
 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
@@ -66,6 +66,30 @@ EXPORT_SYMBOL(get_immrbase);
 
 #if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
 
+static phys_addr_t cpmbase = -1;
+
+phys_addr_t get_cpmbase(void)
+{
+	struct device_node *cpm;
+
+	if (cpmbase != -1)
+		return cpmbase;
+
+	cpm = of_find_node_by_type(NULL, "cpm");
+	if (cpm) {
+		unsigned int size;
+		const void *prop = get_property(cpm, "reg", &size);
+
+		if (prop)
+			cpmbase = of_translate_address(cpm, prop);
+		of_node_put(cpm);
+	};
+
+	return cpmbase;
+}
+
+EXPORT_SYMBOL(get_cpmbase);
+
 static u32 brgfreq = -1;
 
 u32 get_brgfreq(void)
@@ -115,6 +139,7 @@ u32 get_baudrate(void)
 }
 
 EXPORT_SYMBOL(get_baudrate);
+
 #endif /* CONFIG_CPM2 */
 
 static int __init gfar_mdio_of_init(void)
@@ -593,6 +618,7 @@ static int __init fs_enet_of_init(void)
 	struct platform_device *fs_enet_dev;
 	struct resource res;
 	int ret;
+	int configured = 0;
 
 	for (np = NULL, i = 0;
 	     (np = of_find_compatible_node(np, "network", "fs_enet")) != NULL;
@@ -693,14 +719,15 @@ static int __init fs_enet_of_init(void)
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
 			fs_enet_data.init_ioports = init_fcc_ioports;
 
-			mdio_bb_prop = of_get_property(phy, "bitbang", NULL);
-			if (mdio_bb_prop) {
+			mdio_bb_prop = get_property(phy, "bitbang", NULL);
+			if (mdio_bb_prop && !configured) {
 				struct platform_device *fs_enet_mdio_bb_dev;
 				struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
+				struct io_port *io = cpm2_map(im_ioport);
 
 				fs_enet_mdio_bb_dev =
 					platform_device_register_simple("fsl-bb-mdio",
-							i, NULL, 0);
+							res.start, NULL, 0);
 				memset(&fs_enet_mdio_bb_data, 0,
 						sizeof(struct fs_mii_bb_platform_info));
 				fs_enet_mdio_bb_data.mdio_dat.bit =
@@ -723,11 +750,11 @@ static int __init fs_enet_of_init(void)
 				fs_enet_mdio_bb_data.irq[31] = -1;
 
 				fs_enet_mdio_bb_data.mdio_dat.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+					(u32)&io->iop_pdatc;
 				fs_enet_mdio_bb_data.mdio_dir.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdirc;
+					(u32)&io->iop_pdirc;
 				fs_enet_mdio_bb_data.mdc_dat.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+					(u32)&io->iop_pdatc;
 
 				ret = platform_device_add_data(
 						fs_enet_mdio_bb_dev,
@@ -735,6 +762,7 @@ static int __init fs_enet_of_init(void)
 						sizeof(struct fs_mii_bb_platform_info));
 				if (ret)
 					goto unreg;
+				configured++;
 			}
 
 			of_node_put(phy);
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..debcfdb 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -5,6 +5,7 @@
 #include <asm/mmu.h>
 
 extern phys_addr_t get_immrbase(void);
+extern phys_addr_t get_cpmbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 4a05c14..5bd99c6 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -1136,14 +1136,14 @@ static int setup_immap(void)
 
 #ifdef CONFIG_CPM1
 	paddr = IMAP_ADDR;
-	size = 0x10000;	/* map 64K */
+	size = 0x10000; /* map 64K */
+	fs_enet_immap = ioremap(paddr, size);
 #endif
 
 #ifdef CONFIG_CPM2
-	paddr = CPM_MAP_ADDR;
-	size = 0x40000;	/* map 256 K */
+	fs_enet_immap = cpm2_map(im_cpm);
 #endif
-	fs_enet_immap = ioremap(paddr, size);
+
 	if (fs_enet_immap == NULL)
 		return -EBADF;	/* XXX ahem; maybe just BUG_ON? */
 
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index 8545e84..bd803ba 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -88,8 +88,7 @@ static inline int fcc_cr_cmd(struct fs_enet_private *fep, u32 mcn, u32 op)
 {
 	const struct fs_platform_info *fpi = fep->fpi;
 
-	cpm2_map_t *immap = fs_enet_immap;
-	cpm_cpm2_t *cpmp = &immap->im_cpm;
+	cpm_cpm2_t *cpmp = fs_enet_immap;
 	u32 v;
 	int i;
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index 1b3219f..34978fc 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -13,12 +13,12 @@
 #include <asm/cpm2.h>
 
 /* defines for IRQs */
-#define SMC1_IRQ	SIU_INT_SMC1
-#define SMC2_IRQ	SIU_INT_SMC2
-#define SCC1_IRQ	SIU_INT_SCC1
-#define SCC2_IRQ	SIU_INT_SCC2
-#define SCC3_IRQ	SIU_INT_SCC3
-#define SCC4_IRQ	SIU_INT_SCC4
+#define SMC1_IRQ	(CPM_IRQ_OFFSET + 0x04)
+#define SMC2_IRQ	(CPM_IRQ_OFFSET + 0x05)
+#define SCC1_IRQ	(CPM_IRQ_OFFSET + 0x28)
+#define SCC2_IRQ	(CPM_IRQ_OFFSET + 0x29)
+#define SCC3_IRQ	(CPM_IRQ_OFFSET + 0x2a)
+#define SCC4_IRQ	(CPM_IRQ_OFFSET + 0x2b)
 
 static inline void cpm_set_brg(int brg, int baud)
 {
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index c624915..77a44f9 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -17,16 +17,10 @@
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 
-#if defined(CONFIG_8260)
-#include <asm/mpc8260.h>
-#elif defined(CONFIG_85xx)
-#include <asm/mpc85xx.h>
-#endif
-
 #define cpm2_map(member)						\
 ({									\
 	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset,			\
+	void *addr = ioremap (get_cpmbase() + offset,			\
 			      sizeof( ((cpm2_map_t*)0)->member));	\
 	addr;								\
 })
@@ -34,7 +28,7 @@
 #define cpm2_map_size(member, size)					\
 ({									\
 	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset, size);		\
+	void *addr = ioremap (get_cpmbase() + offset,			\
 	addr;								\
 })
 
@@ -73,4 +67,8 @@ static inline int uart_clock(void)
         return ppc_proc_freq;
 }
 
+#ifndef CPM_IRQ_OFFSET
+#define CPM_IRQ_OFFSET 0       /* Backword-compatibility stuff for the drivers */
+#endif
+
 #endif
