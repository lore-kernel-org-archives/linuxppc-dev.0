Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjx4R3kBlzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 13:53:27 +1000 (AEST)
Date: Mon, 11 Apr 2016 13:36:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
Message-ID: <20160411033616.GH3332@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
 <20160309054544.GM22546@voom.fritz.box>
 <57077622.4000002@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
In-Reply-To: <57077622.4000002@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 07:13:06PM +1000, Alexey Kardashevskiy wrote:
> On 03/09/2016 04:45 PM, David Gibson wrote:
>=20
> >>diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> >>index 7f7b6d8..71f577c 100644
> >>--- a/arch/powerpc/kvm/Makefile
> >>+++ b/arch/powerpc/kvm/Makefile
> >>@@ -8,7 +8,7 @@ ccflags-y :=3D -Ivirt/kvm -Iarch/powerpc/kvm
> >>  KVM :=3D ../../../virt/kvm
> >>
> >>  common-objs-y =3D $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> >>-		$(KVM)/eventfd.o $(KVM)/vfio.o
> >>+		$(KVM)/eventfd.o
> >
> >Please don't disable the VFIO device for the non-book3s case.  I added
> >it (even though it didn't do anything until now) so that libvirt
> >wouldn't choke when it finds it's not available.  Obviously the new
> >ioctl needs to be only for the right IOMMU setup, but the device
> >itself should be available always.
>=20
>=20
> After having a closer look, the statement above does not enable VFIO KVM
> device on book3s but does for everything else:
>=20
>=20
> common-objs-$(CONFIG_KVM_VFIO) +=3D $(KVM)/vfio.o
> [...]
> kvm-e500-objs :=3D \
>         $(common-objs-y) \
> [...]
> kvm-objs-$(CONFIG_KVM_E500V2) :=3D $(kvm-e500-objs)
> [...]
> kvm-e500mc-objs :=3D \
>         $(common-objs-y) \
> [...]
> kvm-objs-$(CONFIG_KVM_E500MC) :=3D $(kvm-e500mc-objs)
> [...]
> kvm-book3s_32-objs :=3D \
>         $(common-objs-y) \
> [...]
> kvm-objs-$(CONFIG_KVM_BOOK3S_32) :=3D $(kvm-book3s_32-objs)
>=20
>=20
> This is becaise CONFIG_KVM_BOOK3S_64 does not use "common-objs-y":

Oh, good grief.

> kvm-objs-$(CONFIG_KVM_BOOK3S_64) :=3D $(kvm-book3s_64-module-objs)
>=20
>=20
> So I will keep vfio.o in the "common-objs-y" list and add:
>=20
> +kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) +=3D \
> +	$(KVM)/vfio.o

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXCxuwAAoJEGw4ysog2bOSTUsP/2BHXd+ZZaLEKdHePn8mLBfn
WOGclJd+K668Dntu4GRl9Y6pHFi1fLI9MJa47pZezxLiOD2+Iyn6OqWeIC/8HFXN
QA9W79mXqcnuECMu84A0IfYJ9yGvmXdYnO2AA8iIefduwZQXiawmcwCry8qU57ro
SJt3ASQZBwzq4Wa1GvPoRvFS94DVHZNhuXkUaaxvrLSQEZ1eVA81HG4DVeoHBV3k
dk6TwZtzzibsYUE6CrOYH5/9AX88uix4bz47zhklqnPR8l9lYLBvwk3HNiflXWii
Y2R8bnKbR8pk7d356WVF8WajQznKvWlsKRGubs8aGXa2NCiu/WojxMeYyFMj1Y2p
CTAkUXX5UzOQ3ZhoKLv5S+4/FyHHfhLSYyosZp4mVmAapIXc2Dsq8i4vvYT8u6vy
4XsGb7SilqjwMt3QdCyzCtM5+rUYWBEX6ahf9yl0mbwZWkOBoBkMruBo5QGJgHfo
GaV5SvWuTHNm0yxvpQiIE1F7Fc6r/fvD5kB87KKAcxIF4H7SqO5kF+ttiA4C/SbG
QwEV81VkacDUdum0rb2+sGLUlu5qkGKMnMORrz5r8OTyekuZDA/S74x//N8B1yER
uANrAKDzrNpxQri2A9DT3dwecfU4FILqOgg5xxbABHaQQXEDNlIkI9GyeTyAXAt+
I+J5pnJJ+K02mwApE9F2
=r4RT
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
