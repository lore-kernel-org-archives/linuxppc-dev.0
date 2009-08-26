Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B7E4AB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 00:08:46 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6C0BDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 00:08:46 +1000 (EST)
Subject: Re: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1251289790.1379.71.camel@pasglop>
References: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
	<20090824194800.GA13503@lst.de>  <1251289790.1379.71.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9PIcFcg4wYGlVQG8ZTKp"
Date: Thu, 27 Aug 2009 00:08:45 +1000
Message-Id: <1251295725.7492.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-9PIcFcg4wYGlVQG8ZTKp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-26 at 22:29 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-08-24 at 21:48 +0200, Christoph Hellwig wrote:
> > On Mon, Aug 24, 2009 at 11:17:14AM -0500, Becky Bruce wrote:
> > > Previously, this was specified as a void *, but that's not
> > > large enough on 32-bit systems with 36-bit physical
> > > addressing support.  Change the type to dma_addr_t so it
> > > will scale based on the size of a dma address.
> >=20
> > This looks extreml ugly to me.  It seems like the typical use is to
> > store a pointer to a structure.  So what about making the direct
> > dma case follow that general scheme instead?
> >=20
> > E.g. declare a
> >=20
> > struct direct_dma_data {
> > 	dma_addr_t	direct_dma_offset;
> > };
> >=20
> > and have one normal instace of it, and one per weird cell device.
>=20
> Right, but we want to avoid a structure for the classic case of 32-bit
> systems with no iommu...=20
>=20
> I wouldn't mind doing a union here.=20

That might be best, the patch as it stands is a horrible mess of casts.

Stashing a dma_addr_t into a void * is sort of gross, but storing a
pointer to some struct (a void *) in a dma_addr_t is _really_ gross :)

cheers

--=-9PIcFcg4wYGlVQG8ZTKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqVQekACgkQdSjSd0sB4dIT8gCfZmTn78gFbMgUWNf8DviHeVkb
qSQAnAndDeAEjMOBH/zu9Nsy3c1MFJmi
=LxYB
-----END PGP SIGNATURE-----

--=-9PIcFcg4wYGlVQG8ZTKp--
