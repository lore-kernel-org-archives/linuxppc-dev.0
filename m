Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 7/8] 44x/476fpe: Add 476fpe SoC code
Date: Thu,  1 Dec 2011 18:39:23 +1100
Message-Id: <1322725164-4391-8-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on original work by David 'Shaggy' Kliekamp.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/include/asm/reg.h     |    1 +
 arch/powerpc/kernel/cputable.c     |   14 +++++++++
 arch/powerpc/kernel/head_44x.S     |    2 +
 arch/powerpc/platforms/44x/Kconfig |    4 ++
 arch/powerpc/sysdev/ppc4xx_pci.c   |   57 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/ppc4xx_pci.h   |    7 ++++
 6 files changed, 84 insertions(+), 1 deletions(-)

I wimped out on doing the mask and test opperations in head_44x.S for the
generic 476 PVR.

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 559da19..7fdc2c0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -951,6 +951,7 @@
 #define PVR_403GCX	0x00201400
 #define PVR_405GP	0x40110000
 #define PVR_476		0x11a52000
+#define PVR_476FPE	0x7ff50000
 #define PVR_STB03XXX	0x40310000
 #define PVR_NP405H	0x41410000
 #define PVR_NP405L	0x41610000
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index edae5bb..7797ae2 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1830,6 +1830,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_47x,
 		.platform		= "ppc470",
 	},
+	{ /* 476fpe */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x7ff50000,
+		.cpu_name		= "476fpe",
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD2,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
 	{ /* 476 iss */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00050000,
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b725dab..bb7a9c7 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -732,6 +732,8 @@ _GLOBAL(init_cpu_state)
 	/* We use the PVR to differenciate 44x cores from 476 */
 	mfspr	r3,SPRN_PVR
 	srwi	r3,r3,16
+	cmplwi	cr0,r3,PVR_476FPE@h
+	beq	head_start_47x
 	cmplwi	cr0,r3,PVR_476@h
 	beq	head_start_47x
 	cmplwi	cr0,r3,PVR_476_ISS@h
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 762322c..f0be6e0 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -308,6 +308,10 @@ config 460SX
 	select IBM_EMAC_ZMII
 	select IBM_EMAC_TAH
 
+config 476FPE
+	bool
+	select PPC_FPU
+
 config APM821xx
 	bool
 	select PPC_FPU
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 45148ef..ae15e6f 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1296,6 +1296,52 @@ static struct ppc4xx_pciex_hwops ppc405ex_pcie_hwops __initdata =
 
 #endif /* CONFIG_40x */
 
+#ifdef CONFIG_476FPE
+static int __init ppc_476fpe_pciex_core_init(struct device_node *np)
+{
+	return 4;
+}
+
+static void __init ppc_476fpe_pciex_check_link(struct ppc4xx_pciex_port *port)
+{
+	u32 timeout_ms = 20;
+	u32 val = 0, mask = (PECFG_TLDLP_LNKUP|PECFG_TLDLP_PRESENT);
+	void __iomem *mbase = ioremap(port->cfg_space.start + 0x10000000,
+	                              0x1000);
+
+	printk(KERN_INFO "PCIE%d: Checking link...\n", port->index);
+
+	if (mbase == NULL) {
+		printk(KERN_WARNING "PCIE%d: failed to get cfg space\n",
+		                    port->index);
+		return;
+	}
+		
+	while (timeout_ms--) {
+		val = in_le32(mbase + PECFG_TLDLP);
+
+		if ((val & mask) == mask)
+			break;
+		msleep(10);
+	}
+
+	if (val & PECFG_TLDLP_PRESENT) {
+		printk(KERN_INFO "PCIE%d: link is up !\n", port->index);
+		port->link = 1;
+	} else
+		printk(KERN_WARNING "PCIE%d: Link up failed\n", port->index);
+
+	iounmap(mbase);
+	return;
+}
+
+static struct ppc4xx_pciex_hwops ppc_476fpe_pcie_hwops __initdata =
+{
+	.core_init	= ppc_476fpe_pciex_core_init,
+	.check_link	= ppc_476fpe_pciex_check_link,
+};
+#endif /* CONFIG_476FPE */
+
 /* Check that the core has been initied and if not, do it */
 static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 {
@@ -1321,6 +1367,10 @@ static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
 		ppc4xx_pciex_hwops = &ppc405ex_pcie_hwops;
 #endif
+#ifdef CONFIG_476FPE
+	if (of_device_is_compatible(np, "ibm,plb-pciex-476fpe"))
+		ppc4xx_pciex_hwops = &ppc_476fpe_pcie_hwops;
+#endif
 	if (ppc4xx_pciex_hwops == NULL) {
 		printk(KERN_WARNING "PCIE: unknown host type %s\n",
 		       np->full_name);
@@ -1629,6 +1679,10 @@ static int __init ppc4xx_setup_one_pciex_POM(struct ppc4xx_pciex_port	*port,
 			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
 				sa | DCRO_PEGPL_460SX_OMR1MSKL_UOT
 					| DCRO_PEGPL_OMRxMSKL_VAL);
+		else if (of_device_is_compatible(port->node, "ibm,plb-pciex-476fpe"))
+			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
+				sa | DCRO_PEGPL_476FPE_OMR1MSKL_UOT
+					| DCRO_PEGPL_OMRxMSKL_VAL);
 		else
 			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
 				sa | DCRO_PEGPL_OMR1MSKL_UOT
@@ -1753,7 +1807,8 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 		if (res->flags & IORESOURCE_PREFETCH)
 			sa |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 
-		if (of_device_is_compatible(port->node, "ibm,plb-pciex-460sx"))
+		if (of_device_is_compatible(port->node, "ibm,plb-pciex-460sx") ||
+		    of_device_is_compatible(port->node, "ibm,plb-pciex-476fpe"))
 			sa |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 
 		out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4xx_pci.h
index 32ce763..bb48219 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.h
+++ b/arch/powerpc/sysdev/ppc4xx_pci.h
@@ -476,6 +476,13 @@
 #define DCRO_PEGPL_OMR1MSKL_UOT	 0x00000002
 #define DCRO_PEGPL_OMR3MSKL_IO	 0x00000002
 
+/* 476FPE */
+#define PCCFG_LCPA			0x270
+#define PECFG_TLDLP			0x3F8
+#define PECFG_TLDLP_LNKUP		0x00000008
+#define PECFG_TLDLP_PRESENT		0x00000010
+#define DCRO_PEGPL_476FPE_OMR1MSKL_UOT	 0x00000004
+
 /* SDR Bit Mappings */
 #define PESDRx_RCSSET_HLDPLB	0x10000000
 #define PESDRx_RCSSET_RSTGU	0x01000000
-- 
1.7.6.4
