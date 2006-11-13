Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 78D9C67EAF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 09:31:53 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
References: <adalkmf44eu.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 14:31:51 -0800
In-Reply-To: <adalkmf44eu.fsf@cisco.com> (Roland Dreier's message of "Mon,
	13 Nov 2006 09:55:53 -0800")
Message-ID: <adaac2v2d2g.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is mostly updating the PCI Express code to work with the new core
in the Rev. B chip, which unfortunately has different undocumented
restrictions on the PLB addresses that can be used from the Rev. A core.

Also, when adding the cputable entry for 440SPe Rev. B, we need to
adjust the entry for 440SP Rev. A so that it looks at more bits of the
PVR.  The 440SPe Rev. B has PVR 53421891, which would have matched the
old 440SP pattern of 53xxx891.

This is a cleaned up version of the original work done by Rafal
Jaworowski <raj@semihalf.com>, who actually suffered through figuring
out how to avoid the Rev. B chip locking up when using PCIe.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
Matt, please apply this version, which gives proper credit for the patch.

 arch/powerpc/kernel/cputable.c           |   21 ++-
 arch/ppc/platforms/4xx/davinci_sc.c      |    5 -
 arch/ppc/syslib/ppc440spe_pcie.c         |  258 ++++++++++++++++++++++--------
 drivers/infiniband/hw/mthca/mthca_main.c |    4 +-
 4 files changed, 206 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index bfd499e..04559be 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1073,8 +1073,8 @@ #ifdef CONFIG_44x
 		.platform		= "ppc440",
 	},
 	{ /* 440SP Rev. A */
-		.pvr_mask		= 0xff000fff,
-		.pvr_value		= 0x53000891,
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53200891,
 		.cpu_name		= "440SP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
@@ -1083,9 +1083,20 @@ #ifdef CONFIG_44x
 		.platform		= "ppc440",
 	},
 	{ /* 440SPe Rev. A */
-		.pvr_mask		= 0xff000fff,
-		.pvr_value		= 0x53000890,
-		.cpu_name		= "440SPe Rev. A",
+		.pvr_mask               = 0xfff00fff,
+		.pvr_value              = 0x53400890,
+		.cpu_name               = "440SPe Rev. A",
+		.cpu_features           = CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features      = COMMON_USER_BOOKE,
+		.icache_bsize           = 32,
+		.dcache_bsize           = 32,
+		.platform               = "ppc440",
+	},
+	{ /* 440SPe Rev. B */
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53400891,
+		.cpu_name		= "440SPe Rev. B",
 		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
 			CPU_FTR_USE_TB,
 		.cpu_user_features	= COMMON_USER_BOOKE,
diff --git a/arch/ppc/platforms/4xx/davinci_sc.c b/arch/ppc/platforms/4xx/davinci_sc.c
index 623988f..3dbedda 100644
--- a/arch/ppc/platforms/4xx/davinci_sc.c
+++ b/arch/ppc/platforms/4xx/davinci_sc.c
@@ -172,11 +172,6 @@ davinci_sc_setup_hoses(void)
 	char name[20];
 	int i;
 
-	if (0 && ppc440spe_init_pcie()) {
-		printk(KERN_WARNING "PPC440SPe PCI Express initialization failed\n");
-		return;
-	}
-
 	for (i = 0; i <= 2; ++i) {
 		if (!davinci_sc_pcie_card_present(i))
 			continue;
diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
index dd5d4b9..7ae14d2 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -19,16 +19,23 @@ #include <asm/ibm44x.h>
 
 #include "ppc440spe_pcie.h"
 
+static enum {
+	REV_A,
+	REV_B
+} core_rev;
+
 static int
 pcie_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
 {
 	struct pci_controller *hose = bus->sysdata;
 
-	if (PCI_SLOT(devfn) != 1)
+	/* 440SPE implements only one function per port */
+	if (PCI_SLOT(devfn) != 1 || PCI_FUNC(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	offset += devfn << 12;
+	if (core_rev == REV_A)
+		offset += devfn << 12;
 
 	/*
 	 * Note: the caller has already checked that offset is
@@ -57,10 +64,11 @@ pcie_write_config(struct pci_bus *bus, u
 {
 	struct pci_controller *hose = bus->sysdata;
 
-	if (PCI_SLOT(devfn) != 1)
+	if (PCI_SLOT(devfn) != 1 || PCI_FUNC(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	offset += devfn << 12;
+	if (core_rev == REV_A)
+		offset += devfn << 12;
 
 	switch (len) {
 	case 1:
@@ -153,6 +161,20 @@ static void check_error(void)
  */
 int ppc440spe_init_pcie(void)
 {
+	int i;
+
+	switch (PVR_REV(mfspr(SPRN_PVR))) {
+	case 0x1890: core_rev = REV_A; break;
+	case 0x1891: core_rev = REV_B; break;
+	default:
+		printk(KERN_ERR "PCIE: Unknown PVR rev. %lx\n",
+		       PVR_REV(mfspr(SPRN_PVR)));
+		return -1;
+	}
+
+	printk(KERN_INFO "PCIE: core rev %c detected\n",
+	       core_rev == REV_A ? 'A' : 'B');
+
 	/* Set PLL clock receiver to LVPECL */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
 
@@ -168,21 +190,78 @@ int ppc440spe_init_pcie(void)
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
 	udelay(3);
 
+	for (i = 0; i < 100; ++i) {
+		if (SDR_READ(PESDR0_PLLLCT3) & 0x10000000)
+			goto pll_ok;
+
+		udelay(1);
+	}
+
+	printk(KERN_INFO "PCIE: VCO output not locked: %x\n",
+	       SDR_READ(PESDR0_PLLLCT3));
+	return -1;
+
+pll_ok:
 	return 0;
 }
 
+static void ppc440spe_setup_utl(int port)
+{
+	void __iomem *utl_base;
+
+	/*
+	 * Map UTL registers at 0xc_1000_0n00
+	 */
+	switch (port) {
+	case 0:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
+		break;
+
+	case 1:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
+		break;
+
+	case 2:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
+	}
+
+	utl_base = ioremap64(0xc10000000ull + 0x1000 * port, 0x100);
+
+	/*
+	 * Set buffer allocations and then assert VRB and TXE.
+	 */
+	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
+	out_be32(utl_base + PEUTL_INTR,    0x02000000);
+	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
+	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
+	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
+	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
+
+	iounmap(utl_base);
+}
+
 int ppc440spe_init_pcie_rootport(int port)
 {
 	static int core_init;
-	void __iomem *utl_base;
 	u32 val = 0;
 	int i;
 
 	if (!core_init) {
-		++core_init;
 		i = ppc440spe_init_pcie();
 		if (i)
 			return i;
+		++core_init;
 	}
 
 	/*
@@ -193,13 +272,19 @@ int ppc440spe_init_pcie_rootport(int por
 	 * - Set up UTL configuration.
 	 * - Increase SERDES drive strength to levels suggested by AMCC.
 	 * - De-assert RSTPYN, RSTDL and RSTGU.
+	 *
+	 * For rev. B chips, we don't set PESDRn_UTLSET2, but just
+	 * leave it with default setting 0x11310000. The register has
+	 * new fields, PESDRn_UTLSET2[LKINE] in particular: clearing
+	 * it leads to a PCIe core hang.
 	 */
 	switch (port) {
 	case 0:
 		SDR_WRITE(PESDR0_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X8 << 12);
 
 		SDR_WRITE(PESDR0_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR0_UTLSET2, 0x11000000);
+		if (core_rev == REV_A)
+			SDR_WRITE(PESDR0_UTLSET2, 0x11000000);
 
 		SDR_WRITE(PESDR0_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR0_HSSL1SET1, 0x35000000);
@@ -218,7 +303,8 @@ int ppc440spe_init_pcie_rootport(int por
 		SDR_WRITE(PESDR1_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
 
 		SDR_WRITE(PESDR1_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR1_UTLSET2, 0x11000000);
+		if (core_rev == REV_A)
+			SDR_WRITE(PESDR1_UTLSET2, 0x11000000);
 
 		SDR_WRITE(PESDR1_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR1_HSSL1SET1, 0x35000000);
@@ -233,7 +319,8 @@ int ppc440spe_init_pcie_rootport(int por
 		SDR_WRITE(PESDR2_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
 
 		SDR_WRITE(PESDR2_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR2_UTLSET2, 0x11000000);
+		if (core_rev == REV_A)
+			SDR_WRITE(PESDR2_UTLSET2, 0x11000000);
 
 		SDR_WRITE(PESDR2_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR2_HSSL1SET1, 0x35000000);
@@ -255,78 +342,81 @@ int ppc440spe_init_pcie_rootport(int por
 
 	if (!(val & (1 << 20)))
 		printk(KERN_INFO "PCIE%d: PGRST inactive\n", port);
-	else
-		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n", port, val);
-
-	switch (port) {
-	case 0: printk(KERN_INFO "PCIE0: LOOP %08x\n", SDR_READ(PESDR0_LOOP)); break;
-	case 1: printk(KERN_INFO "PCIE1: LOOP %08x\n", SDR_READ(PESDR1_LOOP)); break;
-	case 2: printk(KERN_INFO "PCIE2: LOOP %08x\n", SDR_READ(PESDR2_LOOP)); break;
+	else {
+		printk(KERN_WARNING "PCIE%d: PGRST failed %08x\n", port, val);
+		return -1;
 	}
 
-	/*
-	 * Map UTL registers at 0xc_1000_0n00
-	 */
 	switch (port) {
-	case 0:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
-		break;
-
-	case 1:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
-		break;
-
-	case 2:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
+	case 0: val = SDR_READ(PESDR0_LOOP); break;
+	case 1: val = SDR_READ(PESDR1_LOOP); break;
+	case 2: val = SDR_READ(PESDR2_LOOP); break;
 	}
 
-	utl_base = ioremap64(0xc10000000ull + 0x1000 * port, 0x100);
+	if (val & 0x1000)
+		printk(KERN_INFO "PCIE%d: link up\n", port);
+	else {
+		printk(KERN_WARNING "PCIE%d: link down %08x\n", port, val);
+		return -1;
+	}
 
 	/*
-	 * Set buffer allocations and then assert VRB and TXE.
+	 * Setup UTL registers - but only on rev. A!
+	 * Just leave rev. B with default settings.
 	 */
-	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
-	out_be32(utl_base + PEUTL_INTR,    0x02000000);
-	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
-	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
-	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
-	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
-
-	iounmap(utl_base);
+	if (core_rev == REV_A)
+		ppc440spe_setup_utl(port);
 
 	/*
 	 * We map PCI Express configuration access into the 512MB regions
+	 *
+	 * Rev. B is very strict about PLB real addressess and ranges
+	 * to be mapped for config space; it seems to only work with
+	 * 0xd_nnnn_nnnn range (the core hangs on config transaction
+	 * attempts when set otherwise), while rev. A only works with
+	 * 0xc_nnnn_nnnn.  So we use the following ranges:
+	 *
+	 * Rev. A:
 	 *     PCIE0: 0xc_4000_0000
 	 *     PCIE1: 0xc_8000_0000
 	 *     PCIE2: 0xc_c000_0000
+	 *
+	 * Rev. B:
+	 *     PCIE0: 0xd_0000_0000
+	 *     PCIE1: 0xd_2000_0000
+	 *     PCIE2: 0xd_4000_0000
 	 */
 	switch (port) {
 	case 0:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
+		if (core_rev == REV_A) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
+		} else {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x00000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE0), 0xe0000001); /* 512MB region, valid */
 		break;
 
 	case 1:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
+		if (core_rev == REV_A) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
+		} else {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x20000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE1), 0xe0000001); /* 512MB region, valid */
 		break;
 
 	case 2:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
+		if (core_rev == REV_A) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
+		} else {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0x40000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE2), 0xe0000001); /* 512MB region, valid */
 		break;
 	}
@@ -336,18 +426,24 @@ int ppc440spe_init_pcie_rootport(int por
 	 */
 	switch (port) {
 	case 0:
-		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
+		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
 			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+			return -1;
+		}
 		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
 		break;
 	case 1:
-		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16))) {
+			printk(KERN_WARNING "PCIE1: VC0 not active\n");
+			return -1;
+		}
 		SDR_WRITE(PESDR1_RCSSET, SDR_READ(PESDR1_RCSSET) | 1 << 20);
 		break;
 	case 2:
-		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16))) {
+			printk(KERN_WARNING "PCIE2: VC0 not active\n");
+			return -1;
+		}
 		SDR_WRITE(PESDR2_RCSSET, SDR_READ(PESDR2_RCSSET) | 1 << 20);
 		break;
 	}
@@ -375,19 +471,42 @@ void ppc440spe_setup_pcie(struct pci_con
 {
 	void __iomem *mbase;
 
-	/*
-	 * Map 16MB, which is enough for 4 bits of bus #
-	 */
-	hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000,
-				   1 << 24);
+	if (core_rev == REV_A) {
+		/*
+		 * Map 16MB, which is enough for 4 bits of bus #
+		 */
+		hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000,
+					   1 << 24);
+
+		mbase = ioremap64(0xc50000000ull + port * 0x40000000, 0x1000);
+	} else {
+		/*
+		 * Rev. B is very strict about PLB real addressess and
+		 * sizes to be mapped for config space; the core hangs
+		 * on config transaction attempt if not set to
+		 * 0xd_0010_0000, 0xd_2010_0000, 0xd_4010_0000
+		 * respectively.
+		 */
+		hose->cfg_data = ioremap64(0xd00100000ull + port * 0x20000000,
+					   0x400);
+
+		/* for accessing Local Config space we need to set A[35] */
+		mbase = ioremap64(0xd10000000ull + port * 0x20000000, 0x400);
+	}
+
 	hose->ops = &pcie_pci_ops;
 
 	/*
 	 * Set bus numbers on our root port
 	 */
-	mbase = ioremap64(0xc50000000ull + port * 0x40000000, 4096);
-	out_8(mbase + PCI_PRIMARY_BUS, 0);
-	out_8(mbase + PCI_SECONDARY_BUS, 0);
+	if (core_rev == REV_A) {
+		out_8(mbase + PCI_PRIMARY_BUS, 0);
+		out_8(mbase + PCI_SECONDARY_BUS, 0);
+	} else {
+		out_8(mbase + PCI_PRIMARY_BUS, 0);
+		out_8(mbase + PCI_SECONDARY_BUS, 1);
+		out_8(mbase + PCI_SUBORDINATE_BUS, 1);
+	}
 
 	/*
 	 * Set up outbound translation to hose->mem_space from PLB
@@ -412,7 +531,6 @@ void ppc440spe_setup_pcie(struct pci_con
 		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE1), 0x7fffffff);
 		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE1),
 		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
-
 		break;
 	case 2:
 		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE2),  0x0000000d);
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 47ea021..c499b90 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -87,9 +87,9 @@ static const char mthca_version[] __devi
 	DRV_VERSION " (" DRV_RELDATE ")\n";
 
 static struct mthca_profile default_profile = {
-	.num_qp		   = 1 << 16,
+	.num_qp		   = 1 << 11,
 	.rdb_per_qp	   = 4,
-	.num_cq		   = 1 << 16,
+	.num_cq		   = 1 << 11,
 	.num_mcg	   = 1 << 13,
 	.num_mpt	   = 1 << 17,
 	.num_mtt	   = 1 << 20,
-- 
1.4.3.2
