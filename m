Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7594B67E6F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:30:42 +1100 (EST)
Date: Wed, 15 Nov 2006 12:29:35 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Adapt ucc_geth driver to use new of_platform_device support
Message-Id: <20061115122935.5fece249.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Include of_platform header, and use
new of_[un]register_platform_driver() fns.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---

please consider for 2.6.20

 drivers/net/ucc_geth.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index b378880..1f05511 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -30,7 +30,7 @@ #include <linux/fsl_devices.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 
-#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -4301,12 +4301,12 @@ static int __init ucc_geth_init(void)
 		memcpy(&(ugeth_info[i]), &ugeth_primary_info,
 		       sizeof(ugeth_primary_info));
 
-	return of_register_driver(&ucc_geth_driver);
+	return of_register_platform_driver(&ucc_geth_driver);
 }
 
 static void __exit ucc_geth_exit(void)
 {
-	of_unregister_driver(&ucc_geth_driver);
+	of_unregister_platform_driver(&ucc_geth_driver);
 }
 
 module_init(ucc_geth_init);
-- 
1.4.2.3
