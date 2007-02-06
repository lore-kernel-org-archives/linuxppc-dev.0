Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 160CFDDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 12:29:37 +1100 (EST)
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070206011949.GA15434@lixom.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206011949.GA15434@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pJdcLs1UbcJP2xyLypxd"
Date: Tue, 06 Feb 2007 02:26:02 +0100
Message-Id: <1170725162.30959.26.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pJdcLs1UbcJP2xyLypxd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:19 -0600, Olof Johansson wrote:
> On Mon, Feb 05, 2007 at 07:30:35PM +0100, Johannes Berg wrote:
> > This implements suspend and resume code for the dart iommu.
>=20
> It's a good start, but it would be even nicer to have more generic iommu
> suspend/resume hooks instead, and do the alloc/copy there. Add the hooks
> to ppc_md together with the rest of the iommu/tce ops.

Ok, I'll take a look. I think we should leave the alloc up to the code
and just have generic calls for what now is iommu_dart_{save,restore}, I
see no point in adding a callback for iommu_init_late_dart since any
other iommu can do it as a late_initcall as well.

> > +	/* this 16MB area is left unmapped because of caching
> > +	 * considerations. that happens early so we can't mark
> > +	 * it there, do it now instead */
> > +	for (i =3D 0; i < (1<<24); i+=3D PAGE_SIZE)
> > +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i=
)));
>=20
> Please do a local void * instead, makes for much less casting in the loop=
. :)

:)

johannes

--=-pJdcLs1UbcJP2xyLypxd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFx9kq/ETPhpq3jKURAsJHAKCvlD8M+JKwKRAO5OYT8/Ze/oY8LQCeJEuJ
vx2tNurpdNnn6CqN/DyCJcY=
=MzUB
-----END PGP SIGNATURE-----

--=-pJdcLs1UbcJP2xyLypxd--
