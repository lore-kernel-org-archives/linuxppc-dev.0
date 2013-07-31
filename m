Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 14F452C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:19:30 +1000 (EST)
Date: Wed, 31 Jul 2013 18:19:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: handle unaligned ldbrx/stdbrx
Message-Id: <20130731181923.270ccd5b2b9438cf8f8c6887@canb.auug.org.au>
In-Reply-To: <20130731150521.74eb6639@kryten>
References: <20130731150521.74eb6639@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__31_Jul_2013_18_19_23_+1000_Aus+RsMvi_NV5RUs"
Cc: mikey@neuling.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Jul_2013_18_19_23_+1000_Aus+RsMvi_NV5RUs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 31 Jul 2013 15:05:21 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> +++ b/arch/powerpc/kernel/align.c
> @@ -764,6 +764,16 @@ int fix_alignment(struct pt_regs *regs)
>  	nb =3D aligninfo[instr].len;
>  	flags =3D aligninfo[instr].flags;
> =20
> +	/* ldbrx/stdbrx overlap lfs/stfs in the DSISR unfortunately */
> +	if (IS_XFORM(instruction) && ((instruction >> 1) & 0x3ff) =3D=3D 532) {

We have get_xop() in asm/disassemble.h (which is unfortunately not
included by this file) ...

> +		nb =3D 8;
> +		flags =3D LD+SW;
> +	} else if (IS_XFORM(instruction) &&
> +		   ((instruction >> 1) & 0x3ff) =3D=3D 660) {

ditto

/me points at a bike shed :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__31_Jul_2013_18_19_23_+1000_Aus+RsMvi_NV5RUs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR+MiPAAoJEECxmPOUX5FEzNoP/0f/B2flJtKfT8VZwasqlAKD
64UNVRA++Q8RGgjGlvWi/AMd7vQaGCHtj/CLMcTtdvfdRUP8qQZgNGpCg3OEJy/r
/JJ6qb9JojPQu2bY7X97MY3pPVDbPpu6oXYydZJcdXIcLtpD0mVTyGqyWI/LHicn
qlMqZ7pEoJ2v08w+um+Q0dZl0ncnpvjv9RYrJnaUOH8ItTU5Nxnx7QFRgBuaSiLb
sf5EWXbgFNPhpFpxi6pROEIQ+/ez3fLnq2ivyZLzJBk7XmyzQ274UT8HIGlsP8o1
G2rwUaihCy/S4sesu/mF9yrv6SocUiQ73ej/1hazgzq34nEh9y44xEytla1ChP5q
mss9m/0LKe5fgvuaGXj+C1jCiPU3Z33HQ8atxtl2ikquZjug51FRMH1wOa9qaQER
w7oWcb2eJpUM2pO1JYY6CSHcQkGxlthulPY4mMT42h9DLY3O+O1x+fEA94z8PpDK
kekDDwDsUpi5YygbzH8dTs3AT+QXIjriBlv8F0uUw87oHJE7aTcjpSRTA/y06IkP
cpEflg/HMuG5Kk9x8cqLdEgxHeeN0/POqbHeiJNKeeLNPZEpqdEwuKa+MmKIsk0x
MchRGcJdl6DWfpmeLwNqHzLNVR7TIQzFrzu3rJFwsT1+VkfBkiialr3I9ahR+lb+
KZiuWvbAdU6u1bLzxw7J
=zW7e
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Jul_2013_18_19_23_+1000_Aus+RsMvi_NV5RUs--
