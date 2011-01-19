Return-Path: <nacc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9C53B708B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 11:48:36 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0J0OoQN005665
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 19:25:08 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F40974DE804E
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 19:45:15 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0J0mTwJ2338998
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 19:48:31 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0J0mSvv003823
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 19:48:29 -0500
Date: Tue, 18 Jan 2011 16:48:24 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110119004824.GA20441@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110118224718.GA19039@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.01.2011 [14:47:18 -0800], Nishanth Aravamudan wrote:
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
> 
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

A bit more detail after trying a few more kernels on the box that
originally showed the error:

1) This doesn't actually prevent booting, afaict. I think it "just"
disables DMA, which is bad, but not a boot fail, technically.

2) Reverting the above commit definitely prevents those messages.

3) I'm seeing a separate issue with 2.6.37-git17 (that's not present in
2.6.37):

sd 0:4:2:0: [sda] Aborting command: 2A
sd 0:4:2:0: Abort timed out. Resetting bus.

At which point the box locks up :)

So testing fixes is a bit of a challenge right now.

Ben, if you're ok with waiting to see if Milton or Sonny have any ideas,
I'd like to hold off on asking for a revert. In the case they do, I'll
be able to test and send out any proposed fix rapidly.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
