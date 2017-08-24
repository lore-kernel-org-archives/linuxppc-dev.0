Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdNsv2pmDzDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:30:11 +1000 (AEST)
Date: Thu, 24 Aug 2017 21:15:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nixiaoming <nixiaoming@huawei.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH really v2] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170824111513.GI5379@umbus.fritz.box>
References: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qih7n4MdZQ4fb9uN"
In-Reply-To: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qih7n4MdZQ4fb9uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 07:14:47PM +1000, Paul Mackerras wrote:
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
> v2: Don't overwrite stt in loop over spapr_tce_tables
>=20
>  arch/powerpc/kvm/book3s_64_vio.c | 56 ++++++++++++++++++++++++----------=
------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index a160c14..53766e2 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -294,32 +294,26 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				   struct kvm_create_spapr_tce_64 *args)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
> +	struct kvmppc_spapr_tce_table *siter;
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
> @@ -334,24 +328,42 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
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
> +	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
> +		if (siter->liobn =3D=3D args->liobn) {
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

--qih7n4MdZQ4fb9uN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmetT4ACgkQbDjKyiDZ
s5IcFw//ZFAxo8IGMy2zqBSPKvZgMzinkHTM+R8kfZ9iY9WspDnsIMXgEW2QTb0k
zpA7FDuZ15kUofPCzX1YxynfMW79ux6ouVnMA7telXUwSUqikeKUL4YNK09Zl58z
j1E8sEoezIlaQWTijQ8HWBVNnUW74y5/PT5OuA4lEpBExowaUBige+RIehrQntck
JY3nFZcTUN6oSpjYIT4kwKi3myKN5CD35tyGEeOT6/jlcNihFx9hc1bKuxg5dGhD
JuZ9AgNkZbaIckae4DqPeEg5j28aEVdYgKKIJvW6SOqoumOV5Uv2NLZT59DEHjBc
NV4XS3VDDuh9lrcMMLjPl+46dqKhCTHFdQTsnqXxCMsiMIWf6wqyCxeMpgu5BSFi
sUjU79jtSAI6p2+wW4mUWM8KPCREevocLDdyeIRMlEfxs5LUYHJGOKuWExAv9VDT
aTzgKNfAsjjNmkaxKxa854qcWAZ+GiDuEpoGteo1wKCtz8Kn5fvcIZksV5S7GAgU
ZFPbWwiPRbBmXc/XYU+pspKC7vKE6UeGb1FFoIJYHyRlOEAIpSKSqBpNfjha3QOo
3dDPScnPecIudHXkWbdLCigg58391Fn77qLoNY+54xmeETE6yjowztFBzLQV0Z4l
m5VZAQPqyZoXEop4xBjfCVT9OwUVbMzklgyezoLoQgtqqgTki9c=
=byFY
-----END PGP SIGNATURE-----

--qih7n4MdZQ4fb9uN--
