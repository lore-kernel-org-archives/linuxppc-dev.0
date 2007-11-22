Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ACDB1DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 10:16:56 +1100 (EST)
Date: Fri, 23 Nov 2007 10:16:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH] PPC: CHRP - fix possible NULL pointer dereference
Message-Id: <20071123101646.63550945.sfr@canb.auug.org.au>
In-Reply-To: <20071122195423.GA9877@cvg>
References: <20071122195423.GA9877@cvg>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Nov_2007_10_16_46_+1100_X7su_ztJU5EfC4Dm"
Cc: Olof Johansson <olof@lixom.net>, PPCML <linuxppc-dev@ozlabs.org>, Paul,
	Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Nov_2007_10_16_46_+1100_X7su_ztJU5EfC4Dm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Nov 2007 22:54:23 +0300 Cyrill Gorcunov <gorcunov@gmail.com> wro=
te:
>
> This patch does fix possible NULL pointer dereference
> inside of strncmp() if of_get_property() failed.

Thanks for this.

>  static void __init sio_init(void)
>  {
>  	struct device_node *root;
> +	const char *model =3D NULL;

You don't need this initialization as you always assign the variable
before you use it.

> +	root =3D of_find_node_by_path("/");
> +	if (root) {

	if (!root)
		return;

would save a level of indentation. Not important.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Nov_2007_10_16_46_+1100_X7su_ztJU5EfC4Dm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRg3jTgG2atn1QN8RAgS+AJ0TSnJ7K3W4eF1xYySKWQoMYZ5enwCgiyDn
eJi7c8GJEdu634081uFuVvU=
=E8Lx
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Nov_2007_10_16_46_+1100_X7su_ztJU5EfC4Dm--
