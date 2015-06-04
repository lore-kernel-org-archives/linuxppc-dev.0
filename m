Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 805BC1A0214
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 11:25:34 +1000 (AEST)
Date: Thu, 4 Jun 2015 11:00:28 +1000
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
Message-ID: <20150604010028.GC5590@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-10-git-send-email-aik@ozlabs.ru>
 <20150601042814.GH22789@voom.redhat.com>
 <556EE0CD.1030508@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
In-Reply-To: <556EE0CD.1030508@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 09:11:09PM +1000, Alexey Kardashevskiy wrote:
> On 06/01/2015 02:28 PM, David Gibson wrote:
> >On Fri, May 29, 2015 at 06:44:33PM +1000, Alexey Kardashevskiy wrote:
> >>There moves locked pages accounting to helpers.
> >>Later they will be reused for Dynamic DMA windows (DDW).
> >>
> >>This reworks debug messages to show the current value and the limit.
> >>
> >>This stores the locked pages number in the container so when unlocking
> >>the iommu table pointer won't be needed. This does not have an effect
> >>now but it will with the multiple tables per container as then we will
> >>allow attaching/detaching groups on fly and we may end up having
> >>a container with no group attached but with the counter incremented.
> >>
> >>While we are here, update the comment explaining why RLIMIT_MEMLOCK
> >>might be required to be bigger than the guest RAM. This also prints
> >>pid of the current process in pr_warn/pr_debug.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>[aw: for the vfio related changes]
> >>Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >>---
> >>Changes:
> >>v4:
> >>* new helpers do nothing if @npages =3D=3D 0
> >>* tce_iommu_disable() now can decrement the counter if the group was
> >>detached (not possible now but will be in the future)
> >>---
> >>  drivers/vfio/vfio_iommu_spapr_tce.c | 82 ++++++++++++++++++++++++++++=
---------
> >>  1 file changed, 63 insertions(+), 19 deletions(-)
> >>
> >>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> >>index 64300cc..40583f9 100644
> >>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>@@ -29,6 +29,51 @@
> >>  static void tce_iommu_detach_group(void *iommu_data,
> >>  		struct iommu_group *iommu_group);
> >>
> >>+static long try_increment_locked_vm(long npages)
> >>+{
> >>+	long ret =3D 0, locked, lock_limit;
> >>+
> >>+	if (!current || !current->mm)
> >>+		return -ESRCH; /* process exited */
> >>+
> >>+	if (!npages)
> >>+		return 0;
> >>+
> >>+	down_write(&current->mm->mmap_sem);
> >>+	locked =3D current->mm->locked_vm + npages;
> >
> >Is there a possibility of userspace triggering an integer overflow
> >here, if npages is really huge?
>=20
>=20
> I do not see how. I just do not accept npages bigger than the host RAM si=
ze
> in pages. And it is "long". For (lets say) 128GB host, the number of 4KB
> pages is (128<<30)/4096=3D33554432.

Ah, yes, npages has already been shifted right so it should be safe. Ok.

>=20
>=20
> >
> >>+	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >>+	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >>+		ret =3D -ENOMEM;
> >>+	else
> >>+		current->mm->locked_vm +=3D npages;
> >>+
> >>+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
> >>+			npages << PAGE_SHIFT,
> >>+			current->mm->locked_vm << PAGE_SHIFT,
> >>+			rlimit(RLIMIT_MEMLOCK),
> >>+			ret ? " - exceeded" : "");
> >>+
> >>+	up_write(&current->mm->mmap_sem);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static void decrement_locked_vm(long npages)
> >>+{
> >>+	if (!current || !current->mm || !npages)
> >>+		return; /* process exited */
> >>+
> >>+	down_write(&current->mm->mmap_sem);
> >>+	if (npages > current->mm->locked_vm)
> >>+		npages =3D current->mm->locked_vm;
> >
> >Can this case ever occur (without there being a leak bug somewhere
> >else in the code)?
>=20
>=20
> It should not. Safety measure. Having a warning here might make sense but=
 I
> believe if this happens, there will be many, many warnings in other places
> :)

Ok.  I'd would be nice to see a WARN_ON() as documentation that this
isn't a situation that should ever happen.  I wouldn't nack on that
basis alone though.

> >>+	current->mm->locked_vm -=3D npages;
> >>+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
> >>+			npages << PAGE_SHIFT,
> >>+			current->mm->locked_vm << PAGE_SHIFT,
> >>+			rlimit(RLIMIT_MEMLOCK));
> >>+	up_write(&current->mm->mmap_sem);
> >>+}
> >>+
> >>  /*
> >>   * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
> >>   *
> >>@@ -45,6 +90,7 @@ struct tce_container {
> >>  	struct mutex lock;
> >>  	struct iommu_table *tbl;
> >>  	bool enabled;
> >>+	unsigned long locked_pages;
> >>  };
> >>
> >>  static bool tce_page_is_contained(struct page *page, unsigned page_sh=
ift)
> >>@@ -60,7 +106,7 @@ static bool tce_page_is_contained(struct page *page,=
 unsigned page_shift)
> >>  static int tce_iommu_enable(struct tce_container *container)
> >>  {
> >>  	int ret =3D 0;
> >>-	unsigned long locked, lock_limit, npages;
> >>+	unsigned long locked;
> >>  	struct iommu_table *tbl =3D container->tbl;
> >>
> >>  	if (!container->tbl)
> >>@@ -89,21 +135,22 @@ static int tce_iommu_enable(struct tce_container *=
container)
> >>  	 * Also we don't have a nice way to fail on H_PUT_TCE due to ulimits,
> >>  	 * that would effectively kill the guest at random points, much bett=
er
> >>  	 * enforcing the limit based on the max that the guest can map.
> >>+	 *
> >>+	 * Unfortunately at the moment it counts whole tables, no matter how
> >>+	 * much memory the guest has. I.e. for 4GB guest and 4 IOMMU groups
> >>+	 * each with 2GB DMA window, 8GB will be counted here. The reason for
> >>+	 * this is that we cannot tell here the amount of RAM used by the gue=
st
> >>+	 * as this information is only available from KVM and VFIO is
> >>+	 * KVM agnostic.
> >>  	 */
> >>-	down_write(&current->mm->mmap_sem);
> >>-	npages =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> >>-	locked =3D current->mm->locked_vm + npages;
> >>-	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >>-	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> >>-		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> >>-				rlimit(RLIMIT_MEMLOCK));
> >>-		ret =3D -ENOMEM;
> >>-	} else {
> >>+	locked =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> >>+	ret =3D try_increment_locked_vm(locked);
> >>+	if (ret)
> >>+		return ret;
> >>
> >>-		current->mm->locked_vm +=3D npages;
> >>-		container->enabled =3D true;
> >>-	}
> >>-	up_write(&current->mm->mmap_sem);
> >>+	container->locked_pages =3D locked;
> >>+
> >>+	container->enabled =3D true;
> >>
> >>  	return ret;
> >>  }
> >>@@ -115,13 +162,10 @@ static void tce_iommu_disable(struct tce_containe=
r *container)
> >>
> >>  	container->enabled =3D false;
> >>
> >>-	if (!container->tbl || !current->mm)
> >>+	if (!current->mm)
> >>  		return;
> >>
> >>-	down_write(&current->mm->mmap_sem);
> >>-	current->mm->locked_vm -=3D (container->tbl->it_size <<
> >>-			container->tbl->it_page_shift) >> PAGE_SHIFT;
> >>-	up_write(&current->mm->mmap_sem);
> >>+	decrement_locked_vm(container->locked_pages);
> >>  }
> >>
> >>  static void *tce_iommu_open(unsigned long arg)
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb6MsAAoJEGw4ysog2bOSnqAP/jH9kOnqRfPz6Z3gkYn6zNBv
aLpB80NxwYkSYGf7zfjb5QaAGZKwrVEd5WqCwmGxYR88ZF9Nsroyh7gzJ9kKKNZd
yKqePLsqH7ZwIN+la9bRyM4kdoRLefPbyjgSxdOgbfcpW15r0Fr4CcyxEE7eh0ut
30jjNdFpr9VY7DQx2nl182pJc2o8QOJxZSQM0/Jp8E1yV0fXLNwlXNEunB2xXUO0
S9NfZB8wXCvvTysQ22/iQfT2mOLzwWprBtz+pHTxhLo3QcJ0ifvmrGbmMKR+sETb
0AEFgTcRcl7xcRTQH9klfS+8VOxP9M/duMYkAa89zlOfhxNkRxFdNjLCJPSlvW6J
AVBhe29jCxS35VlQPezURBpxHGOQ/44m7xe6Ir34m25U7Oumfds/UeFOcUeUv/yR
GRw03YfItCbn4E2XsoblJm5HufROPqoIOCssBpa0e37BqgLDsfI8LNDPGb8AhPX/
5gC3LMQRGPZ3n1eJ0OLAp6hzUrCbR9BeizCY/FRJbMvnkpsUpb9Db4dEA22nzkAS
lg2ApWCWs7/e6UeIBj/qRyzobR0nraLctRR03Lu4fWTn2n7iYiRyTLL6HTriN+JZ
exHi93JpV8VvK8LxdPLyl3cRQHUD6ebkMaAD9Dx71u4vayhYRwfgQNblUcR6jTG7
0WsisrU3bNJQNI0O3jlX
=2gkh
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
