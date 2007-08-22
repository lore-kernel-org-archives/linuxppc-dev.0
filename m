Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 880D4DE3C0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:08:45 +1000 (EST)
Date: Wed, 22 Aug 2007 09:13:35 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [10/10] pasemi_mac: Clean TX ring in poll
Message-ID: <20070822141335.GK16830@lixom.net>
References: <20070817205413.548020000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unfortunately there's no timeout for how long a packet can sit on
the TX ring after completion before an interrupt is generated, and
we want to have a threshold that's larger than one packet per interrupt.

So we have to have a timer that occasionally cleans the TX ring even
though there hasn't been an interrupt. Instead of setting up a dedicated
timer for this, just clean it in the NAPI poll routine instead.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

I know I got this rejected last time it was submitted, but no answers with
suggestions on how to handle it better. I'm all ears if there's a better
way.  (I noticed that Intel's new ixgbe driver does the same thing).

Index: mainline/drivers/net/pasemi_mac.c
===================================================================
--- mainline.orig/drivers/net/pasemi_mac.c
+++ mainline/drivers/net/pasemi_mac.c
@@ -1086,6 +1086,7 @@ static int pasemi_mac_poll(struct net_de
 	int pkts, limit = min(*budget, dev->quota);
 	struct pasemi_mac *mac = netdev_priv(dev);
 
+	pasemi_mac_clean_tx(mac);
 	pkts = pasemi_mac_clean_rx(mac, limit);
 
 	dev->quota -= pkts;

--
