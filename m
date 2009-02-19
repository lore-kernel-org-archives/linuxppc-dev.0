Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C2A5CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:02:26 +1100 (EST)
Date: Thu, 19 Feb 2009 19:02:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Do not configure or probe disabled FSL DR
	USB controllers
Message-ID: <20090219160223.GA2095@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Liu Dave <DaveLiu@freescale.com>, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On MPC837X CPUs Dual-Role USB isn't always available (for example DR
USB pins can be muxed away to eSDHC).

U-Boot adds status = "disabled" property into the DR USB nodes to
indicate that we must not try to configure or probe Dual-Role USB,
otherwise we'll break eSDHC support on targets with MPC837X CPUs.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/usb.c |    3 ++-
 arch/powerpc/sysdev/fsl_soc.c     |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index cc99c28..11e1fac 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -14,6 +14,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -210,7 +211,7 @@ int mpc837x_usb_cfg(void)
 	int ret = 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 	prop = of_get_property(np, "phy_type", NULL);
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 18e49ef..afe8dbc 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
@@ -328,6 +329,9 @@ static int __init fsl_usb_of_init(void)
 		struct fsl_usb2_platform_data usb_data;
 		const unsigned char *prop = NULL;
 
+		if (!of_device_is_available(np))
+			continue;
+
 		memset(&r, 0, sizeof(r));
 		memset(&usb_data, 0, sizeof(usb_data));
 
-- 
1.5.6.5
