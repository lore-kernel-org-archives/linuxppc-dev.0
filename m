Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC403DDF31
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 06:09:51 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH][POWERPC] Update fsl_soc to use cell-index property of I2C
	nodes
Date: Mon,  2 Jun 2008 15:09:35 -0500
Message-Id: <1212437375-30927-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, fsl_i2c_of_init() uses the order of the I2C adapter nodes in the
device tree to enumerate the I2C adapters.  Instead, let's check for the
cell-index property and use it if it exists.

This is handy for device drivers that need to identify the I2C adapters by
specific numbers.  The Freescale MPC8610 ASoC V2 sound drivers are an example.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for Kumar's powerpc-next branch.

 arch/powerpc/sysdev/fsl_soc.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 167523e..14616d5 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -496,6 +496,8 @@ static int __init fsl_i2c_of_init(void)
 		struct resource r[2];
 		struct fsl_i2c_platform_data i2c_data;
 		const unsigned char *flags = NULL;
+		int idx;
+		const u32 *iprop;
 
 		memset(&r, 0, sizeof(r));
 		memset(&i2c_data, 0, sizeof(i2c_data));
@@ -506,7 +508,10 @@ static int __init fsl_i2c_of_init(void)
 
 		of_irq_to_resource(np, 0, &r[1]);
 
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
+		iprop = of_get_property(np, "cell-index", NULL);
+		idx = iprop ? *iprop : i;
+
+		i2c_dev = platform_device_register_simple("fsl-i2c", idx, r, 2);
 		if (IS_ERR(i2c_dev)) {
 			ret = PTR_ERR(i2c_dev);
 			goto err;
@@ -528,7 +533,8 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto unreg;
 
-		of_register_i2c_devices(np, i++);
+		of_register_i2c_devices(np, idx);
+		i++;
 	}
 
 	return 0;
-- 
1.5.5
