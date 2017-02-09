Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJlpb0nGMzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 15:44:07 +1100 (AEDT)
Date: Thu, 9 Feb 2017 14:51:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
Message-ID: <20170209035151.GA14524@umbus>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <20170207071711.28938-9-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 06:17:09PM +1100, Alexey Kardashevskiy wrote:
> For the emulated devices it does not matter much if we get a broken TCE
> half way handling a TCE list but for VFIO it will matter as it has
> more chances to fail so we try to do our best and check as much as we
> can before proceeding.
>=20
> This separates a guest view table update from validation. No change in
> behavior is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 8 ++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 15df8ae627d9..9a7b7fca5e84 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -282,6 +282,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  		ret =3D kvmppc_tce_validate(stt, tce);
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		if (get_user(tce, tces + i)) {
> +			ret =3D H_TOO_HARD;
> +			goto unlock_exit;
> +		}
> +		tce =3D be64_to_cpu(tce);

This doesn't look safe.  The contents of user memory could change
between the two get_user()s, meaning that you're no longer guaranteed
a TCE loaded into kernel has been validated at all.

I think you need to either:

    a) Make sure things safe against a bad TCE being loaded into a TCE
    table and move all validation to where the TCE is used, rather
    than loaded

or
    b) Copy the whole set of indirect entries to a temporary in-kernel
       buffer, then validate, then load into the actual TCE table.

> =20
>  		kvmppc_tce_put(stt, entry + i, tce);
>  	}
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 918af76ab2b6..f8a54b7c788e 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -237,7 +237,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  {
>  	struct kvmppc_spapr_tce_table *stt;
>  	long i, ret =3D H_SUCCESS;
> -	unsigned long tces, entry, ua =3D 0;
> +	unsigned long tces, entry, tce, ua =3D 0;
>  	unsigned long *rmap =3D NULL;
> =20
>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> @@ -279,11 +279,15 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>  	}
> =20
>  	for (i =3D 0; i < npages; ++i) {
> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> =20
>  		ret =3D kvmppc_tce_validate(stt, tce);
>  		if (ret !=3D H_SUCCESS)
>  			goto unlock_exit;
> +	}
> +
> +	for (i =3D 0; i < npages; ++i) {
> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);

Same problem here.

> =20
>  		kvmppc_tce_put(stt, entry + i, tce);
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm+dVAAoJEGw4ysog2bOSPNsP/j6Oi6Nz3YKy6hVS3coIh3wk
bATGt9ficn9k4PqCaiLtVb1VurKW0A76QPDUrjSkUqITxIzz+Qjf5QPN2Az90DDk
LzS3B5Z2IPcN6Gg5mXzAKOpvx8hmnA3TlkVNa2Xuh1fn0CrtVkECW2aWy4KxxU1S
jSZioUrOOj38aT6vSrjxeo6q7RYslfyiSEgcLe1bU8OQeqla4sTSy9LmvcAGhQnt
y6/Ags/F0/sEsk1GJ7DE4H0CQsA0xkfF6gmi6JejsDIvhIfMu5VpxgBW2cWXIGEC
zdw3w13sZ9PT0X3wm8BERyEbip8tkLz+STg8QcRDwX7dZfAGww5bOZ5Ku3owBfot
WOHSY6jgxRqjCKKhG9VR/TrvB/s0mGgntRRFQWyv5HNwOG7ikOFob6LKX3Qnhtlo
Q6X4lA0syWSKT9+ZZX6vsjBBQyUTfgZz+d5cr7LFB+KQfPha3fZOS+ba1BBfAOUT
RLQ6Dlg+BJiQEVvpOA3YElLMdKsLHCYgCZjVrSqjkzwGmRagTue2OnstvmFbCHvR
yOKqa1vu437Af2dv+ruEQcTwRAgg9/x+s48+dA9lvnsI0kb5COPK2wVKWAjR6m4+
01Rvy2g66RXMmdaJmlwyBu0TCg9YCssBuCLGM7KaRekJRCD6PIyvifcpmL0q6mTQ
hnDgQ/Z9MPM/lSLX/TME
=53Aq
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
