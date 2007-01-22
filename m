Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5099CDDF06
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 01:05:48 +1100 (EST)
Date: Mon, 22 Jan 2007 16:55:43 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] [POWERPC] cpm_uart: OF-related fix for arch/powerpc
Message-ID: <20070122165543.3be448b7@localhost.localdomain>
In-Reply-To: <17844.35747.788753.2804@cargo.ozlabs.ibm.com>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<20070113004207.1224.82053.stgit@localhost.localdomain>
	<17844.35747.788753.2804@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_XnC07ahrNQOSoTsGa73DDq1;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_XnC07ahrNQOSoTsGa73DDq1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2007 21:02:11 +1100
Paul Mackerras wrote:

> Vitaly Bordug writes:
>=20
> >  		mem_addr =3D (u8 *)
> > cpm_dpram_addr(cpm_dpalloc(memsz, 8)); +#ifdef  CONFIG_PPC_MERGE
> > +		dma_addr =3D (u32)cpm_dpram_phys(mem_addr);
> > +#else
> >  		dma_addr =3D (u32)mem_addr;
> > +#endif
>=20
> Please define a cpm_dpram_phys() function in include/asm-ppc/fs_pd.h
> rather than having ifdefs in code.  And please also try to avoid
> unnecessary casts.
>=20
> Actually, I notice that cpm_dpram_phys doesn't currently appear
> anywhere in the kernel tree, and your patch sequence doesn't create
> it.  So how come this change won't cause a compile error?
>=20

Well, CONFIG_PPC_MERGE && CPM1 is always false as of now  - it will play wi=
th 8xx series that are forthcoming. So that it=20
won't lead to a hardly-detected confusion, I did it here, though now I thin=
k  better option will be to move this particular hunk to 8xx series.

--
Thanks, Vitaly

--Sig_XnC07ahrNQOSoTsGa73DDq1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtMJguOg9JvQhSEsRAqZ2AJ0RDUmkB1kVTAVqzB6q0zz/ZmIbGwCcCZyX
ETF1fL+hUB29/IpNyZIWn2c=
=IZvF
-----END PGP SIGNATURE-----

--Sig_XnC07ahrNQOSoTsGa73DDq1--
