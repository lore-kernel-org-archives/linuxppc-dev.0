Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EDCEBDDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 04:47:09 +1100 (EST)
Date: Fri, 23 Nov 2007 20:52:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [RFC][PATCH 0/3] OF-platform PATA driver
Message-ID: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here is the PATA Platform driver using OF infrastructure.

Mostly it's just a wrapper around a bit modified pata_platform
driver.

Patches are well split for the easier review:

First one factors out platform_device specific bits and modifies
pata_platform to be a library-alike driver (with platform_device
default binding).

Second patch is OF-driver itself which is using pata_platform
"library".

Third patch is PowerPC specific, but I'm still Cc'ing linux-ide,
just to show how we're using it.


As an alternative approach we can use plain pata_platform
driver, but I'm not sure how Linux OF bindings' ideologists will
or will not like it.

So, these patches are strongly Request For Comments. Feel free
to train your nitpicking skills ;-), and/or vote for the option
you most pleased about (or suggest another?).


Thanks.

---
Down here is "alternative approach".

Probably board-neutral version may be placed somewhere in
the drivers/of/...? But who will call it: board file, or
device_initcall for all boards?

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 150fafb..4caa90d 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/of_platform.h>
+#include <linux/pata_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -102,6 +103,78 @@ static int __init mpc834x_itx_probe(void)
         return of_flat_dt_is_compatible(root, "MPC834xMITX");
 }
 
+static int __init mpc834x_itx_pata_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+
+	if (!machine_is(mpc834x_itx))
+		return 0;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, NULL, "pata-platform"));
+	     i++) {
+		int ret;
+		struct resource res[3];
+		const u32 *ioport_shift;
+		struct platform_device *pdev;
+		struct pata_platform_info pdata = {};
+
+		memset(res, 0, sizeof(res));
+
+		ret = of_address_to_resource(np, 0, &res[0]);
+		if (ret) {
+			printk(KERN_ERR "pata.%d: unable to get IO address "
+			       "from the device tree\n", i);
+			goto err0;
+		}
+
+		ret = of_address_to_resource(np, 1, &res[1]);
+		if (ret) {
+			printk(KERN_ERR "pata.%d: unable to get CTL address "
+			       "from the device tree\n", i);
+			goto err0;
+		}
+
+		ret = of_irq_to_resource(np, 0, &res[2]);
+		if (ret == NO_IRQ) {
+			printk(KERN_ERR "pata.%d: no IRQ\n", i);
+			goto err0;
+		}
+
+		ioport_shift = of_get_property(np, "ioport-shift", NULL);
+		if (ioport_shift)
+			pdata.ioport_shift = *ioport_shift;
+
+		pdev = platform_device_alloc("pata_platform", i);
+		if (!pdev)
+			goto err0;
+
+		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (ret)
+			goto err1;
+
+		ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+		if (ret)
+			goto err1;
+
+		ret = platform_device_register(pdev);
+		if (ret)
+			goto err1;
+
+		continue;
+err1:
+		printk(KERN_ERR "pata.%d: registration failed\n", i);
+		platform_device_del(pdev); /* will free everything */
+err0:
+		/* Even if some device failed, try others */
+		continue;
+	}
+
+	return 0;
+}
+device_initcall(mpc834x_itx_pata_init);
+
 define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
