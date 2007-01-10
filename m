Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1D930DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 08:43:25 +1100 (EST)
Date: Thu, 11 Jan 2007 00:41:36 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] Fix kernel build errors for mpc8272ads
	and mpc8560ads
Message-ID: <20070111004136.4e058899@localhost.localdomain>
In-Reply-To: <7F484F5C-4814-4721-90A8-F8D98DF10823@kernel.crashing.org>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<20070110011200.20342.5712.stgit@localhost.localdomain>
	<628EF2F5-2700-4CB9-B1E4-3DB225232AE1@kernel.crashing.org>
	<20070110235051.256b5794@localhost.localdomain>
	<7F484F5C-4814-4721-90A8-F8D98DF10823@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_+2g3v=loM5M2LHKo2O0zMA2";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_+2g3v=loM5M2LHKo2O0zMA2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 14:58:31 -0600
Kumar Gala wrote:

>=20
> On Jan 10, 2007, at 2:50 PM, Vitaly Bordug wrote:
>=20
> > On Wed, 10 Jan 2007 11:11:05 -0600
> > Kumar Gala wrote:
> >
[snip]
> >>> b/include/asm-powerpc/fs_pd.h index 3d0e819..2ba51b9 100644
> >>> --- a/include/asm-powerpc/fs_pd.h
> >>> +++ b/include/asm-powerpc/fs_pd.h
> >>> @@ -25,6 +25,12 @@ static inline int uart_clock(void)
> >>>          return ppc_proc_freq;
> >>>  }
> >>>
> >>> +#if defined(CONFIG_8260)
> >>> +#include <asm/mpc8260.h>
> >>> +#elif defined(CONFIG_85xx)
> >>> +#include <asm/mpc85xx.h>
> >>> +#endif
> >>> +
> >>
> >> what do we need these includes for?
> >>
> >
> > This is to keep ppc stuff still working mostly. Basically, whole
> > this header is for such aim.
> > To be specific, both fs_enet and cpm_uart will bail the
> > compilation out
> > failing to find CPM_MAP_ADDR:
> >
> > drivers/net/fs_enet/fs_enet-main.c:1144: error: 'CPM_MAP_ADDR'
> > undeclared (first use in this function)
> >
> > and so forth.
>=20
> How about wrapping it a ifndef CONFIG_PPC_MERGE so we know its just =20
> for that and can get ride of it in the future.
>=20

I afraid it will make arch/ppc unhappy - these got included to both.
And the headers required because there used to be same asm/io.h where this =
stuff used to reside, and from=20
the recent time, arch/powerpc has separate io.h that made all the CPM2-rela=
ted kinda hosed.

As a good thing, this header is only for the time we'll have to have same t=
arget working both in ppc and powerpc.
I think this can be revisited after the patch about cleaning-up CPM_MAP_ADD=
R from the drivers and core code.

> >>>  #define
> >>> cpm2_map(member)						\
> >>> ({
> >>> \ u32 offset =3D offsetof(cpm2_map_t, member);
> >>> \
> >>
> >> - k
>=20

--Sig_+2g3v=loM5M2LHKo2O0zMA2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpV2SuOg9JvQhSEsRAqujAKCju9FBeYNpU87FkKFscfVgrLa0lwCfcQoa
8gzxotTMVBSqQcucXCqsHZY=
=Ss3P
-----END PGP SIGNATURE-----

--Sig_+2g3v=loM5M2LHKo2O0zMA2--
