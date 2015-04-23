Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B16D41A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 13:06:27 +1000 (AEST)
Date: Thu, 23 Apr 2015 13:06:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/vdso: Disable building the 32-bit VDSO on
 little endian
Message-ID: <20150423130621.19d74dfb@canb.auug.org.au>
In-Reply-To: <1429681236-11644-3-git-send-email-mpe@ellerman.id.au>
References: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
 <1429681236-11644-3-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LQ0IsoZW/w9w6VzzXLNGHH+"; protocol="application/pgp-signature"
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/LQ0IsoZW/w9w6VzzXLNGHH+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 22 Apr 2015 15:40:36 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/v=
dso.h
> index c53f5f6d1761..f455adb471e7 100644
> --- a/arch/powerpc/include/asm/vdso.h
> +++ b/arch/powerpc/include/asm/vdso.h
> @@ -19,6 +19,7 @@
> =20
>  /* Offsets relative to thread->vdso_base */
>  extern unsigned long vdso64_rt_sigtramp;
> +
>  extern unsigned long vdso32_sigtramp;
>  extern unsigned long vdso32_rt_sigtramp;

You could drop this hunk :-)

> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 8331d0bef0fb..c2bd45187315 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -49,12 +49,15 @@
>  /* The alignment of the vDSO */
>  #define VDSO_ALIGNMENT	(1 << 16)
> =20
> -extern char vdso32_start, vdso32_end;
> -static void *vdso32_kbase =3D &vdso32_start;
>  static unsigned int vdso32_pages;
> +static void *vdso32_kbase;
>  static struct page **vdso32_pagelist;
> -unsigned long vdso32_sigtramp;
> -unsigned long vdso32_rt_sigtramp;
> +unsigned long vdso32_sigtramp =3D 0;
> +unsigned long vdso32_rt_sigtramp =3D 0;

And they should be zero anyway, right?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/LQ0IsoZW/w9w6VzzXLNGHH+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVOGGyAAoJEMDTa8Ir7ZwVObIP/1RshP8hGm3oWcLiT1AUBU3a
nM2RT4Hc7A+rlL3vzFmfEEMLNSYLSOdnnrm0ObT5boVFZW02DMRYMEorLIWkAw0O
gmwkipyd7MzM0/iwh4oQV2pun5E4/QRGxOJrrcKkv/IhwyXft83QaYhEoSQW2FBR
PsWmeH+p/WtK4D59mg10jZ/c1tZRdR4tZJua3hzDRAeE1jE+nJhv+c5tE7eShHe2
UuG7WMtmt1tTQBkAiNxHn6LKalGbfw/QO9jl2Qb/IXR8j6GVYWvTq5u5Xdp3UUlW
3hwIqw03brvEi0/bj9kd2gn9TDrkde15BBCtmu/QSzWIHO9fRBE4UwdPLiB172pA
bqO4zQsVxYtJLBbcuOXmTUBLb9Ucpu5KWUJdTG8Fh9fYk+d907wK1xPfos8qqp+y
1rtE3MruqHz2HAMmpHv39ZvVOrdQV9csDvc+pkYm67sI35arVnWWF1msXup0H3Nj
i6kMHSuiMqhd2Ka4v/y1oesHASIX5bE2z8hQnTAWqv1J2Twf5HtNi8A02tnTdLoB
OLT4hqtnQ/WydyFWpNVgTNOHMDfOUJr4nMQiR31A8ft4m/3oAljHdc8SPFDkducU
ZEwJMwV8Gl6DHz++T8hBCRa/p43WxD5l5vkAfFLrlJe20nkpjaql2GaPZq70v0Ur
mzv3LDamSdcITAgGDc5P
=62AM
-----END PGP SIGNATURE-----

--Sig_/LQ0IsoZW/w9w6VzzXLNGHH+--
