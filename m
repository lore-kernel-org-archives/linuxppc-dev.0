Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 210F6B7D1C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 23:21:30 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/mpc5121: move PSC FIFO memory init to platform
	code
Date: Fri, 30 Apr 2010 15:21:26 +0200
Message-Id: <1272633687-6935-2-git-send-email-agust@denx.de>
In-Reply-To: <1272633687-6935-1-git-send-email-agust@denx.de>
References: <1272633687-6935-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detelv Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since PSC could also be used in other modes than UART mode
we move PSC FIFO memory initialization from serial driver to
common platform code. The initialized FIFO memory slices may
not overlap, so the most easy way would be to configure them
all at once at init time for all PSC devices. This is now done
by this patch.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |   78 ++++++++++++++++++++++++++
 drivers/serial/mpc52xx_uart.c                |   69 -----------------------
 2 files changed, 78 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 796080c..a717466 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -26,6 +26,7 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/mpc5121.h>
+#include <asm/mpc52xx_psc.h>
 
 #include "mpc512x.h"
 
@@ -369,9 +370,86 @@ void __init mpc512x_declare_of_platform_devices(void)
 	}
 }
 
+#define DEFAULT_FIFO_SIZE 16
+
+static unsigned int __init get_fifo_size(struct device_node *np,
+					 char *prop_name)
+{
+	const unsigned int *fp;
+
+	fp = of_get_property(np, prop_name, NULL);
+	if (fp)
+		return *fp;
+
+	pr_warning("no %s property in %s node, defaulting to %d\n",
+		   prop_name, np->full_name, DEFAULT_FIFO_SIZE);
+
+	return DEFAULT_FIFO_SIZE;
+}
+
+#define FIFOC(_base) ((struct mpc512x_psc_fifo __iomem *) \
+		    ((u32)(_base) + sizeof(struct mpc52xx_psc)))
+
+/* Init PSC FIFO space for TX and RX slices */
+void __init mpc512x_psc_fifo_init(void)
+{
+	struct device_node *np;
+	void __iomem *psc;
+	unsigned int tx_fifo_size;
+	unsigned int rx_fifo_size;
+	int fifobase = 0; /* current fifo address in 32 bit words */
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+		tx_fifo_size = get_fifo_size(np, "fsl,tx-fifo-size");
+		rx_fifo_size = get_fifo_size(np, "fsl,rx-fifo-size");
+
+		/* size in register is in 4 byte units */
+		tx_fifo_size /= 4;
+		rx_fifo_size /= 4;
+		if (!tx_fifo_size)
+			tx_fifo_size = 1;
+		if (!rx_fifo_size)
+			rx_fifo_size = 1;
+
+		psc = of_iomap(np, 0);
+		if (!psc) {
+			pr_err("%s: Can't map %s device\n",
+				__func__, np->full_name);
+			continue;
+		}
+
+		/* FIFO space is 4KiB, check if requested size is available */
+		if ((fifobase + tx_fifo_size + rx_fifo_size) > 0x1000) {
+			pr_err("%s: no fifo space available for %s\n",
+				__func__, np->full_name);
+			iounmap(psc);
+			/*
+			 * chances are that another device requests less
+			 * fifo space, so we continue.
+			 */
+			continue;
+		}
+
+		/* set tx and rx fifo size registers */
+		out_be32(&FIFOC(psc)->txsz, (fifobase << 16) | tx_fifo_size);
+		fifobase += tx_fifo_size;
+		out_be32(&FIFOC(psc)->rxsz, (fifobase << 16) | rx_fifo_size);
+		fifobase += rx_fifo_size;
+
+		/* reset and enable the slices */
+		out_be32(&FIFOC(psc)->txcmd, 0x80);
+		out_be32(&FIFOC(psc)->txcmd, 0x01);
+		out_be32(&FIFOC(psc)->rxcmd, 0x80);
+		out_be32(&FIFOC(psc)->rxcmd, 0x01);
+
+		iounmap(psc);
+	}
+}
+
 void __init mpc512x_init(void)
 {
 	mpc512x_declare_of_platform_devices();
 	mpc5121_clk_init();
 	mpc512x_restart_init();
+	mpc512x_psc_fifo_init();
 }
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3119fdd..843e7fb 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -430,34 +430,10 @@ static unsigned long mpc512x_getuartclk(void *p)
 	return mpc5xxx_get_bus_frequency(p);
 }
 
-#define DEFAULT_FIFO_SIZE 16
-
-static unsigned int __init get_fifo_size(struct device_node *np,
-					 char *fifo_name)
-{
-	const unsigned int *fp;
-
-	fp = of_get_property(np, fifo_name, NULL);
-	if (fp)
-		return *fp;
-
-	pr_warning("no %s property in %s node, defaulting to %d\n",
-		   fifo_name, np->full_name, DEFAULT_FIFO_SIZE);
-
-	return DEFAULT_FIFO_SIZE;
-}
-
-#define FIFOC(_base) ((struct mpc512x_psc_fifo __iomem *) \
-		    ((u32)(_base) + sizeof(struct mpc52xx_psc)))
-
 /* Init PSC FIFO Controller */
 static int __init mpc512x_psc_fifoc_init(void)
 {
 	struct device_node *np;
-	void __iomem *psc;
-	unsigned int tx_fifo_size;
-	unsigned int rx_fifo_size;
-	int fifobase = 0; /* current fifo address in 32 bit words */
 
 	np = of_find_compatible_node(NULL, NULL,
 				     "fsl,mpc5121-psc-fifo");
@@ -480,51 +456,6 @@ static int __init mpc512x_psc_fifoc_init(void)
 		return -ENODEV;
 	}
 
-	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc-uart") {
-		tx_fifo_size = get_fifo_size(np, "fsl,tx-fifo-size");
-		rx_fifo_size = get_fifo_size(np, "fsl,rx-fifo-size");
-
-		/* size in register is in 4 byte units */
-		tx_fifo_size /= 4;
-		rx_fifo_size /= 4;
-		if (!tx_fifo_size)
-			tx_fifo_size = 1;
-		if (!rx_fifo_size)
-			rx_fifo_size = 1;
-
-		psc = of_iomap(np, 0);
-		if (!psc) {
-			pr_err("%s: Can't map %s device\n",
-				__func__, np->full_name);
-			continue;
-		}
-
-		/* FIFO space is 4KiB, check if requested size is available */
-		if ((fifobase + tx_fifo_size + rx_fifo_size) > 0x1000) {
-			pr_err("%s: no fifo space available for %s\n",
-				__func__, np->full_name);
-			iounmap(psc);
-			/*
-			 * chances are that another device requests less
-			 * fifo space, so we continue.
-			 */
-			continue;
-		}
-		/* set tx and rx fifo size registers */
-		out_be32(&FIFOC(psc)->txsz, (fifobase << 16) | tx_fifo_size);
-		fifobase += tx_fifo_size;
-		out_be32(&FIFOC(psc)->rxsz, (fifobase << 16) | rx_fifo_size);
-		fifobase += rx_fifo_size;
-
-		/* reset and enable the slices */
-		out_be32(&FIFOC(psc)->txcmd, 0x80);
-		out_be32(&FIFOC(psc)->txcmd, 0x01);
-		out_be32(&FIFOC(psc)->rxcmd, 0x80);
-		out_be32(&FIFOC(psc)->rxcmd, 0x01);
-
-		iounmap(psc);
-	}
-
 	return 0;
 }
 
-- 
1.6.3.3
