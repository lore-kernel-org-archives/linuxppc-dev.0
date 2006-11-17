Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E595567A39
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 09:08:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/16] Supporting of PCI bus for Celleb
Date: Fri, 17 Nov 2006 23:08:44 +0100
References: <200611171040.kAHAeYGG017561@toshiba.co.jp>
In-Reply-To: <200611171040.kAHAeYGG017561@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611172308.44656.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 November 2006 11:40, Ishizaki Kou wrote:
> Hi Christoph-san,
>

>  There were some reasons why we made such  temporary design:
> - To design a new bus seemed to be large scale development and would
> affect large parts of original powerpc codes.
> - Some existing drivers for celleb device(i.e. spider_net) depends on
> PCI methods.
>
>  We think that a new bus type should be defined for IOIFs, as they are
> not PCI, not virtual buses. We did't have enough time to examine what
> kind of method is the best, implement to kernel and then modify device
> drivers..

We are currently in the process of defining similar structures for
the IBM Axon chip, the patches have now been merged in the powerpc.git
tree, but not yet in 2.6.19-rc.

I don't think defining IOIF as the new bus type is the right
approach, it makes more sense to define devices the way they
are connected inside of the chip with an internal bus, e.g. PLB4,
OPC, SiliconBackplane or similar things.

The probing of the devices connected to any of these buses is then
done from of_platform_bus_probe().

> > Struct ioif is a bit too generic, can you give it a better name?
>
>  Thank you. kzalloc is safer and simpler.
>  This function is now called from setup_arch only. The codes assumes
> some future cases. As struct ioif includes pointer to iommu_table, this
> will be used like pci_dn. (with more member variables.. we think.)
>  The name will be struct ioif_dn? (and will include pointer to struct
> device_node)

Please look at the new code that Benjamin Herrenschmidt did in the
current powerpc.git as a reference. I think you don't need a replacement
for pci_dn here.

	Arnd <><
