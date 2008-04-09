Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 61C38DE0A0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:02:42 +1000 (EST)
Message-ID: <47FD2EC1.8030600@am.sony.com>
Date: Wed, 09 Apr 2008 14:01:53 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix gelic net module dependency
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PS3 gelic network driver depends on the wake-on-lan support
provided by the PS3 sys manager driver.  Add that dependency
to the GELIC_NET Kconfig option.

Prevents these build errors:

  ps3_gelic_net.c:1277: undefined reference to `.ps3_sys_manager_get_wol'
  ps3_gelic_net.c:1337: undefined reference to `.ps3_sys_manager_set_wol'

CC: Masakazu Mokuno <mokuno@sm.sony.co.jp>
CC: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Hi Paul,

This fixes an error introduced in my 2.6.26 WOL patches now
queued in your powerpc tree.  Please apply.

-Geoff

 drivers/net/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2358,6 +2358,7 @@ config TSI108_ETH
 config GELIC_NET
 	tristate "PS3 Gigabit Ethernet driver"
 	depends on PPC_PS3
+	select PS3_SYS_MANAGER
 	help
 	  This driver supports the network device on the PS3 game
 	  console.  This driver has built-in support for Ethernet.
