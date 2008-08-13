Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D9D81DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 00:09:45 +1000 (EST)
Message-ID: <48A2EBC1.6020708@grandegger.com>
Date: Wed, 13 Aug 2008 16:12:17 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
References: <20080710123909.GA4275@pengutronix.de>	<20080710153101.GD446@secretlab.ca>
	<200808131548.11813.jbe@pengutronix.de>
In-Reply-To: <200808131548.11813.jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>,
	domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jürgen,

Juergen Beisert wrote:
> On Donnerstag, 10. Juli 2008, Grant Likely wrote:
>> On Thu, Jul 10, 2008 at 02:39:09PM +0200, Wolfram Sang wrote:
>>> Hello,
>>>
>>> today, I was debugging a kernel crash on a board with a MPC5200B using
>>> 2.6.26-rc9. I found the following code in drivers/net/fec_mpc52xx.c:
>> <snip>
>>
>>> I assume the proper thing to do is to set a flag in the ISR and handle
>>> the soft reset later in some other context. Having never dealt with the
>>> network core and its drivers so far, I am not sure which place would be
>>> the right one to perform the soft reset. To not make things worse, I
>>> hope people with more insight to network stuff can deliver a suitable
>>> solution to this problem.
>> Thanks for the bug report.  I'll take a look.
> 
> Some update:
> 
> Enabling XLB pipelining let occure this error less often. Kernel disables this 
> feature by default yet.
> The comment talks about "cfr errate 292." that is valid for MPC5200A, but 
> _it_seems_ no longer for MPC5200B. Has anybody experience if we can enabling 
> pipelining on MPC5200B CPUs without triggering this bug?

No, I haven't...

> We currently are playing with this setting:
> 
> Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
> ===================================================================
> --- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
> +++ arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -99,11 +99,11 @@
>  	out_be32(&xlb->master_pri_enable, 0xff);
>  	out_be32(&xlb->master_priority, 0x11111111);
>  
> -	/* Disable XLB pipelining
> -	 * (cfr errate 292. We could do this only just before ATA PIO
> -	 *  transaction and re-enable it afterwards ...)
> +	/*
> +	 * Enable pipelining, fixes FEC problems. The previous workaround seems
> +	 * not needed, as we have an MPC5200B (not A).
>  	 */
> -	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
> +	out_be32(&xlb->config, in_be32(&xlb->config) & ~MPC52xx_XLB_CFG_PLDIS);
>  
>  	iounmap(xlb);
>  }

...but I prepared a patch to do the reset in the process context. Would be
nice if you could give the patch below a try.

Wolfgang.

===================================================================
From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] powerpc: fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR

Calling mpc52xx_fec_reset() in the ISR is a bug. This patch puts a task
for resetting the FEC into the kernel-global workqueue to be processed
lateron savely in process context.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/fec_mpc52xx.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

Index: linux-2.6.26/drivers/net/fec_mpc52xx.c
===================================================================
--- linux-2.6.26.orig/drivers/net/fec_mpc52xx.c
+++ linux-2.6.26/drivers/net/fec_mpc52xx.c
@@ -24,6 +24,7 @@
 #include <linux/crc32.h>
 #include <linux/hardirq.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
@@ -57,6 +58,8 @@ struct mpc52xx_fec_priv {
 	struct bcom_task *tx_dmatsk;
 	spinlock_t lock;
 	int msg_enable;
+	struct work_struct reset_task;
+	struct net_device *ndev;
 
 	/* MDIO link details */
 	int phy_addr;
@@ -83,6 +86,19 @@ static int debug = -1;	/* the above defa
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "debugging messages level");
 
+static void mpc52xx_fec_reset_task(struct work_struct *work)
+{
+	struct mpc52xx_fec_priv *priv =
+		container_of(work, struct mpc52xx_fec_priv, reset_task);
+	struct net_device *dev = priv->ndev;
+
+	dev_warn(&dev->dev, "deferred FEC reset due to errors\n");
+
+	mpc52xx_fec_reset(dev);
+
+	netif_wake_queue(dev);
+}
+
 static void mpc52xx_fec_tx_timeout(struct net_device *dev)
 {
 	dev_warn(&dev->dev, "transmit timed out\n");
@@ -355,6 +371,8 @@ static int mpc52xx_fec_close(struct net_
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+	flush_scheduled_work();
+
 	netif_stop_queue(dev);
 
 	mpc52xx_fec_stop(dev);
@@ -522,9 +540,9 @@ static irqreturn_t mpc52xx_fec_interrupt
 		if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
 			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
 
-		mpc52xx_fec_reset(dev);
-
-		netif_wake_queue(dev);
+		netif_stop_queue(dev);
+		netif_carrier_off(dev);
+		schedule_work(&priv->reset_task);
 		return IRQ_HANDLED;
 	}
 
@@ -934,7 +952,9 @@ mpc52xx_fec_probe(struct of_device *op, 
 
 	priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
 
-	spin_lock_init(&priv->lock);
+	priv->ndev = ndev;
+ 	spin_lock_init(&priv->lock);
+	INIT_WORK(&priv->reset_task, mpc52xx_fec_reset_task);
 
 	/* ioremap the zones */
 	priv->fec = ioremap(mem.start, sizeof(struct mpc52xx_fec));
@@ -1068,6 +1088,9 @@ mpc52xx_fec_remove(struct of_device *op)
 	ndev = dev_get_drvdata(&op->dev);
 	priv = netdev_priv(ndev);
 
+	if (netif_running(ndev))
+		mpc52xx_fec_close(ndev);
+
 	unregister_netdev(ndev);
 
 	irq_dispose_mapping(ndev->irq);
