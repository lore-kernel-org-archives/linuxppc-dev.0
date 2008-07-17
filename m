Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 9/9] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807160954.03633.arnd@arndb.de>
References: <20080715195139.316677337@arndb.de>
	<200807152327.06946.arnd@arndb.de> <ada7ibmd115.fsf@cisco.com>
	<200807160954.03633.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 16:20:43 +1000
Message-Id: <1216275643.7740.302.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
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

On Wed, 2008-07-16 at 09:54 +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2008, Roland Dreier wrote:
> >  > Strong ordering is only active when both the bridge and the IOMMU enable
> >  > it, but for correctly written drivers, this only results in a slowdown.
> > 
> > So when would someone use this dma attribute?  As a hack to fix drivers
> > where the real fix is too complicated?
> 
> This is used in the Axon PCIe endpoint drivers, e.g. in the Roadrunner
> machine. The reason was to improve roundtrip latency by doing only
> mmio stores, not loads, on each side of the PCIe connection, which
> turn into posted DMA operations on the other end. With relaxed ordering,
> the posted writes may be observed out of order. Strong ordering makes
> sure they arrive in-order without having to do a non-posted mmio read
> or eieio operation on the receiver side.

I don't think it's legal for writes from a given initiator to arrive to
memory out of order.

Some drivers, notably network drivers, for example, rely on the "OWN"
bit being written last in memory when writing back ring buffer status.

If the bit arrives before the actual data, then data corruption will
occur.

Ben.
