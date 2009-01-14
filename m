Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 2F762DE04A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:15:32 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so75867eyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:15:30 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
	<496E0E85.7060801@freescale.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 Jan 2009 17:15:28 +0100
In-Reply-To: <496E0E85.7060801@freescale.com> (Timur Tabi's message of "Wed\,
	14 Jan 2009 10\:10\:45 -0600")
Message-ID: <87iqohc19b.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Timur" == Timur Tabi <timur@freescale.com> writes:

 Timur> Peter Korsgaard wrote:
 >> @@ -875,7 +875,8 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 >> }
 >> 
 >> dev_info(fdev->dev, "#%d (%s), irq %d\n", new_fsl_chan->id,
 >> -				compatible, new_fsl_chan->irq);
 >> +		 compatible,
 >> +		 new_fsl_chan->irq != NO_IRQ ? new_fsl_chan->irq : fdev->irq);

 Timur> Wouldn't it be better to make sure that, on 83xx,
 Timur> new_fsl_chan->irq has the same value as fdev->irq before we
 Timur> get here?

Why? Does it buy us anything to request_irq again for each channel?

Now we're at it, it seems like there's a check for != NO_IRQ missing
in fsl_dma_chan_remove().

-- 
Bye, Peter Korsgaard
