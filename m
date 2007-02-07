Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9822DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 19:58:01 +1100 (EST)
Date: Wed, 07 Feb 2007 17:57:28 +0900 (JST)
Message-Id: <200702070857.l178vhav020612@toshiba.co.jp>
Subject: [PATCH 4/4] spidernet: remove txram full logging
To: jgarzik@pobox.com, jens@de.ibm.com
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jim@jklewis.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patches removes logging for SPIDER_NET_GTMFLLINT interrupts.
Since the interrupts are not irregular, and they happen frequently
when using 100Mbps network switches.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

--- org-linux-powerpc-git/drivers/net/spider_net.c	2007-02-06 20:44:47.000000000 +0900
+++ linux-powerpc-git/drivers/net/spider_net.c	2007-02-06 20:48:38.000000000 +0900
@@ -1417,8 +1417,8 @@
 				switch (i)
 	{
 	case SPIDER_NET_GTMFLLINT:
-		if (netif_msg_intr(card) && net_ratelimit())
-			pr_err("Spider TX RAM full\n");
+		/* TX RAM full may happen on a usual case.
+		 * Logging is not needed. */
 		show_error = 0;
 		break;
 	case SPIDER_NET_GRFDFLLINT: /* fallthrough */
