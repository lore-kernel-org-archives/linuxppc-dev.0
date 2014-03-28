Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51A75140092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 14:03:06 +1100 (EST)
Date: Fri, 28 Mar 2014 10:41:00 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Add isr to deal with error flag
Message-ID: <20140328024059.GA18417@MrMyself>
References: <1395918419-20739-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140327132626.GN30768@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140327132626.GN30768@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, David.Laight@ACULAB.COM, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2014 at 01:26:27PM +0000, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 07:06:59PM +0800, Nicolin Chen wrote:
> > It's quite cricial to clear error flags because SAI might hang if getting
> > FIFO underrun during playback (I haven't confirmed the same issue on Rx
> > overflow though).
> > 
> > So this patch enables those irq and adds isr() to clear the flags so as to
> > keep playback entirely safe.
> 
> So, I've applied this since we're (hopefully!) very near the merge
> window opening and it seems like it should be an improvement overall.
> However a few things below:
> 
> > +	/* Only handle those what we enabled */
> > +	mask = (FSL_SAI_FLAGS >> FSL_SAI_CSR_xIE_SHIFT) << FSL_SAI_CSR_xF_SHIFT;
> 
> The shifting here could use a comment.

Will send an extra patch to cover it.

> > +	regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
> > +			   FSL_SAI_CSR_xF_W_MASK | FSL_SAI_CSR_FR, xcsr);
> 
> Using update_bits() is going to do an extra read, better to do this as:
> 
> 	if (xcsr)
> 		regmap_write(sai->regmap, FSL_SAI_RCSR, xcsr);

T/RCSR register stands for T/Rx Control (Status -- I guess) Register.
It actually contains control bits, IRQ mask bits and IRQ status bits.
Thus we can't regard it as a entire status register. That's why I try
to update it partially for status bits only at this point.

But if it's just for saving this extra read instance, I may save those
non-status bits from upper regmap_read() and then merge them into this
regmap_write() over here.

> otherwise we might be ignoring any of the bits that are actually clear
> on read (it seems like there are some?).

For all status flags bits, actually five for each, three of them are
write-1-clear and the other two are self-clearance by SAI self -- so
none of them are clear-on-read type.

> > +	return IRQ_HANDLED;
> 
> I'd expect to see IRQ_NONE if we didn't actually see an interrupt
> source.

Will add this.

Thank you,
Nicolin
