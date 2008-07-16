Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [patch 9/9] powerpc/cell: Add DMA_ATTR_STRONG_ORDERING dma
	attribute and use in IOMMU code
Date: Wed, 16 Jul 2008 09:54:03 +0200
References: <20080715195139.316677337@arndb.de>
	<200807152327.06946.arnd@arndb.de> <ada7ibmd115.fsf@cisco.com>
In-Reply-To: <ada7ibmd115.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807160954.03633.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Roland Dreier wrote:
> =A0> Strong ordering is only active when both the bridge and the IOMMU en=
able
> =A0> it, but for correctly written drivers, this only results in a slowdo=
wn.
>=20
> So when would someone use this dma attribute? =A0As a hack to fix drivers
> where the real fix is too complicated?

This is used in the Axon PCIe endpoint drivers, e.g. in the Roadrunner
machine. The reason was to improve roundtrip latency by doing only
mmio stores, not loads, on each side of the PCIe connection, which
turn into posted DMA operations on the other end. With relaxed ordering,
the posted writes may be observed out of order. Strong ordering makes
sure they arrive in-order without having to do a non-posted mmio read
or eieio operation on the receiver side.

	Arnd <><
