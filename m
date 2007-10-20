Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C902FDDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 11:57:49 +1000 (EST)
Date: Fri, 19 Oct 2007 21:04:20 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] Fix build break in tsi108.c
Message-ID: <20071020020420.GA20073@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joe@perches.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build break:

drivers/net/tsi108_eth.c: In function 'tsi108_init_one':
drivers/net/tsi108_eth.c:1633: error: expected ')' before 'dev'
drivers/net/tsi108_eth.c:1633: warning: too few arguments for format
make[2]: *** [drivers/net/tsi108_eth.o] Error 1


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/net/tsi108_eth.c b/drivers/net/tsi108_eth.c
index df10af7..35d15e8 100644
--- a/drivers/net/tsi108_eth.c
+++ b/drivers/net/tsi108_eth.c
@@ -1629,7 +1629,7 @@ tsi108_init_one(struct platform_device *pdev)
 		goto register_fail;
 	}
 
-	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n"
+	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n",
 	       dev->name, print_mac(mac, dev->dev_addr));
 #ifdef DEBUG
 	data->msg_enable = DEBUG;
