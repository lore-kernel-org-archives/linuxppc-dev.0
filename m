Return-Path: <SRS0=JDpv=TM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9712DDDF4E
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 08:08:57 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 5/5] [POWERPC] Add 460EX PCIe support to 4xx pci driver
Date: Sat, 23 Feb 2008 22:08:27 +0100
Message-Id: <1203800907-13898-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All this code is needed to properly initialize the 460EX PCIe host
bridge(s). We re-initialize all ports again, even though this has been done
in the bootloader (U-Boot) before. This way we make sure, that we always
run the latest init code in Linux and don't depend on code versions from
U-Boot.

Unfortunately all IBM/AMCC chips currently supported in this PCIe driver need
a different reset-/init-sequence.

Tested on AMCC Canyonlands eval board.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |  114 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h |   59 +++++++++++++++++++
 2 files changed, 173 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 5abfcd1..d183b83 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -527,6 +527,7 @@ static void __init ppc4xx_probe_pcix_bridge(struct device_node *np)
  *
  * ibm,plb-pciex-440spe
  * ibm,plb-pciex-405ex
+ * ibm,plb-pciex-460ex
  *
  * Anything else will be rejected for now as they are all subtly
  * different unfortunately.
@@ -775,6 +776,117 @@ static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
 	.setup_utl	= ppc440speB_pciex_init_utl,
 };
 
+static int __init ppc460ex_pciex_core_init(struct device_node *np)
+{
+	/* Nothing to do, return 2 ports */
+	return 2;
+}
+
+static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+{
+	u32 val;
+	u32 utlset1;
+
+	if (port->endpoint) {
+		val = PTYPE_LEGACY_ENDPOINT << 20;
+		utlset1 = 0x20222222;
+	} else {
+		val = PTYPE_ROOT_PORT << 20;
+		utlset1 = 0x21222222;
+	}
+
+	if (port->index == 0) {
+		val |= LNKW_X1 << 12;
+	} else {
+		val |= LNKW_X4 << 12;
+		utlset1 |= 0x00101101;
+	}
+
+	mtdcri(SDR0, port->sdr_base + PESDRn_DLPSET, val);
+	mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET1, utlset1);
+	mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET2, 0x01210000);
+
+	switch (port->index) {
+	case 0:
+		mtdcri(SDR0, PESDR0_460EX_L0CDRCTL, 0x00003230);
+		mtdcri(SDR0, PESDR0_460EX_L0DRV, 0x00000136);
+		mtdcri(SDR0, PESDR0_460EX_L0CLK, 0x00000006);
+
+		mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST,0x10000000);
+		break;
+
+	case 1:
+		mtdcri(SDR0, PESDR1_460EX_L0CDRCTL, 0x00003230);
+		mtdcri(SDR0, PESDR1_460EX_L1CDRCTL, 0x00003230);
+		mtdcri(SDR0, PESDR1_460EX_L2CDRCTL, 0x00003230);
+		mtdcri(SDR0, PESDR1_460EX_L3CDRCTL, 0x00003230);
+		mtdcri(SDR0, PESDR1_460EX_L0DRV, 0x00000136);
+		mtdcri(SDR0, PESDR1_460EX_L1DRV, 0x00000136);
+		mtdcri(SDR0, PESDR1_460EX_L2DRV, 0x00000136);
+		mtdcri(SDR0, PESDR1_460EX_L3DRV, 0x00000136);
+		mtdcri(SDR0, PESDR1_460EX_L0CLK, 0x00000006);
+		mtdcri(SDR0, PESDR1_460EX_L1CLK, 0x00000006);
+		mtdcri(SDR0, PESDR1_460EX_L2CLK, 0x00000006);
+		mtdcri(SDR0, PESDR1_460EX_L3CLK, 0x00000006);
+
+		mtdcri(SDR0, PESDR1_460EX_PHY_CTL_RST,0x10000000);
+		break;
+	}
+
+	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
+	       mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) |
+	       (PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTPYN));
+
+	/* Poll for PHY reset */
+	/* XXX FIXME add timeout */
+	switch (port->index) {
+	case 0:
+		while (!(mfdcri(SDR0, PESDR0_460EX_RSTSTA) & 0x1))
+			udelay(10);
+		break;
+	case 1:
+		while (!(mfdcri(SDR0, PESDR1_460EX_RSTSTA) & 0x1))
+			udelay(10);
+		break;
+	}
+
+	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
+	       (mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) &
+		~(PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTDL)) |
+	       PESDRx_RCSSET_RSTPYN);
+
+	port->has_ibpre = 1;
+
+	return 0;
+}
+
+static int ppc460ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
+{
+	dcr_write(port->dcrs, DCRO_PEGPL_SPECIAL, 0x0);
+
+	/*
+	 * Set buffer allocations and then assert VRB and TXE.
+	 */
+	out_be32(port->utl_base + PEUTL_PBCTL,	0x0800000c);
+	out_be32(port->utl_base + PEUTL_OUTTR,	0x08000000);
+	out_be32(port->utl_base + PEUTL_INTR,	0x02000000);
+	out_be32(port->utl_base + PEUTL_OPDBSZ,	0x04000000);
+	out_be32(port->utl_base + PEUTL_PBBSZ,	0x00000000);
+	out_be32(port->utl_base + PEUTL_IPHBSZ,	0x02000000);
+	out_be32(port->utl_base + PEUTL_IPDBSZ,	0x04000000);
+	out_be32(port->utl_base + PEUTL_RCIRQEN,0x00f00000);
+	out_be32(port->utl_base + PEUTL_PCTL,	0x80800066);
+
+	return 0;
+}
+
+static struct ppc4xx_pciex_hwops ppc460ex_pcie_hwops __initdata =
+{
+	.core_init	= ppc460ex_pciex_core_init,
+	.port_init_hw	= ppc460ex_pciex_init_port_hw,
+	.setup_utl	= ppc460ex_pciex_init_utl,
+};
+
 #endif /* CONFIG_44x */
 
 #ifdef CONFIG_40x
@@ -896,6 +1008,8 @@ static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 		else
 			ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;
 	}
+	if (of_device_is_compatible(np, "ibm,plb-pciex-460ex"))
+		ppc4xx_pciex_hwops = &ppc460ex_pcie_hwops;
 #endif /* CONFIG_44x    */
 #ifdef CONFIG_40x
 	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4xx_pci.h
index 1c07908..d04e40b 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.h
+++ b/arch/powerpc/sysdev/ppc4xx_pci.h
@@ -271,6 +271,59 @@
 #define PESDR1_405EX_PHYSTA		0x044C
 
 /*
+ * 460EX additional DCRs
+ */
+#define PESDR0_460EX_L0BIST		0x0308
+#define PESDR0_460EX_L0BISTSTS		0x0309
+#define PESDR0_460EX_L0CDRCTL		0x030A
+#define PESDR0_460EX_L0DRV		0x030B
+#define PESDR0_460EX_L0REC		0x030C
+#define PESDR0_460EX_L0LPB		0x030D
+#define PESDR0_460EX_L0CLK		0x030E
+#define PESDR0_460EX_PHY_CTL_RST	0x030F
+#define PESDR0_460EX_RSTSTA		0x0310
+#define PESDR0_460EX_OBS		0x0311
+#define PESDR0_460EX_L0ERRC		0x0320
+
+#define PESDR1_460EX_L0BIST		0x0348
+#define PESDR1_460EX_L1BIST		0x0349
+#define PESDR1_460EX_L2BIST		0x034A
+#define PESDR1_460EX_L3BIST		0x034B
+#define PESDR1_460EX_L0BISTSTS		0x034C
+#define PESDR1_460EX_L1BISTSTS		0x034D
+#define PESDR1_460EX_L2BISTSTS		0x034E
+#define PESDR1_460EX_L3BISTSTS		0x034F
+#define PESDR1_460EX_L0CDRCTL		0x0350
+#define PESDR1_460EX_L1CDRCTL		0x0351
+#define PESDR1_460EX_L2CDRCTL		0x0352
+#define PESDR1_460EX_L3CDRCTL		0x0353
+#define PESDR1_460EX_L0DRV		0x0354
+#define PESDR1_460EX_L1DRV		0x0355
+#define PESDR1_460EX_L2DRV		0x0356
+#define PESDR1_460EX_L3DRV		0x0357
+#define PESDR1_460EX_L0REC		0x0358
+#define PESDR1_460EX_L1REC		0x0359
+#define PESDR1_460EX_L2REC		0x035A
+#define PESDR1_460EX_L3REC		0x035B
+#define PESDR1_460EX_L0LPB		0x035C
+#define PESDR1_460EX_L1LPB		0x035D
+#define PESDR1_460EX_L2LPB		0x035E
+#define PESDR1_460EX_L3LPB		0x035F
+#define PESDR1_460EX_L0CLK		0x0360
+#define PESDR1_460EX_L1CLK		0x0361
+#define PESDR1_460EX_L2CLK		0x0362
+#define PESDR1_460EX_L3CLK		0x0363
+#define PESDR1_460EX_PHY_CTL_RST	0x0364
+#define PESDR1_460EX_RSTSTA		0x0365
+#define PESDR1_460EX_OBS		0x0366
+#define PESDR1_460EX_L0ERRC		0x0368
+#define PESDR1_460EX_L1ERRC		0x0369
+#define PESDR1_460EX_L2ERRC		0x036A
+#define PESDR1_460EX_L3ERRC		0x036B
+#define PESDR0_460EX_IHS1		0x036C
+#define PESDR0_460EX_IHS2		0x036D
+
+/*
  * Of the above, some are common offsets from the base
  */
 #define PESDRn_UTLSET1			0x00
@@ -353,6 +406,12 @@
 #define PECFG_POM2LAL		0x390
 #define PECFG_POM2LAH		0x394
 
+/* SDR Bit Mappings */
+#define PESDRx_RCSSET_HLDPLB	0x10000000
+#define PESDRx_RCSSET_RSTGU	0x01000000
+#define PESDRx_RCSSET_RDY       0x00100000
+#define PESDRx_RCSSET_RSTDL     0x00010000
+#define PESDRx_RCSSET_RSTPYN    0x00001000
 
 enum
 {
-- 
1.5.4.2
