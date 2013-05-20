Return-Path: <peterhuewe@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by ozlabs.org (Postfix) with ESMTP id 1AAD92C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 05:34:05 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.28]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MEYeV-1UgvcB46sj-00Fn9c for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 21:34:03 +0200
From: Peter Huewe <peterhuewe@gmx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/platforms/83xx/mcu_mpc8349emitx: Use
 module_i2c_driver to register driver
Date: Mon, 20 May 2013 21:39:09 +0200
Message-Id: <1369078749-3197-1-git-send-email-peterhuewe@gmx.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Removing some boilerplate by using module_i2c_driver instead of calling
register and unregister in the otherwise empty init/exit functions

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 624cb51..4b8ea95 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -231,18 +231,7 @@ static struct i2c_driver mcu_driver = {
 	.id_table = mcu_ids,
 };
 
-static int __init mcu_init(void)
-{
-	return i2c_add_driver(&mcu_driver);
-}
-module_init(mcu_init);
-
-static void __exit mcu_exit(void)
-{
-	i2c_del_driver(&mcu_driver);
-}
-module_exit(mcu_exit);
-
+module_i2c_driver(mcu_driver);
 MODULE_DESCRIPTION("Power Management and GPIO expander driver for "
 		   "MPC8349E-mITX-compatible MCU");
 MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
-- 
1.8.1.5
