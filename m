Message-ID: <41129315.600@rossvideo.com>
Date: Thu, 05 Aug 2004 16:05:41 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] 44x ethernet MDIO access
References: <41128413.7030900@rossvideo.com>
In-Reply-To: <41128413.7030900@rossvideo.com>
Content-Type: multipart/mixed;
 boundary="------------040707080006080109080200"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040707080006080109080200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralph Siemsen wrote:
> In a related issue, both the PHY read and write functions use a fixed
> time delay (MDIO_DELAY = 50) presently... it seems I need a longer value
> on my hardware, and having such hardcoded values is trouble anyways... I
> suggest we change the code to poll for completion, with a short delay
> and an upper limit on the number of loops.

I've just checked the hardware, it seems that the MDIO clock is driven
at EPB clock divided by 10.  So on the IBM eval board its 7.6MHz.  Each
MDIO transfer involves moving 64 bits of data.  So that means just the
data transfer (never mind any processing in the PHY) takes 8.4us.

The important part to note is that EPB could vary over a considerable
range, so the time needed for MDIO is potentially longer than the 50us
currently used in the code.

Attached is a patch that "works for me" - turns the long udelay() into a
polling loop with short little delays instead.  This allows MDIO_DELAY
to be increased to a larger value (say 150) without slowing down most
systems.

Also I can be used to measure just how long the transfers actually take.
  If MDIO_DEBUG is enabled then you'll see how many "loops" were
needed... on the Ocotea board i get values around 25.

-Ralph

--------------040707080006080109080200
Content-Type: text/plain;
 name="mdio_loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mdio_loop.patch"

Change MDIO read/write to poll for completion rather than waiting
an arbitrary length of time.  Note this changes the semantics of the
MDIO_DELAY definition - it is now a maximal loop count, rather than
a time delay in microseconds.

--- linux-2.6.8-rc3/drivers/net/ibm_emac/ibm_emac_core.c	2004-08-05 14:54:56.000000000 -0400
+++ linux-2.6-devel/drivers/net/ibm_emac/ibm_emac_core.c	2004-08-05 15:08:50.000000000 -0400
@@ -367,6 +371,7 @@

 int emac_phy_read(struct net_device *dev, int mii_id, int reg)
 {
+	int count;
 	uint32_t stacr;
 	struct ocp_enet_private *fep = dev->priv;
 	emac_t *emacp = fep->emacp;
@@ -398,8 +403,11 @@

 	out_be32(&emacp->em0stacr, stacr);

-	udelay(MDIO_DELAY);
-	stacr = in_be32(&emacp->em0stacr);
+	count =  0;
+	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+					&& (count++ < MDIO_DELAY))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

 	if ((stacr & EMAC_STACR_OC) == 0) {
 		printk(KERN_WARNING "%s: PHY read timeout #2!\n", dev->name);
@@ -419,6 +427,7 @@

 void emac_phy_write(struct net_device *dev, int mii_id, int reg, int data)
 {
+	int count;
 	uint32_t stacr;
 	struct ocp_enet_private *fep = dev->priv;
 	emac_t *emacp = fep->emacp;
@@ -451,9 +460,13 @@

 	out_be32(&emacp->em0stacr, stacr);

-	udelay(MDIO_DELAY);
+	count = 0;
+	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
+					&& (count++ < 5000))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

-	if (((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+	if ((stacr & EMAC_STACR_OC) == 0)
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);

 	/* Check for a write error */


--------------040707080006080109080200--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
