Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN9n22H1zzDvPZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:24:22 +1100 (AEDT)
Date: Tue, 22 Nov 2016 13:38:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
Message-ID: <20161122023801.GA28479@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2016 at 06:39:41PM +1100, Alexey Kardashevskiy wrote:
> On 11/11/16 23:32, Alexey Kardashevskiy wrote:
> > In some situations the userspace memory context may live longer than
> > the userspace process itself so if we need to do proper memory context
> > cleanup, we better have tce_container take a reference to mm_struct and
> > use it later when the process is gone (@current or @current->mm is NULL=
).
> >=20
> > This references mm and stores the pointer in the container; this is done
> > in a new helper - tce_iommu_mm_set() - when one of the following happen=
s:
> > - a container is enabled (IOMMU v1);
> > - a first attempt to pre-register memory is made (IOMMU v2);
> > - a DMA window is created (IOMMU v2).
> > The @mm stays referenced till the container is destroyed.
> >=20
> > This replaces current->mm with container->mm everywhere except debug
> > prints.
> >=20
> > This adds a check that current->mm is the same as the one stored in
> > the container to prevent userspace from making changes to a memory
> > context of other processes.
> >=20
> > DMA map/unmap ioctls() do not check for @mm as they already check
> > for @enabled which is set after tce_iommu_mm_set() is called.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v5:
> > * postpone referencing of mm
> >=20
> > v4:
> > * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
> > for all ioctls and removed other redundand checks
> > ---
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++------=
--------
> >  1 file changed, 99 insertions(+), 60 deletions(-)
> >=20
> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> > index 1c02498..9a81a7e 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -31,49 +31,49 @@
> >  static void tce_iommu_detach_group(void *iommu_data,
> >  		struct iommu_group *iommu_group);
> > =20
> > -static long try_increment_locked_vm(long npages)
> > +static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> >  {
> >  	long ret =3D 0, locked, lock_limit;
> > =20
> > -	if (!current || !current->mm)
> > -		return -ESRCH; /* process exited */
> > +	if (!mm)
> > +		return -EPERM;
> > =20
> >  	if (!npages)
> >  		return 0;
> > =20
> > -	down_write(&current->mm->mmap_sem);
> > -	locked =3D current->mm->locked_vm + npages;
> > +	down_write(&mm->mmap_sem);
> > +	locked =3D mm->locked_vm + npages;
> >  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>=20
>=20
>=20
> Oh boy. Now it seems I have to reference a task, not just mm (which I may
> not have to reference at all after all as the task reference should keep =
mm
> alive) as I missed the fact capable() and rlimit() are working with
> @current.

Sorry, what?  I'm not seeing how a task reference comes into this.

>=20
>=20
> Alex,
>=20
> Is there anything else I should fix before posting v6? Thanks.
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYM6+GAAoJEGw4ysog2bOSmvYQAISSM7mzggEoj6VKaTX81vq/
7cS2tcz5L/EBtGcosBpuKA+3aQReaydhaNBC8UUwU/KOKJgc84pUwbDwO0MvCZtU
qWV2tu54uzTeS3Y+aS5bKtAq/KfOD00R+7FWHC3CqjZQnPonIwZ+T0PMyIHigjed
5OqH3dkeNUfnw3CudQPpC6fXQ1dWbANGvMoxkiOIJ69SknJxay63gBedm/wi2I+1
JRpgY/Lnvr+GxeFXaJ9Nnrydu+j7n54lIeitF+U/iOVTJ5R4OGLrCDE3AHpCWMtT
w/V5c1/EUrr/GaUp35JwLbtxWKmDRDwtwXZaGKZHHangymcC6qEVj9Y/XyUc3W9a
GMVt43I6xYJbjdR0it4B/8BT2adVbRC2dF1wMmzfmXMrqKDWJ03n5kzA5jsD9zo6
L+ZgeA/bckeceKMQGrSrL8/aNS5BM8aod0XimfjQ0QzMDoJMOmo9Dz6D+pWAatSF
jeIb7GD7lwy/iPyusQd1RghkgDhPWH7X1eePrL+7PgIEdh2fJGgXqywR98ERHCem
fMqxISngWTxddeEzpn0yPugZnLIpqYBTE/PzkzQhCK+A/VCPbeioUxSr4UIjx1bT
0F851I+UlhIZ7OeHDPDjkvy8RayERPE8iv7S1nS6s9e270fwGTJNl2CQyCKgw9w3
IZ+o+fM/giG13+9pwDRi
=VDMi
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
