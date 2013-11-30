Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F2A952C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:51:57 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 01/17] powerpc/fsl-pci: improve clock API use
Date: Sat, 30 Nov 2013 23:51:21 +0100
Message-Id: <1385851897-23475-2-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make the Freescale PCI driver get, prepare and enable the PCI clock
during probe(); the clock gets put upon device shutdown by the devm
approach

clock lookup is non-fatal as not all platforms may provide clock specs
in their device tree or implement a device tree based clock provider,
but failure to enable clocks after successful lookup is fatal

the driver appears to not have a remove() routine, so no reference to
the clock is kept during use, and the clock isn't released (the devm
approach will put the clock, but it won't get disabled or unprepared)

the 85xx/86xx platforms go through the probe() routine, where clock
lookup occurs and the clock gets acquired if one was specified; the
512x/83xx platforms don't pass through probe() but instead directly call
the add_bridge() routine at a point in time where the clock provider has
not been setup yet even if the platform implements one -- add comments
to the code paths as a reminder for the potential need of a workaround
in the platform's clock driver, and to keep awareness if code should get
re-arranged or moved

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/sysdev/fsl_pci.c |   52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61df8aba..bee8011d6bd7 100644
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
@@ -756,6 +758,32 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int primary;
 
+	/*
+	 * 85xx/86xx platforms take the path through the probe() routine
+	 * as one would expect, PCI related clocks get acquired there if
+	 * specified
+	 *
+	 * 83xx/512x _don't_ pass through probe(), this add_bridge()
+	 * routine instead is called from within .setup_arch() at a
+	 * point in time where clock providers haven't been setup yet;
+	 * so clocks cannot get acquired here -- lookup would always
+	 * fail even on those platforms which implement the provider
+	 *
+	 * there is no counterpart for add_bridge() just like there is
+	 * no remove() counterpart for probe(), so in either case the
+	 * PCI related clock won't get released, and all of the
+	 * 512x/83xx/85xx/86xx platforms behave in identical ways
+	 *
+	 * this comment is here to "keep the balance" against the
+	 * probe() routine, and as a reminder to acquire clocks if the
+	 * add_bridge() call should move to some later point in time
+	 *
+	 * until then clock providers are expected to work around the
+	 * peripheral driver's not acquiring the PCI clock on those
+	 * platforms where clock providers exist, while nothing needs to
+	 * be done for those platforms without a clock provider
+	 */
+
 	is_mpc83xx_pci = 1;
 
 	if (!of_device_is_available(dev)) {
@@ -1087,9 +1115,33 @@ void fsl_pci_assign_primary(void)
 
 static int fsl_pci_probe(struct platform_device *pdev)
 {
+	struct clk *clk;
 	int ret;
 	struct device_node *node;
 
+	/*
+	 * clock lookup is non-fatal since the driver is shared among
+	 * platforms and not all of them provide clocks specs in their
+	 * device tree, but failure to enable a specified clock is
+	 * considered fatal
+	 *
+	 * note that only the 85xx and 86xx platforms pass through this
+	 * probe() routine, while 83xx and 512x directly invoke the
+	 * mpc83xx_add_bridge() routine from within .setup_arch() code
+	 */
+	clk = devm_clk_get(&pdev->dev, "ipg");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Could not enable PCI clock\n");
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
