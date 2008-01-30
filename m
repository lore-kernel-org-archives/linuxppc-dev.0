Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9DF2DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 01:18:49 +1100 (EST)
Message-ID: <47A08740.3020708@tiscali.nl>
Date: Wed, 30 Jan 2008 15:18:40 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: tnt@246tNt.com, grant.likely@secretlab.ca
Subject: [PATCH][drivers/net/fec_mpc52xx.c] duplicate NETIF_MSG_IFDOWN in
	MPC52xx_MESSAGES_DEFAULT
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Untested patch below, please confirm it's the right fix.
--
duplicate NETIF_MSG_IFDOWN, 2nd should be NETIF_MSG_IFUP

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index f91ee70..ca3c3b3 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -55,7 +55,7 @@ module_param_array_named(mac, mpc52xx_fec_mac_addr, byte, NULL, 0);
 MODULE_PARM_DESC(mac, "six hex digits, ie. 0x1,0x2,0xc0,0x01,0xba,0xbe");
 
 #define MPC52xx_MESSAGES_DEFAULT ( NETIF_MSG_DRV | NETIF_MSG_PROBE | \
-		NETIF_MSG_LINK | NETIF_MSG_IFDOWN | NETIF_MSG_IFDOWN )
+		NETIF_MSG_LINK | NETIF_MSG_IFDOWN | NETIF_MSG_IFUP)
 static int debug = -1;	/* the above default */
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "debugging messages level");
