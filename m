Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CAAE2B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 10:24:59 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBF1FDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 10:24:59 +1000 (EST)
Subject: Re: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
From: Michael Ellerman <michael@ellerman.id.au>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <E3F20841-FB04-44EF-8DAA-91F51873C0A6@kernel.crashing.org>
References: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
	<20090824194800.GA13503@lst.de>  <1251289790.1379.71.camel@pasglop>
	<1251295725.7492.5.camel@concordia>
	<E3F20841-FB04-44EF-8DAA-91F51873C0A6@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DOI+CM+oRK0oRDsMjON8"
Date: Thu, 27 Aug 2009 10:24:56 +1000
Message-Id: <1251332696.5914.6.camel@concordia>
Mime-Version: 1.0
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DOI+CM+oRK0oRDsMjON8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-26 at 15:20 -0500, Becky Bruce wrote:
> On Aug 26, 2009, at 9:08 AM, Michael Ellerman wrote:
>=20
> > On Wed, 2009-08-26 at 22:29 +1000, Benjamin Herrenschmidt wrote:
> >> On Mon, 2009-08-24 at 21:48 +0200, Christoph Hellwig wrote:
> >>> On Mon, Aug 24, 2009 at 11:17:14AM -0500, Becky Bruce wrote:
> >>>> Previously, this was specified as a void *, but that's not
> >>>> large enough on 32-bit systems with 36-bit physical
> >>>> addressing support.  Change the type to dma_addr_t so it
> >>>> will scale based on the size of a dma address.
> >>>
> >>> This looks extreml ugly to me.  It seems like the typical use is to
> >>> store a pointer to a structure.  So what about making the direct
> >>> dma case follow that general scheme instead?
> >>>
> >>> E.g. declare a
> >>>
> >>> struct direct_dma_data {
> >>> 	dma_addr_t	direct_dma_offset;
> >>> };
> >>>
> >>> and have one normal instace of it, and one per weird cell device.
> >>
> >> Right, but we want to avoid a structure for the classic case of 32-=20
> >> bit
> >> systems with no iommu...
> >>
> >> I wouldn't mind doing a union here.
> >
> > That might be best, the patch as it stands is a horrible mess of =20
> > casts.
>=20
> Let's be fair - the code before was a horrible mess of casts, I've =20
> just moved them :)

Yeah true. Though I think we end up with more casts because there were
more call sites using it as a pointer originally. But yeah it's not
pretty either way.

> > Stashing a dma_addr_t into a void * is sort of gross, but storing a
> > pointer to some struct (a void *) in a dma_addr_t is _really_ gross :)
>=20
> Both are revolting (and storing a dma_addr_t into a void * is really =20
> gross when the void * is smaller than the dma_addr_t!!).  A union =20
> might not be a bad idea, though.  I'll look at doing that instead.

Cool. That is how we're using it, sometimes it points to something
sometimes it's a dma_addr_t, so I think a union will work.

cheers

--=-DOI+CM+oRK0oRDsMjON8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqV0lUACgkQdSjSd0sB4dL+KwCgpNJi6r6FtwHYDWi0HRvWpCDQ
1A0AoMpZnccRrTAn53InO4r2OYksVJmZ
=Q1wz
-----END PGP SIGNATURE-----

--=-DOI+CM+oRK0oRDsMjON8--
