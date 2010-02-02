Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 5A7B6B7D57
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 08:36:56 +1100 (EST)
Date: Tue, 2 Feb 2010 13:36:54 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 8/8] fsldma: major cleanups and fixes
Message-ID: <20100202213654.GD2609@ovro.caltech.edu>
References: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
	<1262820846-13198-9-git-send-email-iws@ovro.caltech.edu>
	<4B6892F4.9070906@intel.com>
	<20100202211656.GA2609@ovro.caltech.edu> <4B6897BC.60203@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B6897BC.60203@intel.com>
Cc: "R58472@freescale.com" <R58472@freescale.com>,
	"B04825@freescale.com" <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"scottwood@freescale.com" <scottwood@freescale.com>,
	"Dipen.Dudhat@freescale.com" <Dipen.Dudhat@freescale.com>,
	"Maneesh.Gupta@freescale.com" <Maneesh.Gupta@freescale.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 02, 2010 at 02:23:08PM -0700, Dan Williams wrote:
> Ira W. Snyder wrote:
> > In the fsldma driver, all callbacks are run from tasklet (softirq)
> > context. That's under local_irq_disable(), right? Hardirq's certainly
> > aren't disabled there.
> 
> Actually, my mistake, the cleanup routine does spin_lock_irqsave(), but 
> I now see that it drops the lock across the callback:
> 
> /* Run the link descriptor callback function */
> if (callback) {
> 	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
> 	dev_dbg(fsl_chan->dev, "link descriptor %p callback\n", desc);
> 	callback(callback_param);
> 	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
> }
> 
> ...so I retract my comment about surprising the raid5 code.

I'm glad to hear that :)

Thanks for picking up the patches.
Ira
