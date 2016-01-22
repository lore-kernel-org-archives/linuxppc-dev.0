Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03171A0562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 12:26:36 +1100 (AEDT)
Date: Fri, 22 Jan 2016 11:42:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 1/6] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE
 handlers
Message-ID: <20160122004245.GL27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oY1uq2ONqt5kuovO"
In-Reply-To: <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oY1uq2ONqt5kuovO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 06:39:32PM +1100, Alexey Kardashevskiy wrote:
> This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have following
> patches applied nicer.
>=20
> This moves the ioba boundaries check to a helper and adds a check for
> least bits which have to be zeros.
>=20
> The patch is pretty mechanical (only check for least ioba bits is added)
> so no change in behaviour is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Concept looks good, but there are a couple of nits.

> ---
> Changelog:
> v2:
> * compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
> * made error reporting cleaner
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 111 +++++++++++++++++++++++-------=
------
>  1 file changed, 72 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 89e96b3..862f9a2 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -35,71 +35,104 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/kvm_host.h>
>  #include <asm/udbg.h>
> +#include <asm/iommu.h>
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
> +/*
> + * Finds a TCE table descriptor by LIOBN.
> + *
> + * WARNING: This will be called in real or virtual mode on HV KVM and vi=
rtual
> + *          mode on PR KVM
> + */
> +static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu =
*vcpu,
> +		unsigned long liobn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvmppc_spapr_tce_table *stt;
> +
> +	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)

list_for_each_entry_lockless?  According to the comments in the
header, that's for RCU protected lists, whereas this one is just
protected by the lock in the kvm structure.  This is replacing a plain
list_for_each_entry().


> +		if (stt->liobn =3D=3D liobn)
> +			return stt;
> +
> +	return NULL;
> +}
> +
> +/*
> + * Validates IO address.
> + *
> + * WARNING: This will be called in real-mode on HV KVM and virtual
> + *          mode on PR KVM
> + */
> +static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long ioba, unsigned long npages)
> +{
> +	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> +	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> +
> +	if ((ioba & mask) || (idx + npages > size))

It doesn't matter for the current callers, but you should check for
overflow in idx + npages as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oY1uq2ONqt5kuovO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWoXsFAAoJEGw4ysog2bOSVBoP/0q6y0bmJqNPisIKy6TCJKW5
W5PL2XtzIIRYM/L63CnPQp9u6GxtE+ETbGa4muLqruWKHBzgeypVMEjWKypyDdvk
LDE97Aq96YIBjW7rtsnPeK6A43DgQhHNezVd7pd8tiBoUDTNDirW8YctD3lDFZgt
zUZZI5/hBsBZqQl8XjjGNDdhSYDsp+y4zPGKPQuEac6Z0fRVlPnkPdOUtd0tMbrN
8FClISyDNV+IY7w9kWzvBvRrCG2b7bQ0XuQ9wHHTnn4RFkJIa2H6UfW5GjxNCKN4
Oyl9UegBYJaJp3o8/vI1xFWHeLsvgX5gUviXe6sgdFYwYaQFUpnWzxW1zGeW9RrE
TtWhvUG4pr/878Y/alWrfGNmh63fUda5XBAvw/iqoD12pxP8rYOb20eCvQq64ZFl
ZLAyOrhzy4cuYK6q68K4xtaPLKCSPH0bbLDiIT6UFSmffacfcNg8gCvfwCuALVmP
ddsZRnaGT4VIS264jnMePwHK3jbJb1d/3kiXvE3mYZoX3HqgW9Sf9O9Cb6n2vukR
magDYSyfsNSVEOySsHq4xYqq0bBCLaKLlNIqRNYqHV6TGmBnSsuFKc9VW++Gre57
xwna08E8R6D3M3BYeTrhboPTqe0vvZf4U46pZcYjZwmokZ6m0Aqxqw7y4PUiBWJT
BFYbv5dphhLngHYuC0Fy
=gt5J
-----END PGP SIGNATURE-----

--oY1uq2ONqt5kuovO--
