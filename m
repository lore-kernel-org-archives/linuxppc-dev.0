Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 72FE367A64
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 23:20:52 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 8 Mar 2005 05:20:48 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050308122048.GA22866@xyzzy>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110266832.13607.267.camel@gaston>
Cc: Nicolas DET <det.nicolas@free.fr>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 06:27:12PM +1100, Benjamin Herrenschmidt wrote:
> > Notice that benh is telling me that you should use SA_SHIRQ always and that
> > SA_INTERRUPT should go away, and that you should contact him online if you
> > have trouble with that.
> > 
> > > For the pegasos 2, you'll need the second patch which applies after
> > > the one I previously sent for chrp_setup.c.
> > 
> > Ok, will test this anyway, and tell you how it works.
> 
> GHeh, ok, just picked up the discussion. Yes, there is really no reason
> to use SA_INTERRUPT here, this is a thing of the past.

Excellent.  Thanks.

Here's a new patch to try.  :-)

-Dale

mv643xx: Always pass SA_SHIRQ to request_irq()

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-enet/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-enet.orig/drivers/net/mv643xx_eth.c
+++ linux-2.5-enet/drivers/net/mv643xx_eth.c
@@ -668,7 +668,7 @@
 	spin_lock_irq(&mp->lock);
 
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_INTERRUPT | SA_SAMPLE_RANDOM, dev->name, dev);
+			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
 
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
