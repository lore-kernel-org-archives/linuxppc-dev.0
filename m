Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17012B70EB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 15:06:33 +1100 (EST)
Subject: Re: 2.6.37-git17 virtual IO boot failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20110118224718.GA19039@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 15:06:20 +1100
Message-ID: <1295409980.2148.125.camel@pasglop>
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

On Tue, 2011-01-18 at 14:47 -0800, Nishanth Aravamudan wrote:
> On 18.01.2011 [12:31:52 +1100], Anton Blanchard wrote:
> > Hi,
> > 
> > I was testing 2.6.37-git17 on a POWER7 with virtual IO and hit this:
> > 
> > Trying to unpack rootfs image as initramfs...
> > Freeing initrd memory: 7446k freed
> > vio 30000000: Warning: IOMMU dma not supported: mask
> > 0xffffffffffffffff, table unavailable
> > vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > table unavailable
> > vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > table unavailable
> > vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > table unavailable
> > vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> > table unavailable
> > audit: initializing netlink socket (disabled)
> > 
> > Haven't had a chance to look closer yet.

Well, this causes messages for vdevices that don't do DMA at all (such
as vterm etc...) and don't have the necessary properties. However, it
didn't -break- anything for me in my tests so far, just spurrious
messages. Not sure what's up with Anton's setup. Anton, can you hack the
printk to display the OF path to the device so we see what devices are
complaining ? It could be a different issue that prevents booting.

Cheers,
Ben.

> After debugging a bit, this would appear to be due to the second hunk of
> b3c73856ae47d43d0d181f9de1c1c6c0820c4515.
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index b265405..1b695fd 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1257,6 +1257,10 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>         viodev->dev.parent = &vio_bus_device.dev;
>         viodev->dev.bus = &vio_bus_type;
>         viodev->dev.release = vio_dev_release;
> +        /* needed to ensure proper operation of coherent allocations
> +         * later, in case driver doesn't set it explicitly */
> +        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
> +        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
> 
>         /* register with generic device framework */
>         if (device_register(&viodev->dev)) {
> 
> Milton, Sonny, any thoughts?
> 
> Thanks,
> Nish
> 
