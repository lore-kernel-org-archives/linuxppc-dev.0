Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D969B1A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 15:47:25 +1000 (AEST)
Date: Mon, 1 Jun 2015 14:28:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 09/34] vfio: powerpc/spapr: Move locked_vm
 accounting to helpers
Message-ID: <20150601042814.GH22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
In-Reply-To: <1432889098-22924-10-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:33PM +1000, Alexey Kardashevskiy wrote:
> There moves locked pages accounting to helpers.
> Later they will be reused for Dynamic DMA windows (DDW).
>=20
> This reworks debug messages to show the current value and the limit.
>=20
> This stores the locked pages number in the container so when unlocking
> the iommu table pointer won't be needed. This does not have an effect
> now but it will with the multiple tables per container as then we will
> allow attaching/detaching groups on fly and we may end up having
> a container with no group attached but with the counter incremented.
>=20
> While we are here, update the comment explaining why RLIMIT_MEMLOCK
> might be required to be bigger than the guest RAM. This also prints
> pid of the current process in pr_warn/pr_debug.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> Changes:
> v4:
> * new helpers do nothing if @npages =3D=3D 0
> * tce_iommu_disable() now can decrement the counter if the group was
> detached (not possible now but will be in the future)
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 82 ++++++++++++++++++++++++++++---=
------
>  1 file changed, 63 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 64300cc..40583f9 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -29,6 +29,51 @@
>  static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group);
> =20
> +static long try_increment_locked_vm(long npages)
> +{
> +	long ret =3D 0, locked, lock_limit;
> +
> +	if (!current || !current->mm)
> +		return -ESRCH; /* process exited */
> +
> +	if (!npages)
> +		return 0;
> +
> +	down_write(&current->mm->mmap_sem);
> +	locked =3D current->mm->locked_vm + npages;

Is there a possibility of userspace triggering an integer overflow
here, if npages is really huge?

> +	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> +		ret =3D -ENOMEM;
> +	else
> +		current->mm->locked_vm +=3D npages;
> +
> +	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
> +			npages << PAGE_SHIFT,
> +			current->mm->locked_vm << PAGE_SHIFT,
> +			rlimit(RLIMIT_MEMLOCK),
> +			ret ? " - exceeded" : "");
> +
> +	up_write(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
> +static void decrement_locked_vm(long npages)
> +{
> +	if (!current || !current->mm || !npages)
> +		return; /* process exited */
> +
> +	down_write(&current->mm->mmap_sem);
> +	if (npages > current->mm->locked_vm)
> +		npages =3D current->mm->locked_vm;

Can this case ever occur (without there being a leak bug somewhere
else in the code)?

> +	current->mm->locked_vm -=3D npages;
> +	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
> +			npages << PAGE_SHIFT,
> +			current->mm->locked_vm << PAGE_SHIFT,
> +			rlimit(RLIMIT_MEMLOCK));
> +	up_write(&current->mm->mmap_sem);
> +}
> +
>  /*
>   * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
>   *
> @@ -45,6 +90,7 @@ struct tce_container {
>  	struct mutex lock;
>  	struct iommu_table *tbl;
>  	bool enabled;
> +	unsigned long locked_pages;
>  };
> =20
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> @@ -60,7 +106,7 @@ static bool tce_page_is_contained(struct page *page, u=
nsigned page_shift)
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret =3D 0;
> -	unsigned long locked, lock_limit, npages;
> +	unsigned long locked;
>  	struct iommu_table *tbl =3D container->tbl;
> =20
>  	if (!container->tbl)
> @@ -89,21 +135,22 @@ static int tce_iommu_enable(struct tce_container *co=
ntainer)
>  	 * Also we don't have a nice way to fail on H_PUT_TCE due to ulimits,
>  	 * that would effectively kill the guest at random points, much better
>  	 * enforcing the limit based on the max that the guest can map.
> +	 *
> +	 * Unfortunately at the moment it counts whole tables, no matter how
> +	 * much memory the guest has. I.e. for 4GB guest and 4 IOMMU groups
> +	 * each with 2GB DMA window, 8GB will be counted here. The reason for
> +	 * this is that we cannot tell here the amount of RAM used by the guest
> +	 * as this information is only available from KVM and VFIO is
> +	 * KVM agnostic.
>  	 */
> -	down_write(&current->mm->mmap_sem);
> -	npages =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> -	locked =3D current->mm->locked_vm + npages;
> -	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> -		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> -				rlimit(RLIMIT_MEMLOCK));
> -		ret =3D -ENOMEM;
> -	} else {
> +	locked =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> +	ret =3D try_increment_locked_vm(locked);
> +	if (ret)
> +		return ret;
> =20
> -		current->mm->locked_vm +=3D npages;
> -		container->enabled =3D true;
> -	}
> -	up_write(&current->mm->mmap_sem);
> +	container->locked_pages =3D locked;
> +
> +	container->enabled =3D true;
> =20
>  	return ret;
>  }
> @@ -115,13 +162,10 @@ static void tce_iommu_disable(struct tce_container =
*container)
> =20
>  	container->enabled =3D false;
> =20
> -	if (!container->tbl || !current->mm)
> +	if (!current->mm)
>  		return;
> =20
> -	down_write(&current->mm->mmap_sem);
> -	current->mm->locked_vm -=3D (container->tbl->it_size <<
> -			container->tbl->it_page_shift) >> PAGE_SHIFT;
> -	up_write(&current->mm->mmap_sem);
> +	decrement_locked_vm(container->locked_pages);
>  }
> =20
>  static void *tce_iommu_open(unsigned long arg)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa99eAAoJEGw4ysog2bOSbm0P/RcijPatzeCNcd7WHYNIO4Sy
wcge3KJ5/uYuSZGL2K/CECML30botJq/Fh2oNpsuyl036CEP+D9xDP+l2qFqAlfi
9Aw7fZ+mBovlBPBHW7MyvgA1v/POpaiFZz99CVvN+U9GU4SPdW1oUwfNvUZEt9RZ
GH5wmRfGA0RvMAqRuZY8GBzkT87MCaSZux7idXrmPh6F3u4DUTOF5kG1mRCcrXnN
4T6iyZlRkx0dm71COXaRmDBIZirPDjew+yIDGRxrLx250wgc6DAvqtXxdSWOUIIQ
Qu8GOtaj3eNmHmQusBOQ9VhEMAiLehxI+DhKeuwcvObt4moH3dHd/1rnOC9tnOGC
bOcC/IrjFeBv8+VPO13whPJTSbZOweA4Zb/qyvcv0keNQVqiC6tGVmvpa3n520HV
2AAGQ/tJRTFX0Z/s5i5Hcr8Eh1r31wFckYZjYMswVoBehcK+Wg+S46sINa4JSuAw
MpxiB4IBV6n3YW7u1v9T9ZuZuK3wS+vN8VZQ7W0z4n9geGhkz/3S4es9k7EPAGk7
ARq/d8LHgyIWiNaLaUyX/rC/djDefDg7oX9jPXRsbK+ZwBqpAUewjEr9SU8vvdWU
EfPK3VSKJvfRXshen2/f4LtX1K4K1thfQ24pa9hg/vtoaHA1uI1lLZEKGUOgmpJ3
vhndi2sJ/LGTa42V0QYA
=TQlG
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
