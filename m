Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 036151007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 12:38:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [RFC PATCH 2/2 -mm] RapidIO: TSI721 Add DMA Engine support
Date: Tue, 4 Oct 2011 18:38:09 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552022D6319@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20111004144353.18087914.akpm00@gmail.com>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com><1317418715-9666-2-git-send-email-alexandre.bounine@idt.com><20110930151544.31875132.akpm00@gmail.com><0CE8B6BE3C4AD74AB97D9D29BD24E55202291E8D@CORPEXCH1.na.ads.idt.com>
	<20111004144353.18087914.akpm00@gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm00@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton wrote:
>=20
> On Mon, 3 Oct 2011 10:53:45 -0700
> "Bounine, Alexandre" <Alexandre.Bounine@idt.com> wrote:
>=20
> > > > +	memset(bd_ptr, 0, bd_num * sizeof(struct
tsi721_dma_desc));
> > > > +
> > > > +	dev_dbg(dev, "DMA descriptors @ %p (phys =3D %llx)\n",
> > > > +		bd_ptr, (unsigned long long)bd_phys);
> > > > +
> > > > +	/* Allocate space for descriptor status FIFO */
> > > > +	sts_size =3D (bd_num >=3D TSI721_DMA_MINSTSSZ) ?
> > > > +					bd_num :
TSI721_DMA_MINSTSSZ;
> > > > +	sts_size =3D roundup_pow_of_two(sts_size);
> > > > +	sts_ptr =3D dma_alloc_coherent(dev,
> > > > +				     sts_size * sizeof(struct
> > tsi721_dma_sts),
> > > > +				     &sts_phys, GFP_KERNEL);
> > > > +	if (!sts_ptr) {
> > > > +		/* Free space allocated for DMA descriptors */
> > > > +		dma_free_coherent(dev,
> > > > +				  bd_num * sizeof(struct
> > tsi721_dma_desc),
> > > > +				  bd_ptr, bd_phys);
> > > > +		chan->bd_base =3D NULL;
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	chan->sts_phys =3D sts_phys;
> > > > +	chan->sts_base =3D sts_ptr;
> > > > +	chan->sts_size =3D sts_size;
> > > > +
> > > > +	memset(sts_ptr, 0, sts_size);
> > >
> > > You meant
> >
> > I really need it here. That status block tracks progress by keeping
> > non-zero addresses of processed descriptors.
>=20
> Confused.  Are you saying that the use of "sts_size" there was
> intentional?

Sorry, somehow I mistakenly linked this comment to dma_zalloc_coherent()
because of use of memset.
Yes, it should be "sts_size * sizeof(struct tsi721_dma_sts)" as
allocated.

> > >
> > > --- a/drivers/rapidio/devices/tsi721.c~rapidio-tsi721-add-dma-
> engine-
> > > support-fix
> > > +++ a/drivers/rapidio/devices/tsi721.c
> > > @@ -1006,7 +1006,7 @@ static int tsi721_bdma_maint_init(struct
> > >  	priv->mdma.sts_base =3D sts_ptr;
> > >  	priv->mdma.sts_size =3D sts_size;
> > >
> > > -	memset(sts_ptr, 0, sts_size);
> > > +	memset(sts_ptr, 0, sts_size * sizeof(struct tsi721_dma_sts));
> > >
> > >  	dev_dbg(&priv->pdev->dev,
> > >  		"desc status FIFO @ %p (phys =3D %llx) size=3D0x%x\n",
> > >
> > > However that's at least two instances where you wanted a
> > > dma_zalloc_coherent().  How's about we give ourselves one?
> >
> > Does this mean that I am on hook for it as a "most frequent user"?
>=20
> No, it can be used all over the place: drivers/net/irda/w83977af_ir.c,
> drivers/scsi/bnx2fc/bnx2fc_tgt.c,
> drivers/net/wireless/rt2x00/rt2x00pci.c,
> drivers/crypto/amcc/crypto4xx_core.c and many nmore.

In this case I will happily use dma_zalloc_coherent() as soon as
it is available
