Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id 41B40B7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 10:13:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] Fixes for MPC512x PSC
Date: Thu, 22 Apr 2010 19:13:21 -0500
Message-ID: <181804936ABC2349BE503168465576460E8723C5@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will apply on the mpc512x-v2.6.33-devel branch of the DENX git
repository.  This is all mostly based
on what was in the Freescale LTIB release from the Freescale website.

On a somewhat unrelated note, does anyone know if the Freescale LTIB
drivers have been merged into any newer
kernel versions?  In particular, I could not find a branch that has
drivers for the newer NAND Flash controller
that was in the LTIB version.


 In clock.c replaced clk_enable with mpc5121_clk_enable as clk_functions
is not yet set.
 Added initialization of the FIFO address and size registers based on
device tree.
 Removed port-number property from mpc5121ads device tree as the driver
doesn't use it.
 Made sure PSC clocks are enabled early for console.
 Made sure interrupt is requested with IRQF_SHARED as they share the
FIFO irq.
 Moved initialization of CSR to mpc52xx_uart_set_termios so it is done
for the MPC512x
 and also so it is done early in the console setup.

---
 arch/powerpc/boot/dts/mpc5121ads.dts         |    3 +-
 arch/powerpc/platforms/512x/clock.c          |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c    |    1 +
 arch/powerpc/platforms/512x/mpc512x.h        |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c |   80
++++++++++++++++++++++++++
 drivers/serial/mpc52xx_uart.c                |    7 +-
 6 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts
b/arch/powerpc/boot/dts/mpc5121ads.dts
index d2b2db7..bdaf534 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -325,6 +325,7 @@
 			interrupt-parent =3D < &ipic >;
 		};
=20
+		// UART port numbers are enumerated in the order they
occur
 		// 512x PSCs are not 52xx PSC compatible
 		// PSC3 serial port A aka ttyPSC0
 		serial@11300 {
@@ -332,7 +333,6 @@
 			compatible =3D "fsl,mpc5121-psc-uart",
"fsl,mpc5121-psc";
 			// Logical port assignment needed until driver
 			// learns to use aliases
-			port-number =3D <0>;
 			cell-index =3D <3>;
 			reg =3D <0x11300 0x100>;
 			interrupts =3D <40 0x8>;
@@ -347,7 +347,6 @@
 			compatible =3D "fsl,mpc5121-psc-uart",
"fsl,mpc5121-psc";
 			// Logical port assignment needed until driver
 			// learns to use aliases
-			port-number =3D <1>;
 			cell-index =3D <4>;
 			reg =3D <0x11400 0x100>;
 			interrupts =3D <40 0x8>;
diff --git a/arch/powerpc/platforms/512x/clock.c
b/arch/powerpc/platforms/512x/clock.c
index 8733143..d32c83f 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -681,7 +681,7 @@ static void psc_clks_init(void)
 				psc_calc_rate(clk, pscnum, np);
 			sprintf(clk->name, "psc%d_mclk", pscnum);
 			clk_register(clk);
-			clk_enable(clk);
+			mpc5121_clk_enable(clk);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c
b/arch/powerpc/platforms/512x/mpc5121_ads.c
index aa4d5a8..44a0a51 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -64,6 +64,7 @@ static int __init mpc5121_ads_probe(void)
 void __init mpc5121_ads_init_early(void)
 {
 	mpc512x_init_diu();
+	mpc5121_psc_early_init();
 }
=20
 define_machine(mpc5121_ads) {
diff --git a/arch/powerpc/platforms/512x/mpc512x.h
b/arch/powerpc/platforms/512x/mpc512x.h
index 1cfe9d5..fb69e3f 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -21,3 +21,4 @@ extern void __init mpc512x_init_diu(void);
 extern void __init mpc512x_setup_diu(void);
 extern struct fsl_diu_shared_fb diu_shared_fb;
 #endif				/* __MPC512X_H__ */
+extern void __init mpc5121_psc_early_init(void);
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 65b0a5d..1d74046 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -61,6 +61,86 @@ void mpc512x_restart(char *cmd)
 		;
 }
=20
+#define DEFAULT_FIFO_SIZE 16
+
+static unsigned int get_fifo_size(struct device_node *np, int psc_num,
char *fifo_name)
+{
+	const unsigned int *fp;
+
+	fp =3D of_get_property(np, fifo_name, NULL);
+	if (fp) {
+		/* make sure has at least 1 byte */
+		return *fp ? *fp : 1;
+	}
+
+	printk(KERN_WARNING "no %s property for psc%d defaulting to
%d\n",
+		fifo_name, psc_num, DEFAULT_FIFO_SIZE);
+	return DEFAULT_FIFO_SIZE;
+}
+
+static void __init mpc5121_psc_lowlevel_clock_init(void)
+{
+	struct device_node *np;
+	const u32 *cell_index;
+	void __iomem *clockctl;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clock");
+	clockctl =3D of_iomap(np, 0);
+	of_node_put(np);
+
+	if (clockctl) {
+		for_each_compatible_node(np, NULL,
"fsl,mpc5121-psc-uart") {
+			cell_index =3D of_get_property(np, "cell-index",
NULL);
+			if (cell_index) {
+				setbits32(clockctl+4, 0x08000000 >>
*cell_index);
+			}
+		}
+	}
+	iounmap(clockctl);
+}
+
+static void __init mpc5121_psc_fifo_init(void)
+{
+	struct device_node *np;
+	const u32 *cell_index;
+	int fifobase =3D 0; /* current fifo address in 32 bit words */
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+		cell_index =3D of_get_property(np, "cell-index", NULL);
+		if (cell_index) {
+			int psc_num =3D *cell_index;
+			unsigned int tx_fifo_size;
+			unsigned int rx_fifo_size;
+			void __iomem *psc;
+
+			tx_fifo_size =3D get_fifo_size(np, psc_num,
"tx-fifo-size");
+			rx_fifo_size =3D get_fifo_size(np, psc_num,
"rx-fifo-size");
+
+			/* size in register is in 4 byte words */
+			tx_fifo_size =3D (tx_fifo_size + 3)/4;
+			rx_fifo_size =3D (rx_fifo_size + 3)/4;
+
+			psc =3D of_iomap(np, 0);
+
+			/* tx fifo size register is at 0x9c and rx at
0xdc */
+			out_be32(psc + 0x9c, (fifobase << 16) |
tx_fifo_size);
+			fifobase +=3D tx_fifo_size;
+			out_be32(psc + 0xdc, (fifobase << 16) |
rx_fifo_size);
+			fifobase +=3D rx_fifo_size;
+
+			iounmap(psc);
+		}
+	}
+}
+
+/* Early PSC initialization that may be
+ * needed before console_init is called */
+void __init mpc5121_psc_early_init(void)
+{
+	mpc5121_psc_lowlevel_clock_init();
+	mpc5121_psc_fifo_init();
+}
+
=20
 struct fsl_diu_shared_fb {
 	char		gamma[0x300];	/* 32-bit aligned! */
diff --git a/drivers/serial/mpc52xx_uart.c
b/drivers/serial/mpc52xx_uart.c
index 7ce9e9f..d0b1d8f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -154,9 +154,6 @@ static void mpc52xx_psc_fifo_init(struct uart_port
*port)
 	struct mpc52xx_psc __iomem *psc =3D PSC(port);
 	struct mpc52xx_psc_fifo __iomem *fifo =3D FIFO_52xx(port);
=20
-	/* /32 prescaler */
-	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
-
 	out_8(&fifo->rfcntl, 0x00);
 	out_be16(&fifo->rfalarm, 0x1ff);
 	out_8(&fifo->tfcntl, 0x07);
@@ -521,7 +518,7 @@ mpc52xx_uart_startup(struct uart_port *port)
=20
 	/* Request IRQ */
 	ret =3D request_irq(port->irq, mpc52xx_uart_int,
-		IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
+		IRQF_SAMPLE_RANDOM | IRQF_SHARED,
 		"mpc52xx_psc_uart", port);
 	if (ret)
 		return ret;
@@ -637,6 +634,8 @@ mpc52xx_uart_set_termios(struct uart_port *port,
struct ktermios *new,
 	out_8(&psc->mode, mr2);
 	out_8(&psc->ctur, ctr >> 8);
 	out_8(&psc->ctlr, ctr & 0xff);
+	/* /32 prescaler */
+	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00);
=20
 	if (UART_ENABLE_MS(port, new->c_cflag))
 		mpc52xx_uart_enable_ms(port);
--=20
1.5.6.5
