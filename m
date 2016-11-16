Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tJqjR0WfszDvgn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 03:39:37 +1100 (AEDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Yangbo Lu <yangbo.lu@nxp.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] soc: fsl: fix section mismatch build warnings
Date: Wed, 16 Nov 2016 16:39:27 +0000
Message-Id: <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
References: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We get the following warning with the driver is compiled in:

WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

With CONFIG_DEBUG_SECTION_MISMATCH enabled, the details are reported:

WARNING: vmlinux.o(.text+0x55d014): Section mismatch in reference from the
function fsl_guts_probe() to the function
.init.text:of_flat_dt_get_machine_name()
The function fsl_guts_probe() references
the function __init of_flat_dt_get_machine_name().
This is often because fsl_guts_probe lacks a __init
annotation or the annotation of of_flat_dt_get_machine_name is wrong.

This patch stashes the machine name during fsl_guts_init initcall to
fix the above warnings.

Cc: Scott Wood <oss@buserror.net>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/fsl/guts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 885409d84eb2..5513a2b3448f 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -31,6 +31,7 @@ struct fsl_soc_die_attr {
 static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
 static struct soc_device *soc_dev;
+static const char *machine;
 
 
 /* SoC die attribute definition for QorIQ platform */
@@ -135,7 +136,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
-	const char *machine;
 	u32 svr;
 
 	/* Initialize guts */
@@ -151,7 +151,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		return PTR_ERR(guts->regs);
 
 	/* Register soc device */
-	machine = of_flat_dt_get_machine_name();
 	if (machine)
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
 
@@ -223,6 +222,7 @@ static struct platform_driver fsl_guts_driver = {
 
 static int __init fsl_guts_init(void)
 {
+	machine = of_flat_dt_get_machine_name();
 	return platform_driver_register(&fsl_guts_driver);
 }
 core_initcall(fsl_guts_init);
-- 
2.7.4
