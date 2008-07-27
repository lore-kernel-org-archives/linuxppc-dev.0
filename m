Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 96E88DDE08
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:04:46 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4716513wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:04:46 -0700 (PDT)
Date: Sat, 26 Jul 2008 19:31:27 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
Message-ID: <20080727013127.GI12191@secretlab.ca>
References: <20080710123909.GA4275@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080710123909.GA4275@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 02:39:09PM +0200, Wolfram Sang wrote:
> Hello,
> 
> today, I was debugging a kernel crash on a board with a MPC5200B using
> 2.6.26-rc9. I found the following code in drivers/net/fec_mpc52xx.c:
> 
> static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
> {
> [...]
> 	/* on fifo error, soft-reset fec */
> 	if (ievent & (FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {
> 
> 		if (net_ratelimit() && (ievent & FEC_IEVENT_RFIFO_ERROR))
> 			dev_warn(&dev->dev, "FEC_IEVENT_RFIFO_ERROR\n");
> 		if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
> 			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
> 
> 		mpc52xx_fec_reset(dev);
> 
> 		netif_wake_queue(dev);
> 		return IRQ_HANDLED;
> 	}
> [...]
> }
> 
> Calling mpc52xx_fec_reset() from interrupt context is bad, at least
> because
> 
> a) it calls phy_write, which contains BUG_ON(in_interrupt())
> b) it calls mpc52xx_fec_hw_init, which has a delay-loop to check
>    if the reset was successful (1..50 us)
> 
> I assume the proper thing to do is to set a flag in the ISR and handle
> the soft reset later in some other context. Having never dealt with the
> network core and its drivers so far, I am not sure which place would be
> the right one to perform the soft reset. To not make things worse, I
> hope people with more insight to network stuff can deliver a suitable
> solution to this problem.
> 
> All the best,
> 
>    Wolfram

Hi Wolfram,

I'm not an expert on the FEC driver, but I'll take a look when I get back
home to Calgary.  There has also been other churn in this area and I
need to get myself up to speed.

g.
