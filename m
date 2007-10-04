Return-Path: <benh@ozlabs.org>
To: <bluesmoke-devel@lists.sourceforge.net>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Oct 2007 15:40:43 +1000
Subject: [PATCH 2/4] powerpc: Add Cell memory controller register defs and
	expose it
In-Reply-To: <1191476442.154524.519055590678.qpush@grosgo>
Message-Id: <20071004054104.C996CDDE05@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds definitions for the Cell memory controller registers (at
least some of them) for use by the EDAC driver for ECC error reporting.

It also expose the said MIC as a platform device that can be used
by the EDAC driver to match on.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/cell/setup.c |   10 +++++++
 include/asm-powerpc/cell-regs.h     |   48 ++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

Index: linux-work/include/asm-powerpc/cell-regs.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cell-regs.h	2007-10-04 15:15:23.000000000 +1000
+++ linux-work/include/asm-powerpc/cell-regs.h	2007-10-04 15:33:06.000000000 +1000
@@ -244,16 +244,60 @@ struct cbe_mic_tm_regs {
 	u64	slow_fast_timer_0;				/* 0x0090 */
 	u64	slow_next_timer_0;				/* 0x0098 */
 
-	u8	pad_0x00a0_0x01c0[0x01c0 - 0x0a0];		/* 0x00a0 */
+	u8	pad_0x00a0_0x00f8[0x00f8 - 0x00a0];		/* 0x00a0 */
+	u64    	mic_df_ecc_address_0;				/* 0x00f8 */
+
+	u8	pad_0x0100_0x01b8[0x01b8 - 0x0100];		/* 0x0100 */
+	u64    	mic_df_ecc_address_1;				/* 0x01b8 */
 
 	u64	mic_ctl_cnfg_1;					/* 0x01c0 */
 #define CBE_MIC_DISABLE_PWR_SAV_1	0x8000000000000000LL
+
 	u64	pad_0x01c8;					/* 0x01c8 */
 
 	u64	slow_fast_timer_1;				/* 0x01d0 */
 	u64	slow_next_timer_1;				/* 0x01d8 */
 
-	u8	pad_0x01e0_0x1000[0x1000 - 0x01e0];		/* 0x01e0 */
+	u8	pad_0x01e0_0x0208[0x0208 - 0x01e0];		/* 0x01e0 */
+	u64	mic_exc;					/* 0x0208 */
+#define CBE_MIC_EXC_BLOCK_SCRUB		0x0800000000000000ULL
+#define CBE_MIC_EXC_FAST_SCRUB		0x0100000000000000ULL
+
+	u64	mic_mnt_cfg;					/* 0x0210 */
+#define CBE_MIC_MNT_CFG_CHAN_0_POP	0x0002000000000000ULL
+#define CBE_MIC_MNT_CFG_CHAN_1_POP	0x0004000000000000ULL
+
+	u64	mic_df_config;					/* 0x0218 */
+#define CBE_MIC_ECC_DISABLE_0		0x4000000000000000ULL
+#define CBE_MIC_ECC_REP_SINGLE_0	0x2000000000000000ULL
+#define CBE_MIC_ECC_DISABLE_1		0x0080000000000000ULL
+#define CBE_MIC_ECC_REP_SINGLE_1	0x0040000000000000ULL
+
+	u8	pad_0x0220_0x0230[0x0230 - 0x0220];		/* 0x0220 */
+	u64	mic_fir;					/* 0x0230 */
+#define CBE_MIC_FIR_ECC_SINGLE_0_ERR	0x0200000000000000ULL
+#define CBE_MIC_FIR_ECC_MULTI_0_ERR	0x0100000000000000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_1_ERR	0x0080000000000000ULL
+#define CBE_MIC_FIR_ECC_MULTI_1_ERR	0x0040000000000000ULL
+#define CBE_MIC_FIR_ECC_ERR_MASK	0xffff000000000000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_0_CTE	0x0000020000000000ULL
+#define CBE_MIC_FIR_ECC_MULTI_0_CTE	0x0000010000000000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_1_CTE	0x0000008000000000ULL
+#define CBE_MIC_FIR_ECC_MULTI_1_CTE	0x0000004000000000ULL
+#define CBE_MIC_FIR_ECC_CTE_MASK	0x0000ffff00000000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_0_RESET	0x0000000002000000ULL
+#define CBE_MIC_FIR_ECC_MULTI_0_RESET	0x0000000001000000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_1_RESET	0x0000000000800000ULL
+#define CBE_MIC_FIR_ECC_MULTI_1_RESET	0x0000000000400000ULL
+#define CBE_MIC_FIR_ECC_RESET_MASK	0x00000000ffff0000ULL
+#define CBE_MIC_FIR_ECC_SINGLE_0_SET	0x0000000000000200ULL
+#define CBE_MIC_FIR_ECC_MULTI_0_SET	0x0000000000000100ULL
+#define CBE_MIC_FIR_ECC_SINGLE_1_SET	0x0000000000000080ULL
+#define CBE_MIC_FIR_ECC_MULTI_1_SET	0x0000000000000040ULL
+#define CBE_MIC_FIR_ECC_SET_MASK	0x000000000000ffffULL
+	u64	mic_fir_debug;					/* 0x0238 */
+
+	u8	pad_0x0240_0x1000[0x1000 - 0x0240];		/* 0x0240 */
 };
 
 extern struct cbe_mic_tm_regs __iomem *cbe_get_mic_tm_regs(struct device_node *np);
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2007-10-04 15:15:23.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2007-10-04 15:33:06.000000000 +1000
@@ -83,12 +83,22 @@ static void cell_progress(char *s, unsig
 
 static int __init cell_publish_devices(void)
 {
+	int node;
+
 	if (!machine_is(cell))
 		return 0;
 
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, NULL, NULL);
 
+	/* There is no device for the MIC memory controller, thus we create
+	 * a platform device for it to attach the EDAC driver to.
+	 */
+	for_each_online_node(node) {
+		if (cbe_get_cpu_mic_tm_regs(cbe_node_to_cpu(node)) == NULL)
+			continue;
+		platform_device_register_simple("cbe-mic", node, NULL, 0);
+	}
 	return 0;
 }
 device_initcall(cell_publish_devices);
