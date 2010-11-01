Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] iSeries: Don't leak if allocations fail in
	mf_getSrcHistory
From: Michael Ellerman <michael@ellerman.id.au>
To: Jesper Juhl <jj@chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1010301911220.1572@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1010301911220.1572@swampdragon.chaosbits.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-gBTVMiECxDTmalQzWme3"
Date: Mon, 01 Nov 2010 22:10:42 +1100
Message-ID: <1288609842.10671.7.camel@concordia>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@pcug.org.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gBTVMiECxDTmalQzWme3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-10-30 at 19:20 +0200, Jesper Juhl wrote:
> Hi,
>=20
> If memory is tight and a dynamic allocation fails there's no reason to=
=20
> make a bad situation worse by leaking memory.
>=20
> mf_getSrcHistory potentially leaks pages[0-3]. I believe the right thing=
=20
> to do is to free that memory again before returning -ENOMEM - which is=
=20
> what this patch does.
>=20
> I realize that the function is under '#if 0' so this probably doesn't=20
> matter much, but I assume that the function is still there for a reason=
=20
> (but I could be wrong, I don't know the powerpc code).
> Anyway, I suggest we remove the leak.

Stephen is the iSeries maintainer, and I think he #if 0'ed the code. But
I don't think it will ever be un-ifdef'ed, so should probably just be
removed.

cheers


--=-gBTVMiECxDTmalQzWme3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzOoDIACgkQdSjSd0sB4dL0dACgqcRspxXeU01uHOVG9ZaBdwkd
1Q8AmgKshK1tiCp7tMAWNiZAeESMBdZn
=UUKN
-----END PGP SIGNATURE-----

--=-gBTVMiECxDTmalQzWme3--
