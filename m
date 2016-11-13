Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tH9d44F1qzDvWr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:00:07 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Scott Wood
 <oss@buserror.net>, Yangbo Lu <yangbo.lu@nxp.com>, Arnd Bergmann
 <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] soc: fsl: make guts driver explicitly non-modular
Date: Sun, 13 Nov 2016 14:03:02 -0500
Message-ID: <20161113190302.18099-4-paul.gortmaker@windriver.com>
In-Reply-To: <20161113190302.18099-1-paul.gortmaker@windriver.com>
References: <20161113190302.18099-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig currently controlling compilation of this code is:

drivers/soc/fsl/Kconfig:config FSL_GUTS
drivers/soc/fsl/Kconfig:        bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since the code was already not using module_init, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Scott Wood <oss@buserror.net>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/soc/fsl/guts.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 0ac88263c2d7..b4d2fd9263b2 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -11,7 +11,7 @@
 
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_fdt.h>
 #include <linux/sys_soc.h>
 #include <linux/of_address.h>
@@ -180,12 +180,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fsl_guts_remove(struct platform_device *dev)
-{
-	soc_device_unregister(soc_dev);
-	return 0;
-}
-
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for Freescale QorIQ SOCs.
@@ -212,15 +206,14 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls2080a-dcfg", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
 
 static struct platform_driver fsl_guts_driver = {
 	.driver = {
 		.name = "fsl-guts",
+		.suppress_bind_attrs = true,
 		.of_match_table = fsl_guts_of_match,
 	},
 	.probe = fsl_guts_probe,
-	.remove = fsl_guts_remove,
 };
 
 static int __init fsl_guts_init(void)
@@ -228,9 +221,3 @@ static int __init fsl_guts_init(void)
 	return platform_driver_register(&fsl_guts_driver);
 }
 core_initcall(fsl_guts_init);
-
-static void __exit fsl_guts_exit(void)
-{
-	platform_driver_unregister(&fsl_guts_driver);
-}
-module_exit(fsl_guts_exit);
-- 
2.10.1
