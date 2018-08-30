Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42184y3VxYzF36d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 14:04:18 +1000 (AEST)
Date: Thu, 30 Aug 2018 14:04:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel 4/4] KVM: PPC: Propagate errors to the guest when
 failed instead of ignoring
Message-ID: <20180830040413.GJ2222@umbus.fritz.box>
References: <20180830031647.34134-1-aik@ozlabs.ru>
 <20180830031647.34134-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
In-Reply-To: <20180830031647.34134-5-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 01:16:47PM +1000, Alexey Kardashevskiy wrote:
> At the moment if the PUT_TCE{_INDIRECT} handlers fail to update
> the hardware tables, we print a warning once, clear the entry and
> continue. This is so as at the time the assumption was that if
> a VFIO device is hotplugged into the guest, and the userspace replays
> virtual DMA mappings (i.e. TCEs) to the hardware tables and if this fails,
> then there is nothing useful we can do about it.
>=20
> However the assumption is not valid as these handlers are not called for
> TCE replay (VFIO ioctl interface is used for that) and these handlers
> are for new TCEs.
>=20
> This returns an error to the guest if there is a request which cannot be
> processed. By now the only possible failure must be H_TOO_HARD.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 20 ++++++--------------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 20 ++++++--------------
>  2 files changed, 12 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 5cd2a66..5e3151b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -568,14 +568,10 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsign=
ed long liobn,
>  			ret =3D kvmppc_tce_iommu_map(vcpu->kvm, stt, stit->tbl,
>  					entry, ua, dir);
> =20
> -		if (ret =3D=3D H_SUCCESS)
> -			continue;
> -
> -		if (ret =3D=3D H_TOO_HARD)
> +		if (ret !=3D H_SUCCESS) {
> +			kvmppc_clear_tce(stit->tbl, entry);
>  			goto unlock_exit;
> -
> -		WARN_ON_ONCE(1);
> -		kvmppc_clear_tce(stit->tbl, entry);
> +		}
>  	}
> =20
>  	kvmppc_tce_put(stt, entry, tce);
> @@ -660,14 +656,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcp=
u,
>  					stit->tbl, entry + i, ua,
>  					iommu_tce_direction(tce));
> =20
> -			if (ret =3D=3D H_SUCCESS)
> -				continue;
> -
> -			if (ret =3D=3D H_TOO_HARD)
> +			if (ret !=3D H_SUCCESS) {
> +				kvmppc_clear_tce(stit->tbl, entry);
>  				goto unlock_exit;
> -
> -			WARN_ON_ONCE(1);
> -			kvmppc_clear_tce(stit->tbl, entry);
> +			}
>  		}
> =20
>  		kvmppc_tce_put(stt, entry + i, tce);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index e79ffbb..8d82133 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -380,14 +380,10 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, uns=
igned long liobn,
>  			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
>  					stit->tbl, entry, ua, dir);
> =20
> -		if (ret =3D=3D H_SUCCESS)
> -			continue;
> -
> -		if (ret =3D=3D H_TOO_HARD)
> +		if (ret !=3D H_SUCCESS) {
> +			kvmppc_rm_clear_tce(stit->tbl, entry);
>  			return ret;
> -
> -		WARN_ON_ONCE_RM(1);
> -		kvmppc_rm_clear_tce(stit->tbl, entry);
> +		}
>  	}
> =20
>  	kvmppc_tce_put(stt, entry, tce);
> @@ -533,14 +529,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>  					stit->tbl, entry + i, ua,
>  					iommu_tce_direction(tce));
> =20
> -			if (ret =3D=3D H_SUCCESS)
> -				continue;
> -
> -			if (ret =3D=3D H_TOO_HARD)
> +			if (ret !=3D H_SUCCESS) {
> +				kvmppc_rm_clear_tce(stit->tbl, entry);
>  				goto unlock_exit;
> -
> -			WARN_ON_ONCE_RM(1);
> -			kvmppc_rm_clear_tce(stit->tbl, entry);
> +			}
>  		}
> =20
>  		kvmppc_tce_put(stt, entry + i, tce);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHbL0ACgkQbDjKyiDZ
s5Ljbw//cNwz4gdLgrOquks2b5HdA739/gsCiue/a2mwjSHRG1utQ7TLrj/+NaKy
p5F92LpbPb7l7nsO3wUwg/utJIEOb8pKwcdCE9G0wI4+lgebQ0kpwzfs+R+nvEHz
HdZM9B+7Y5ElN5b5bZI7kpSE0sPDzBe9OYKfCYQSFLgwPdtzr1E9TSp7Sbi3zLW3
yWK00Q4ne0gVNpm2TGwp3V8wqBRooJK/aFGOK6nnY+nIR8IT4j71pWm7CBA8WE+c
EehqtOWJOoCGCxlCyCx6jF6bMjNWSZ5xquRu7NZgogUuhc00XTRhi7Iln+75EfNT
kNuaD8BjXX64ATGeKLOfXgWEdJxQqRBpIffZ0jo+/1ecwn0eiFidO0Ya05uDDQ+8
YOmeyFnQeKCN/CsBoA9J0OU31phi4hf0CB5krTtPUoRzxJPiaEjqkrtkAD61nAIW
Suvvq5lV3WSxUzoIp4hu1AI5qFFxRUBTcHk3vaWGDpUSziWf4sZu23qS5jCi6/He
TiD16NRYxiogL7BsBVwL4YztqC+axdd9l6q42qZsF3tSjoUum1vYegts2K1OYOtu
3xU1kNxyu2HY+J3uVhyBWeX4usVI+sOpjhdIrd7extC2z9ba2IoCkviSPWe48lwx
Tx5qhWpkwC6Bq6BG2SuIbgg4syqVZnd3AxgHxFBRG0As/Q5DijE=
=23Wk
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--
