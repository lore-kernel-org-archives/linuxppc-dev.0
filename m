Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11F5867BD7
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 09:20:40 +1100 (EST)
Subject: Re: [PATCH 9/16] Supporting of PCI bus for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611171040.kAHAeYGG017561@toshiba.co.jp>
References: <200611171040.kAHAeYGG017561@toshiba.co.jp>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 09:20:51 +1100
Message-Id: <1163802051.5826.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  We think that a new bus type should be defined for IOIFs, as they are 
> not PCI, not virtual buses. We did't have enough time to examine what 
> kind of method is the best, implement to kernel and then modify device 
> drivers..

It mostly depends on wether you need specific methods for devices in
there or you can just use some generic platform bus type. The later is
the approach we have taken with the Axon chip in the new blades. We
basically register everything under the IOIFs as of_platform_device and
use standard OF device-tree matching to attach drivers.

>  Thank you. kzalloc is safer and simpler.
>  This function is now called from setup_arch only. The codes assumes 
> some future cases. As struct ioif includes pointer to iommu_table, this 
> will be used like pci_dn. (with more member variables.. we think.)
>  The name will be struct ioif_dn? (and will include pointer to struct 
> device_node)

You don't need to use pci_dn anymore for DMA mappings with the code I've
merged in powerpc.git. There is a generic extension to struct device
providing dma mappings ops for any device.

That's how I handle DMA with of_platform_device on Axon for example.

Now, you can still use your own bus type if you want (it's actually
fairly simple to add a bus type to linux), if you feel like you need
additional specific informations per device than what of_platform_device
covers.

In that case, I would suggest laying it out on top of of_device, like
of_platform_device itself does, or like macio_device (you can see the
later in drivers/macintosh/macio_asic).

That way, you keep an open firmware based matching
(name/type/compatible).

Ben.
