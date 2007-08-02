Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9182DDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 04:01:26 +1000 (EST)
Date: Thu, 2 Aug 2007 11:04:57 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH v3 2/3] powerpc: create pci err platform device for EDAC on
	mpc85xx
Message-ID: <20070802180457.GA29926@blade.az.mvista.com>
References: <20070726222021.GA10427@blade.az.mvista.com>
	<20070731220749.GB29780@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070731220749.GB29780@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Creating a platform device for the PCI error registers in order for the
mpc85xx EDAC driver to pick up proper resources. This is to prevent the EDAC
driver from monopolizing the of_device and thus preventing future PCI code from
using the PCI of_device(s).

Signed-off-by: Dave Jiang <djiang@mvista.com>

---
Code reworked to setup the platform device as a child of the PCI of_device.
The routine has to be called after device_initcall() due to having to wait
for the of_device to be setup first in order to pick up the parent.

 arch/powerpc/sysdev/fsl_pci.c |   52 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9fb0ce5..a769bbb 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -19,6 +19,8 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -27,6 +29,56 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#ifdef CONFIG_85xx
+/* setting up 85xx PCI error platform device for EDAC consumption */
+static int __init mpc85xx_pcierr_setup(void)
+{
+	struct device_node *np = NULL;
+	struct of_device *of_dev;
+	struct platform_device *pdev;
+	struct resource res[2];
+	int id = 0;
+	int err;
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci") {
+		memset(res, 0, sizeof(struct resource) * 2);
+		if (of_address_to_resource(np, 0, &res[0])) {
+			printk(KERN_WARNING "Can't get pci register base!\n");
+			continue;
+		}
+
+		/* move start to where the error registers are */
+		res[0].start += 0xe00;
+
+		of_irq_to_resource(np, 0, &res[1]);
+
+		of_dev = of_find_device_by_node(np);
+		if (!of_dev)
+			return -ENODEV;
+
+		pdev = platform_device_alloc("mpc85xx_pci_err", id++);
+		if (!pdev)
+			return -ENOMEM;
+
+		err = platform_device_add_resources(pdev, res, 2);
+		if (err)
+			goto error;
+
+		pdev->dev.parent = &of_dev->dev;
+
+		err = platform_device_add(pdev);
+		if (err)
+			goto error;
+	}
+	return 0;
+
+error:
+	platform_device_put(pdev);
+	return err;
+}
+late_initcall(mpc85xx_pcierr_setup);
+#endif
+
 /* atmu setup for fsl pci/pcie controller */
 void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 {
