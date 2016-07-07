Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlPxR3WFLzDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:37:47 +1000 (AEST)
Date: Thu, 7 Jul 2016 14:39:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] spapr: Set ibm, pa-features HTM from
 KVM_CAP_PPC_HTM
Message-ID: <20160707043926.GR14675@voom.fritz.box>
References: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
 <fb64116eb0795e0b2b0789a02b4ce8f694fc69e4.1467783317.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8Bx+wEju+vH9ym24"
In-Reply-To: <fb64116eb0795e0b2b0789a02b4ce8f694fc69e4.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8Bx+wEju+vH9ym24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 03:35:23PM +1000, Sam Bobroff wrote:
> Advertise HTM support in ibm, pa-features if KVM indicates support when
> queried via a new capability (KVM_CAP_PPC_HTM).
>=20
> If KVM returns false for the capability (which may indicate that the
> host kernel doesn't support the capability itself) attempt to
> determine availability using a fallback method based on KVM being
> KVM-HV and HTM being available to the QEMU process.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>=20
> * Improve readability of HTM bit set code.
> * Move the test for KVM into kvmppc_get_htm_support().
>=20
>  hw/ppc/spapr.c       |  3 +++
>  target-ppc/kvm.c     | 29 +++++++++++++++++++++++++++++
>  target-ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 38 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 704aae7..843fbe7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -712,6 +712,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      } else /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */ {
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
> +        if (kvmppc_get_htm_support(env)) {
> +            pa_features[24] |=3D 0x80;
> +        }
>      }
>      if (env->ci_large_pages) {
>          pa_features[3] |=3D 0x20;
> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> index 884d564..9d13446 100644
> --- a/target-ppc/kvm.c
> +++ b/target-ppc/kvm.c
> @@ -20,6 +20,7 @@
>  #include <sys/vfs.h>
> =20
>  #include <linux/kvm.h>
> +#include "elf.h"
> =20
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
> @@ -1976,6 +1977,34 @@ uint32_t kvmppc_get_dfp(void)
>      return kvmppc_read_int_cpu_dt("ibm,dfp");
>  }
> =20
> +bool kvmppc_get_htm_support(CPUPPCState *env)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (!kvm_enabled()) {
> +        return false;
> +    }
> +    if (kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_HTM)) {
> +        return true;
> +    }
> +    /*
> +     * Fallback test for host kernels that don't yet support KVM_CAP_PPC=
_HTM.
> +     * This will be unnecessary when KVM_API_VERSION is incremented (to =
13 or
> +     * above) because that will remove the ambiguity between the host ke=
rnel
> +     * lacking support for KVM_CAP_PPC_HTM and it having support but rep=
orting
> +     * HTM as unavailable (both of which return 0, above).
> +     */
> +    if (kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
> +        /* Assume this means PR KVM, so no TM. */
> +        return false;
> +    } else {
> +        /* Assume this means HV KVM, propagate whatever host userspace s=
ees. */
> +        unsigned long hwcap2 =3D qemu_getauxval(AT_HWCAP2);
> +        return !!(hwcap2 & PPC_FEATURE2_HAS_HTM);
> +    }
> +}
> +
>  static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pv=
info)
>   {
>       PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
> index 20bfb59..b01c717 100644
> --- a/target-ppc/kvm_ppc.h
> +++ b/target-ppc/kvm_ppc.h
> @@ -17,6 +17,7 @@ uint32_t kvmppc_get_tbfreq(void);
>  uint64_t kvmppc_get_clockfreq(void);
>  uint32_t kvmppc_get_vmx(void);
>  uint32_t kvmppc_get_dfp(void);
> +bool kvmppc_get_htm_support(CPUPPCState *env);
>  bool kvmppc_get_host_model(char **buf);
>  bool kvmppc_get_host_serial(char **buf);
>  int kvmppc_get_hasidle(CPUPPCState *env);
> @@ -90,6 +91,11 @@ static inline uint32_t kvmppc_get_dfp(void)
>      return 0;
>  }
> =20
> +static inline bool kvmppc_get_htm_support(KVMState *kvm_state)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_get_hasidle(CPUPPCState *env)
>  {
>      return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8Bx+wEju+vH9ym24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfdz+AAoJEGw4ysog2bOSfnQQAKYrIANZ3f1fENM6mTfs653S
1aQddYxelIsqEGPAaxteqaQYm8AqZG9fjAGWY5rxJImmDKLunrmghD2BoDM9dcgq
eJ+X5vnNz84e7M9drno4JhKlxN+ZKc5lVEl4WOxa4OEuQK/cXQWuW7FwKKWvg2Ff
9uYSs+Mu2mgPJ/ZUdnSOSItIXGZ0KGjVVAA90xE0+TyCD1it6DYRJduQsT+AlskM
aeHOhFspiYNh3MVeRcrANfb/do3tz+YpjsQB/JEkqX6+JEaIhNee6gE5pLScWzS5
pYNDeHERk62EuFfYUtoQxq73YuzTEYbjg7BrfeHz+DEctWC5oUf9MNJrSR1FNf0D
P1i7FIrUCW+sLm0HJJXXDPl2hNIcC71hpEC3+mB1v9Em1o9Cj/s0A0gWKB0b1EgH
UF2QBKtNIC6SKHcP0lVtc4yDxjy3ongB69e/cqSMvTVCfD4xGBQx/PspavPd6icq
GMRPlhAH+n2stEhYchP4B+5ITXaGyKDvLHrGDP03IRBSiMu7bhcJjWJhfBfRxn3R
1GzWIug89RuLynCSevTNN+KcrA7TOcCu3w/QlVsKwWQmDo7vfzCukGaiZiBy7oyW
PXpx/pYrKWd8otMtpKttYk4PH7bHLY7Aq8EdeNsyG328ZEikmlbaptLawuDlx7uf
sJHvXseWEaalCmxqc+Jt
=1dC7
-----END PGP SIGNATURE-----

--8Bx+wEju+vH9ym24--
