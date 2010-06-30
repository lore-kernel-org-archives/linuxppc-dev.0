Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C5708B712A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 02:39:16 +1000 (EST)
Date: Wed, 30 Jun 2010 20:39:15 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2 3/3] gianfar: Implement workaround for eTSEC-A002 erratum
Message-ID: <20100630163915.GC23337@oksana.dev.rtsoft.ru>
References: <20100630163804.GA636@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100630163804.GA636@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	Manfred Rudigier <manfred.rudigier@omicron.at>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8313ECE says:

"If the controller receives a 1- or 2-byte frame (such as an illegal
 runt packet or a packet with RX_ER asserted) before GRS is asserted
 and does not receive any other frames, the controller may fail to set
 GRSC even when the receive logic is completely idle. Any subsequent
 receive frame that is larger than two bytes will reset the state so
 the graceful stop can complete. A MAC receiver (Rx) reset will also
 reset the state."

This patch implements the proposed workaround:

"If IEVENT[GRSC] is still not set after the timeout, read the eTSEC
 register at offset 0xD1C. If bits 7-14 are the same as bits 23-30,
 the eTSEC Rx is assumed to be idle and the Rx can be safely reset.
 If the register fields are not equal, wait for another timeout
 period and check again."

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/net/gianfar.c |   40 +++++++++++++++++++++++++++++++++++++---
 drivers/net/gianfar.h |    1 +
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 8ba2973..35626eb 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -947,6 +947,11 @@ static void gfar_detect_errata(struct gfar_private *priv)
 			(pvr == 0x80861010 && (mod & 0xfff9) == 0x80c0))
 		priv->errata |= GFAR_ERRATA_76;
 
+	/* MPC8313 and MPC837x all rev */
+	if ((pvr == 0x80850010 && mod == 0x80b0) ||
+			(pvr == 0x80861010 && (mod & 0xfff9) == 0x80c0))
+		priv->errata |= GFAR_ERRATA_A002;
+
 	if (priv->errata)
 		dev_info(dev, "enabled errata workarounds, flags: 0x%x\n",
 			 priv->errata);
@@ -1570,6 +1575,29 @@ static void init_registers(struct net_device *dev)
 	gfar_write(&regs->minflr, MINFLR_INIT_SETTINGS);
 }
 
+static int __gfar_is_rx_idle(struct gfar_private *priv)
+{
+	u32 res;
+
+	/*
+	 * Normaly TSEC should not hang on GRS commands, so we should
+	 * actually wait for IEVENT_GRSC flag.
+	 */
+	if (likely(!gfar_has_errata(priv, GFAR_ERRATA_A002)))
+		return 0;
+
+	/*
+	 * Read the eTSEC register at offset 0xD1C. If bits 7-14 are
+	 * the same as bits 23-30, the eTSEC Rx is assumed to be idle
+	 * and the Rx can be safely reset.
+	 */
+	res = gfar_read((void __iomem *)priv->gfargrp[0].regs + 0xd1c);
+	res &= 0x7f807f80;
+	if ((res & 0xffff) == (res >> 16))
+		return 1;
+
+	return 0;
+}
 
 /* Halt the receive and transmit queues */
 static void gfar_halt_nodisable(struct net_device *dev)
@@ -1593,12 +1621,18 @@ static void gfar_halt_nodisable(struct net_device *dev)
 	tempval = gfar_read(&regs->dmactrl);
 	if ((tempval & (DMACTRL_GRS | DMACTRL_GTS))
 	    != (DMACTRL_GRS | DMACTRL_GTS)) {
+		int ret;
+
 		tempval |= (DMACTRL_GRS | DMACTRL_GTS);
 		gfar_write(&regs->dmactrl, tempval);
 
-		spin_event_timeout(((gfar_read(&regs->ievent) &
-			 (IEVENT_GRSC | IEVENT_GTSC)) ==
-			 (IEVENT_GRSC | IEVENT_GTSC)), -1, 0);
+		do {
+			ret = spin_event_timeout(((gfar_read(&regs->ievent) &
+				 (IEVENT_GRSC | IEVENT_GTSC)) ==
+				 (IEVENT_GRSC | IEVENT_GTSC)), 1000000, 0);
+			if (!ret && !(gfar_read(&regs->ievent) & IEVENT_GRSC))
+				ret = __gfar_is_rx_idle(priv);
+		} while (!ret);
 	}
 }
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index c414374..710810e 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -1028,6 +1028,7 @@ struct gfar_priv_grp {
 enum gfar_errata {
 	GFAR_ERRATA_74		= 0x01,
 	GFAR_ERRATA_76		= 0x02,
+	GFAR_ERRATA_A002	= 0x04,
 };
 
 /* Struct stolen almost completely (and shamelessly) from the FCC enet source
-- 
1.7.0.5
