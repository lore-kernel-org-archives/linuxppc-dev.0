Return-Path: <olof@lixom.net>
Date: Tue, 29 Jan 2008 15:36:46 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
Message-ID: <20080129213646.GA28997@lixom.net>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
	<20080129151511.GA18975@lixom.net>
	<1201619625.10012.19.camel@concordia>
	<1201641495.6815.207.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201641495.6815.207.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 08:18:15AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-01-30 at 02:13 +1100, Michael Ellerman wrote:
> > On Tue, 2008-01-29 at 09:15 -0600, Olof Johansson wrote:
> > > On Wed, Jan 30, 2008 at 01:14:03AM +1100, Michael Ellerman wrote:
> > > 
> > > > For example a machine with 4GB of memory would end up with the normal
> > > > IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. In
> > > > this case a 64-bit device wishing to DMA to 1GB would be told to DMA to
> > > > 3GB, plus any offset required by firmware. The firmware offset is encoded
> > > > in the "dma-ranges" property.
> > > 
> > > Shouldn't the fixed mapping be between 4G and 8G (and the offset for 1G
> > > is at 5G), to account for the MMIO range at 2-4G?
> > 
> > I don't think so, ie. it works setup like that, but I'm not entirely
> > sure why. Presumably the 2-4GB for MMIO is only for cycles heading out
> > of the CPU.
> 
> No no no... it's because on the PCI segment, it's all offset up
> remember ?
> 
> Basically, the PCI host bridge on these has 2 interesting windows for
> us:
> 
> 0....2G			-> This goes up to memory @0 (via a couple of 
>                            layers)
> 
> 0x80*....0xF*		-> This goes untranslated to the PLB5 which
>   			   drops the top bits and does some other 
>                            manipulations, which allows to access, among
>                            others the full 32GB of the cell inbound 
>                            range.
> 
> The MMIO region of 2...4G is on the PCI (outbound from the Cell is yet
> another range of addresses with different constraints but that ends up
> generating cycles between 2 and 4G on the PCI segment).
> 
> If we had set the direct mapped region so that it uses 2G...N on PCI, we
> would indeed be toast. But instead, the addresses for direct DMA that we
> hand out to devices are in the 0x80* region and go hit the cell
> directly, they never match MMIO.

Yeah, ok. That makes more sense. Thanks for the clarification.

Michael, btw, I wonder if it would make sense to duplicate the patch
description at the top of the file as well, since it'll be lost in the
change log for people who don't go back and read history, and having
the intentions documented in the file could be a good idea.



-Olof
