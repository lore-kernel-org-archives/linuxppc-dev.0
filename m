Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 08DC8DDEC4
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 15:36:29 +1100 (EST)
Date: Sun, 2 Dec 2007 22:40:16 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Fix module information for gpio-mdio
Message-ID: <20071203044016.GA24068@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Fix module information for gpio-mdio
    
Fix up the module information for gpio-mdio, it wouldn't load
because of lacking license, and wouldn't auto-load because of missing
MODULE_DEVICE_TABLE.
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index b029804..04a8686 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -318,6 +318,7 @@ static struct of_device_id gpio_mdio_match[] =
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, gpio_mdio_match);
 
 static struct of_platform_driver gpio_mdio_driver =
 {
@@ -356,3 +357,7 @@ void gpio_mdio_exit(void)
 		iounmap(gpio_regs);
 }
 module_exit(gpio_mdio_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Olof Johansson <olof@lixom.net>");
+MODULE_DESCRIPTION("Driver for MDIO over GPIO on PA Semi PWRficient-based boards");
