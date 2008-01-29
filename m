Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080129213646.GA28997@lixom.net>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
	<20080129151511.GA18975@lixom.net>
	<1201619625.10012.19.camel@concordia>
	<1201641495.6815.207.camel@pasglop> <20080129213646.GA28997@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-q1xvqaWCoprGzHo9epJV"
Date: Wed, 30 Jan 2008 10:56:32 +1100
Message-Id: <1201650992.11907.3.camel@concordia>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-q1xvqaWCoprGzHo9epJV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-01-29 at 15:36 -0600, Olof Johansson wrote:
> On Wed, Jan 30, 2008 at 08:18:15AM +1100, Benjamin Herrenschmidt wrote:
> >=20
> > On Wed, 2008-01-30 at 02:13 +1100, Michael Ellerman wrote:
> > > On Tue, 2008-01-29 at 09:15 -0600, Olof Johansson wrote:
> > > > On Wed, Jan 30, 2008 at 01:14:03AM +1100, Michael Ellerman wrote:
> > > >=20
> > > > > For example a machine with 4GB of memory would end up with the no=
rmal
> > > > > IOMMU window from 0-2GB and the fixed mapping window from 2GB to =
6GB. In
> > > > > this case a 64-bit device wishing to DMA to 1GB would be told to =
DMA to
> > > > > 3GB, plus any offset required by firmware. The firmware offset is=
 encoded
> > > > > in the "dma-ranges" property.
> > > >=20
> > > > Shouldn't the fixed mapping be between 4G and 8G (and the offset fo=
r 1G
> > > > is at 5G), to account for the MMIO range at 2-4G?
> > >=20
> > > I don't think so, ie. it works setup like that, but I'm not entirely
> > > sure why. Presumably the 2-4GB for MMIO is only for cycles heading ou=
t
> > > of the CPU.
> >=20
> > No no no... it's because on the PCI segment, it's all offset up
> > remember ?
> >=20
> > Basically, the PCI host bridge on these has 2 interesting windows for
> > us:
> >=20
> > 0....2G			-> This goes up to memory @0 (via a couple of=20
> >                            layers)
> >=20
> > 0x80*....0xF*		-> This goes untranslated to the PLB5 which
> >   			   drops the top bits and does some other=20
> >                            manipulations, which allows to access, among
> >                            others the full 32GB of the cell inbound=20
> >                            range.
> >=20
> > The MMIO region of 2...4G is on the PCI (outbound from the Cell is yet
> > another range of addresses with different constraints but that ends up
> > generating cycles between 2 and 4G on the PCI segment).
> >=20
> > If we had set the direct mapped region so that it uses 2G...N on PCI, w=
e
> > would indeed be toast. But instead, the addresses for direct DMA that w=
e
> > hand out to devices are in the 0x80* region and go hit the cell
> > directly, they never match MMIO.
>=20
> Yeah, ok. That makes more sense. Thanks for the clarification.

Right, that's the firmware offset I mentioned in the changelog - 2am is
not a good time to think about these things.

> Michael, btw, I wonder if it would make sense to duplicate the patch
> description at the top of the file as well, since it'll be lost in the
> change log for people who don't go back and read history, and having
> the intentions documented in the file could be a good idea.

Yeah that probably makes sense. I've got most of the fixed mapping code
in a block, so I'll put a comment above that section. New patch coming.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-q1xvqaWCoprGzHo9epJV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn70wdSjSd0sB4dIRAkqmAKDHTjZ6HRfIE6ie6M1Oifa2SPjcGACgoJek
atAyjnDoVlP812W4Dobhwgg=
=Ktf+
-----END PGP SIGNATURE-----

--=-q1xvqaWCoprGzHo9epJV--
