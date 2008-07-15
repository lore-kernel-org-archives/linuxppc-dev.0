Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 9/9] powerpc/cell: Add DMA_ATTR_STRONG_ORDERING dma
	attribute and use in IOMMU code
Date: Tue, 15 Jul 2008 23:27:06 +0200
References: <20080715195139.316677337@arndb.de>
	<20080715195740.098068951@arndb.de> <ada3amaevj5.fsf@cisco.com>
In-Reply-To: <ada3amaevj5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807152327.06946.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Roland Dreier <rdreier@cisco.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 July 2008, Roland Dreier wrote:
> Sorry for the late comments, I missed this when it went by before.
>=20
> =C2=A0> +DMA_ATTR_STRONG_ORDERING
> =C2=A0> +----------------------
> =C2=A0> +
> =C2=A0> +DMA_ATTR_STRONG_ORDERING specifies that previous reads and write=
s are
> =C2=A0> +performed in the order in which they're received by the IOMMU; t=
hus
> =C2=A0> +reads and writes may not pass each other.
>=20
> I don't understand what this is trying to say. =C2=A0What is "previous"
> referring to? What does "received by the IOMMU" mean -- do you mean=20
> issued onto the bus by the CPU?

This is all about inbound transfers, i.e. DMAs coming from the I/O bridge
into the CPU, both DMA read and DMA write.

The relevant paragraph in the specification is=20
"If the SO bits in the I/O page table entry =3D =E2=80=9811=E2=80=99 and th=
e IOIF S-bit is =E2=80=981=E2=80=99,
this READ or WRITE cannot be placed on the EIB until all previous READs and
WRITEs from this CVCID and IOID have gotten an ACK or NULL type snoop respo=
nse."

Normally, this is only true for accesses going to the same cache line,
accesses from one device to different cache lines that are issued in order
also send their response in-order (unless you get an I/O exception, which m=
eans
you're toast), but can arrive at the I/O location out of order.

My interpretation is that strong ordering basically turns our whole I/O
subsystem into single-issue non-posted accesses (all devices are currently
configured to use the same CVCID and IOID), so we really should not
do that.

> When you say "reads and writes may not=20
> pass each other," do you mean just that reads may not pass writes and
> writes may not pass reads, or do you mean that reads also can't pass
> reads and writes can't pass writes?
>=20
> Since I don't know exactly what this attribute does, I can't be sure,
> but it seems that making weak ordering the default is dangerous in that
> it breaks drivers that expect usual memory ordering semantics. =C2=A0Woul=
d it
> be safer/better to make strong ordering the default and then add a
> "WEAK_ORDERING" attribute that drivers can use as an optimization?

With all our existing hardware, the I/O bridge overrides the setting
to select weak ordering. The purpose of this patch is to change the
default so that the bridge does not force weak ordering any more and
some drivers are free to set strong ordering without impacting performance
on the other drivers.

Strong ordering is only active when both the bridge and the IOMMU enable
it, but for correctly written drivers, this only results in a slowdown.

	Arnd <><
