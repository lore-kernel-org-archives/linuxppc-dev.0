Message-ID: <3DB84A2C.89BC0C38@corelatus.com>
Date: Thu, 24 Oct 2002 21:29:48 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: patch for arch/ppc/8xx_io/fec.c
Content-Type: multipart/mixed;
 boundary="------------B618876DE50B60AB20A10161"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B618876DE50B60AB20A10161
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Against bk:linuxppc_2_4

Use retry counter (RC) to detect collisions instead of
Defer (DEF).

>From Table 6-29: (MPC860T (Rev. D) Fast Ethernet Controller 0.8)

6 DEF Defer indication, written by FEC (valid if L = 1). Set when the
FEC had to defer while trying to
transmit a frame. This bit is not set if a collision occurs during
transmission.

10-13 RC Retry count, written by FEC (valid if L = 1). Counts retries
needed
to successfully send this frame. If RC = 0, the frame was sent correctly
the first time. If RC = 15, the frame was sent successfully while the
retry
count was at its maximum value. If RL = 1, RC has no meaning.

/Thomas
--------------B618876DE50B60AB20A10161
Content-Type: text/plain; charset=us-ascii;
 name="fec_collision_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec_collision_patch"

--- fec.c	2002-10-15 14:58:00.000000000 +0200
+++ fec_cfix.c	2002-10-24 20:59:20.000000000 +0200
@@ -502,11 +502,12 @@
 		if (bdp->cbd_sc & BD_ENET_TX_READY)
 			printk("HEY! Enet xmit interrupt and TX_READY.\n");
 #endif
-		/* Deferred means some collisions occurred during transmit,
-		 * but we eventually sent the packet OK.
-		 */
-		if (bdp->cbd_sc & BD_ENET_TX_DEF)
-			fep->stats.collisions++;
+		/* Check retry counter, i.e. collision counter */
+		/* Only valid if LAST is set, but it should always be. */
+		if (bdp->cbd_sc & BD_ENET_TX_RCMASK){
+			/* Note that counter cannot go higher than 15 */
+			fep->stats.collisions+=(bdp->cbd_sc & BD_ENET_TX_RCMASK)>>2;
+		}

 		/* Free the sk buffer associated with this last transmit.
 		 */

--------------B618876DE50B60AB20A10161--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
