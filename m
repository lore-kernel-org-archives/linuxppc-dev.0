Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9621BDDF3E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:46:12 +1100 (EST)
Subject: Re: [PATCH] dma: add new dma_mapping_ops API sync_page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Remi Machet <rmachet@slac.stanford.edu>
In-Reply-To: <1223314733.21869.38.camel@pcds-ts102.slac.stanford.edu>
References: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
	<1223051594.4251.12.camel@pcds-ts102.slac.stanford.edu>
	<48EA3D0C.1050107@freescale.com>
	<1223314733.21869.38.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:46:02 +1100
Message-Id: <1223610362.8157.139.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Linux PPC <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > A virtual address will typically be needed to perform the flush; why 
> > pass the bus address?

> Because it is a sync API. You want to make sure that a physical memory
> area is in sync with the caches, not the virtual address. This
> distinction can become important in the event where the page is mapped
> multiple times in the memory and the architecture does not take care of
> synchronizing the multiple mapping, the dma_mapping_ops code should be
> able to synchronize the multiple mapping. In most case it would be easy
> of course to go from virtual address to the page address, but not if the
> page is in high memory ...

Well, not really. IE, you are right that a dma_addr_t or a struct page
is the way to go but for the wrong reasons :-)

All mappings should be coherent. The powerpc architecture is pretty
strict with that. The only known violation is the instruction cache on
44x but that's irrelevant to your problem.

Thus, -any- virtual address will do.

However, you may not have a virtual address. You may get into a
situation where the page isn't in the linear mapping and needs to be
kmap'ed for the sync to happen.

Now, using PCI_DRAM_OFFSET in bus_to_page() is incorrect here with
Becky's new set of changes. You need to get the offset properly using
the accessor she provides (I don't have the name off the top of my
head).

Cheers,
Ben.
