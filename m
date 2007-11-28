Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] PPC: CELLEB - fix potential NULL pointer dereference
From: Michael Ellerman <michael@ellerman.id.au>
To: Cyrill Gorcunov <gorcunov@gmail.com>
In-Reply-To: <aa79d98a0711252346m583b652bocf72e11077da352e@mail.gmail.com>
References: <aa79d98a0711252346m583b652bocf72e11077da352e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SxJAWHRVCLUUuseXi9OR"
Date: Wed, 28 Nov 2007 20:48:53 +1100
Message-Id: <1196243333.2109.2.camel@concordia>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, PPCML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SxJAWHRVCLUUuseXi9OR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-11-26 at 10:46 +0300, Cyrill Gorcunov wrote:
> This patch adds checking for NULL value returned to prevent possible
> NULL pointer dereference.
> Also two unneeded 'return' are removed.
>=20
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
> Any comments are welcome.

I guess it's good to be paranoid, but this is a little verbose:

        wi0 =3D of_get_property(node, "device-id", NULL);
+       if (unlikely((!wi0))) {
+               printk(KERN_ERR "PCI: device-id not found.\n");
+               goto error;
+       }
        wi1 =3D of_get_property(node, "vendor-id", NULL);
+       if (unlikely((!wi1))) {
+               printk(KERN_ERR "PCI: vendor-id not found.\n");
+               goto error;
+       }
        wi2 =3D of_get_property(node, "class-code", NULL);
+       if (unlikely((!wi2))) {
+               printk(KERN_ERR "PCI: class-code not found.\n");
+               goto error;
+       }
        wi3 =3D of_get_property(node, "revision-id", NULL);
+       if (unlikely((!wi3))) {
+               printk(KERN_ERR "PCI: revision-id not found.\n");
+               goto error;
+       }

Perhaps instead:

        wi0 =3D of_get_property(node, "device-id", NULL);
        wi1 =3D of_get_property(node, "vendor-id", NULL);
        wi2 =3D of_get_property(node, "class-code", NULL);
        wi3 =3D of_get_property(node, "revision-id", NULL);

       if (!wi0 || !wi1 || !wi2 || !wi3) {
               printk(KERN_ERR "PCI: Missing device tree properties.\n");
               goto error;
       }


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SxJAWHRVCLUUuseXi9OR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHTTmFdSjSd0sB4dIRAkUlAKC97nGHNwqDUa3D7eZ5/XSLyI4WLACeMjoP
2s61ngBVOglJijVK2md/gB8=
=kQsS
-----END PGP SIGNATURE-----

--=-SxJAWHRVCLUUuseXi9OR--
