Return-Path: <eric@anholt.net>
Received: from kingsolver.anholt.net (69-30-77-85.dq1sn.easystreet.com
	[69.30.77.85]) by ozlabs.org (Postfix) with ESMTP id 5AD5DDDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:57:31 +1100 (EST)
Subject: Re: [PATCH 2/3] drm: Split drm_map and drm_local_map
From: Eric Anholt <eric@anholt.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090202055558.4F200DDF4B@ozlabs.org>
References: <20090202055558.4F200DDF4B@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jg4Ruukjt0Wdobch3a+w"
Date: Mon, 02 Feb 2009 12:57:27 -0800
Message-Id: <1233608247.4932.11.camel@gaiman>
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org,
	dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jg4Ruukjt0Wdobch3a+w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-02-02 at 16:55 +1100, Benjamin Herrenschmidt wrote:
> Once upon a time, the DRM made the distinction between the drm_map
> data structure exchanged with user space and the drm_local_map used
> in the kernel.
>=20
> For some reasons, while the BSD port still has that "feature", the
> linux part abused drm_map for kernel internal usage as the local
> map only existed as a typedef of the struct drm_map.
>=20
> This patch fixes it by declaring struct drm_local_map separately
> (though its content is currently identical to the userspace variant),
> and changing the kernel code to only use that, except when it's a
> user<->kernel interface (ie. ioctl).
>=20
> This allows subsequent changes to the in-kernel format
>=20
> I've also replaced the use of drm_local_map_t with struct drm_local_map
> in a couple of places. Mostly by accident but they are the same (the
> former is a typedef of the later) and I have some remote plans and
> half finished patch to completely kill the drm_local_map_t typedef
> so I left those bits in.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for taking on this mess!

Acked-by: Eric Anholt <eric@anholt.net>

--=20
Eric Anholt
eric@anholt.net                         eric.anholt@intel.com



--=-jg4Ruukjt0Wdobch3a+w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmHXjYACgkQHUdvYGzw6vdMxwCdE5n8fn3j9SNV448Z/48gMMr3
fBkAn1m/KmR0totoCXshU4l8ZzINAcik
=Ugmb
-----END PGP SIGNATURE-----

--=-jg4Ruukjt0Wdobch3a+w--
