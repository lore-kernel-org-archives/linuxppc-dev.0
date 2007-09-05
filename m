Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE67CDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:28:06 +1000 (EST)
Date: Wed, 5 Sep 2007 14:27:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/9] 8xx: Add pin and clock setting functions.
Message-ID: <20070905192757.GB32398@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These let board code set up pins and clocks without having to
put magic numbers directly into the registers.

The clock function is mostly duplicated from the cpm2 version;
hopefully this stuff can be merged at some point.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/commproc.c |  201 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/commproc.h |   49 ++++++++++
 2 files changed, 250 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index af26659..7497745 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -405,3 +405,204 @@ uint cpm_dpram_phys(u8 *addr)
 	return (dpram_pbase + (uint)(addr - (u8 __force *)dpram_vbase));
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
+struct cpm_ioport16 {
+	__be16 dir, par, sor, dat, intr;
+	__be16 res[3];
+};
+
+struct cpm_ioport32 {
+	__be32 dir, par, sor;
+};
+
+static void cpm1_set_pin32(int port, int pin, int flags)
+{
+	struct cpm_ioport32 __iomem *iop;
+	pin = 1 << (31 - pin);
+
+	if (port == CPM_PORTB)
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pbdir;
+	else
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pedir;
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits32(&iop->dir, pin);
+	else
+		clrbits32(&iop->dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits32(&iop->par, pin);
+	else
+		clrbits32(&iop->par, pin);
+
+	if (port == CPM_PORTE) {
+		if (flags & CPM_PIN_SECONDARY)
+			setbits32(&iop->sor, pin);
+		else
+			clrbits32(&iop->sor, pin);
+
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+		else
+			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+	}
+}
+
+static void cpm1_set_pin16(int port, int pin, int flags)
+{
+	struct cpm_ioport16 __iomem *iop =
+		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
+
+	pin = 1 << (15 - pin);
+
+	if (port != 0)
+		iop += port - 1;
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits16(&iop->dir, pin);
+	else
+		clrbits16(&iop->dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits16(&iop->par, pin);
+	else
+		clrbits16(&iop->par, pin);
+
+	if (port == CPM_PORTC) {
+		if (flags & CPM_PIN_SECONDARY)
+			setbits16(&iop->sor, pin);
+		else
+			clrbits16(&iop->sor, pin);
+	}
+}
+
+void cpm1_set_pin(enum cpm_port port, int pin, int flags)
+{
+	if (port == CPM_PORTB || port == CPM_PORTE)
+		cpm1_set_pin32(port, pin, flags);
+	else
+		cpm1_set_pin16(port, pin, flags);
+}
+
+int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
+{
+	int shift;
+	int i, bits = 0;
+	u32 __iomem *reg;
+	u32 mask = 7;
+
+	u8 clk_map[][3] = {
+		{CPM_CLK_SCC1, CPM_BRG1, 0},
+		{CPM_CLK_SCC1, CPM_BRG2, 1},
+		{CPM_CLK_SCC1, CPM_BRG3, 2},
+		{CPM_CLK_SCC1, CPM_BRG4, 3},
+		{CPM_CLK_SCC1, CPM_CLK1, 4},
+		{CPM_CLK_SCC1, CPM_CLK2, 5},
+		{CPM_CLK_SCC1, CPM_CLK3, 6},
+		{CPM_CLK_SCC1, CPM_CLK4, 7},
+
+		{CPM_CLK_SCC2, CPM_BRG1, 0},
+		{CPM_CLK_SCC2, CPM_BRG2, 1},
+		{CPM_CLK_SCC2, CPM_BRG3, 2},
+		{CPM_CLK_SCC2, CPM_BRG4, 3},
+		{CPM_CLK_SCC2, CPM_CLK1, 4},
+		{CPM_CLK_SCC2, CPM_CLK2, 5},
+		{CPM_CLK_SCC2, CPM_CLK3, 6},
+		{CPM_CLK_SCC2, CPM_CLK4, 7},
+
+		{CPM_CLK_SCC3, CPM_BRG1, 0},
+		{CPM_CLK_SCC3, CPM_BRG2, 1},
+		{CPM_CLK_SCC3, CPM_BRG3, 2},
+		{CPM_CLK_SCC3, CPM_BRG4, 3},
+		{CPM_CLK_SCC3, CPM_CLK5, 4},
+		{CPM_CLK_SCC3, CPM_CLK6, 5},
+		{CPM_CLK_SCC3, CPM_CLK7, 6},
+		{CPM_CLK_SCC3, CPM_CLK8, 7},
+
+		{CPM_CLK_SCC4, CPM_BRG1, 0},
+		{CPM_CLK_SCC4, CPM_BRG2, 1},
+		{CPM_CLK_SCC4, CPM_BRG3, 2},
+		{CPM_CLK_SCC4, CPM_BRG4, 3},
+		{CPM_CLK_SCC4, CPM_CLK5, 4},
+		{CPM_CLK_SCC4, CPM_CLK6, 5},
+		{CPM_CLK_SCC4, CPM_CLK7, 6},
+		{CPM_CLK_SCC4, CPM_CLK8, 7},
+
+		{CPM_CLK_SMC1, CPM_BRG1, 0},
+		{CPM_CLK_SMC1, CPM_BRG2, 1},
+		{CPM_CLK_SMC1, CPM_BRG3, 2},
+		{CPM_CLK_SMC1, CPM_BRG4, 3},
+		{CPM_CLK_SMC1, CPM_CLK1, 4},
+		{CPM_CLK_SMC1, CPM_CLK2, 5},
+		{CPM_CLK_SMC1, CPM_CLK3, 6},
+		{CPM_CLK_SMC1, CPM_CLK4, 7},
+
+		{CPM_CLK_SMC2, CPM_BRG1, 0},
+		{CPM_CLK_SMC2, CPM_BRG2, 1},
+		{CPM_CLK_SMC2, CPM_BRG3, 2},
+		{CPM_CLK_SMC2, CPM_BRG4, 3},
+		{CPM_CLK_SMC2, CPM_CLK5, 4},
+		{CPM_CLK_SMC2, CPM_CLK6, 5},
+		{CPM_CLK_SMC2, CPM_CLK7, 6},
+		{CPM_CLK_SMC2, CPM_CLK8, 7},
+	};
+
+	switch (target) {
+	case CPM_CLK_SCC1:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 0;
+		break;
+
+	case CPM_CLK_SCC2:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 8;
+		break;
+
+	case CPM_CLK_SCC3:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 16;
+		break;
+
+	case CPM_CLK_SCC4:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 24;
+		break;
+
+	case CPM_CLK_SMC1:
+		reg = &mpc8xx_immr->im_cpm.cp_simode;
+		shift = 12;
+		break;
+
+	case CPM_CLK_SMC2:
+		reg = &mpc8xx_immr->im_cpm.cp_simode;
+		shift = 28;
+		break;
+
+	default:
+		printk(KERN_ERR "cpm1_clock_setup: invalid clock target\n");
+		return -EINVAL;
+	}
+
+	if (reg == &mpc8xx_immr->im_cpm.cp_sicr && mode == CPM_CLK_RX)
+		shift += 3;
+
+	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
+		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
+			bits = clk_map[i][2];
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(clk_map)) {
+		printk(KERN_ERR "cpm1_clock_setup: invalid clock combination\n");
+		return -EINVAL;
+	}
+
+	bits <<= shift;
+	mask <<= shift;
+	out_be32(reg, (in_be32(reg) & ~mask) | bits);
+
+	return 0;
+}
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 86fcf26..5dec324 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -691,4 +691,53 @@ extern void cpm_free_handler(int vec);
 
 #define IMAP_ADDR		(get_immrbase())
 
+#define CPM_PIN_INPUT     0
+#define CPM_PIN_OUTPUT    1
+#define CPM_PIN_PRIMARY   0
+#define CPM_PIN_SECONDARY 2
+#define CPM_PIN_GPIO      4
+#define CPM_PIN_OPENDRAIN 8
+
+enum cpm_port {
+	CPM_PORTA,
+	CPM_PORTB,
+	CPM_PORTC,
+	CPM_PORTD,
+	CPM_PORTE,
+};
+
+void cpm1_set_pin(enum cpm_port port, int pin, int flags);
+
+enum cpm_clk_dir {
+	CPM_CLK_RX,
+	CPM_CLK_TX,
+	CPM_CLK_RTX
+};
+
+enum cpm_clk_target {
+	CPM_CLK_SCC1,
+	CPM_CLK_SCC2,
+	CPM_CLK_SCC3,
+	CPM_CLK_SCC4,
+	CPM_CLK_SMC1,
+	CPM_CLK_SMC2,
+};
+
+enum cpm_clk {
+	CPM_BRG1,	/* Baud Rate Generator  1 */
+	CPM_BRG2,	/* Baud Rate Generator  2 */
+	CPM_BRG3,	/* Baud Rate Generator  3 */
+	CPM_BRG4,	/* Baud Rate Generator  4 */
+	CPM_CLK1,	/* Clock  1 */
+	CPM_CLK2,	/* Clock  2 */
+	CPM_CLK3,	/* Clock  3 */
+	CPM_CLK4,	/* Clock  4 */
+	CPM_CLK5,	/* Clock  5 */
+	CPM_CLK6,	/* Clock  6 */
+	CPM_CLK7,	/* Clock  7 */
+	CPM_CLK8,	/* Clock  8 */
+};
+
+int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode);
+
 #endif /* __CPM_8XX__ */
-- 
1.5.3
