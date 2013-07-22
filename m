Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A2212C0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:15:50 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v3 09/31] powerpc/fsl-pci: improve clock API use
Date: Mon, 22 Jul 2013 14:14:36 +0200
Message-Id: <1374495298-22019-10-git-send-email-gsi@denx.de>
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make the Freescale PCI driver get, prepare and enable the PCI clock
during probe()

clock lookup is non-fatal as not all platforms may provide clock specs
in their device tree, but failure to enable specified clocks are fatal

the driver appears to not have a remove() routine, so no reference to
the clock is kept during use, and the clock isn't released (the devm
approach will put the clock, but it won't get disabled or unprepared)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/sysdev/fsl_pci.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..5e2f411 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -17,6 +17,8 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -926,12 +928,33 @@ void fsl_pci_assign_primary(void)
 
 static int fsl_pci_probe(struct platform_device *pdev)
 {
+	struct clk *clk;
 	int ret;
 	struct device_node *node;
 #ifdef CONFIG_SWIOTLB
 	struct pci_controller *hose;
 #endif
 
+	/*
+	 * clock lookup is non-fatal since the driver is shared among
+	 * platforms and not all of them provide clocks specs in their
+	 * device tree, but failure to enable a specified clock is
+	 * considered fatal
+	 */
+	clk = devm_clk_get(&pdev->dev, "per");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(dev, "Could not enable peripheral clock\n");
+			devm_clk_put(&pdev->dev, clk);
+			return ret;
+		}
+		/*
+		 * TODO where to store the 'clk' reference?  there appears
+		 * to be no remove() routine which undoes what probe() does
+		 */
+	}
+
 	node = pdev->dev.of_node;
 	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
 
-- 
1.7.10.4
