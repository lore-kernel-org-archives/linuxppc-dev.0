Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtcGT6xrlzDrRw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 10:48:49 +1000 (AEST)
Date: Fri, 15 Sep 2017 10:48:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20170915004839.GA5250@umbus.fritz.box>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 11:56:25PM +0200, Greg Kurz wrote:
> The following program causes a kernel oops:
>=20
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <linux/kvm.h>
>=20
> main()
> {
>     int fd =3D open("/dev/kvm", O_RDWR);
>     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> }
>=20
> This happens because when using the global KVM fd with
> KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> called with a NULL kvm argument, which gets dereferenced
> in is_kvmppc_hv_enabled(). Spotted while reading the code.
>=20
> Let's use the hv_enabled fallback variable, like everywhere
> else in this function.
>=20
> Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Greg Kurz <groug@kaod.org>

I don't think this is right.  I'm pretty sure you want to fall back to
hv_enabled *only when* kvm is NULL.  Otherwise if you have a PR guest
on an HV capable machine, this will give the wrong answer, when called
for that specific VM.

> ---
>  arch/powerpc/kvm/powerpc.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 3480faaf1ef8..ee279c7f4802 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -644,8 +644,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  		break;
>  #endif
>  	case KVM_CAP_PPC_HTM:
> -		r =3D cpu_has_feature(CPU_FTR_TM_COMP) &&
> -		    is_kvmppc_hv_enabled(kvm);
> +		r =3D cpu_has_feature(CPU_FTR_TM_COMP) && hv_enabled;
>  		break;
>  	default:
>  		r =3D 0;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7I2IACgkQbDjKyiDZ
s5IVQBAAwLBwQr6BrKvpLsKPRRxYraIoo8Ik5+W551pBFbeG9efZb/RJA4cpgoBt
L6kLok23ZSG/QyWgvgXx696T2TQd3jXq61vpY0b7JrpIlGM6ztKcnVdABNZV1UDy
Gqv0KF4WqW8MxmsZ62YEsoq24cZA1uyAwjQnwaGXSfRUFrMdVd4+RGUfdp7q9xjx
MzxaLnTdftQ++OHUWFXzr1sgm3+fxM0REODPepXR0dDKMQT+gh6GnBdA+XiUNiA+
Ftx8BkezE8k9x6QSKdamx4IXcvUMKaZrSSyIhGtxF4T83rbApk7ATsgJYDo8F0GX
yDeTXkyV6SnrRZWdYFujXEvbPaGJ8vEcBQBW7/tTHmPvBvQN+BTdF0ic6gAII9i9
eGvpp/NW/cLfXkF85yp4FmphTB2qQ/g+P5uKbUfTYcKwDv6Cf7I9oyr0/q7NE/D5
81s9RB5lxji8/Fpm1vjGRFWK+Xq2+jy1bAsAQ/H+uJMp5LP7c71fdbjq9+0wuUZe
pv8uZjXSDLvOxcSbWbKi9dQ4sWpckKT+vpArTfa9cQS3kyI3A9d+QkoReiTVgi81
ibma3XhnTlZHx2LksH2Ph/cUrcRPJXXuJ86x4tZVqBpY6+NxcyHw/Ffbdvq4ufqE
s42ndRUBK6MFqXGHk/7uHI9O6FB660a499wt+DfmF0xpEfWEPoM=
=lHab
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
