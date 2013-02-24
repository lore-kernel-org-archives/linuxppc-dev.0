Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 522422C029A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 02:40:13 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH net] gianfar: fix compile fail for NET_POLL=y due to struct
 packing
Date: Sun, 24 Feb 2013 10:38:31 -0500
Message-ID: <1361720311-13267-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1361717023.16950.12.camel@pasglop>
References: <1361717023.16950.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jianhua Xie <jianhua.xie@freescale.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@lists.ozlabs.org,
 Claudiu Manoil <claudiu.manoil@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ee873fda3bec7c668407b837fc5519eb961fcd37 ("gianfar: Pack struct
gfar_priv_grp into three cachelines") moved the irq number and names
off into a separate struct and created accessors for them.  However
it was never tested with NET_POLL enabled, and so some conversions
that were simply overlooked went undetected until now.

Make the netpoll ones also use the gfar_irq() accessors.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: Jianhua Xie <jianhua.xie@freescale.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[compile tested for sbc8548 with NET_POLL=y]

 drivers/net/ethernet/freescale/gianfar.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 4b5e8a6..d2c5441 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2906,21 +2906,23 @@ static void gfar_netpoll(struct net_device *dev)
 	/* If the device has multiple interrupts, run tx/rx */
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
 		for (i = 0; i < priv->num_grps; i++) {
-			disable_irq(priv->gfargrp[i].interruptTransmit);
-			disable_irq(priv->gfargrp[i].interruptReceive);
-			disable_irq(priv->gfargrp[i].interruptError);
-			gfar_interrupt(priv->gfargrp[i].interruptTransmit,
-				       &priv->gfargrp[i]);
-			enable_irq(priv->gfargrp[i].interruptError);
-			enable_irq(priv->gfargrp[i].interruptReceive);
-			enable_irq(priv->gfargrp[i].interruptTransmit);
+			struct gfar_priv_grp *grp = &priv->gfargrp[i];
+
+			disable_irq(gfar_irq(grp, TX)->irq);
+			disable_irq(gfar_irq(grp, RX)->irq);
+			disable_irq(gfar_irq(grp, ER)->irq);
+			gfar_interrupt(gfar_irq(grp, TX)->irq, grp);
+			enable_irq(gfar_irq(grp, ER)->irq);
+			enable_irq(gfar_irq(grp, RX)->irq);
+			enable_irq(gfar_irq(grp, TX)->irq);
 		}
 	} else {
 		for (i = 0; i < priv->num_grps; i++) {
-			disable_irq(priv->gfargrp[i].interruptTransmit);
-			gfar_interrupt(priv->gfargrp[i].interruptTransmit,
-				       &priv->gfargrp[i]);
-			enable_irq(priv->gfargrp[i].interruptTransmit);
+			struct gfar_priv_grp *grp = &priv->gfargrp[i];
+
+			disable_irq(gfar_irq(grp, TX)->irq);
+			gfar_interrupt(gfar_irq(grp, TX)->irq, grp);
+			enable_irq(gfar_irq(grp, TX)->irq);
 		}
 	}
 }
-- 
1.8.1.2
