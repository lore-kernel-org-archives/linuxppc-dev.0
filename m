Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807052351.39945.arnd@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<1215236584.7424.2.camel@localhost> <1215239339.8970.10.camel@pasglop>
	<200807052351.39945.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 06 Jul 2008 08:20:48 +1000
Message-Id: <1215296448.8970.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-07-05 at 23:51 +0200, Arnd Bergmann wrote:
> 
> It turned out that the firmware sets up the south bridge to never set the 'S'
> bit on incoming transactions, which overrides the IOPTE_SO_RW bits, on all
> existing cell hardware.
> 
> This weak ordering gives the same ordering guarantees as the default ordering
> for DMA on other PowerPC machines. Setting strong ordering on both the host
> bridge *and* the page table will give further ordering guarantees, i.e.
> it will make sure that no DMA requests on the bus can ever overtake each
> other

I need to look closely at what the various bridge settings are. Drivers
do expect DMA requests from one device to stay in order, at least up to
what's defined in the PCI spec, which is pretty much fully ordered
unless those devices set the PCIe (or X) relaxed ordering attribute.
However, AFAIK, Axon doesn't convey that sort of ordering attributes
from incoming transactions between the PCIe segment and the PLB5.

Ben.
