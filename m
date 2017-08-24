Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xd9TB6THczDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 13:56:30 +1000 (AEST)
Date: Thu, 24 Aug 2017 13:49:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nixiaoming <nixiaoming@huawei.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170824034904.GD5379@umbus.fritz.box>
References: <20170824034008.GB27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/EQiL+SffV/fXkvV"
In-Reply-To: <20170824034008.GB27401@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/EQiL+SffV/fXkvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 01:40:08PM +1000, Paul Mackerras wrote:
> Nixiaoming pointed out that there is a memory leak in
> kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd()
> fails; the memory allocated for the kvmppc_spapr_tce_table struct
> is not freed, and nor are the pages allocated for the iommu
> tables.  In addition, we have already incremented the process's
> count of locked memory pages, and this doesn't get restored on
> error.
>=20
> David Hildenbrand pointed out that there is a race in that the
> function checks early on that there is not already an entry in the
> stt->iommu_tables list with the same LIOBN, but an entry with the
> same LIOBN could get added between then and when the new entry is
> added to the list.
>=20
> This fixes all three problems.  To simplify things, we now call
> anon_inode_getfd() before placing the new entry in the list.  The
> check for an existing entry is done while holding the kvm->lock
> mutex, immediately before adding the new entry to the list.
> Finally, on failure we now call kvmppc_account_memlimit to
> decrement the process's count of locked memory pages.
>=20
> Reported-by: Nixiaoming <nixiaoming@huawei.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 55 ++++++++++++++++++++++++----------=
------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index a160c14304eb..d463c1cd0d8d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -297,29 +297,22 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	unsigned long npages, size;
>  	int ret =3D -ENOMEM;
>  	int i;
> +	int fd =3D -1;
> =20
>  	if (!args->size)
>  		return -EINVAL;
> =20
> -	/* Check this LIOBN hasn't been previously allocated */
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> -		if (stt->liobn =3D=3D args->liobn)
> -			return -EBUSY;
> -	}
> -
>  	size =3D _ALIGN_UP(args->size, PAGE_SIZE >> 3);
>  	npages =3D kvmppc_tce_pages(size);
>  	ret =3D kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
> -	if (ret) {
> -		stt =3D NULL;
> -		goto fail;
> -	}
> +	if (ret)
> +		return ret;
> =20
>  	ret =3D -ENOMEM;
>  	stt =3D kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
>  		      GFP_KERNEL);
>  	if (!stt)
> -		goto fail;
> +		goto fail_acct;
> =20
>  	stt->liobn =3D args->liobn;
>  	stt->page_shift =3D args->page_shift;
> @@ -334,24 +327,42 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  			goto fail;
>  	}
> =20
> -	kvm_get_kvm(kvm);
> +	ret =3D fd =3D anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> +				    stt, O_RDWR | O_CLOEXEC);
> +	if (ret < 0)
> +		goto fail;
> =20
>  	mutex_lock(&kvm->lock);
> -	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> +
> +	/* Check this LIOBN hasn't been previously allocated */
> +	ret =3D 0;
> +	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> +		if (stt->liobn =3D=3D args->liobn) {
> +			ret =3D -EBUSY;
> +			break;
> +		}
> +	}
> +
> +	if (!ret) {
> +		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> +		kvm_get_kvm(kvm);
> +	}
> =20
>  	mutex_unlock(&kvm->lock);
> =20
> -	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> -				stt, O_RDWR | O_CLOEXEC);
> +	if (!ret)
> +		return fd;
> =20
> -fail:
> -	if (stt) {
> -		for (i =3D 0; i < npages; i++)
> -			if (stt->pages[i])
> -				__free_page(stt->pages[i]);
> +	put_unused_fd(fd);
> =20
> -		kfree(stt);
> -	}
> + fail:
> +	for (i =3D 0; i < npages; i++)
> +		if (stt->pages[i])
> +			__free_page(stt->pages[i]);
> +
> +	kfree(stt);
> + fail_acct:
> +	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
>  	return ret;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/EQiL+SffV/fXkvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeTK4ACgkQbDjKyiDZ
s5J1sg/9FYXvD4lzjEBEeqqMFEH5QaTZubUFcY9yPFwHeGqe3VM0bwrFl7CxIWBk
8oHKU+5pUin9ATjTq3Yfp1Ux4PeHOOcvl7yR+zTl7CedGFGLSlT4nLT7o59nz4EJ
7xbSXMVWVY2feJPa8NyKr4gU2I3TjwzPJkg7QWDsdAYFUL7Ue8Qy1w5sAP+2g60k
R/maYcGP+wMdmg2GSKbTLFZpwEW0z4YEI2pOEk1y9URxjr1JAtux+v9dc9ylUdcc
GSLdpfGv+GQZa/h2GoOC9vdhds8GEiXzfxUGcjRb9C4XuQvTL1o1UKpiAmnpWZTi
O+CVouR3g4m3rvL4+HAdesNK/sgn03K7+njaMUDp2ru6cauLK+hd3scF0tl9UB4G
b5TgsPdfBDssc264GuCwg/RTK26pmVc8ZiYiLQAxGwyQcTQ3h/nlePfWU56cjEtp
YaHsgrN5v6/ZdCS03hTpkPfaiOCTY8UGdiIYrySFf0PleV2f8p/Eqvm+hneygDMX
hSpZ1r3ZQBw+L7/TbV0OqR3IaLMfNwzB0ZaPDUDJy/Dur2EX5jaL+s2srqT8cNi4
z3gbbqjTCNE2hbDMIHoIrirHHkWJFZ0DLOsC5XtQQRRE6nN8PlghJESNHiHLYymb
Q+uXaVS6dy7z84grBQquv58fY7PTfRRyAYmsvWCvKhNnIBf0sjo=
=cRy/
-----END PGP SIGNATURE-----

--/EQiL+SffV/fXkvV--
