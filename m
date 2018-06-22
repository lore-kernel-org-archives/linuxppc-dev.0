Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BhCF14sKzDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 11:42:33 +1000 (AEST)
Date: Fri, 22 Jun 2018 11:17:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel] KVM: PPC: Fix hardware and emulated TCE tables
 matching
Message-ID: <20180622011749.GD612@umbus.fritz.box>
References: <20180620084258.1155-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
In-Reply-To: <20180620084258.1155-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 06:42:58PM +1000, Alexey Kardashevskiy wrote:
> When attaching a hardware table to LIOBN in KVM, we match table parameters
> such as page size, table offset and table size. However the tables are
> created via very different paths - VFIO and KVM - and the VFIO path goes
> through the platform code which has minimum TCE page size requirement
> (which is 4K but since we allocate memory by pages and cannot avoid
> alignment anyway, we align to 64k pages for powernv_defconfig).
>=20
> So when we match the tables, one might be bigger that the other which
> means the hardware table cannot get attached to LIOBN and DMA mapping
> fails.
>=20
> This removes the table size alignment from the guest visible table.
> This does not affect the memory allocation which is still aligned -
> kvmppc_tce_pages() takes care of this.
>=20
> This relaxes the check we do when attaching tables to allow the hardware
> table be bigger than the guest visible table.
>=20
> Ideally we want the KVM table to cover the same space as the hardware
> table does but since the hardware table may use multiple levels, and
> all levels must use the same table size (IODA2 design), the area it can
> actually cover might get very different from the window size which
> the guest requested, even though the guest won't map it all.
>=20
> Fixes: ca1fc489cf "KVM: PPC: Book3S: Allow backing bigger guest IOMMU pag=
es with smaller physical pages"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 8c456fa..8167ce8 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -180,7 +180,7 @@ extern long kvm_spapr_tce_attach_iommu_group(struct k=
vm *kvm, int tablefd,
>  		if ((tbltmp->it_page_shift <=3D stt->page_shift) &&
>  				(tbltmp->it_offset << tbltmp->it_page_shift =3D=3D
>  				 stt->offset << stt->page_shift) &&
> -				(tbltmp->it_size << tbltmp->it_page_shift =3D=3D
> +				(tbltmp->it_size << tbltmp->it_page_shift >=3D
>  				 stt->size << stt->page_shift)) {
>  			/*
>  			 * Reference the table to avoid races with
> @@ -296,7 +296,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
>  	struct kvmppc_spapr_tce_table *siter;
> -	unsigned long npages, size;
> +	unsigned long npages, size =3D args->size;
>  	int ret =3D -ENOMEM;
>  	int i;
> =20
> @@ -304,7 +304,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
>  		return -EINVAL;
> =20
> -	size =3D _ALIGN_UP(args->size, PAGE_SIZE >> 3);
>  	npages =3D kvmppc_tce_pages(size);
>  	ret =3D kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
>  	if (ret)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlssTjoACgkQbDjKyiDZ
s5L2kQ/8CAHv282/TGCCEVMXm2pfJzlWufy6SSXG+QEvFmyDNA3Ophh9Phl/COcy
ceGmlhTBD3oIZYhrYRAHxwZ1BfHPMlkbWlzdsdVj8LdbU53xN8FGQdVEnuYeTsLo
aKTbpMV7ddTF1IXFySTZQXagAraB3v+cOijL6StbbOx0Ijvb8WTuZ3ZVstwP9UDU
aKIaXI8wqWqoLk85Pxqdc/1dRmw+43fgkMuGAimadwIJlw/P3MJz1Pab+tGVy6Ht
h2VYtENxiTjKPyuT8AOXUXI9zpLR5skscz6ilyoMJxB0I42AcI9B4JIKjW2JSkOd
inZdq6MkXeOa2/y91MNR8inGh+RXMkBgVzXFjdv+d/6WTucfz57md8c4XN/5VXeZ
VDd3KXT32Hef1QEJOTwmXyl/S4jPdfmbDWbS7s4pJ65aG2O8Uz/AwEFQuGNyYksx
IBdiPYnOMnuDWTwALlGV7epMKS5gMCxgSjJSmChgNGGJ9HlBtCOYvrHp7TtnH8rl
8BMwYQp6lApL9RWu/gGjnER9Il6NxQFq+hoarQ21RfKkeTorlW6dEFLnXsFuSR62
HxbMKYtK1Ut7DuAtJBtrWm1ayPMUQm+ky4LENl1Bj0sqQmMBZdj4WWCYkzuFjcjc
SnFW5EOQzWEaSdWmhzvtEW1WiENUj/yrmhjBy1litnfXQwy2+78=
=R6Gl
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
