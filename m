Return-Path: <to-fleischer@t-online.de>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EA211B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 07:21:47 +1000 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: gianfar.c: Unwanted VLAN tagging on TX frames
Date: Mon, 24 Aug 2009 18:10:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908241810.54239.to-fleischer@t-online.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

I have the Freescale's MPC8313erdb eval board and run the latest stable linux
kernel version (linux-2.6.30.5).

After creating a VLAN device (e.g. eth0.2) a VLAN tag is also inserted into 
frames that don't relate to a VLAN device. This is the case for frames that 
are directly sent through a standard ethernet interface (e.g. eth0).

When creating a VLAN device the gianfar driver enables the  hardware supported 
VLAN tagging on TX frames. This is done by setting the VLINS bit of the TCTRL 
register inside the function gianfar_vlan_rx_register().
The problem is that every outgoing frame will be tagged.  For frames from an 
interface like eth0 the VLN bit of the FCB isn't set. Therefore the eTSEC uses 
the content of the Default VLAN control word register (DFVLAN) to tag the 
frame. As long as this register will not be modified after a reset of the 
controller the outgoing frames will be tagged with VID = 0 (priority tagged 
frames). 

The following patch solves this problem.

diff -uprN linux-2.6.30.5_orig//drivers/net/gianfar.c linux-2.6.30.5/drivers/net/gianfar.c
--- linux-2.6.30.5_orig//drivers/net/gianfar.c	2009-08-16 23:19:38.000000000 +0200
+++ linux-2.6.30.5/drivers/net/gianfar.c	2009-08-22 10:38:28.000000000 +0200
@@ -1309,6 +1309,7 @@ static int gfar_start_xmit(struct sk_buf
 	u32 bufaddr;
 	unsigned long flags;
 	unsigned int nr_frags, length;
+	u32 tempval;
 
 	base = priv->tx_bd_base;
 
@@ -1385,13 +1386,30 @@ static int gfar_start_xmit(struct sk_buf
 		gfar_tx_checksum(skb, fcb);
 	}
 
-	if (priv->vlgrp && vlan_tx_tag_present(skb)) {
-		if (unlikely(NULL == fcb)) {
-			fcb = gfar_add_fcb(skb);
-			lstatus |= BD_LFLAG(TXBD_TOE);
-		}
+	if (priv->vlgrp) {
+		if (vlan_tx_tag_present(skb)) {
+			if (unlikely(NULL == fcb)) {
+				fcb = gfar_add_fcb(skb);
+				lstatus |= BD_LFLAG(TXBD_TOE);
+			}
+
+			/* Enable VLAN tag insertion for frames from VLAN devices */
+			tempval = gfar_read(&priv->regs->tctrl);
+			if ( !(tempval & TCTRL_VLINS) ) {
+				tempval |= TCTRL_VLINS;
+				gfar_write(&priv->regs->tctrl, tempval);
+			}
 
-		gfar_tx_vlan(skb, fcb);
+			gfar_tx_vlan(skb, fcb);
+		}
+		else {
+			/* Disable VLAN tag insertion for frames that are not from a VLAN device */
+			tempval = gfar_read(&priv->regs->tctrl);
+			if ( tempval & TCTRL_VLINS ) {
+				tempval &= ~TCTRL_VLINS;
+				gfar_write(&priv->regs->tctrl, tempval);
+			}
+		}
 	}
 
 	/* setup the TxBD length and buffer pointer for the first BD */
@@ -1484,23 +1502,11 @@ static void gfar_vlan_rx_register(struct
 	priv->vlgrp = grp;
 
 	if (grp) {
-		/* Enable VLAN tag insertion */
-		tempval = gfar_read(&priv->regs->tctrl);
-		tempval |= TCTRL_VLINS;
-
-		gfar_write(&priv->regs->tctrl, tempval);
-
 		/* Enable VLAN tag extraction */
 		tempval = gfar_read(&priv->regs->rctrl);
-		tempval |= RCTRL_VLEX;
 		tempval |= (RCTRL_VLEX | RCTRL_PRSDEP_INIT);
 		gfar_write(&priv->regs->rctrl, tempval);
 	} else {
-		/* Disable VLAN tag insertion */
-		tempval = gfar_read(&priv->regs->tctrl);
-		tempval &= ~TCTRL_VLINS;
-		gfar_write(&priv->regs->tctrl, tempval);
-
 		/* Disable VLAN tag extraction */
 		tempval = gfar_read(&priv->regs->rctrl);
 		tempval &= ~RCTRL_VLEX;
