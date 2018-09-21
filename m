Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GnTg06QqzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 18:54:31 +1000 (AEST)
Date: Fri, 21 Sep 2018 18:54:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey
 for handling pkey exceptions
Message-ID: <20180921185429.4cda432e@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-7-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lFjDkxZKyUobxHjbwFpE2lL"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/lFjDkxZKyUobxHjbwFpE2lL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:48 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Now that _exception no longer calls _exception_pkey it is no longer
> necessary to handle any signal with any si_code.  All pkey exceptions
> are SIGSEGV with paired with SEGV_PKUERR.  So just handle
> that case and remove the now unnecessary parameters from _exception_pkey.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks fine to me (small query below).

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

>  	clear_siginfo(&info);
> -	info.si_signo =3D signr;
> -	info.si_code =3D code;
> +	info.si_signo =3D SIGSEGV;
> +	info.si_code =3D SEGV_PKUERR;
>  	info.si_addr =3D (void __user *) addr;
>  	info.si_pkey =3D key;
> =20
> -	force_sig_info(signr, &info, current);
> +	force_sig_info(info.si_signo, &info, current);
                       ^^^^^^^^^^^^^
Why not just SIGSEGV?

--=20
Cheers,
Stephen Rothwell

--Sig_/lFjDkxZKyUobxHjbwFpE2lL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukscUACgkQAVBC80lX
0GwAXgf9F8yMklDfoP6e48FJaOXDueVFA9b53pNSfzFQugIKW1XsaxdbL8qI9LWJ
wpNJ8rZETfWnFtlnWG1KdFjUQB3oH5OqL3VXaDh1ABnZlcCPZ/NypUuDR7yp5lkr
v6nxgep+81ccgBacRK64s5k7m0FVbVvFRzQ2HdRmCCbOs7B+cLUeZu6ojjDVE/w7
G1xRb4l1sPZQ1tbxcTUkDNm0bySy66lc07N5bXKqh0oywxf0yZjFOilT2Z4QzuFW
b2Za5SvMlQRTW2mE2dcvvazFTBxavx01PBqq8/U/r7/tdP8c7IyTdq8+8rpC8lre
aL7CFmHgGNQXRIgvd510/NIX5dnYbA==
=eOVQ
-----END PGP SIGNATURE-----

--Sig_/lFjDkxZKyUobxHjbwFpE2lL--
