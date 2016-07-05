Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkF1P3KPPzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:52:09 +1000 (AEST)
Date: Tue, 5 Jul 2016 16:52:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] spapr: Set ibm, pa-features HTM from KVM_CAP_PPC_HTM
Message-ID: <20160705065257.GM2251@voom.fritz.box>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <92f09cf433b816a88d94adc50cd9cb89b94131a3.1467695915.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
In-Reply-To: <92f09cf433b816a88d94adc50cd9cb89b94131a3.1467695915.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 03:19:24PM +1000, Sam Bobroff wrote:
> Advertise HTM support in ibm, pa-features if KVM indicates support when
> queried via a new capability (KVM_CAP_PPC_HTM).
>=20
> If KVM returns false for the capability (which may indicate that the
> host kernel doesn't support the capability itself) attempt to
> determine availability using a fallback method based on KVM being
> KVM-HV and HTM being available to the QEMU process.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr.c       |  3 ++-
>  target-ppc/kvm.c     | 27 +++++++++++++++++++++++++++
>  target-ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 704aae7..e229532 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -606,6 +606,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
>          : SPAPR_TIMEBASE_FREQ;
>      uint32_t cpufreq =3D kvm_enabled() ? kvmppc_get_clockfreq() : 100000=
0000;
> +    uint8_t htm =3D (kvm_enabled() && kvmppc_get_htm_support(env)) ? 0x8=
0 : 0x00;

You can simplify this if you make kvmppc_get_htm_support() return
false when !kvm_enabled().

>      uint32_t page_sizes_prop[64];
>      size_t page_sizes_prop_size;
>      uint32_t vcpus_per_socket =3D smp_threads * smp_cores;
> @@ -635,7 +636,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>          0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> +        0x80, 0x00, 0x80, 0x00, 0x00 | htm, 0x00 };

I think it would be easier to read if the initializer is kept constant
and you fold in the htm bit in the actual code.

>      uint8_t *pa_features;
>      size_t pa_size;
> =20
> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> index 884d564..f94ce3b 100644
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
> @@ -1976,6 +1977,32 @@ uint32_t kvmppc_get_dfp(void)
>      return kvmppc_read_int_cpu_dt("ibm,dfp");
>  }
> =20
> +bool kvmppc_get_htm_support(CPUPPCState *env)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    CPUState *cs =3D CPU(cpu);
> +
> +
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

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe1lJAAoJEGw4ysog2bOSowUQALaVQJg6+1Jl54XjoIM5mraO
/KHi2AqVd2Xj49xNk9HOfh08kX5jO45ZwnUW1LNEPreiFPzLGLCac7RxC26igqiH
3YeAFW6GJXrOgD9of/DKAFgIj7NzP2ubKBtKQHP2RiD0eecF91CTiCWSuB6CqXuW
S6hP8Ax0Y2eDqIRbC/zcRzJlYpoXANN+DPBiIr3VlxHhVNTTLW/HrQqo7PgO+sF1
V+iZyeXbAN2d9Z9Ma0Sc3B9i0T9zd/Lv3sBgGk5ghMxttiF6Wm7i6JgEOZBt/qZP
P9sZP3ZEJ0hlH5ROhRa9lTIA0nM+6shH/ork9EcVmtgkM7t3HBxhI8k8n/IlW4AK
MeeHuu6gG0DBLpSbpHyxgC7eGp6KR8UL7lZRcIg9gidfNaZHCdLksmgwWFCnpqNf
VmTZfMHEU4qv6RNgqRmOvEJUmPRS6QBISho+sGOyFOwJycy5jXPI4AjjcGG9WmCo
7WBew+U3UCjfyhhzCv74iT4RE7rN2a+LYDq7KToMvYgoN9HFU0M0UCOvT1Vob399
nluX8FiIvN1kG3cRISnGsjabdwsGy0GNTtdEtaVmfdfNzLILuv+34O65/Kp/kXdn
1B7Qd6xmkJIXHA5rdXe9P6ZVYzKltC57Mxv/AUuIBFIn30R3+mlqsN51DStMZ0PB
jiQRhN12huUl6hH7fdgq
=fWWO
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
