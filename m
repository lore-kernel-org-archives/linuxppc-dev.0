Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
Date: Sat, 5 Jul 2008 23:51:39 +0200
References: <20080704190535.316377278@arndb.de>
	<1215236584.7424.2.camel@localhost>
	<1215239339.8970.10.camel@pasglop>
In-Reply-To: <1215239339.8970.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807052351.39945.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 July 2008, Benjamin Herrenschmidt wrote:
> On Sat, 2008-07-05 at 15:43 +1000, Michael Ellerman wrote:
> > > The current Cell IOMMU implementation sets the IOPTE_SO_RW bits in all IOTPEs
> > > (for both the dynamic and fixed mappings) which enforces strong ordering of
> > > both reads and writes. This patch makes the default behaviour weak ordering
> > > (the IOPTE_SO_RW bits not set) and to request a strongly ordered mapping the
> > > new DMA_ATTR_STRONG_ORDERING needs to be used.
> > 
> > We're sure that's safe?
> 
> I'd say it's not...

It turned out that the firmware sets up the south bridge to never set the 'S'
bit on incoming transactions, which overrides the IOPTE_SO_RW bits, on all
existing cell hardware.

This weak ordering gives the same ordering guarantees as the default ordering
for DMA on other PowerPC machines. Setting strong ordering on both the host
bridge *and* the page table will give further ordering guarantees, i.e.
it will make sure that no DMA requests on the bus can ever overtake each
other.

	Arnd <><
