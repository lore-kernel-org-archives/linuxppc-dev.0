Date: Thu, 15 Mar 2001 12:37:35 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: anyone with bmac network problem?
Message-ID: <Pine.A41.3.96LJ1.1b7.1010315122129.41552B-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm looking for testers on a possible workaround for bmac network problem.
As some of you might know, bmac tx dies abruptly when network environment
is very busy and never recovers.  A patch enclosed might alleviate the
situation, and I want to know if it works for anybody else.

This problem is hard to reproduce in that it takes time and you must have
busy traffic.  I can say I have not been able to reproduce the problem
when the patch is applied, whereas I could eventually reproduce the bmac
hang without the patch, but YMMV.

The patch should apply cleanly to reasonably recent 2.2.x source and with
offsets to 2.4.x.

Let me know if you see any (or no) changes or problems with this patch.


Takashi Oe

--- bmac.c.ORIG	Sun Dec 10 18:49:42 2000
+++ bmac.c	Thu Mar 15 12:38:00 2001
@@ -772,7 +772,13 @@
 		if (txintcount < 10) {
 			XXDEBUG(("bmac_txdma_xfer_stat=%#0x\n", stat));
 		}
-		if (!(stat & ACTIVE)) break;
+		if (!(stat & ACTIVE)) {
+			/*
+			 * status field might not have been filled by DBDMA
+			 */
+			if (cp == bus_to_virt(in_le32(&bp->tx_dma->cmdptr)))
+				break;
+		}

 		if (bp->tx_bufs[bp->tx_empty]) {
 			++bp->stats.tx_packets;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
