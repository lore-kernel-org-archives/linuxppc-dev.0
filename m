Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F29ADDFA4
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:49:27 +1000 (EST)
Subject: Re: [PATCH 0/9] powerpc/pci: clean up direct access to sysdata
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1241096999-11164-1-git-send-email-galak@kernel.crashing.org>
References: <1241096999-11164-1-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-v5rkVP74EnTt2mZCc96A"
Date: Thu, 30 Apr 2009 23:49:26 +1000
Message-Id: <1241099366.7356.4.camel@concordia>
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


--=-v5rkVP74EnTt2mZCc96A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-30 at 08:09 -0500, Kumar Gala wrote:
> We shouldn't be accessing sysdata directly.  In the future we might have
> sysdata be a device_node on ppc32 to match ppc64.  Direct access would ma=
ke that
> a bit difficult.
>=20
> If someone can look at the iseries code I would appreciate that:
>=20
> arch/powerpc/platforms/iseries/pci.c:           iomm_table[current_iomm_t=
able_entry] =3D dev->sysdata;
> arch/powerpc/platforms/iseries/pci.c:                   iseries_ds_addr(d=
ev->sysdata) | (bar_num << 24);
> arch/powerpc/platforms/iseries/pci.c:   pdev->sysdata =3D node;

It looks like it's basically doing the same logic as
pci_device_to_OF_node(), and fetch_dev_dn(), but there's probably some
reason why it's not using those.

Given how much new iseries hardware there is, I think we'd probably
rather leave the code as is. It's a device node anyway, so it doesn't
block your plans RE ppc32.

cheers

--=-v5rkVP74EnTt2mZCc96A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn5rGYACgkQdSjSd0sB4dIzzgCgwATpbDl+2Ub+oBNXEIyfv/BB
lEAAoMtcjaOFRRxy2Le9j12c8FscP+IQ
=1XN9
-----END PGP SIGNATURE-----

--=-v5rkVP74EnTt2mZCc96A--
