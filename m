Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 5B7B52BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Dec 2004 03:32:38 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 1 Dec 2004 17:07:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200412011707.14693.g.jaeger@sysgo.com>
Subject: [PATCH][PPC32] Fix gianfar netdriver oops when using bootp...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this patch fixes an issue, that occurs on my MPC8541CDS, when trying to
use bootp to get the IP parameters. It seems, that the patch only cures
the symptom but obviously not the cause ;)

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.10-rc2-mm4/drivers/net/gianfar.c.orig	2004-11-15 02:26:34.000000000 +0100
+++ linux-2.6.10-rc2-mm4/drivers/net/gianfar.c	2004-12-01 17:00:19.000000000 +0100
@@ -1477,6 +1477,9 @@ static void gfar_phy_change(void *data)
 	struct gfar_private *priv = netdev_priv(dev);
 	int result = 0;
 
+	if( !priv->mii_info->phyinfo )
+		return;
+
 	/* Delay to give the PHY a chance to change the
 	 * register state */
 	msleep(1);
