Return-Path: <akpm00@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 942001007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 08:44:00 +1100 (EST)
Received: by qyk32 with SMTP id 32so3994380qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Oct 2011 14:43:56 -0700 (PDT)
Date: Tue, 4 Oct 2011 14:43:53 -0700
From: Andrew Morton <akpm00@gmail.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [RFC PATCH 2/2 -mm] RapidIO: TSI721 Add DMA Engine support
Message-Id: <20111004144353.18087914.akpm00@gmail.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55202291E8D@CORPEXCH1.na.ads.idt.com>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com>
	<1317418715-9666-2-git-send-email-alexandre.bounine@idt.com>
	<20110930151544.31875132.akpm00@gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55202291E8D@CORPEXCH1.na.ads.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 3 Oct 2011 10:53:45 -0700
"Bounine, Alexandre" <Alexandre.Bounine@idt.com> wrote:

> > > +	memset(bd_ptr, 0, bd_num * sizeof(struct tsi721_dma_desc));
> > > +
> > > +	dev_dbg(dev, "DMA descriptors @ %p (phys = %llx)\n",
> > > +		bd_ptr, (unsigned long long)bd_phys);
> > > +
> > > +	/* Allocate space for descriptor status FIFO */
> > > +	sts_size = (bd_num >= TSI721_DMA_MINSTSSZ) ?
> > > +					bd_num : TSI721_DMA_MINSTSSZ;
> > > +	sts_size = roundup_pow_of_two(sts_size);
> > > +	sts_ptr = dma_alloc_coherent(dev,
> > > +				     sts_size * sizeof(struct
> tsi721_dma_sts),
> > > +				     &sts_phys, GFP_KERNEL);
> > > +	if (!sts_ptr) {
> > > +		/* Free space allocated for DMA descriptors */
> > > +		dma_free_coherent(dev,
> > > +				  bd_num * sizeof(struct
> tsi721_dma_desc),
> > > +				  bd_ptr, bd_phys);
> > > +		chan->bd_base = NULL;
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	chan->sts_phys = sts_phys;
> > > +	chan->sts_base = sts_ptr;
> > > +	chan->sts_size = sts_size;
> > > +
> > > +	memset(sts_ptr, 0, sts_size);
> > 
> > You meant
> 
> I really need it here. That status block tracks progress by keeping
> non-zero addresses of processed descriptors.

Confused.  Are you saying that the use of "sts_size" there was
intentional?

> > 
> > --- a/drivers/rapidio/devices/tsi721.c~rapidio-tsi721-add-dma-engine-
> > support-fix
> > +++ a/drivers/rapidio/devices/tsi721.c
> > @@ -1006,7 +1006,7 @@ static int tsi721_bdma_maint_init(struct
> >  	priv->mdma.sts_base = sts_ptr;
> >  	priv->mdma.sts_size = sts_size;
> > 
> > -	memset(sts_ptr, 0, sts_size);
> > +	memset(sts_ptr, 0, sts_size * sizeof(struct tsi721_dma_sts));
> > 
> >  	dev_dbg(&priv->pdev->dev,
> >  		"desc status FIFO @ %p (phys = %llx) size=0x%x\n",
> > 
> > However that's at least two instances where you wanted a
> > dma_zalloc_coherent().  How's about we give ourselves one?
> 
> Does this mean that I am on hook for it as a "most frequent user"?

No, it can be used all over the place: drivers/net/irda/w83977af_ir.c,
drivers/scsi/bnx2fc/bnx2fc_tgt.c,
drivers/net/wireless/rt2x00/rt2x00pci.c,
drivers/crypto/amcc/crypto4xx_core.c and many nmore.
