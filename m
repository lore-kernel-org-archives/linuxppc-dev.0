Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE884DDEBE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 21:34:02 +1100 (EST)
Date: Fri, 02 Feb 2007 19:33:11 +0900 (JST)
Message-Id: <200702021033.l12AXCdE021278@toshiba.co.jp>
To: jens@de.ibm.com
Subject: [RFC/PATCH 2.6.20-rc6 4/4] spidernet: remove txram full logging
In-Reply-To: <200702011204.30526.jens@de.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, jim@jklewis.com,
	netdev@vger.kernel.org
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

This patch is just for a test. Please try this if you can.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

--- org-linux-powerpc-git/drivers/net/spider_net.c	2007-02-02 14:35:14.000000000 +0900
+++ linux-powerpc-git/drivers/net/spider_net.c	2007-02-02 14:35:49.000000000 +0900
@@ -1435,8 +1435,8 @@
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
