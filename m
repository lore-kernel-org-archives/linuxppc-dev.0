Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A77FDB6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 15:54:46 +1100 (EST)
Subject: Re: 2.6.37-git17 virtual IO boot failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20110119043757.GA29865@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com> <1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 15:54:38 +1100
Message-ID: <1295412878.2148.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sonnyrao@us.ibm.com,
	Anton Blanchard <anton@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-01-18 at 20:37 -0800, Nishanth Aravamudan wrote:

> Is this what you were looking for?
> 
> vio 30000000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
> vio 30000000: Path: /vdevice/vty@30000000
> vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
> vio 4000: Path: /vdevice/IBM,sp@4000
> vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
> vio 4001: Path: /vdevice/rtc@4001
> vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
> vio 4002: Path: /vdevice/nvram@4002
> vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
> vio 4004: Path: /vdevice/gscsi@4004

Ok, so they are all harmess (none of those device do DMA, appart maybe
gscsi, I have no idea what it is :-)

> FWIW, I looked at Anton's logs, and I don't think the boot failed, per
> se. I think it may have timed out (but not positive on that). I was able
> to boot 2.6.27-git17 on the exact same box, albeit it locks up at a
> later point (the sd abort I e-mailed about in a follow-up).

I haven't seen your email. I'll dig. Have to run now.

Cheers,
Ben.

> 
> 
> > 
> > Cheers,
> > Ben.
> > 
> > > After debugging a bit, this would appear to be due to the second hunk of
> > > b3c73856ae47d43d0d181f9de1c1c6c0820c4515.
> > > 
> > > diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> > > index b265405..1b695fd 100644
> > > --- a/arch/powerpc/kernel/vio.c
> > > +++ b/arch/powerpc/kernel/vio.c
> > > @@ -1257,6 +1257,10 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> > >         viodev->dev.parent = &vio_bus_device.dev;
> > >         viodev->dev.bus = &vio_bus_type;
> > >         viodev->dev.release = vio_dev_release;
> > > +        /* needed to ensure proper operation of coherent allocations
> > > +         * later, in case driver doesn't set it explicitly */
> > > +        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
> > > +        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
> > > 
> > >         /* register with generic device framework */
> > >         if (device_register(&viodev->dev)) {
> > > 
> > > Milton, Sonny, any thoughts?
> > > 
> > > Thanks,
> > > Nish
> > > 
> > 
> > 
> 
