Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19625DE4CD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:26:50 +1000 (EST)
Date: Tue, 15 Apr 2008 17:26:38 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: fec_mpc5200: reset FEC on error
Message-ID: <20080415152638.GW13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Domen Puncer <domen@coderock.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sascha Hauer <s.hauer@pengutronix.de>

The error handling for the mpc5200 fec interrupt is broken. The intended
behaviour is like this:

* If one of FEC_IEVENT_RFIFO_ERROR and FEC_IEVENT_XFIFO_ERROR happens,
  the datasheet says (MPC5200B User's Guide R1.2, p. 14-13): "When this
  occurs, software must ensure both the FIFO Controller and BestComm are
  soft-reset".

* On any other error (non-TFINT) interrupt, just issue a debug message.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 drivers/net/fec_mpc52xx.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: drivers/net/fec_mpc52xx.c
===================================================================
--- drivers/net/fec_mpc52xx.c.orig
+++ drivers/net/fec_mpc52xx.c
@@ -491,20 +491,23 @@
 
 	out_be32(&fec->ievent, ievent);		/* clear pending events */
 
-	if (ievent & ~(FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {
-		if (ievent & ~FEC_IEVENT_TFINT)
-			dev_dbg(&dev->dev, "ievent: %08x\n", ievent);
+	/* on fifo error, soft-reset fec */
+	if (ievent & (FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {
+
+		if (net_ratelimit() && (ievent & FEC_IEVENT_RFIFO_ERROR))
+			dev_warn(&dev->dev, "FEC_IEVENT_RFIFO_ERROR\n");
+		if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
+			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
+
+		mpc52xx_fec_reset(dev);
+
+		netif_wake_queue(dev);
 		return IRQ_HANDLED;
 	}
 
-	if (net_ratelimit() && (ievent & FEC_IEVENT_RFIFO_ERROR))
-		dev_warn(&dev->dev, "FEC_IEVENT_RFIFO_ERROR\n");
-	if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
-		dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
-
-	mpc52xx_fec_reset(dev);
+	if (ievent & ~FEC_IEVENT_TFINT)
+		dev_dbg(&dev->dev, "ievent: %08x\n", ievent);
 
-	netif_wake_queue(dev);
 	return IRQ_HANDLED;
 }
 
