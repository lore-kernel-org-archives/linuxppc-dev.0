Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4fTG2NZ6zDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 16:01:38 +1000 (AEST)
Date: Thu, 4 Aug 2016 15:21:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 02/15] KVM: PPC: Finish enabling VFIO KVM device
 on POWER
Message-ID: <20160804052143.GF9189@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
In-Reply-To: <1470213656-1042-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:43PM +1000, Alexey Kardashevskiy wrote:
> 178a787502 "vfio: Enable VFIO device for powerpc" made an attempt to
> enable VFIO KVM device on POWER.
>=20
> However as CONFIG_KVM_BOOK3S_64 does not use "common-objs-y",
> VFIO KVM device was not enabled for Book3s KVM, this adds VFIO to
> the kvm-book3s_64-objs-y list.
>=20
> While we are here, enforce KVM_VFIO on KVM_BOOK3S as other platforms
> already do.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This should be merged regardless of the rest of the series.  There's
no reason not to include the kvm device on Power, and it makes life
easier for userspace because it doens't have to have conditionals
about whether to instantiate it or not.

> ---
>  arch/powerpc/kvm/Kconfig  | 1 +
>  arch/powerpc/kvm/Makefile | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index c2024ac..b7c494b 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -64,6 +64,7 @@ config KVM_BOOK3S_64
>  	select KVM_BOOK3S_64_HANDLER
>  	select KVM
>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
> +	select KVM_VFIO if VFIO
>  	---help---
>  	  Support running unmodified book3s_64 and book3s_32 guest kernels
>  	  in virtual machines on book3s_64 host processors.
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 1f9e552..8907af9 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -88,6 +88,9 @@ endif
>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
>  	book3s_xics.o
> =20
> +kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) +=3D \
> +	$(KVM)/vfio.o
> +
>  kvm-book3s_64-module-objs +=3D \
>  	$(KVM)/kvm_main.o \
>  	$(KVM)/eventfd.o \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXotDnAAoJEGw4ysog2bOSokIP/iMpVvi/lVoHrFBN2u06dELF
lvKCBVEAbZl/iZUPw2vJTyvV+FAT2ETwM1ChNpOGsVV8XPvvxMqlzKzRKgbBofKo
SvbJ3QBN9sD71HRlvj8+sTDTESdt4ljjOYzMO5rzziHbMFhRz0h47fq9c27RJszW
wy09aAft7KQtb7RxixrsEWXWqVcNgS3L/SDoYwHrXDN9uolcZD0ZbpsKIR80rGNl
uC3hFu44x+UGbxhH1aPf4R67j+XJvpV75jm4LB5DMOHKWKTsNHOq958z1ojmuEnN
rhiaXVN9B1a9HwMwt5UaWvbuT0rnvqT19NkKWRI1+ygzDrYrnzjrbUhaLoUpl+Pe
p5kgaToaq7eqUMkYkylYGaaI0910lWU2Mcl5amv2B5qqmlT6Kj5SlSb5fF8CoVtC
I2Qlsa8m5qy0hq20pRrSE0yBpoN+r6nO5iLa+0852K2TCnEnH654KrJih+IfTnlG
NMHZQMvjo6RRq/dckArbK+JIX2ZyxSGxd5Qne23+3efdlpyv4D4cNpYGgnXWhtCU
mma3TP5Sb/Hiwom8srlzsTaxGHjrSJV9IfrOyysVYP4b61U/vS8wmhX1zKdhGPmr
JCazeoVFWbt3R88PKWGgOPrc4KgAbENBdgC9GTiTM5D3vA2kud69qKuzT6ffqJxL
s2smVEMpZdvn3SYaSxhu
=6SHJ
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
