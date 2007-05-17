Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E90E5DDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 01:26:49 +1000 (EST)
Date: Thu, 17 May 2007 10:19:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fsl_soc: Pre-allocate i2c bus number and
	pre-register devices.
Message-ID: <20070517151904.GA31862@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bus number is dynamically allocated, used to register devices
with i2c_register_board_info(), and then passed to the i2c-mpc
driver to use with i2c_add_prenumbered_adapter().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This supersedes the "Call of_register_i2c_devices() for	fsl-i2c" patch.

 arch/powerpc/sysdev/fsl_soc.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index cad1757..4ff0daf 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -26,6 +26,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/i2c.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -319,7 +320,13 @@ static int __init fsl_i2c_of_init(void)
 
 		of_irq_to_resource(np, 0, &r[1]);
 
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
+		ret = i2c_alloc_bus_number();
+		if (ret < 0)
+			goto err;
+
+		of_register_i2c_devices(np, ret);
+
+		i2c_dev = platform_device_register_simple("fsl-i2c", ret, r, 2);
 		if (IS_ERR(i2c_dev)) {
 			ret = PTR_ERR(i2c_dev);
 			goto err;
-- 
1.5.0.3
