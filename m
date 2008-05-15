Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05EDBDDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 08:05:07 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, jochen@scram.de
Subject: [PATCH] Add warning for unrecognized I2C nodes in the device tree
Date: Thu, 15 May 2008 17:04:57 -0500
Message-Id: <1210889097-32368-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update of_find_i2c_driver in fsl_soc.c to display a warning message if an
I2C node in the device tree isn't found in the i2c_devices[] array.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3a7054e..a38c364 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -448,6 +448,10 @@ static int __init of_find_i2c_driver(struct device_node *node,
 			return -ENOMEM;
 		return 0;
 	}
+
+	pr_warning("fsl_soc.c: unrecognized i2c node %s\n",
+		(const char *) of_get_property(node, "compatible", NULL));
+
 	return -ENODEV;
 }
 
-- 
1.5.5
