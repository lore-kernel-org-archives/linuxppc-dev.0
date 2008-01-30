Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 2A0E4DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 11:54:48 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
Date: Wed, 30 Jan 2008 01:54:01 +0100
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1201619625.10012.19.camel@concordia>
	<20080129155048.GA19822@lixom.net>
In-Reply-To: <20080129155048.GA19822@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801300154.02358.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 January 2008, Olof Johansson wrote:
> 
> > > Shouldn't the fixed mapping be between 4G and 8G (and the offset for 1G
> > > is at 5G), to account for the MMIO range at 2-4G?
> > 
> > I don't think so, ie. it works setup like that, but I'm not entirely
> > sure why. Presumably the 2-4GB for MMIO is only for cycles heading out
> > of the CPU.
> 
> Ben denied that being so yesterday. :-)
> 
> If that's the case, then you can stick the dynamic range there for >32GB
> configs, since it's still addressable with 32 bits.
> 

For addresses going from the CPU to the bus, RAM is occupying everything
from zero to SIZE_OF_RAM, while PCI MMIO starts at LARGE_NUMBER+2GB.

As seen from the PCI bus, DMA addresses for RAM range from zero to 2GB,
while the MMIO space is between 2GB and 4GB. The 64 bit space for
the linear mapping is between EVEN_LARGER_NUMBER and
EVEN_LARGER_NUMBER+SIZE_OF_RAM.

The bridge chip remaps EVEN_LARGER_NUMBER to zero when going into the IOMMU,
so that the IOMMU can fit both SIZE_OF_RAM and the dynamic DMA window
into the 32GB bus address range.

I don't see how it should be possible here to reuse the 2-4GB range
for anything else.

	Arnd <><
