Message-ID: <41128413.7030900@rossvideo.com>
Date: Thu, 05 Aug 2004 15:01:39 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] 44x ethernet MDIO access
Content-Type: multipart/mixed;
 boundary="------------090109030802030704040307"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090109030802030704040307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There is a small bug in the emac_phy_write() routine defined in
drivers/net/ibm_emac/ibm_emac_core.c (present in latest 2.6.8-rc3).  At
the end of the function, check is done for phy error; however as written
this will always be false, because "stacr" contains the value _written_
to the hardware, rather than the value read back from hardware.

Simple on-line fix attached.

In a related issue, both the PHY read and write functions use a fixed
time delay (MDIO_DELAY = 50) presently... it seems I need a longer value
on my hardware, and having such hardcoded values is trouble anyways... I
suggest we change the code to poll for completion, with a short delay
and an upper limit on the number of loops.

=Ralph

--------------090109030802030704040307
Content-Type: text/plain;
 name="mdio_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mdio_write.patch"

Allow proper detection of phy write error.

--- linux-2.6.8-rc3/drivers/net/ibm_emac/ibm_emac_core.c.orig	2004-08-05 14:54:22.000000000 -0400
+++ linux-2.6.8-rc3/drivers/net/ibm_emac/ibm_emac_core.c	2004-08-05 14:54:56.000000000 -0400
@@ -453,7 +453,7 @@

 	udelay(MDIO_DELAY);

-	if ((in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
+	if (((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);

 	/* Check for a write error */

--------------090109030802030704040307--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
