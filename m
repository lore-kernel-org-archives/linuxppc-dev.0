Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A99B4DE17A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 06:44:52 +1000 (EST)
Date: Thu, 10 Apr 2008 15:45:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] CPM: Always use new binding.
Message-ID: <20080410204502.GB20197@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The kconfig entry can go away once arch/ppc and references to the config in
drivers are removed.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/Kconfig |    3 -
 arch/powerpc/platforms/85xx/Kconfig |    8 -
 arch/powerpc/platforms/8xx/Kconfig  |    4 -
 arch/powerpc/platforms/Kconfig      |    8 +-
 arch/powerpc/sysdev/cpm1.c          |  112 -------
 arch/powerpc/sysdev/cpm2.c          |   97 -------
 arch/powerpc/sysdev/cpm_common.c    |    3 -
 arch/powerpc/sysdev/fsl_soc.c       |  541 -----------------------------------
 8 files changed, 1 insertions(+), 775 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 4fad6c7..917ac88 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -11,7 +11,6 @@ config MPC8272_ADS
 	select 8260
 	select FSL_SOC
 	select PQ2_ADS_PCI_PIC if PCI
-	select PPC_CPM_NEW_BINDING
 	help
 	  This option enables support for the MPC8272 ADS board
 
@@ -22,7 +21,6 @@ config PQ2FADS
 	select 8260
 	select FSL_SOC
 	select PQ2_ADS_PCI_PIC if PCI
-	select PPC_CPM_NEW_BINDING
 	help
 	  This option enables support for the PQ2FADS board
 
@@ -31,7 +29,6 @@ config EP8248E
 	select 8272
 	select 8260
 	select FSL_SOC
-	select PPC_CPM_NEW_BINDING
 	select MDIO_BITBANG
 	help
 	  This enables support for the Embedded Planet EP8248E board.
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 28bc6e5..7ff29d5 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -19,7 +19,6 @@ config MPC8540_ADS
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select CPM2
 	help
 	  This option enables support for the MPC 8560 ADS board
@@ -48,7 +47,6 @@ config MPC85xx_DS
 
 config KSI8560
         bool "Emerson KSI8560"
-        select PPC_CPM_NEW_BINDING
         select DEFAULT_UIMAGE
         help
           This option enables support for the Emerson KSI8560 board
@@ -60,14 +58,12 @@ config STX_GP3
 	  board.
 	select CPM2
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 
 config TQM8540
 	bool "TQ Components TQM8540"
 	help
 	  This option enables support for the TQ Components TQM8540 board.
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select TQM85xx
 
 config TQM8541
@@ -75,7 +71,6 @@ config TQM8541
 	help
 	  This option enables support for the TQ Components TQM8541 board.
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select TQM85xx
 	select CPM2
 
@@ -84,7 +79,6 @@ config TQM8555
 	help
 	  This option enables support for the TQ Components TQM8555 board.
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select TQM85xx
 	select CPM2
 
@@ -93,7 +87,6 @@ config TQM8560
 	help
 	  This option enables support for the TQ Components TQM8560 board.
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select TQM85xx
 	select CPM2
 
@@ -106,7 +99,6 @@ config SBC8548
 config SBC8560
 	bool "Wind River SBC8560"
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING if CPM2
 	help
 	  This option enables support for the Wind River SBC8560 board
 
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 7fd224c..6fc849e 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -18,7 +18,6 @@ config MPC8XXFADS
 config MPC86XADS
 	bool "MPC86XADS"
 	select CPM1
-	select PPC_CPM_NEW_BINDING
 	help
 	  MPC86x Application Development System by Freescale Semiconductor.
 	  The MPC86xADS is meant to serve as a platform for s/w and h/w
@@ -27,7 +26,6 @@ config MPC86XADS
 config MPC885ADS
 	bool "MPC885ADS"
 	select CPM1
-	select PPC_CPM_NEW_BINDING
 	help
 	  Freescale Semiconductor MPC885 Application Development System (ADS).
 	  Also known as DUET.
@@ -37,7 +35,6 @@ config MPC885ADS
 config PPC_EP88XC
 	bool "Embedded Planet EP88xC (a.k.a. CWH-PPC-885XN-VE)"
 	select CPM1
-	select PPC_CPM_NEW_BINDING
 	help
 	  This enables support for the Embedded Planet EP88xC board.
 
@@ -47,7 +44,6 @@ config PPC_EP88XC
 config PPC_ADDER875
 	bool "Analogue & Micro Adder 875"
 	select CPM1
-	select PPC_CPM_NEW_BINDING
 	select REDBOOT
 	help
 	  This enables support for the Analogue & Micro Adder 875
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index a578b96..f38c50b 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -290,13 +290,7 @@ config CPM2
 config PPC_CPM_NEW_BINDING
 	bool
 	depends on CPM1 || CPM2
-	help
-	  Select this if your board has been converted to use the new
-	  device tree bindings for CPM, and no longer needs the
-	  ioport callbacks or the platform device glue code.
-
-	  The fs_enet and cpm_uart drivers will be built as
-	  of_platform devices.
+	default y
 
 config AXON_RAM
 	tristate "Axon DDR2 memory device driver"
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 3eceeb5..58292a0 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -44,9 +44,6 @@
 
 #define CPM_MAP_SIZE    (0x4000)
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-static void m8xx_cpm_dpinit(void);
-#endif
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
 immap_t __iomem *mpc8xx_immr;
 static cpic8xx_t __iomem *cpic_reg;
@@ -229,12 +226,7 @@ void __init cpm_reset(void)
 	out_be32(&siu_conf->sc_sdcr, 1);
 	immr_unmap(siu_conf);
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 	cpm_muram_init();
-#else
-	/* Reclaim the DP memory for our use. */
-	m8xx_cpm_dpinit();
-#endif
 }
 
 static DEFINE_SPINLOCK(cmd_lock);
@@ -293,110 +285,6 @@ cpm_setbrg(uint brg, uint rate)
 			      CPM_BRG_EN | CPM_BRG_DIV16);
 }
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/*
- * dpalloc / dpfree bits.
- */
-static spinlock_t cpm_dpmem_lock;
-/*
- * 16 blocks should be enough to satisfy all requests
- * until the memory subsystem goes up...
- */
-static rh_block_t cpm_boot_dpmem_rh_block[16];
-static rh_info_t cpm_dpmem_info;
-
-#define CPM_DPMEM_ALIGNMENT	8
-static u8 __iomem *dpram_vbase;
-static phys_addr_t dpram_pbase;
-
-static void m8xx_cpm_dpinit(void)
-{
-	spin_lock_init(&cpm_dpmem_lock);
-
-	dpram_vbase = cpmp->cp_dpmem;
-	dpram_pbase = get_immrbase() + offsetof(immap_t, im_cpm.cp_dpmem);
-
-	/* Initialize the info header */
-	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
-			sizeof(cpm_boot_dpmem_rh_block) /
-			sizeof(cpm_boot_dpmem_rh_block[0]),
-			cpm_boot_dpmem_rh_block);
-
-	/*
-	 * Attach the usable dpmem area.
-	 * XXX: This is actually crap.  CPM_DATAONLY_BASE and
-	 * CPM_DATAONLY_SIZE are a subset of the available dparm.  It varies
-	 * with the processor and the microcode patches applied / activated.
-	 * But the following should be at least safe.
-	 */
-	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
-}
-
-/*
- * Allocate the requested size worth of DP memory.
- * This function returns an offset into the DPRAM area.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- */
-unsigned long cpm_dpalloc(uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return (uint)start;
-}
-EXPORT_SYMBOL(cpm_dpalloc);
-
-int cpm_dpfree(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, offset);
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(cpm_dpfree);
-
-unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_dpalloc_fixed);
-
-void cpm_dpdump(void)
-{
-	rh_dump(&cpm_dpmem_info);
-}
-EXPORT_SYMBOL(cpm_dpdump);
-
-void *cpm_dpram_addr(unsigned long offset)
-{
-	return (void *)(dpram_vbase + offset);
-}
-EXPORT_SYMBOL(cpm_dpram_addr);
-
-uint cpm_dpram_phys(u8 *addr)
-{
-	return (dpram_pbase + (uint)(addr - dpram_vbase));
-}
-EXPORT_SYMBOL(cpm_dpram_phys);
-#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
-
 struct cpm_ioport16 {
 	__be16 dir, par, odr_sor, dat, intr;
 	__be16 res[3];
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 803b59c..f2fc1a5 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -46,10 +46,6 @@
 
 #include <sysdev/fsl_soc.h>
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-static void cpm2_dpinit(void);
-#endif
-
 cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
 
 /* We allocate this here because it is used almost exclusively for
@@ -71,11 +67,7 @@ void __init cpm2_reset(void)
 
 	/* Reclaim the DP memory for our use.
 	 */
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 	cpm_muram_init();
-#else
-	cpm2_dpinit();
-#endif
 
 	/* Tell everyone where the comm processor resides.
 	 */
@@ -346,95 +338,6 @@ int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
 	return ret;
 }
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/*
- * dpalloc / dpfree bits.
- */
-static spinlock_t cpm_dpmem_lock;
-/* 16 blocks should be enough to satisfy all requests
- * until the memory subsystem goes up... */
-static rh_block_t cpm_boot_dpmem_rh_block[16];
-static rh_info_t cpm_dpmem_info;
-static u8 __iomem *im_dprambase;
-
-static void cpm2_dpinit(void)
-{
-	spin_lock_init(&cpm_dpmem_lock);
-
-	/* initialize the info header */
-	rh_init(&cpm_dpmem_info, 1,
-			sizeof(cpm_boot_dpmem_rh_block) /
-			sizeof(cpm_boot_dpmem_rh_block[0]),
-			cpm_boot_dpmem_rh_block);
-
-	im_dprambase = cpm2_immr;
-
-	/* Attach the usable dpmem area */
-	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
-	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
-	 * varies with the processor and the microcode patches activated.
-	 * But the following should be at least safe.
-	 */
-	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
-}
-
-/* This function returns an index into the DPRAM area.
- */
-unsigned long cpm_dpalloc(uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return (uint)start;
-}
-EXPORT_SYMBOL(cpm_dpalloc);
-
-int cpm_dpfree(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, offset);
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(cpm_dpfree);
-
-/* not sure if this is ever needed */
-unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_dpalloc_fixed);
-
-void cpm_dpdump(void)
-{
-	rh_dump(&cpm_dpmem_info);
-}
-EXPORT_SYMBOL(cpm_dpdump);
-
-void *cpm_dpram_addr(unsigned long offset)
-{
-	return (void *)(im_dprambase + offset);
-}
-EXPORT_SYMBOL(cpm_dpram_addr);
-#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
-
 struct cpm2_ioports {
 	u32 dir, par, sor, odr, dat;
 	u32 res[3];
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 165981c..cb7df2d 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -58,7 +58,6 @@ void __init udbg_init_cpm(void)
 }
 #endif
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 static spinlock_t cpm_muram_lock;
 static rh_block_t cpm_boot_muram_rh_block[16];
 static rh_info_t cpm_muram_info;
@@ -199,5 +198,3 @@ dma_addr_t cpm_muram_dma(void __iomem *addr)
 	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
 }
 EXPORT_SYMBOL(cpm_muram_dma);
-
-#endif /* CONFIG_PPC_CPM_NEW_BINDING */
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 2c5388c..642e45e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -735,547 +735,6 @@ err:
 
 arch_initcall(fsl_usb_of_init);
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-#ifdef CONFIG_CPM2
-
-extern void init_scc_ioports(struct fs_uart_platform_info*);
-
-static const char fcc_regs[] = "fcc_regs";
-static const char fcc_regs_c[] = "fcc_regs_c";
-static const char fcc_pram[] = "fcc_pram";
-static char bus_id[9][BUS_ID_SIZE];
-
-static int __init fs_enet_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *fs_enet_dev;
-	struct resource res;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "network", "fs_enet")) != NULL;
-	     i++) {
-		struct resource r[4];
-		struct device_node *phy, *mdio;
-		struct fs_platform_info fs_enet_data;
-		const unsigned int *id, *phy_addr, *phy_irq;
-		const void *mac_addr;
-		const phandle *ph;
-		const char *model;
-
-		memset(r, 0, sizeof(r));
-		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-		r[0].name = fcc_regs;
-
-		ret = of_address_to_resource(np, 1, &r[1]);
-		if (ret)
-			goto err;
-		r[1].name = fcc_pram;
-
-		ret = of_address_to_resource(np, 2, &r[2]);
-		if (ret)
-			goto err;
-		r[2].name = fcc_regs_c;
-		fs_enet_data.fcc_regs_c = r[2].start;
-
-		of_irq_to_resource(np, 0, &r[3]);
-
-		fs_enet_dev =
-		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
-
-		if (IS_ERR(fs_enet_dev)) {
-			ret = PTR_ERR(fs_enet_dev);
-			goto err;
-		}
-
-		model = of_get_property(np, "model", NULL);
-		if (model == NULL) {
-			ret = -ENODEV;
-			goto unreg;
-		}
-
-		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
-			memcpy(fs_enet_data.macaddr, mac_addr, 6);
-
-		ph = of_get_property(np, "phy-handle", NULL);
-		phy = of_find_node_by_phandle(*ph);
-
-		if (phy == NULL) {
-			ret = -ENODEV;
-			goto unreg;
-		}
-
-		phy_addr = of_get_property(phy, "reg", NULL);
-		fs_enet_data.phy_addr = *phy_addr;
-
-		phy_irq = of_get_property(phy, "interrupts", NULL);
-
-		id = of_get_property(np, "device-id", NULL);
-		fs_enet_data.fs_no = *id;
-		strcpy(fs_enet_data.fs_type, model);
-
-		mdio = of_get_parent(phy);
-                ret = of_address_to_resource(mdio, 0, &res);
-                if (ret) {
-                        of_node_put(phy);
-                        of_node_put(mdio);
-                        goto unreg;
-                }
-
-		fs_enet_data.clk_rx = *((u32 *)of_get_property(np,
-						"rx-clock", NULL));
-		fs_enet_data.clk_tx = *((u32 *)of_get_property(np,
-						"tx-clock", NULL));
-
-		if (strstr(model, "FCC")) {
-			int fcc_index = *id - 1;
-			const unsigned char *mdio_bb_prop;
-
-			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
-			fs_enet_data.rx_ring = 32;
-			fs_enet_data.tx_ring = 32;
-			fs_enet_data.rx_copybreak = 240;
-			fs_enet_data.use_napi = 0;
-			fs_enet_data.napi_weight = 17;
-			fs_enet_data.mem_offset = FCC_MEM_OFFSET(fcc_index);
-			fs_enet_data.cp_page = CPM_CR_FCC_PAGE(fcc_index);
-			fs_enet_data.cp_block = CPM_CR_FCC_SBLOCK(fcc_index);
-
-			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
-							(u32)res.start, fs_enet_data.phy_addr);
-			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
-			fs_enet_data.init_ioports = init_fcc_ioports;
-
-			mdio_bb_prop = of_get_property(phy, "bitbang", NULL);
-			if (mdio_bb_prop) {
-				struct platform_device *fs_enet_mdio_bb_dev;
-				struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
-
-				fs_enet_mdio_bb_dev =
-					platform_device_register_simple("fsl-bb-mdio",
-							i, NULL, 0);
-				memset(&fs_enet_mdio_bb_data, 0,
-						sizeof(struct fs_mii_bb_platform_info));
-				fs_enet_mdio_bb_data.mdio_dat.bit =
-					mdio_bb_prop[0];
-				fs_enet_mdio_bb_data.mdio_dir.bit =
-					mdio_bb_prop[1];
-				fs_enet_mdio_bb_data.mdc_dat.bit =
-					mdio_bb_prop[2];
-				fs_enet_mdio_bb_data.mdio_port =
-					mdio_bb_prop[3];
-				fs_enet_mdio_bb_data.mdc_port =
-					mdio_bb_prop[4];
-				fs_enet_mdio_bb_data.delay =
-					mdio_bb_prop[5];
-
-				fs_enet_mdio_bb_data.irq[0] = phy_irq[0];
-				fs_enet_mdio_bb_data.irq[1] = -1;
-				fs_enet_mdio_bb_data.irq[2] = -1;
-				fs_enet_mdio_bb_data.irq[3] = phy_irq[0];
-				fs_enet_mdio_bb_data.irq[31] = -1;
-
-				fs_enet_mdio_bb_data.mdio_dat.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdatc;
-				fs_enet_mdio_bb_data.mdio_dir.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdirc;
-				fs_enet_mdio_bb_data.mdc_dat.offset =
-					(u32)&cpm2_immr->im_ioport.iop_pdatc;
-
-				ret = platform_device_add_data(
-						fs_enet_mdio_bb_dev,
-						&fs_enet_mdio_bb_data,
-						sizeof(struct fs_mii_bb_platform_info));
-				if (ret)
-					goto unreg;
-			}
-
-			of_node_put(phy);
-			of_node_put(mdio);
-
-			ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
-						     sizeof(struct
-							    fs_platform_info));
-			if (ret)
-				goto unreg;
-		}
-	}
-	return 0;
-
-unreg:
-	platform_device_unregister(fs_enet_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fs_enet_of_init);
-
-static const char scc_regs[] = "regs";
-static const char scc_pram[] = "pram";
-
-static int __init cpm_uart_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *cpm_uart_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "serial", "cpm_uart")) != NULL;
-	     i++) {
-		struct resource r[3];
-		struct fs_uart_platform_info cpm_uart_data;
-		const int *id;
-		const char *model;
-
-		memset(r, 0, sizeof(r));
-		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		r[0].name = scc_regs;
-
-		ret = of_address_to_resource(np, 1, &r[1]);
-		if (ret)
-			goto err;
-		r[1].name = scc_pram;
-
-		of_irq_to_resource(np, 0, &r[2]);
-
-		cpm_uart_dev =
-		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
-
-		if (IS_ERR(cpm_uart_dev)) {
-			ret = PTR_ERR(cpm_uart_dev);
-			goto err;
-		}
-
-		id = of_get_property(np, "device-id", NULL);
-		cpm_uart_data.fs_no = *id;
-
-		model = of_get_property(np, "model", NULL);
-		strcpy(cpm_uart_data.fs_type, model);
-
-		cpm_uart_data.uart_clk = ppc_proc_freq;
-
-		cpm_uart_data.tx_num_fifo = 4;
-		cpm_uart_data.tx_buf_size = 32;
-		cpm_uart_data.rx_num_fifo = 4;
-		cpm_uart_data.rx_buf_size = 32;
-		cpm_uart_data.clk_rx = *((u32 *)of_get_property(np,
-						"rx-clock", NULL));
-		cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
-						"tx-clock", NULL));
-
-		ret =
-		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
-					     sizeof(struct
-						    fs_uart_platform_info));
-		if (ret)
-			goto unreg;
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(cpm_uart_dev);
-err:
-	return ret;
-}
-
-arch_initcall(cpm_uart_of_init);
-#endif /* CONFIG_CPM2 */
-
-#ifdef CONFIG_8xx
-
-extern void init_scc_ioports(struct fs_platform_info*);
-extern int platform_device_skip(const char *model, int id);
-
-static int __init fs_enet_mdio_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *mdio_dev;
-	struct resource res;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "mdio", "fs_enet")) != NULL;
-	     i++) {
-		struct fs_mii_fec_platform_info mdio_data;
-
-		memset(&res, 0, sizeof(res));
-		memset(&mdio_data, 0, sizeof(mdio_data));
-
-		ret = of_address_to_resource(np, 0, &res);
-		if (ret)
-			goto err;
-
-		mdio_dev =
-		    platform_device_register_simple("fsl-cpm-fec-mdio",
-						    res.start, &res, 1);
-		if (IS_ERR(mdio_dev)) {
-			ret = PTR_ERR(mdio_dev);
-			goto err;
-		}
-
-		mdio_data.mii_speed = ((((ppc_proc_freq + 4999999) / 2500000) / 2) & 0x3F) << 1;
-
-		ret =
-		    platform_device_add_data(mdio_dev, &mdio_data,
-					     sizeof(struct fs_mii_fec_platform_info));
-		if (ret)
-			goto unreg;
-	}
-	return 0;
-
-unreg:
-	platform_device_unregister(mdio_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fs_enet_mdio_of_init);
-
-static const char *enet_regs = "regs";
-static const char *enet_pram = "pram";
-static const char *enet_irq = "interrupt";
-static char bus_id[9][BUS_ID_SIZE];
-
-static int __init fs_enet_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *fs_enet_dev = NULL;
-	struct resource res;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "network", "fs_enet")) != NULL;
-	     i++) {
-		struct resource r[4];
-		struct device_node *phy = NULL, *mdio = NULL;
-		struct fs_platform_info fs_enet_data;
-		const unsigned int *id;
-		const unsigned int *phy_addr;
-		const void *mac_addr;
-		const phandle *ph;
-		const char *model;
-
-		memset(r, 0, sizeof(r));
-		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
-
-		model = of_get_property(np, "model", NULL);
-		if (model == NULL) {
-			ret = -ENODEV;
-			goto unreg;
-		}
-
-		id = of_get_property(np, "device-id", NULL);
-		fs_enet_data.fs_no = *id;
-
-		if (platform_device_skip(model, *id))
-			continue;
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-		r[0].name = enet_regs;
-
-		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
-			memcpy(fs_enet_data.macaddr, mac_addr, 6);
-
-		ph = of_get_property(np, "phy-handle", NULL);
-		if (ph != NULL)
-			phy = of_find_node_by_phandle(*ph);
-
-		if (phy != NULL) {
-			phy_addr = of_get_property(phy, "reg", NULL);
-			fs_enet_data.phy_addr = *phy_addr;
-			fs_enet_data.has_phy = 1;
-
-			mdio = of_get_parent(phy);
-			ret = of_address_to_resource(mdio, 0, &res);
-			if (ret) {
-				of_node_put(phy);
-				of_node_put(mdio);
-                                goto unreg;
-			}
-		}
-
-		model = of_get_property(np, "model", NULL);
-		strcpy(fs_enet_data.fs_type, model);
-
-		if (strstr(model, "FEC")) {
-			r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-			r[1].flags = IORESOURCE_IRQ;
-			r[1].name = enet_irq;
-
-			fs_enet_dev =
-				    platform_device_register_simple("fsl-cpm-fec", i, &r[0], 2);
-
-			if (IS_ERR(fs_enet_dev)) {
-				ret = PTR_ERR(fs_enet_dev);
-				goto err;
-			}
-
-			fs_enet_data.rx_ring = 128;
-			fs_enet_data.tx_ring = 16;
-			fs_enet_data.rx_copybreak = 240;
-			fs_enet_data.use_napi = 1;
-			fs_enet_data.napi_weight = 17;
-
-			snprintf((char*)&bus_id[i], BUS_ID_SIZE, "%x:%02x",
-							(u32)res.start, fs_enet_data.phy_addr);
-			fs_enet_data.bus_id = (char*)&bus_id[i];
-			fs_enet_data.init_ioports = init_fec_ioports;
-		}
-		if (strstr(model, "SCC")) {
-			ret = of_address_to_resource(np, 1, &r[1]);
-			if (ret)
-				goto err;
-			r[1].name = enet_pram;
-
-			r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
-			r[2].flags = IORESOURCE_IRQ;
-			r[2].name = enet_irq;
-
-			fs_enet_dev =
-				    platform_device_register_simple("fsl-cpm-scc", i, &r[0], 3);
-
-			if (IS_ERR(fs_enet_dev)) {
-				ret = PTR_ERR(fs_enet_dev);
-				goto err;
-			}
-
-			fs_enet_data.rx_ring = 64;
-			fs_enet_data.tx_ring = 8;
-			fs_enet_data.rx_copybreak = 240;
-			fs_enet_data.use_napi = 1;
-			fs_enet_data.napi_weight = 17;
-
-			snprintf((char*)&bus_id[i], BUS_ID_SIZE, "%s", "fixed@10:1");
-                        fs_enet_data.bus_id = (char*)&bus_id[i];
-			fs_enet_data.init_ioports = init_scc_ioports;
-		}
-
-		of_node_put(phy);
-		of_node_put(mdio);
-
-		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
-					     sizeof(struct
-						    fs_platform_info));
-		if (ret)
-			goto unreg;
-	}
-	return 0;
-
-unreg:
-	platform_device_unregister(fs_enet_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fs_enet_of_init);
-
-static int __init fsl_pcmcia_of_init(void)
-{
-	struct device_node *np;
-	/*
-	 * Register all the devices which type is "pcmcia"
-	 */
-	for_each_compatible_node(np, "pcmcia", "fsl,pq-pcmcia")
-		of_platform_device_create(np, "m8xx-pcmcia", NULL);
-	return 0;
-}
-
-arch_initcall(fsl_pcmcia_of_init);
-
-static const char *smc_regs = "regs";
-static const char *smc_pram = "pram";
-
-static int __init cpm_smc_uart_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *cpm_uart_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "serial", "cpm_uart")) != NULL;
-	     i++) {
-		struct resource r[3];
-		struct fs_uart_platform_info cpm_uart_data;
-		const int *id;
-		const char *model;
-
-		memset(r, 0, sizeof(r));
-		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		r[0].name = smc_regs;
-
-		ret = of_address_to_resource(np, 1, &r[1]);
-		if (ret)
-			goto err;
-		r[1].name = smc_pram;
-
-		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
-		r[2].flags = IORESOURCE_IRQ;
-
-		cpm_uart_dev =
-		    platform_device_register_simple("fsl-cpm-smc:uart", i, &r[0], 3);
-
-		if (IS_ERR(cpm_uart_dev)) {
-			ret = PTR_ERR(cpm_uart_dev);
-			goto err;
-		}
-
-		model = of_get_property(np, "model", NULL);
-		strcpy(cpm_uart_data.fs_type, model);
-
-		id = of_get_property(np, "device-id", NULL);
-		cpm_uart_data.fs_no = *id;
-		cpm_uart_data.uart_clk = ppc_proc_freq;
-
-		cpm_uart_data.tx_num_fifo = 4;
-		cpm_uart_data.tx_buf_size = 32;
-		cpm_uart_data.rx_num_fifo = 4;
-		cpm_uart_data.rx_buf_size = 32;
-
-		ret =
-		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
-					     sizeof(struct
-						    fs_uart_platform_info));
-		if (ret)
-			goto unreg;
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(cpm_uart_dev);
-err:
-	return ret;
-}
-
-arch_initcall(cpm_smc_uart_of_init);
-
-#endif /* CONFIG_8xx */
-#endif /* CONFIG_PPC_CPM_NEW_BINDING */
-
 static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 				   struct spi_board_info *board_infos,
 				   unsigned int num_board_infos,
-- 
1.5.4.4
