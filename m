Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B0D367B28
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 12:43:39 +1000 (EST)
Message-ID: <425EB470.9040203@am.sony.com>
Date: Thu, 14 Apr 2005 11:20:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: {PATCH] Fix IBM EMAC driver ioctl bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix IBM EMAC driver ioctl bug.

I found IBM EMAC driver bug.
So mii-tool command print wrong status.

  # mii-tool
  eth0: 10 Mbit, half duplex, no link
  eth1: 10 Mbit, half duplex, no link

I can get correct status on fixed kernel.

  # mii-tool
  eth0: negotiated 100baseTx-FD, link okZZ
  eth1: negotiated 100baseTx-FD, link ok

Hiroaki Fuse

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
---

Index: linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-2.6.11.orig/drivers/net/ibm_emac/ibm_emac_core.c	2005-04-14 10:54:20.014023550 -0700
+++ linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c	2005-04-14 10:55:24.723458722 -0700
@@ -1587,7 +1587,7 @@
 static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	uint *data = (uint *) & rq->ifr_ifru;
+	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:

-EOF
