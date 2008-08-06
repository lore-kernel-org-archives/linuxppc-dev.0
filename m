Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05697DDF80
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:07 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m766o2KE028175
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:50:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIa000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:50:01 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
Date: Wed,  6 Aug 2008 15:04:44 +0800
Message-Id: <1218006285-27138-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006285-27138-4-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc836x_mds.dts     |   15 ++++++-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   19 ++++++++-
 arch/powerpc/platforms/83xx/mpc83xx.h     |    1 +
 arch/powerpc/platforms/83xx/usb.c         |   67 +++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index a3b76a7..596377b 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -235,6 +235,17 @@
 					0  2  1  0  1  0>; /* MDC */
 			};
 
+			pio_usb: usb_pin@01 {
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq */
+					1  2  1  0  3  0        /* USBOE  */
+					1  3  1  0  3  0        /* USBTP  */
+					1  8  1  0  1  0        /* USBTN  */
+					1 10  2  0  3  0        /* USBRXD */
+					1  9  2  1  3  0        /* USBRP  */
+					1 11  2  1  3  0>;      /* USBRN  */
+			};
+
 		};
 	};
 
@@ -280,11 +291,13 @@
 		};
 
 		usb@6c0 {
-			compatible = "qe_udc";
+			compatible = "fsl,qe_udc";
 			reg = <0x6c0 0x40 0x8b00 0x100>;
 			interrupts = <11>;
 			interrupt-parent = <&qeic>;
 			mode = "slave";
+			usb-clock = <21>;
+			pio-handle = <&pio_usb>;
 		};
 
 		enet0: ucc@2000 {
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 9d46e5b..92afd40 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -93,6 +93,12 @@ static void __init mpc836x_mds_setup_arch(void)
 
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
+
+		np = of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
+		if (np) {
+			par_io_of_config(np);
+			qe_usb_clock_set(np);
+		}
 	}
 
 	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
@@ -127,9 +133,20 @@ static void __init mpc836x_mds_setup_arch(void)
 			iounmap(immap);
 		}
 
-		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
+	if (np != NULL) {
+		/* Set the TESCs run on RGMII mode */
+		bcsr_regs[8] &= ~0xf0;
+		/* Enable the USB Device PHY */
+		bcsr_regs[13] &= ~0x0f;
+		udelay(1000);
+		bcsr_regs[13] |= 0x05;
+		of_node_put(np);
+	}
+	iounmap(bcsr_regs);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 2a7cbab..d025b47 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -63,5 +63,6 @@ extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
+extern int qe_usb_clock_set(struct device_node *np);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index cc99c28..3d04ab5 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
+#include <asm/qe.h>
 
 #include "mpc83xx.h"
 
@@ -240,3 +241,69 @@ int mpc837x_usb_cfg(void)
 	return ret;
 }
 #endif /* CONFIG_PPC_MPC837x */
+
+#ifdef CONFIG_QUICC_ENGINE
+/* QE USB_CLOCK configure functions */
+int qe_usb_clock_set(struct device_node *np)
+{
+	u32 tmpreg = 0;
+	struct qe_mux *qemux = NULL;
+	const int *clock;
+
+	qemux = &qe_immr->qmx;
+
+	clock = of_get_property(np, "usb-clock", NULL);
+	if (!clock)
+		return -EINVAL;
+
+	/* CLK21 -> USBCLK on MPC8360-PB*/
+	tmpreg = in_be32(&qemux->cmxgcr) & ~QE_CMXGCR_USBCS;
+	switch (*clock) {
+	case 21:
+		tmpreg |= 0x8;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 20, 2, 0, 1, 0);  /* PC20 for CLK21 */
+		break;
+	case 19:
+		tmpreg |= 0x7;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 18, 2, 0, 1, 0);  /* PC18 for CLK19 */
+		break;
+	case 17:
+		tmpreg |= 0x6;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 16, 2, 0, 1, 0);  /* PC16 for CLK17 */
+		break;
+	case 13:
+		tmpreg |= 0x5;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 12, 2, 0, 1, 0);  /* PC12 for CLK13 */
+		break;
+	case 9:
+		tmpreg |= 0x4;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 8, 2, 0, 1, 0);  /* PC8 for CLK9 */
+		break;
+	case 7:
+		tmpreg |= 0x3;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 6, 2, 0, 1, 0);  /* PC6 for CLK7 */
+		break;
+	case 5:
+		tmpreg |= 0x2;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 4, 2, 0, 1, 0);  /* PC4 for CLK5 */
+		break;
+	case 3:
+		tmpreg |= 0x1;
+		out_be32(&qemux->cmxgcr, tmpreg);
+		par_io_config_pin(2, 2, 2, 0, 1, 0);  /* PC2 for CLK3 */
+		break;
+	default:
+		printk(KERN_ERR "Unsupport usb-clock input pin\n");
+	}
+
+	return 0;
+}
+#endif
+
-- 
1.5.5.1.248.g4b17
