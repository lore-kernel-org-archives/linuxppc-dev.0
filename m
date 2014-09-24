Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F9F61A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 16:40:12 +1000 (EST)
Date: Wed, 24 Sep 2014 16:40:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc: Add VM_FAULT_HWPOISON handling to powerpc
 page fault handler
Message-ID: <20140924164005.2b142a4a@canb.auug.org.au>
In-Reply-To: <1411518427-14408-1-git-send-email-anton@samba.org>
References: <1411518427-14408-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_5xAMFCkquqkd3U=QIxMT7r"; protocol="application/pgp-signature"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/_5xAMFCkquqkd3U=QIxMT7r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 24 Sep 2014 10:27:06 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> -	if (user_mode(regs)) {
> -		current->thread.trap_nr =3D BUS_ADRERR;
> -		info.si_signo =3D SIGBUS;
> -		info.si_errno =3D 0;
> -		info.si_code =3D BUS_ADRERR;
> -		info.si_addr =3D (void __user *)address;
> -		force_sig_info(SIGBUS, &info, current);
> -		return MM_FAULT_RETURN;
> +	if (!user_mode(regs))
> +		return MM_FAULT_ERR(SIGBUS);
> +
> +	current->thread.trap_nr =3D BUS_ADRERR;
> +	info.si_signo =3D SIGBUS;
> +	info.si_errno =3D 0;
> +	info.si_code =3D BUS_ADRERR;
> +	info.si_addr =3D (void __user *)address;

If you had done this as 2 patches (one to remove the indent and a
second to fix the actual problem), it would have been much easier to
review ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/_5xAMFCkquqkd3U=QIxMT7r
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUImdKAAoJEMDTa8Ir7ZwVsg8P/1GSnL/e2Ew2cusC428kz9ue
/Oyx9AP+i4k/ltkJoOW15X1SD/TJuQRV3lj1Q7p8nTe0fm9cRxmqiqpHgn1y78Gl
RYd6+yU+LMrq8bWP/rfxpI3pkL4K5ZsA/FGeXmnQaC+4cS1xNvPsUn9o1Z2kdL69
xqbzNqCuQp29UWof0IUHQYO34ocNamReS5ovCT2yxJe0R9NVpr3M+sD2rdUDVOdB
unyWclKKfDLXYbWoxTTyRZWUVvkDuGiULfEG1QOgJ4Rbuylk0vNnRlP/svDIOb+Q
Ie2m4TKHM5DogqyQ9EWc8nXaN8bDlhoQUUjHBWX7S8jtjAI7IT39ledB6825XNgk
6sShS1IuzYfN4k67sJp1CSA6YBwl/hDr5Ik2x0LeaJugK8zUCVH9YGltimgG+x1y
NhatKTXqCI647GQk4W3wE7nZExhaZpw7WazztuWFwmNGd5iMx570fmmT38EL/ZkC
Gt4QMdD+CHrYBOBc98EAbJ4ZxJBTDrrPlRfp9VmWYcFej7bUQlyY2VdtJHhRBqfv
X8/KD9ltzfm6m5ZzJg3cJie/B8EK7dv5eJoEnbXyd9d4BnOPBEhAYxTQzm4FqeTi
8kwzKZA0nXxhkSszj2UL6QtH+RD1OKYCTPXL/lDtu5PbKvEwsSj7dRjZR6H6u0lb
6Hk3hn3IZS/u+WcjeXu4
=hzpK
-----END PGP SIGNATURE-----

--Sig_/_5xAMFCkquqkd3U=QIxMT7r--
