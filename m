Message-ID: <3CECF29B.FEA9EAAD@lvl7.com>
Date: Thu, 23 May 2002 09:46:03 -0400
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: NBLIST@sbcglobal.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ethernet works only the first time
References: <AA-0296B6B7975FF39FEDDBA26C4B9351E2-ZZ@homebase1.prodigy.net>
Content-Type: multipart/mixed;
 boundary="------------92E43CCF4CEC68AFC1658D27"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------92E43CCF4CEC68AFC1658D27
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This sounds exactly like a problem we (and our customers) have seen
here.  One of our guys coded-up a fix.  I'm attaching it as a diff
against the fec.c that shipped with the 2.4.2_hhl20 kernel (i.e. HardHat
2.0 from MontaVista).  I've included 10 lines of context in either
direction to help you place it in your own fec.c version.

I didn't code this myself, so don't blame me if it causes problems! :-)

John

NBLIST@sbcglobal.net wrote:
>
> Hello all,
>
> I am using the fec on the MPC855T on my custom board.
> I seem to be having some weird ethernet configuration
> problems. My eth0 interface comes up only the first
> time. If I "ifconfig down" the eth0 and bring it back
> up by doing "ifconfig up", the eth0 interface shows up
> fine. But ethernet doesnt work anymore. After a couple
> of minutes, I get "tx buffer full" error messages. But
> it always works the first time I boot the linux kernel
> and bring up etho using ifconfig.
>
> What's going on here? Any ideas, clues, tips????
>
> Thank you,
> NB
>

--
John W. Linville
LVL7 Systems, Inc.
--------------92E43CCF4CEC68AFC1658D27
Content-Type: text/plain; charset=us-ascii;
 name="fec.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec.c.patch"

--- fec.c.old	Thu May 23 09:34:27 2002
+++ fec.c	Thu May 23 09:34:38 2002
@@ -1861,20 +1861,26 @@
 		bdp->cbd_sc = 0;
 		bdp->cbd_bufaddr = 0;
 		bdp++;
 	}

 	/* Set the last buffer to wrap.
 	*/
 	bdp--;
 	bdp->cbd_sc |= BD_SC_WRAP;

+	/* Since we have re-initialized the buffer pool, the ring is no longer
+	 * full.
+	 */
+	fep->tx_full = 0;
+	netif_wake_queue(dev);
+
 	/* Enable MII mode.
 	*/
 	if (duplex) {
 		fecp->fec_r_cntrl = FEC_RCNTRL_MII_MODE;	/* MII enable */
 		fecp->fec_x_cntrl = FEC_TCNTRL_FDEN;		/* FD enable */
 	}
 	else {
 		fecp->fec_r_cntrl = FEC_RCNTRL_MII_MODE | FEC_RCNTRL_DRT;
 		fecp->fec_x_cntrl = 0;
 	}

--------------92E43CCF4CEC68AFC1658D27--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
