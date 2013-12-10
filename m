Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CF1D2C0227
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:47:00 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v1 3/4] powerpc/512x: clk: support MPC5121/5123/5125 SoC
 variants
Date: Tue, 10 Dec 2013 14:11:36 +0100
Message-Id: <1386681097-14126-4-git-send-email-gsi@denx.de>
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

improve the common clock support code for MPC512x

- expand the CCM register set declaration with MPC5125 related registers
  (which reside in the previously "reserved" area)
- tell the MPC5121, MPC5123, and MPC5125 SoC variants apart, and derive
  the availability of components and their clocks from the detected SoC
  (MBX, AXE, VIU, SPDIF, PATA, SATA, PCI, second FEC, second SDHC,
  number of PSC components, type of NAND flash controller,
  interpretation of the CPMF bitfield, PSC/CAN mux0 stage input clocks,
  output clocks on SoC pins)
- add backwards compatibility (allow operation against a device tree
  which lacks clock related specs) for MPC5125 FECs, too

telling SoC variants apart and adjusting the clock tree's generation
occurs at runtime, a common generic binary supports all of the chips

the MPC5125 approach to the NFC clock (one register with two counters
for the high and low periods of the clock) is not implemented, as there
are no users and there is no common implementation which supports this
kind of clock -- the new implementation would be unused and could not
get verified, so it shall wait until there is demand

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/include/asm/mpc5121.h            |    7 +-
 arch/powerpc/platforms/512x/clock-commonclk.c |  339 +++++++++++++++++++++----
 include/dt-bindings/clock/mpc512x-clock.h     |    9 +-
 3 files changed, 309 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index 887d3d6133e3..4a69cd1d5041 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -37,7 +37,12 @@ struct mpc512x_ccm {
 	u32	cccr;	/* CFM Clock Control Register */
 	u32	dccr;	/* DIU Clock Control Register */
 	u32	mscan_ccr[4];	/* MSCAN Clock Control Registers */
-	u8	res[0x98]; /* Reserved */
+	u32	out_ccr[4];	/* OUT CLK Configure Registers */
+	u32	rsv0[2];	/* Reserved */
+	u32	scfr3;		/* System Clock Frequency Register 3 */
+	u32	rsv1[3];	/* Reserved */
+	u32	spll_lock_cnt;	/* System PLL Lock Counter */
+	u8	res[0x6c];	/* Reserved */
 };
 
 /*
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b5190fcb81bb..af8d50d58af5 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -36,7 +36,8 @@ enum {
 #define NR_PSCS			12
 #define NR_MSCANS		4
 #define NR_SPDIFS		1
-#define NR_MCLKS		(NR_PSCS + NR_MSCANS + NR_SPDIFS)
+#define NR_OUTCLK		4
+#define NR_MCLKS		(NR_PSCS + NR_MSCANS + NR_SPDIFS + NR_OUTCLK)
 
 /* extend the public set of clocks by adding internal slots for management */
 enum {
@@ -46,11 +47,11 @@ enum {
 	MPC512x_CLK_DDR,
 	MPC512x_CLK_MEM,
 	MPC512x_CLK_IIM,
-	MPC512x_CLK_SDHC_2,
 	/* intermediates in div+gate combos or fractional dividers */
 	MPC512x_CLK_DDR_UG,
 	MPC512x_CLK_SDHC_x4,
 	MPC512x_CLK_SDHC_UG,
+	MPC512x_CLK_SDHC2_UG,
 	MPC512x_CLK_DIU_x4,
 	MPC512x_CLK_DIU_UG,
 	MPC512x_CLK_MBX_BUS_UG,
@@ -76,6 +77,144 @@ static struct clk_onecell_data clk_data;
 static struct mpc512x_ccm __iomem *clkregs;
 static DEFINE_SPINLOCK(clklock);
 
+/* SoC variants {{{ */
+
+/*
+ * tell SoC variants apart as they are rather similar yet not identical,
+ * cache the result in an enum to not repeatedly run the expensive OF test
+ *
+ * MPC5123 is an MPC5121 without the MBX graphics accelerator
+ *
+ * MPC5125 has many more differences: no MBX, no AXE, no VIU, no SPDIF,
+ * no PATA, no SATA, no PCI, two FECs (of different compatibility name),
+ * only 10 PSCs (of different compatibility name), two SDHCs, different
+ * NFC IP block, output clocks, system PLL status query, different CPMF
+ * interpretation, no CFM, different fourth PSC/CAN mux0 input -- yet
+ * those differences can get folded into this clock provider support
+ * code and don't warrant a separate highly redundant implementation
+ */
+
+static enum soc_type {
+	MPC512x_SOC_MPC5121,
+	MPC512x_SOC_MPC5123,
+	MPC512x_SOC_MPC5125,
+} soc;
+
+static void mpc512x_clk_determine_soc(void)
+{
+	if (of_machine_is_compatible("fsl,mpc5121")) {
+		soc = MPC512x_SOC_MPC5121;
+		return;
+	}
+	if (of_machine_is_compatible("fsl,mpc5123")) {
+		soc = MPC512x_SOC_MPC5123;
+		return;
+	}
+	if (of_machine_is_compatible("fsl,mpc5125")) {
+		soc = MPC512x_SOC_MPC5125;
+		return;
+	}
+}
+
+static bool soc_has_mbx(void)
+{
+	if (soc == MPC512x_SOC_MPC5121)
+		return true;
+	return false;
+}
+
+static bool soc_has_axe(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_viu(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_spdif(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_pata(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_sata(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_pci(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return false;
+	return true;
+}
+
+static bool soc_has_fec2(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+static int soc_max_pscnum(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return 10;
+	return 12;
+}
+
+static bool soc_has_sdhc2(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+static bool soc_has_nfc_5125(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+static bool soc_has_outclk(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+static bool soc_has_cpmf_0_bypass(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+static bool soc_has_mclk_mux0_canin(void)
+{
+	if (soc == MPC512x_SOC_MPC5125)
+		return true;
+	return false;
+}
+
+/* }}} SoC variants */
 /* common clk API wrappers {{{ */
 
 /* convenience wrappers around the common clk API */
@@ -196,12 +335,23 @@ static int get_sys_div_x2(void)
  */
 static int get_cpmf_mult_x2(void)
 {
-	static int cpmf_to_mult[] = {
+	static int cpmf_to_mult_x36[] = {
+		/* 0b000 is "times 36" */
 		72, 2, 2, 3, 4, 5, 6, 7,
 	};
+	static int cpmf_to_mult_0by[] = {
+		/* 0b000 is "bypass" */
+		2, 2, 2, 3, 4, 5, 6, 7,
+	};
+
+	int *cpmf_to_mult;
 	int cpmf;
 
 	cpmf = get_bit_field(&clkregs->spmr, 16, 4);
+	if (soc_has_cpmf_0_bypass())
+		cpmf_to_mult = cpmf_to_mult_0by;
+	else
+		cpmf_to_mult = cpmf_to_mult_x36;
 	return cpmf_to_mult[cpmf];
 }
 
@@ -347,14 +497,19 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
  * it's the very data type dictated by <linux/clk-provider.h>,
  * "fixing" this warning will break compilation
  */
-static const char *parent_names_mux0[] = {
+static const char *parent_names_mux0_spdif[] = {
 	"sys", "ref", "psc-mclk-in", "spdif-tx",
 };
 
+static const char *parent_names_mux0_canin[] = {
+	"sys", "ref", "psc-mclk-in", "can-clk-in",
+};
+
 enum mclk_type {
 	MCLK_TYPE_PSC,
 	MCLK_TYPE_MSCAN,
 	MCLK_TYPE_SPDIF,
+	MCLK_TYPE_OUTCLK,
 };
 
 struct mclk_setup_data {
@@ -394,6 +549,15 @@ struct mclk_setup_data {
 	"spdif_mclk", \
 }
 
+#define MCLK_SETUP_DATA_OUTCLK(id) { \
+	MCLK_TYPE_OUTCLK, 0, \
+	"out" #id "-mux0", \
+	"out" #id "-en0", \
+	"out" #id "_mclk_div", \
+	{ "out" #id "_mclk_div", "dummy", }, \
+	"out" #id "_clk", \
+}
+
 static struct mclk_setup_data mclk_psc_data[] = {
 	MCLK_SETUP_DATA_PSC(0),
 	MCLK_SETUP_DATA_PSC(1),
@@ -420,6 +584,13 @@ static struct mclk_setup_data mclk_spdif_data[] = {
 	MCLK_SETUP_DATA_SPDIF,
 };
 
+static struct mclk_setup_data mclk_outclk_data[] = {
+	MCLK_SETUP_DATA_OUTCLK(0),
+	MCLK_SETUP_DATA_OUTCLK(1),
+	MCLK_SETUP_DATA_OUTCLK(2),
+	MCLK_SETUP_DATA_OUTCLK(3),
+};
+
 /* setup the MCLK clock subtree of an individual PSC/MSCAN/SPDIF */
 static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 {
@@ -447,6 +618,13 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 			     + (NR_PSCS + NR_MSCANS) * MCLK_MAX_IDX;
 		mccr_reg = &clkregs->spccr;
 		break;
+	case MCLK_TYPE_OUTCLK:
+		clks_idx_pub = MPC512x_CLK_OUT0_CLK + idx;
+		clks_idx_int = MPC512x_CLK_MCLKS_FIRST
+			     + (NR_PSCS + NR_MSCANS + NR_SPDIFS + idx)
+			     * MCLK_MAX_IDX;
+		mccr_reg = &clkregs->out_ccr[idx];
+		break;
 	default:
 		return;
 	}
@@ -495,7 +673,10 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 	 */
 	clks[clks_idx_int + MCLK_IDX_MUX0] = mpc512x_clk_muxed(
 			entry->name_mux0,
-			&parent_names_mux0[0], ARRAY_SIZE(parent_names_mux0),
+			soc_has_mclk_mux0_canin()
+				? &parent_names_mux0_canin[0]
+				: &parent_names_mux0_spdif[0],
+			ARRAY_SIZE(parent_names_mux0_spdif),
 			mccr_reg, 14, 2);
 	clks[clks_idx_int + MCLK_IDX_EN0] = mpc512x_clk_gated(
 			entry->name_en0, entry->name_mux0,
@@ -576,6 +757,12 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	clks[MPC512x_CLK_SDHC_UG] = mpc512x_clk_divider("sdhc-ug", "sdhc-x4", 0,
 							&clkregs->scfr2, 1, 7,
 							CLK_DIVIDER_ONE_BASED);
+	if (soc_has_sdhc2()) {
+		clks[MPC512x_CLK_SDHC2_UG] = mpc512x_clk_divider(
+				"sdhc2-ug", "sdhc-x4", 0, &clkregs->scfr2,
+				9, 7, CLK_DIVIDER_ONE_BASED);
+	}
+
 	clks[MPC512x_CLK_DIU_x4] = mpc512x_clk_factor("diu-x4", "csb", 4, 1);
 	clks[MPC512x_CLK_DIU_UG] = mpc512x_clk_divider("diu-ug", "diu-x4", 0,
 						       &clkregs->scfr1, 0, 8,
@@ -592,19 +779,32 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	div = 2;	/* compensate for the fractional factor */
 	clks[MPC512x_CLK_E300] = mpc512x_clk_factor("e300", "csb", mul, div);
 
-	clks[MPC512x_CLK_MBX_BUS_UG] = mpc512x_clk_factor("mbx-bus-ug", "csb",
-							  1, 2);
-	clks[MPC512x_CLK_MBX_UG] = mpc512x_clk_divtable("mbx-ug", "mbx-bus-ug",
-							&clkregs->scfr1, 14, 3,
-							divtab_1234);
-	clks[MPC512x_CLK_MBX_3D_UG] = mpc512x_clk_factor("mbx-3d-ug", "mbx-ug",
-							 1, 1);
-	clks[MPC512x_CLK_PCI_UG] = mpc512x_clk_divtable("pci-ug", "csb",
-							&clkregs->scfr1, 20, 3,
-							divtab_2346);
-	clks[MPC512x_CLK_NFC_UG] = mpc512x_clk_divtable("nfc-ug", "ips",
-							&clkregs->scfr1, 8, 3,
-							divtab_1234);
+	if (soc_has_mbx()) {
+		clks[MPC512x_CLK_MBX_BUS_UG] = mpc512x_clk_factor(
+				"mbx-bus-ug", "csb", 1, 2);
+		clks[MPC512x_CLK_MBX_UG] = mpc512x_clk_divtable(
+				"mbx-ug", "mbx-bus-ug", &clkregs->scfr1,
+				14, 3, divtab_1234);
+		clks[MPC512x_CLK_MBX_3D_UG] = mpc512x_clk_factor(
+				"mbx-3d-ug", "mbx-ug", 1, 1);
+	}
+	if (soc_has_pci()) {
+		clks[MPC512x_CLK_PCI_UG] = mpc512x_clk_divtable(
+				"pci-ug", "csb", &clkregs->scfr1,
+				20, 3, divtab_2346);
+	}
+	if (soc_has_nfc_5125()) {
+		/*
+		 * XXX TODO implement 5125 NFC clock setup logic,
+		 * with high/low period counters in clkregs->scfr3,
+		 * currently there are no users so it's ENOIMPL
+		 */
+		clks[MPC512x_CLK_NFC_UG] = ERR_PTR(-ENOTSUPP);
+	} else {
+		clks[MPC512x_CLK_NFC_UG] = mpc512x_clk_divtable(
+				"nfc-ug", "ips", &clkregs->scfr1,
+				8, 3, divtab_1234);
+	}
 	clks[MPC512x_CLK_LPC_UG] = mpc512x_clk_divtable("lpc-ug", "ips",
 							&clkregs->scfr1, 11, 3,
 							divtab_1234);
@@ -613,10 +813,12 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 						  &clkregs->sccr1, 30);
 	clks[MPC512x_CLK_NFC] = mpc512x_clk_gated("nfc", "nfc-ug",
 						  &clkregs->sccr1, 29);
-	clks[MPC512x_CLK_PATA] = mpc512x_clk_gated("pata", "ips",
-						   &clkregs->sccr1, 28);
+	if (soc_has_pata()) {
+		clks[MPC512x_CLK_PATA] = mpc512x_clk_gated(
+				"pata", "ips", &clkregs->sccr1, 28);
+	}
 	/* for PSCs there is a "registers" gate and a bitrate MCLK subtree */
-	for (mclk_idx = 0; mclk_idx < ARRAY_SIZE(mclk_psc_data); mclk_idx++) {
+	for (mclk_idx = 0; mclk_idx < soc_max_pscnum(); mclk_idx++) {
 		char name[12];
 		snprintf(name, sizeof(name), "psc%d", mclk_idx);
 		clks[MPC512x_CLK_PSC0 + mclk_idx] = mpc512x_clk_gated(
@@ -625,19 +827,29 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	}
 	clks[MPC512x_CLK_PSC_FIFO] = mpc512x_clk_gated("psc-fifo", "ips",
 						       &clkregs->sccr1, 15);
-	clks[MPC512x_CLK_SATA] = mpc512x_clk_gated("sata", "ips",
-						   &clkregs->sccr1, 14);
+	if (soc_has_sata()) {
+		clks[MPC512x_CLK_SATA] = mpc512x_clk_gated(
+				"sata", "ips", &clkregs->sccr1, 14);
+	}
 	clks[MPC512x_CLK_FEC] = mpc512x_clk_gated("fec", "ips",
 						  &clkregs->sccr1, 13);
-	clks[MPC512x_CLK_PCI] = mpc512x_clk_gated("pci", "pci-ug",
-						  &clkregs->sccr1, 11);
+	if (soc_has_pci()) {
+		clks[MPC512x_CLK_PCI] = mpc512x_clk_gated(
+				"pci", "pci-ug", &clkregs->sccr1, 11);
+	}
 	clks[MPC512x_CLK_DDR] = mpc512x_clk_gated("ddr", "ddr-ug",
 						  &clkregs->sccr1, 10);
+	if (soc_has_fec2()) {
+		clks[MPC512x_CLK_FEC2] = mpc512x_clk_gated(
+				"fec2", "ips", &clkregs->sccr1, 9);
+	}
 
 	clks[MPC512x_CLK_DIU] = mpc512x_clk_gated("diu", "diu-ug",
 						  &clkregs->sccr2, 31);
-	clks[MPC512x_CLK_AXE] = mpc512x_clk_gated("axe", "csb",
-						  &clkregs->sccr2, 30);
+	if (soc_has_axe()) {
+		clks[MPC512x_CLK_AXE] = mpc512x_clk_gated(
+				"axe", "csb", &clkregs->sccr2, 30);
+	}
 	clks[MPC512x_CLK_MEM] = mpc512x_clk_gated("mem", "ips",
 						  &clkregs->sccr2, 29);
 	clks[MPC512x_CLK_USB1] = mpc512x_clk_gated("usb1", "csb",
@@ -654,21 +866,35 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	clks[MPC512x_CLK_SDHC] = mpc512x_clk_gated("sdhc", "sdhc-ug",
 						   &clkregs->sccr2, 24);
 	/* there is only one SPDIF component, which shares MCLK support code */
-	clks[MPC512x_CLK_SPDIF] = mpc512x_clk_gated("spdif", "ips",
-						    &clkregs->sccr2, 23);
-	mpc512x_clk_setup_mclk(&mclk_spdif_data[0], 0);
-	clks[MPC512x_CLK_MBX_BUS] = mpc512x_clk_gated("mbx-bus", "mbx-bus-ug",
-						      &clkregs->sccr2, 22);
-	clks[MPC512x_CLK_MBX] = mpc512x_clk_gated("mbx", "mbx-ug",
-						  &clkregs->sccr2, 21);
-	clks[MPC512x_CLK_MBX_3D] = mpc512x_clk_gated("mbx-3d", "mbx-3d-ug",
-						     &clkregs->sccr2, 20);
+	if (soc_has_spdif()) {
+		clks[MPC512x_CLK_SPDIF] = mpc512x_clk_gated(
+				"spdif", "ips", &clkregs->sccr2, 23);
+		mpc512x_clk_setup_mclk(&mclk_spdif_data[0], 0);
+	}
+	if (soc_has_mbx()) {
+		clks[MPC512x_CLK_MBX_BUS] = mpc512x_clk_gated(
+				"mbx-bus", "mbx-bus-ug", &clkregs->sccr2, 22);
+		clks[MPC512x_CLK_MBX] = mpc512x_clk_gated(
+				"mbx", "mbx-ug", &clkregs->sccr2, 21);
+		clks[MPC512x_CLK_MBX_3D] = mpc512x_clk_gated(
+				"mbx-3d", "mbx-3d-ug", &clkregs->sccr2, 20);
+	}
 	clks[MPC512x_CLK_IIM] = mpc512x_clk_gated("iim", "csb",
 						  &clkregs->sccr2, 19);
-	clks[MPC512x_CLK_VIU] = mpc512x_clk_gated("viu", "csb",
-						  &clkregs->sccr2, 18);
-	clks[MPC512x_CLK_SDHC_2] = mpc512x_clk_gated("sdhc-2", "sdhc-ug",
-						     &clkregs->sccr2, 17);
+	if (soc_has_viu()) {
+		clks[MPC512x_CLK_VIU] = mpc512x_clk_gated(
+				"viu", "csb", &clkregs->sccr2, 18);
+	}
+	if (soc_has_sdhc2()) {
+		clks[MPC512x_CLK_SDHC2] = mpc512x_clk_gated(
+				"sdhc-2", "sdhc2-ug", &clkregs->sccr2, 17);
+	}
+
+	if (soc_has_outclk()) {
+		size_t idx;	/* used as mclk_idx, just to trim line length */
+		for (idx = 0; idx < ARRAY_SIZE(mclk_outclk_data); idx++)
+			mpc512x_clk_setup_mclk(&mclk_outclk_data[idx], idx);
+	}
 
 	/*
 	 * externally provided clocks (when implemented in hardware,
@@ -678,10 +904,18 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	if (!freq)
 		freq = 25000000;
 	clks[MPC512x_CLK_PSC_MCLK_IN] = mpc512x_clk_fixed("psc_mclk_in", freq);
-	freq = get_freq_from_dt("spdif_tx_in");
-	clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_tx_in", freq);
-	freq = get_freq_from_dt("spdif_rx_in");
-	clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed("spdif_rx_in", freq);
+	if (soc_has_mclk_mux0_canin()) {
+		freq = get_freq_from_dt("can_clk_in");
+		clks[MPC512x_CLK_CAN_CLK_IN] = mpc512x_clk_fixed(
+				"can_clk_in", freq);
+	} else {
+		freq = get_freq_from_dt("spdif_tx_in");
+		clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed(
+				"spdif_tx_in", freq);
+		freq = get_freq_from_dt("spdif_rx_in");
+		clks[MPC512x_CLK_SPDIF_TX_IN] = mpc512x_clk_fixed(
+				"spdif_rx_in", freq);
+	}
 
 	/* fixed frequency for AC97, always 24.567MHz */
 	clks[MPC512x_CLK_AC97] = mpc512x_clk_fixed("ac97", 24567000);
@@ -884,6 +1118,20 @@ static void mpc5121_clk_provide_backwards_compat(void)
 		NODE_PREP;
 		NODE_CHK("per", clks[MPC512x_CLK_FEC], 0, FEC);
 	}
+	/*
+	 * MPC5125 has two FECs: FEC1 at 0x2800, FEC2 at 0x4800;
+	 * the clock items don't "form an array" since FEC2 was
+	 * added only later and was not allowed to shift all other
+	 * clock item indices, so the numbers aren't adjacent
+	 */
+	FOR_NODES("fsl,mpc5125-fec") {
+		NODE_PREP;
+		if (res.start & 0x4000)
+			idx = MPC512x_CLK_FEC2;
+		else
+			idx = MPC512x_CLK_FEC;
+		NODE_CHK("per", clks[idx], 0, FEC);
+	}
 
 	FOR_NODES("fsl,mpc5121-usb2-dr") {
 		NODE_PREP;
@@ -933,6 +1181,9 @@ int __init mpc5121_clk_init(void)
 	clkregs = of_iomap(clk_np, 0);
 	WARN_ON(!clkregs);
 
+	/* determine the SoC variant we run on */
+	mpc512x_clk_determine_soc();
+
 	/* invalidate all not yet registered clock slots */
 	mpc512x_clk_preset_data();
 
diff --git a/include/dt-bindings/clock/mpc512x-clock.h b/include/dt-bindings/clock/mpc512x-clock.h
index 9e81b3b99a32..4f94919327ce 100644
--- a/include/dt-bindings/clock/mpc512x-clock.h
+++ b/include/dt-bindings/clock/mpc512x-clock.h
@@ -63,7 +63,14 @@
 #define MPC512x_CLK_PSC9		55
 #define MPC512x_CLK_PSC10		56
 #define MPC512x_CLK_PSC11		57
+#define MPC512x_CLK_SDHC2		58
+#define MPC512x_CLK_FEC2		59
+#define MPC512x_CLK_OUT0_CLK		60
+#define MPC512x_CLK_OUT1_CLK		61
+#define MPC512x_CLK_OUT2_CLK		62
+#define MPC512x_CLK_OUT3_CLK		63
+#define MPC512x_CLK_CAN_CLK_IN		64
 
-#define MPC512x_CLK_LAST_PUBLIC		57
+#define MPC512x_CLK_LAST_PUBLIC		64
 
 #endif
-- 
1.7.10.4
