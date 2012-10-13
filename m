Return-Path: <devendra.aaru@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A35682C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2012 06:05:49 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so3866259pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2012 12:05:47 -0700 (PDT)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/9] powerpc: 83xx: use module_i2c_driver macro
Date: Sat, 13 Oct 2012 15:05:42 -0400
Message-Id: <1350155142-1629-1-git-send-email-devendra.aaru@gmail.com>
Cc: Devendra Naga <devendra.aaru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

replace the module init and exit calls containing the
i2c_add_driver and i2c_del_driver with the module_i2c_driver
macro as it does the same things as the code that is removed

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---

 Not compile tested, because i dont have a ppc cross toolchain
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index ef6537b..d27477b 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -232,18 +232,7 @@ static struct i2c_driver mcu_driver = {
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
1.7.1
