Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6VwL3FlszDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:28:50 +1000 (AEST)
Date: Tue, 18 Apr 2017 12:16:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel] KVM: PPC: Align the table size to system page size
Message-ID: <20170418021609.GC12235@umbus.fritz.box>
References: <20170413070420.16927-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
In-Reply-To: <20170413070420.16927-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 05:04:20PM +1000, Alexey Kardashevskiy wrote:
> At the moment the userspace can request a table smaller than a page size
> and this value will be stored as kvmppc_spapr_tce_table::size.
> However the actual allocated size will still be aligned to the system
> page size as alloc_page() is used there.
>=20
> This aligns the table size up to the system page size. It should not
> change the existing behaviour but when in-kernel TCE acceleration patchset
> reaches the upstream kernel, this will allow small TCE tables be
> accelerated as well: PCI IODA iommu_table allocator already aligns
> the size and, without this patch, an IOMMU group won't attach to LIOBN
> due to the mismatching table size.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> For sake of bisectability (otherwise in-kernel acceleration won't work
> hugepages braking DMA completely), this is better be put before
> [PATCH kernel v11 00/10] powerpc/kvm/vfio: Enable in-kernel acceleration
>=20
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index aea3a5b74fb6..45941af9c6d7 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -333,7 +333,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  			return -EBUSY;
>  	}
> =20
> -	size =3D args->size;
> +	size =3D _ALIGN_UP(args->size, PAGE_SIZE >> 3);
>  	npages =3D kvmppc_tce_pages(size);
>  	ret =3D kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
>  	if (ret) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9XbpAAoJEGw4ysog2bOSASEQANOBvcXVx7b0JZZtda4QHZUL
hWnEoDdOT4bL56ISPoK/qVuZnBlcJPJpr4QbdxK0pypa/yArbZYbPZ9lt3n5GLTm
Z5cDkmjqS/m2VwU3KG6W2sSG6JrLxOAjRjkzoJK+hQcKDSfUGi8SPaAV5crsRspB
t8Iw0BR/BWl7A9zmbHPJalq61kTud7LC0bfk3x4s3qLdKjfbuiR/SSG/cc5jTSFb
9LiTfqyvlUxuACV1HfVPF11MzTNEG8SOjJWgrhNiYiQ4oV6zDurFuMSnGCW6qwvo
rMIRksUl3COeRTIh9ovfU1VzmKuEWYLbTpMNmmLzt5okhVF9EQBEp07PBk37qq1a
tV6FBz6odRVa18LD35I0nWIVoKRpgPNLgaf6yjB8Abflrm31TCDPF+XIFhqx3W8E
c/0TFRqnU9T1Xs3ELSP3tpqNPsRZSR1yOSLmaIzhnxs9+h/7v+LrY05+DU6MD7AM
ccVzeQ57YoEIhJjI7861eN9hxCqqXguJOwREfYGVqZOu9m2s5d7/KxwFGjjJrNQL
PYE8t2OfNcenvmOf5BjIzce7ntfntpUP37n6chVz8/kBjGYaRByhNITORwekq/fi
VC5ESjxMRuKKZzxR3PIZ3x/jZT6K5S9ofyEkgsislrnANwzKkOWVm510Zr1Qe96b
N3LTOIDeWIcVEVd4GMuW
=Du/O
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
