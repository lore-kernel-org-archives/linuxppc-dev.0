Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F0C91A03F9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:36:33 +1100 (AEDT)
Date: Mon, 25 Jan 2016 16:30:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 2/4] KVM: PPC: Add @page_shift to
 kvmppc_spapr_tce_table
Message-ID: <20160125053049.GC32205@voom.redhat.com>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
In-Reply-To: <1453364126-22527-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 07:15:24PM +1100, Alexey Kardashevskiy wrote:
> At the moment the kvmppc_spapr_tce_table struct can only describe
> 4GB windows and handle fixed size (4K) pages. Dynamic DMA windows
> support more so these limits need to be extended.
>=20
> This replaces window_size (in bytes, 4GB max) with page_shift (32bit)
> and size (64bit, in pages).
>=20
> This should cause no behavioural change.

This commit message could be clearer about the fact that this is
changing the internal structures only - the user interface still only
allows one to create a 32-bit table with 4KiB pages at this stage.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_host.h |  3 ++-
>  arch/powerpc/kvm/book3s_64_vio.c    | 29 +++++++++++++++--------------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 20 ++++++++++----------
>  3 files changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index c7ee696..a4ed9f5 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -183,8 +183,9 @@ struct kvmppc_spapr_tce_table {
>  	struct list_head list;
>  	struct kvm *kvm;
>  	u64 liobn;
> -	u32 window_size;
>  	struct rcu_head rcu;
> +	u32 page_shift;
> +	u64 size;		/* in pages */
>  	struct page *pages[0];
>  };
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 987f406..85ee572 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -40,10 +40,9 @@
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> =20
> -static unsigned long kvmppc_stt_npages(unsigned long window_size)
> +static unsigned long kvmppc_stt_npages(unsigned long size)
>  {
> -	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
> -		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
> +	return ALIGN(size * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
> =20
>  static long kvmppc_account_memlimit(unsigned long npages, bool inc)
> @@ -92,8 +91,8 @@ static void release_spapr_tce_table(struct rcu_head *he=
ad)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
>  			struct kvmppc_spapr_tce_table, rcu);
> -	int i;
> -	unsigned long npages =3D kvmppc_stt_npages(stt->window_size);
> +	unsigned long i;
> +	unsigned long npages =3D kvmppc_stt_npages(stt->size);
> =20
>  	for (i =3D 0; i < npages; i++)
>  		__free_page(stt->pages[i]);
> @@ -106,7 +105,7 @@ static int kvm_spapr_tce_fault(struct vm_area_struct =
*vma, struct vm_fault *vmf)
>  	struct kvmppc_spapr_tce_table *stt =3D vma->vm_file->private_data;
>  	struct page *page;
> =20
> -	if (vmf->pgoff >=3D kvmppc_stt_npages(stt->window_size))
> +	if (vmf->pgoff >=3D kvmppc_stt_npages(stt->size))
>  		return VM_FAULT_SIGBUS;
> =20
>  	page =3D stt->pages[vmf->pgoff];
> @@ -133,7 +132,7 @@ static int kvm_spapr_tce_release(struct inode *inode,=
 struct file *filp)
> =20
>  	kvm_put_kvm(stt->kvm);
> =20
> -	kvmppc_account_memlimit(kvmppc_stt_npages(stt->window_size), false);
> +	kvmppc_account_memlimit(kvmppc_stt_npages(stt->size), false);
>  	call_rcu(&stt->rcu, release_spapr_tce_table);
> =20
>  	return 0;
> @@ -148,7 +147,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				   struct kvm_create_spapr_tce *args)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
> -	unsigned long npages;
> +	unsigned long npages, size;
>  	int ret =3D -ENOMEM;
>  	int i;
> =20
> @@ -158,7 +157,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  			return -EBUSY;
>  	}
> =20
> -	npages =3D kvmppc_stt_npages(args->window_size);
> +	size =3D args->window_size >> IOMMU_PAGE_SHIFT_4K;
> +	npages =3D kvmppc_stt_npages(size);
>  	ret =3D kvmppc_account_memlimit(npages, true);
>  	if (ret) {
>  		stt =3D NULL;
> @@ -171,7 +171,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  		goto fail;
> =20
>  	stt->liobn =3D args->liobn;
> -	stt->window_size =3D args->window_size;
> +	stt->page_shift =3D IOMMU_PAGE_SHIFT_4K;
> +	stt->size =3D size;
>  	stt->kvm =3D kvm;
> =20
>  	for (i =3D 0; i < npages; i++) {
> @@ -220,7 +221,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
> +	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
>  }
> @@ -239,7 +240,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	entry =3D ioba >> stt->page_shift;
>  	/*
>  	 * SPAPR spec says that the maximum size of the list is 512 TCEs
>  	 * so the whole table fits in 4K page
> @@ -300,8 +301,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> -	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> -		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> +		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
>  	return H_SUCCESS;
>  }
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 58c63ed..01ef9f9 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -72,11 +72,10 @@ EXPORT_SYMBOL_GPL(kvmppc_find_table);
>  long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long ioba, unsigned long npages)
>  {
> -	unsigned long mask =3D IOMMU_PAGE_MASK_4K;
> -	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> -	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> +	unsigned long mask =3D ~((1ULL << stt->page_shift) - 1);
> +	unsigned long idx =3D ioba >> stt->page_shift;
> =20
> -	if ((ioba & ~mask) || (idx + npages > size))
> +	if ((ioba & ~mask) || (idx + npages > stt->size))
>  		return H_PARAMETER;
> =20
>  	return H_SUCCESS;
> @@ -96,7 +95,8 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
>   */
>  long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned lo=
ng tce)
>  {
> -	unsigned long mask =3D IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_REA=
D;
> +	unsigned long mask =3D ~((1ULL << stt->page_shift) - 1) |
> +			TCE_PCI_WRITE | TCE_PCI_READ;
> =20
>  	if (tce & ~mask)
>  		return H_PARAMETER;
> @@ -197,7 +197,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
> +	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
> =20
>  	return H_SUCCESS;
>  }
> @@ -242,7 +242,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	entry =3D ioba >> stt->page_shift;
>  	/*
>  	 * The spec says that the maximum size of the list is 512 TCEs
>  	 * so the whole table addressed resides in 4K page
> @@ -302,8 +302,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>  		return H_PARAMETER;
> =20
> -	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> -		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> +	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
> +		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
> =20
>  	return H_SUCCESS;
>  }
> @@ -324,7 +324,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> +	idx =3D ioba >> stt->page_shift;
>  	page =3D stt->pages[idx / TCES_PER_PAGE];
>  	tbl =3D (u64 *)page_address(page);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpbMJAAoJEGw4ysog2bOSWMIP/1S2VppZi5q8+BmfIS1sqBML
+TwDCQ/74B9F1r/oc42ZCBCmGU+uUmXaWfZ8k8IuHPc936zj2aQCjUo0MFW8ucK8
sSOQ44yU679ULqdVwwCipoIt4DNPr1aF82cT1FkkiHe44j5LZ9v6EgJQkEim99OJ
jKWVAKESRWMFJfO3byEo9dfadRJse2/lXnS6A6RMk88xAagN/BrcDlQtumHpFD+o
BDUaokhwG+RafjlctAGMXTnV4h7h+dp4keu/TehWS2hmRjDcCjrcEzIo1vFi7Lhn
KNEWA8g/9Dg/rFH6PjIKew6J8UawYhsvHO4P6Q4DEbti3EDijHPi+WYMSOFSZuBv
5PRKBpL+91M5zhXUIMcgr06HBc2bSt6e8zPMyyD8IauICwN0roPY4l0WG33uxqXU
mZYjBaI7NgqvqPam0ggcxU1TALIoxuBArIqHGTulbYISkdOY+L7PM2FZWx/LxlNz
GCBo7sMAp8DjcXatwPco5fCs0xk1hvwB/hJOIPQUpMVqZzo1YF/2l3TX4Jf5G2KN
H4IicMPQCm5hgFtIpxnxfS6mcpgZs296IFwmHvqnC7YPh1Ml74C4OrPcRSWA6nE/
NiF9T0soZ2oQmnARothYHXRyMM9HQKvXqzQLr1f0OC1Y4HKXH3iNYCXhRDBZmINd
lIzIr0SMblzCGzQoJF1a
=VDXR
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
