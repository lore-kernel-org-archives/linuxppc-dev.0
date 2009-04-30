Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D059DDFC2
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 00:50:49 +1000 (EST)
Subject: Re: [PATCH 0/9] powerpc/pci: clean up direct access to sysdata
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <EAC6B615-35F2-4CD9-A7E8-FAAD4B9D9DF3@kernel.crashing.org>
References: <1241096999-11164-1-git-send-email-galak@kernel.crashing.org>
	<1241099366.7356.4.camel@concordia>
	<EAC6B615-35F2-4CD9-A7E8-FAAD4B9D9DF3@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-wMpLCGkNumzQx21ALZ9h"
Date: Fri, 01 May 2009 00:50:47 +1000
Message-Id: <1241103047.7356.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wMpLCGkNumzQx21ALZ9h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-30 at 09:18 -0500, Kumar Gala wrote:
> On Apr 30, 2009, at 8:49 AM, Michael Ellerman wrote:
>=20
> > On Thu, 2009-04-30 at 08:09 -0500, Kumar Gala wrote:
> >> We shouldn't be accessing sysdata directly.  In the future we might =20
> >> have
> >> sysdata be a device_node on ppc32 to match ppc64.  Direct access =20
> >> would make that
> >> a bit difficult.
> >>
> >> If someone can look at the iseries code I would appreciate that:
> >>
> >> arch/powerpc/platforms/iseries/pci.c:           =20
> >> iomm_table[current_iomm_table_entry] =3D dev->sysdata;
> >> arch/powerpc/platforms/iseries/pci.c:                   =20
> >> iseries_ds_addr(dev->sysdata) | (bar_num << 24);
> >> arch/powerpc/platforms/iseries/pci.c:   pdev->sysdata =3D node;
> >
> > It looks like it's basically doing the same logic as
> > pci_device_to_OF_node(), and fetch_dev_dn(), but there's probably some
> > reason why it's not using those.
> >
> > Given how much new iseries hardware there is, I think we'd probably
> > rather leave the code as is. It's a device node anyway, so it doesn't
> > block your plans RE ppc32.
> >
> > cheers
>=20
> I was already thinking along those lines, but figured I see if anyone =20
> is really "maintaining" iseries code :)

Not that much, it would be sfr if anyone, but I think he's a bit busy :)

cheers

--=-wMpLCGkNumzQx21ALZ9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn5uscACgkQdSjSd0sB4dJHKACfWKs0NazTtqpsD/gNtEfBvr1P
xe8AoLQZsgm1wI8Dkv5+xtdj1tqEG0Jt
=Lb9i
-----END PGP SIGNATURE-----

--=-wMpLCGkNumzQx21ALZ9h--
