Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlJKW3cdQzDr4P
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 10:24:47 +1000 (AEST)
Date: Thu, 7 Jul 2016 10:07:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org
Subject: Re: [PATCH 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
Message-ID: <20160707000737.GB2615@voom.fritz.box>
References: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
In-Reply-To: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 04:05:54PM +1000, Sam Bobroff wrote:
> Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
> determine if a PowerPC KVM guest should use HTM (Hardware Transactional
> Memory).
>=20
> This will be used by QEMU to populate the pa-features bits in the
> guest's device tree.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  arch/powerpc/kvm/powerpc.c | 4 ++++
>  include/uapi/linux/kvm.h   | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 02416fe..06d79bc 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  		r =3D 1;
>  		break;
>  #endif
> +	case KVM_CAP_PPC_HTM:
> +		r =3D cpu_has_feature(CPU_FTR_TM)
> +		    && is_kvmppc_hv_enabled(kvm);
> +		break;
>  	default:
>  		r =3D 0;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 05ebf47..f421d0e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -866,6 +866,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_ARM_PMU_V3 126
>  #define KVM_CAP_VCPU_ATTRIBUTES 127
>  #define KVM_CAP_MAX_VCPU_ID 128
> +#define KVM_CAP_PPC_HTM 129
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfZ1JAAoJEGw4ysog2bOSJ2gP/R2X9SCYvYWeTjmY7jNpsQ/k
HF5jWIC6qTLxsihMdSwRiazcABAAq1RbTj0tH8FY1ycHxbW/KT/HXlohtUGSLsHn
2BHZlemVX3q8E4/0SVxEBIlAxMYhCewxS3TGI5IhcEpwFC4tN5tYgHnwelqX8nMK
UWHzN5tiAzmnsLGxb2ddXDjstW7Wm0iceTzcI8kd3UWp14NFboS42iY7KKj/QVh3
sDh4zqOFwygT2bwbZjQV+MnhI8aVwxTUdpLbKttivGO6gElUDpFbjXSvPeXsYDNL
026K0CRltF3WyubvMbx+ve+dLjI7s6MNU0LQ+bq4ZTmgNKAF2SpDfPo4aN2WcfOk
3/cLHViO4LGSIQayF++W+nQ4Wv8Sgp80+nPps9tDfOKRueg8xrIzDi0QMUAIkH1b
o/K1eG1svm9Pa5Y+aWnGUPXpvZiEK3294YcXQ/PR+T906qDf9jbaAXWcExFYkvcG
V8ieRXbNXGzMaApzokCNAVLkxwEatiUUZHPBn6wjevOoWvDQWiHr1vt1veb6RUjz
J30w7HCH9BqCOhpAuFrs5yWR/w+kawtSI2mvO+qKoO0YZ8nclXQyqm+yDpknPmuR
ayaMlsgAQSL9USbsUUNmveJIaFM6ZyjC4JwczDNiaIjluylHIur9ju14HRIoubCr
R7lpsbXKOGbig7vd+hql
=Y8IA
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
