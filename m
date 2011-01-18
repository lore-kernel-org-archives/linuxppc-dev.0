Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54724B711B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 09:47:33 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0IMaQn1008446
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 15:36:26 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0IMlRAF091280
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 15:47:27 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0IMlPRv023499
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 15:47:26 -0700
Date: Tue, 18 Jan 2011 14:47:18 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110118224718.GA19039@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110118123152.50f75a72@kryten>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.01.2011 [12:31:52 +1100], Anton Blanchard wrote:
> Hi,
> 
> I was testing 2.6.37-git17 on a POWER7 with virtual IO and hit this:
> 
> Trying to unpack rootfs image as initramfs...
> Freeing initrd memory: 7446k freed
> vio 30000000: Warning: IOMMU dma not supported: mask
> 0xffffffffffffffff, table unavailable
> vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> table unavailable
> vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> table unavailable
> vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> table unavailable
> vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
> table unavailable
> audit: initializing netlink socket (disabled)
> 
> Haven't had a chance to look closer yet.

After debugging a bit, this would appear to be due to the second hunk of
b3c73856ae47d43d0d181f9de1c1c6c0820c4515.

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index b265405..1b695fd 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1257,6 +1257,10 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
        viodev->dev.parent = &vio_bus_device.dev;
        viodev->dev.bus = &vio_bus_type;
        viodev->dev.release = vio_dev_release;
+        /* needed to ensure proper operation of coherent allocations
+         * later, in case driver doesn't set it explicitly */
+        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
+        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));

        /* register with generic device framework */
        if (device_register(&viodev->dev)) {

Milton, Sonny, any thoughts?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
