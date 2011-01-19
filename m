Return-Path: <nacc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55BFCB70B3
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 15:38:05 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0J4ZZW1027821
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 21:35:35 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0J4c2GS076560
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 21:38:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0J4c1Y9020585
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 21:38:01 -0700
Date: Tue, 18 Jan 2011 20:37:57 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110119043757.GA29865@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295409980.2148.125.camel@pasglop>
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

On 19.01.2011 [15:06:20 +1100], Benjamin Herrenschmidt wrote:
> On Tue, 2011-01-18 at 14:47 -0800, Nishanth Aravamudan wrote:
> > On 18.01.2011 [12:31:52 +1100], Anton Blanchard wrote:
> > > Hi,
> > > 
> > > I was testing 2.6.37-git17 on a POWER7 with virtual IO and hit this:
> > > 
> > > Trying to unpack rootfs image as initramfs...
> > > Freeing initrd memory: 7446k freed
> > > vio 30000000: Warning: IOMMU dma not supported: mask
> > > 0xffffffffffffffff, table unavailable
> > > vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > > table unavailable
> > > vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > > table unavailable
> > > vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > > table unavailable
> > > vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > > table unavailable
> > > audit: initializing netlink socket (disabled)
> > > 
> > > Haven't had a chance to look closer yet.
> 
> Well, this causes messages for vdevices that don't do DMA at all (such
> as vterm etc...) and don't have the necessary properties. However, it
> didn't -break- anything for me in my tests so far, just spurrious
> messages. Not sure what's up with Anton's setup. Anton, can you hack the
> printk to display the OF path to the device so we see what devices are
> complaining ? It could be a different issue that prevents booting.

Is this what you were looking for?

vio 30000000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
vio 30000000: Path: /vdevice/vty@30000000
vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
vio 4000: Path: /vdevice/IBM,sp@4000
vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
vio 4001: Path: /vdevice/rtc@4001
vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
vio 4002: Path: /vdevice/nvram@4002
vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable
vio 4004: Path: /vdevice/gscsi@4004

FWIW, I looked at Anton's logs, and I don't think the boot failed, per
se. I think it may have timed out (but not positive on that). I was able
to boot 2.6.27-git17 on the exact same box, albeit it locks up at a
later point (the sd abort I e-mailed about in a follow-up).



> 
> Cheers,
> Ben.
> 
> > After debugging a bit, this would appear to be due to the second hunk of
> > b3c73856ae47d43d0d181f9de1c1c6c0820c4515.
> > 
> > diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> > index b265405..1b695fd 100644
> > --- a/arch/powerpc/kernel/vio.c
> > +++ b/arch/powerpc/kernel/vio.c
> > @@ -1257,6 +1257,10 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> >         viodev->dev.parent = &vio_bus_device.dev;
> >         viodev->dev.bus = &vio_bus_type;
> >         viodev->dev.release = vio_dev_release;
> > +        /* needed to ensure proper operation of coherent allocations
> > +         * later, in case driver doesn't set it explicitly */
> > +        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
> > +        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
> > 
> >         /* register with generic device framework */
> >         if (device_register(&viodev->dev)) {
> > 
> > Milton, Sonny, any thoughts?
> > 
> > Thanks,
> > Nish
> > 
> 
> 

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
