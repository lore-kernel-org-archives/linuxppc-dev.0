Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 12ED667A7D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 00:15:12 +1100 (EST)
Message-ID: <42270DCE.8060703@asist-traffic.com>
Date: Thu, 03 Mar 2005 14:14:54 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: ppcembed <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tnt@246tNt.com
Subject: FEC_IEVENT_RFIFO_ERROR
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

I run 2.6.10-rc2 kernel (http://www.246tNt.com/mpc52xx/)
for MPC5200 chip on a custom board that is almost lite5200 compatible.
I noticed a couple of times I have a strange error at bootup.
It was FEC_IEVENT_RFIFO_ERROR. Most of the times this
went trough without problems but since today system just hangs.
Sometimes with several printouts of this error.
---boot sequence ------
FEC_IEVENT_RFIFO_ERROR
FEC_IEVENT_RFIFO_ERROR
FEC_IEVENT_RFIFO_ERROR
....

I traced a problem a bit and found that this happenes at
mpc52xx_fec_probe() function in fec.c at this point:
-----------------------------------------------------------------------------------------
       /* Get the IRQ we need one by one */
                /* Control */
        dev->irq = ocp->def->irq;
-->       if (request_irq(dev->irq, &fec_interrupt, SA_INTERRUPT, 
                        "mpc52xx_fec_ctrl", dev)) {
                printk(KERN_ERR "mpc52xx_fec: ctrl interrupt request 
failed\n");
                ret = -EBUSY;
                dev->irq = -1;  /* Don't try to free it */
                goto probe_error;
        }
------------------------------------------------------------------------------------------

When fec_interrupt() is called also from fec.c.

------------------------------------------------------------------------------------------
static irqreturn_t fec_interrupt(int irq, void *dev_id, struct pt_regs 
*regs)
{
        struct net_device *dev = (struct net_device *)dev_id;
        struct fec_priv *priv = (struct fec_priv *)dev->priv;
        struct mpc52xx_fec *fec = priv->fec;
        int ievent;

        ievent = in_be32(&fec->ievent);
        out_be32(&fec->ievent, ievent);         /* clear pending events */

        if (ievent & (FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {
                if (ievent & FEC_IEVENT_RFIFO_ERROR)
-->                        printk(KERN_WARNING "FEC_IEVENT_RFIFO_ERROR\n");
                if (ievent & FEC_IEVENT_XFIFO_ERROR)
                        printk(KERN_WARNING "FEC_IEVENT_XFIFO_ERROR\n");
                fec_reinit(dev);
        }
        else if (ievent & FEC_IEVENT_MII)
                fec_mii(dev);
        return IRQ_HANDLED;
}
-------------------------------------------------------------------------------------------------


This is what I found in MPC5200 Users Manual:
Receive FIFO Error--indicates error occurred within the forest green version
RX FIFO. When RFIFO_ERROR bit is set, ECNTRL.ETHER_EN is cleared,
halting FEC frame processing. When this occurs, software must ensure both
the FIFO Controller and BestComm are soft-reset.

Any ideas on what could be causing this?
