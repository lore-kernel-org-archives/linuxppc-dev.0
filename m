Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42184y1DYbzF36X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 14:04:18 +1000 (AEST)
Date: Thu, 30 Aug 2018 14:01:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 1/4] KVM: PPC: Validate all tces before updating
 tables
Message-ID: <20180830040101.GG2222@umbus.fritz.box>
References: <20180830031647.34134-1-aik@ozlabs.ru>
 <20180830031647.34134-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
In-Reply-To: <20180830031647.34134-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 01:16:44PM +1000, Alexey Kardashevskiy wrote:
> The KVM TCE handlers are written in a way so they fail when either
> something went horribly wrong or the userspace did some obvious mistake
> such as passing a misaligned address.
>=20
> We are going to enhance the TCE checker to fail on attempts to map bigger
> IOMMU page than the underlying pinned memory so let's valitate TCE
> beforehand.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

With one misgiving..

> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 4 ++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 9a3f264..0fef22b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -599,6 +599,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		ret =3D kvmppc_tce_validate(stt, tce);
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		if (get_user(tce, tces + i)) {

This looks unsafe, because we validate, then regrab the TCE from
userspace which could have been changed by another thread.

But it actually is safe, because the relevant checks will be
re-executed in the following code.  If userspace tries to change this
dodgily it will result in a messier failure mode but won't threaten
the host.

Long term, I think we would be better off copying everything into
kernel space then doing the validation just once.  But the difference
should only become apparent with a malicious or badly broken guest,
and in the meantime this series addresses a real problem.

So, I think we should go ahead with it despite that imperfection.


> +			ret =3D H_TOO_HARD;
> +			goto unlock_exit;
> +		}
> +		tce =3D be64_to_cpu(tce);
> =20
>  		if (kvmppc_gpa_to_ua(vcpu->kvm,
>  				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 506a4d4..7ab6f3f 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -501,6 +501,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
>  		ret =3D kvmppc_tce_validate(stt, tce);
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> =20
>  		ua =3D 0;
>  		if (kvmppc_gpa_to_ua(vcpu->kvm,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHa/0ACgkQbDjKyiDZ
s5Ix/g/9H5OHziVVbmR9rUT50Bq73okp/jl0sML71+1heUW2TbuphxoAh5HgIASx
NlWa1C2Vr01dDfOBLf1ovTVlQeWGBhasRvAafg2pJJ9rMK41b7zQDBTQrHadrfjw
pi1F5KcG9kvtEZbHuHronggCW9Rh2hxIB515k5VdqTKI0gJ35ImnmTQKEDh/6lrT
Lh/Tp2K+DhxAjbgasELDgzz/j49+nynjAFTbug1FWndrwN67Hu6nrkPNIQSJZNZd
84PdtZrXQrzgZVb2aRfFteyKA7AVjt2vpPjJnTbwrZgYAakWeDd/dV+Y6b4hXoCf
2t4vUGjhe7Dcsnn8+XU4rvz0HWQ0JoRRLj99YgOgif9yOITWmq14T58upSqgNPZy
g1Pfw50Sf8zBnWHqZ+69PVvnnKXDW3c+x2B9WAEjaL1/xbJze6Np8T+ySkO91+0k
s2oppY+FTrl05Ja05BP8CvohHnKmkeICdqo9ueX6UL/T35JZSNZDdJyC8SP+nkO4
w+ts1dN+M3OOHfvEIL8qmNBI+dRKfebR9uIBjxLwlVHRRIXtwD1Qj/sqJlUCjd0D
Plv4rfmi76DIwMCkOlcGmitvztEM2BYQJ4/uMzsHwVwYW3Zlr4G2clyOChLsO+Ju
NNrzJ1XsO/KAMjguFrN2gaRMUrgOWBxnZtXwkfGqky6weY6sBeY=
=/8B/
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
