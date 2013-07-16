Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 22/24] powerpc/fsl-pci: OF clock lookup,
 prepare before enable
Date: Tue, 16 Jul 2013 10:45:38 +0200
Message-Id: <1373964341-25228-2-git-send-email-gsi@denx.de>
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
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

device tree based clock lookup, must prepare clocks before enabling
them, error check in the clock setup

this change implements non-fatal clock lookup for compatibility with
platforms that don't provide OF clock specs, but failure to enable a
specified clock is considered fatal

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/sysdev/fsl_pci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..cb2ed92 100644
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
@@ -741,6 +743,7 @@ err0:
 
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
+	struct clk *clk;
 	int ret;
 	int len;
 	struct pci_controller *hose;
@@ -758,6 +761,18 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	}
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
+	/* non-fatal OF clock lookup, but fatal when a clock
+	 * was specified yet could not get enabled */
+	clk = of_clk_get_by_name(dev, "per");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		clk_put(clk);
+		if (ret) {
+			pr_err("Could not enable peripheral clock\n");
+			return ret;
+		}
+	}
+
 	/* Fetch host bridge registers address */
 	if (of_address_to_resource(dev, 0, &rsrc_reg)) {
 		printk(KERN_WARNING "Can't get pci register base!\n");
-- 
1.7.10.4
