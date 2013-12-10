Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0E782C0311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:52:22 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v1 1/4] powerpc/512x: clk: minor comment updates
Date: Tue, 10 Dec 2013 14:11:34 +0100
Message-Id: <1386681097-14126-2-git-send-email-gsi@denx.de>
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

adjust (expand on or move) a few comments,
add markers for easier navigation around helpers

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 189be4a4cb42..079eb1137260 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -76,6 +76,8 @@ static struct clk_onecell_data clk_data;
 static struct mpc512x_ccm __iomem *clkregs;
 static DEFINE_SPINLOCK(clklock);
 
+/* common clk API wrappers {{{ */
+
 /* convenience wrappers around the common clk API */
 static inline struct clk *mpc512x_clk_fixed(const char *name, int rate)
 {
@@ -139,6 +141,8 @@ static inline struct clk *mpc512x_clk_muxed(const char *name,
 				reg, pos, len, muxflags, &clklock);
 }
 
+/* }}} common clk API wrappers */
+
 /* helper to isolate a bit field from a register */
 static inline int get_bit_field(uint32_t __iomem *reg, uint8_t pos, uint8_t len)
 {
@@ -308,6 +312,8 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
 	}
 }
 
+/* MCLK helpers {{{ */
+
 /*
  * helper code for the MCLK subtree setup
  *
@@ -338,8 +344,8 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
 
 /*
  * note that this declaration raises a checkpatch warning, but
- * it's the very data type which <linux/clk-provider.h> expects,
- * making this declaration pass checkpatch will break compilation
+ * it's the very data type dictated by <linux/clk-provider.h>,
+ * "fixing" this warning will break compilation
  */
 static const char *parent_names_mux0[] = {
 	"sys", "ref", "psc-mclk-in", "spdif-tx",
@@ -512,6 +518,8 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 	}
 }
 
+/* }}} MCLK helpers */
+
 static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 {
 	int sys_mul, sys_div, ips_div;
@@ -549,8 +557,8 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	clks[MPC512x_CLK_IPS] = mpc512x_clk_divtable("ips", "csb",
 						     &clkregs->scfr1, 23, 3,
 						     divtab_2346);
-
 	/* now setup anything below SYS and CSB and IPS */
+
 	clks[MPC512x_CLK_DDR_UG] = mpc512x_clk_factor("ddr-ug", "sys", 1, 2);
 	clks[MPC512x_CLK_SDHC_x4] = mpc512x_clk_factor("sdhc-x4", "csb", 4, 1);
 	clks[MPC512x_CLK_SDHC_UG] = mpc512x_clk_divider("sdhc-ug", "sdhc-x4", 0,
-- 
1.7.10.4
