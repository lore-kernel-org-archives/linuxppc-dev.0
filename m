Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A123DDF98
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 08:51:17 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove CS4270 i2c data from fsl_soc.c
Date: Tue, 24 Jun 2008 17:51:07 -0500
Message-Id: <1214347867-12107-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c_devices[] array in fsl_soc.c lists new-style I2C drivers that have
device tree nodes.  The CS4270 driver is not a new-style driver, and won't be
in 2.6.27, so it should not appear in this array.  Its presence in this array
blocks the old-style driver from finding the device.

This patch reverts commit 64f9b5ee17ee7974d7cc58d75221432d86960ba3.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for Kumar's powerpc-next branch.

 arch/powerpc/sysdev/fsl_soc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ca54563..97b9d44 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -433,7 +433,6 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"dallas,ds1340",  "ds1340"},
 	{"stm,m41t00",     "m41t00"},
 	{"dallas,ds1374",  "ds1374"},
-	{"cirrus,cs4270",  "cs4270"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
-- 
1.5.5
