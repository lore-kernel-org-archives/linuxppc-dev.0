Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A248A1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 14:18:59 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E5D1414031D
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 14:18:58 +1000 (AEST)
Received: by pdrh1 with SMTP id h1so60810918pdr.0
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 21:18:56 -0700 (PDT)
Message-ID: <1439266598.24419.21.camel@axtens.net>
Subject: Re: [PATCH v2 02/10] cxl: Allocate and release the SPA with the AFU
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Tue, 11 Aug 2015 14:16:38 +1000
In-Reply-To: <20150811134254.0358f0e3@camb691>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-3-git-send-email-dja@axtens.net>
 <20150811134254.0358f0e3@camb691>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-LYDIp2HneOwL8CrHONXY"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-LYDIp2HneOwL8CrHONXY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-08-11 at 13:42 +1000, Cyril Bur wrote:
> On Tue, 28 Jul 2015 15:28:35 +1000
> Daniel Axtens <dja@axtens.net> wrote:
>=20
> > Previously the SPA was allocated and freed upon entering and leaving
> > AFU-directed mode. This causes some issues for error recovery - context=
s
> > hold a pointer inside the SPA, and they may persist after the AFU has
> > been detached.
> >=20
> > We would ideally like to allocate the SPA when the AFU is allocated, an=
d
> > release it until the AFU is released. However, we don't know how big th=
e
> > SPA needs to be until we read the AFU descriptor.
> >=20
> > Therefore, restructure the code:
> >=20
> >  - Allocate the SPA only once, on the first attach.
> >=20
> >  - Release the SPA only when the entire AFU is being released (not
> >    detached). Guard the release with a NULL check, so we don't free
> >    if it was never allocated (e.g. dedicated mode)
> >=20
>=20
> I'm sure you tested this :), looks fine to me, from an outsiders perspect=
ive
> code appears to do what the commit message says.
>=20
> Just one super minor question, you do the NULL check in the caller. How o=
bvious
> is the error if/when a caller forgets?
>=20
Good point. The SPA is only released when releasing the entire AFU, so
it doesn't really matter at this point, but in case we ever move around
the assignment/release of the SPA (dynamic reprogramming comes to mind)
I've moved the check and added an explicit NULLing of the SPA pointer.

> Acked-by: Cyril Bur <cyrilbur@gmail.com>
>=20
Thanks!
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  drivers/misc/cxl/cxl.h    |  3 +++
> >  drivers/misc/cxl/native.c | 28 ++++++++++++++++++----------
> >  drivers/misc/cxl/pci.c    |  3 +++
> >  3 files changed, 24 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> > index 47eadbcfd379..88a88c445e2a 100644
> > --- a/drivers/misc/cxl/cxl.h
> > +++ b/drivers/misc/cxl/cxl.h
> > @@ -603,6 +603,9 @@ void unregister_cxl_calls(struct cxl_calls *calls);
> >  int cxl_alloc_adapter_nr(struct cxl *adapter);
> >  void cxl_remove_adapter_nr(struct cxl *adapter);
> > =20
> > +int cxl_alloc_spa(struct cxl_afu *afu);
> > +void cxl_release_spa(struct cxl_afu *afu);
> > +
> >  int cxl_file_init(void);
> >  void cxl_file_exit(void);
> >  int cxl_register_adapter(struct cxl *adapter);
> > diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> > index 16948915eb0d..debd97147b58 100644
> > --- a/drivers/misc/cxl/native.c
> > +++ b/drivers/misc/cxl/native.c
> > @@ -182,10 +182,8 @@ static int spa_max_procs(int spa_size)
> >  	return ((spa_size / 8) - 96) / 17;
> >  }
> > =20
> > -static int alloc_spa(struct cxl_afu *afu)
> > +int cxl_alloc_spa(struct cxl_afu *afu)
> >  {
> > -	u64 spap;
> > -
> >  	/* Work out how many pages to allocate */
> >  	afu->spa_order =3D 0;
> >  	do {
> > @@ -204,6 +202,13 @@ static int alloc_spa(struct cxl_afu *afu)
> >  	pr_devel("spa pages: %i afu->spa_max_procs: %i   afu->num_procs: %i\n=
",
> >  		 1<<afu->spa_order, afu->spa_max_procs, afu->num_procs);
> > =20
> > +	return 0;
> > +}
> > +
> > +static void attach_spa(struct cxl_afu *afu)
> > +{
> > +	u64 spap;
> > +
> >  	afu->sw_command_status =3D (__be64 *)((char *)afu->spa +
> >  					    ((afu->spa_max_procs + 3) * 128));
> > =20
> > @@ -212,13 +217,15 @@ static int alloc_spa(struct cxl_afu *afu)
> >  	spap |=3D CXL_PSL_SPAP_V;
> >  	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_s=
tatus: 0x%p CXL_PSL_SPAP_An=3D0x%016llx\n", afu->spa, afu->spa_max_procs, a=
fu->sw_command_status, spap);
> >  	cxl_p1n_write(afu, CXL_PSL_SPAP_An, spap);
> > -
> > -	return 0;
> >  }
> > =20
> > -static void release_spa(struct cxl_afu *afu)
> > +static inline void detach_spa(struct cxl_afu *afu)
> >  {
> >  	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0);
> > +}
> > +
> > +void cxl_release_spa(struct cxl_afu *afu)
> > +{
> >  	free_pages((unsigned long) afu->spa, afu->spa_order);
> >  }
> > =20
> > @@ -446,8 +453,11 @@ static int activate_afu_directed(struct cxl_afu *a=
fu)
> > =20
> >  	dev_info(&afu->dev, "Activating AFU directed mode\n");
> > =20
> > -	if (alloc_spa(afu))
> > -		return -ENOMEM;
> > +	if (afu->spa =3D=3D NULL) {
> > +		if (cxl_alloc_spa(afu))
> > +			return -ENOMEM;
> > +	}
> > +	attach_spa(afu);
> > =20
> >  	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_AFU);
> >  	cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
> > @@ -560,8 +570,6 @@ static int deactivate_afu_directed(struct cxl_afu *=
afu)
> >  	cxl_afu_disable(afu);
> >  	cxl_psl_purge(afu);
> > =20
> > -	release_spa(afu);
> > -
> >  	return 0;
> >  }
> > =20
> > diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> > index 32ad09705949..1849c1785b49 100644
> > --- a/drivers/misc/cxl/pci.c
> > +++ b/drivers/misc/cxl/pci.c
> > @@ -551,6 +551,9 @@ static void cxl_release_afu(struct device *dev)
> > =20
> >  	pr_devel("cxl_release_afu\n");
> > =20
> > +	if (afu->spa)
> > +		cxl_release_spa(afu);
> > +
> >  	kfree(afu);
> >  }
> > =20
>=20

--=20
Regards,
Daniel

--=-LYDIp2HneOwL8CrHONXY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIbBAABCgAGBQJVyXcnAAoJEPC3R3P2I92FFg4P+LfV97N9OKhtNK4xcSsJpD//
TR+hmQQiHF4LNi9eQzCqZUgw78S4KJfBxAYTvofJOM8RSoQU1YImzUCu1UM9D7gx
pT4D8R6x998vrj2BsxObQIoRim3Fr7/31eE97aEr8PjvoYWHkyhlMbZF6sw+VIGN
A3+xrD5CxshdBS2TbdAJxHL1PjK6Fl5Rm5iiIekZOFx/rkil9PgQ+Ygkg8OphowT
wGZhOpbjjdkRNAcnWifR5HQ73gjpsMgmh5E4lbRcpOlO/LvZiFr1+awiILBXCCfo
Ejsdpo6Q4BWVymBwzRh69LShgqyLChrtQsiGnIRLDgiAiFgn0f9rWbELsfXozVQG
mhh941zwdmKWHXL1B9GwTeEM/QRJUSR/Z8CKUNPbVDyAPEd482P8iaLwd6Hfkjab
pgc5EhMxxy/iW1G18SDPCKHD3tixxw+BF20vjfXbWI3Ripxcg9XPYhmNHftEK6VC
Kw1Vzb6VwrpyrnAg4TGXGpgU6DUEGbmKwCtYqP09wWo/1P9epOAZQBHMUqE1Y6E7
+Fdol1uFkWgPJ+QcXG+sM84LFTev56EsD6Y3HO3viZh7CDJL4+eoKZ6gDSLwxD0S
2iwQQCYJtj4Vyt5m7hWQCnlh0gujf+CzZhp8Pg9X6xOIKxXijmciYX9FvwPYoDdk
ejcXANvk26s1sdpUqmM=
=PlE1
-----END PGP SIGNATURE-----

--=-LYDIp2HneOwL8CrHONXY--
