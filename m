Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3883FDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 09:54:39 +1100 (EST)
Subject: Re: [BUG/RFC/PATCH] drm: Fix for non-coherent DMA PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080302223012.90210@gmx.net>
References: <20071125234254.B4405DDE49@ozlabs.org>
	<20080302110505.175270@gmx.net> <1204490829.15052.482.camel@pasglop>
	<20080302223012.90210@gmx.net>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 09:54:07 +1100
Message-Id: <1204498447.15052.485.camel@pasglop>
Mime-Version: 1.0
Cc: airlied@linux.ie, linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Okay, I changed the code to this:
> 
> >DRM_DEBUG("dev = 0x%x, bus_address = 0x%x, bus_to_virt = 0x%lx, max_pages = 0x%x\n",
> >	(unsigned int)&dev->pdev->dev, bus_address,
> >	(unsigned long)virt_to_bus(bus_address), max_pages);
> >
> >if (gart_info->gart_table_location == DRM_ATI_GART_MAIN) {
> >	DRM_DEBUG("calling dma_sync_single_for_device()\n");
> >	dma_sync_single_for_device(&dev->pdev->dev,
> >		bus_address,
> >		max_pages * sizeof(u32),
> >		PCI_DMA_TODEVICE);
> >}
> 
> It looks like dma_sync_single_for_device() is not called here (the debug
> messages don't show up in kernel log). I also included the Xorg.0.log
> file.

Ok, try adding more debug then, around the calls to pci_map_single() in
that same function and dump the arguments. I'm especially interested
in the result of the various page_address().

Ben.
