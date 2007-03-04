Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2CFE0DDFBF
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 16:40:49 +1100 (EST)
Date: Sat, 3 Mar 2007 23:52:21 -0600
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070304055221.GA11982@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070302222748.GA1206@lixom.net>
	<1172910451.8184.51.camel@localhost.localdomain>
	<20070304051738.GA30747@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070304051738.GA30747@lst.de>
From: olof@lixom.net (Olof Johansson)
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 04, 2007 at 06:17:38AM +0100, Christoph Hellwig wrote:
> On Sat, Mar 03, 2007 at 09:27:31AM +0100, Benjamin Herrenschmidt wrote:
> > - Drivers are broken -today- and I doubt they can all be audited and
> > fixed (and fixes bacported to distros) quickly
> 
> Which drivers?  All requests coming from the block layer make sure
> you never span the 4GB boundary, and IIRC that same is true for
> networking.  Similarly dma_alloc_coherent and pci_alloc_consinstant
> only allocate from the lower 4G unless told otherwise. 

Since the IOMMU layer adds a completely independent address space, any
mapping might end up straddling the boundary if you're unlucky. But, with
the above info, adding the restrictions in the iommu code seems safer --
at least it won't cause problems on non-translated enviromnents if the
block and network code makes sure it can't happen there.

> A driver writer
> would have to be extra-ordinarily stuid to get this wrong.  (And yes,
> some driver writers are..)

Any pci_map_single or friends should be able to end up there based on
how the iommu allocator works. It doesn't take into consideration any
kind of alignment of the physical regions being mapped.


-Olof
