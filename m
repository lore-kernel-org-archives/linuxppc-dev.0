Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 8C72667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 05:10:50 +1100 (EST)
Message-ID: <42275320.6000302@asist-traffic.com>
Date: Thu, 03 Mar 2005 19:10:40 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
References: <42270DCE.8060703@asist-traffic.com> <20050303165955.GA20533@xyzzy>
In-Reply-To: <20050303165955.GA20533@xyzzy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FEC_IEVENT_RFIFO_ERROR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I tried the patch you've sent and It's still the same.
FEC_IEVENT_RFIFO_ERROR is still here.
Can you/anyone think of something that I could do to make
analyzing this problem easier?



Dale Farnsworth wrote:

>On Thu, Mar 03, 2005 at 01:14:54PM +0000, Babarovic Ivica wrote:
>  
>
>>I run 2.6.10-rc2 kernel (http://www.246tNt.com/mpc52xx/)
>>for MPC5200 chip on a custom board that is almost lite5200 compatible.
>>I noticed a couple of times I have a strange error at bootup.
>>It was FEC_IEVENT_RFIFO_ERROR. Most of the times this
>>went trough without problems but since today system just hangs.
>>Sometimes with several printouts of this error.
>>---boot sequence ------
>>FEC_IEVENT_RFIFO_ERROR
>>FEC_IEVENT_RFIFO_ERROR
>>FEC_IEVENT_RFIFO_ERROR
>>....
>>
>>I traced a problem a bit and found that this happenes at
>>mpc52xx_fec_probe() function in fec.c at this point:
>>--------------------------------------------------------------------------
>>      /* Get the IRQ we need one by one */
>>               /* Control */
>>       dev->irq = ocp->def->irq;
>>-->       if (request_irq(dev->irq, &fec_interrupt, SA_INTERRUPT, 
>>                       "mpc52xx_fec_ctrl", dev)) {
>>               printk(KERN_ERR "mpc52xx_fec: ctrl interrupt request 
>>failed\n");
>>               ret = -EBUSY;
>>               dev->irq = -1;  /* Don't try to free it */
>>               goto probe_error;
>>       }
>>--------------------------------------------------------------------------
>>    
>>
>
>It looks like the bootloader left the FEC enabled.  You might try
>the following (untested) patch which resets the FEC and disables
>its interrupts before requesting the irq.
>
>-Dale
>
>===== drivers/net/fec_mpc52xx/fec.c 1.1 vs edited =====
>--- 1.1/drivers/net/fec_mpc52xx/fec.c	2004-11-20 15:26:33 -07:00
>+++ edited/drivers/net/fec_mpc52xx/fec.c	2005-03-03 09:43:08 -07:00
>@@ -85,18 +85,13 @@
> 	return 0;
> }
> 
>-/* This function is called to start or restart the FEC during a link
>- * change.  This happens on fifo errors or when switching between half
>- * and full duplex.
>- */
>-static void fec_restart(struct net_device *dev, int duplex)
>+static void fec_reset(struct net_device *dev)
> {
> 	struct fec_priv *priv = (struct fec_priv *)dev->priv;
> 	struct mpc52xx_fec *fec = priv->fec;
>-	u32 rcntrl;
>-	u32 tcntrl;
> 	int i;
> 
>+	out_be32(&priv->fec->imask, 0);		/* mask all interrupts */
> 	out_be32(&fec->rfifo_status, in_be32(&fec->rfifo_status) & 0x700000);
> 	out_be32(&fec->tfifo_status, in_be32(&fec->tfifo_status) & 0x700000);
> 	out_be32(&fec->reset_cntrl, 0x1000000);
>@@ -110,6 +105,20 @@
> 	}
> 	if (i == FEC_RESET_DELAY)
> 		printk (KERN_ERR "FEC Reset timeout!\n");
>+}
>+
>+/* This function is called to start or restart the FEC during a link
>+ * change.  This happens on fifo errors or when switching between half
>+ * and full duplex.
>+ */
>+static void fec_restart(struct net_device *dev, int duplex)
>+{
>+	struct fec_priv *priv = (struct fec_priv *)dev->priv;
>+	struct mpc52xx_fec *fec = priv->fec;
>+	u32 rcntrl;
>+	u32 tcntrl;
>+
>+	fec_reset(dev);
> 
> 	/* Set station address. */
> 	fec_set_paddr(dev, dev->dev_addr);
>@@ -645,6 +654,8 @@
> 	ret = sdma_fec_tx_init(priv->tx_sdma, priv->tx_fifo);
> 	if (ret < 0)
> 		goto probe_error;
>+
>+	fec_reset(dev);
> 
> 	/* Get the IRQ we need one by one */
> 		/* Control */
>
>
>
>  
>
