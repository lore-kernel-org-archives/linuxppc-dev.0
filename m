Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 23898DE0E0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:53:07 +1100 (EST)
Date: Wed, 10 Jan 2007 23:50:51 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] Fix kernel build errors for mpc8272ads
	and mpc8560ads
Message-ID: <20070110235051.256b5794@localhost.localdomain>
In-Reply-To: <628EF2F5-2700-4CB9-B1E4-3DB225232AE1@kernel.crashing.org>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<20070110011200.20342.5712.stgit@localhost.localdomain>
	<628EF2F5-2700-4CB9-B1E4-3DB225232AE1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_BnOP51E+pKAz.gkJuol2M3L;
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

--Sig_BnOP51E+pKAz.gkJuol2M3L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 11:11:05 -0600
Kumar Gala wrote:

>=20
> On Jan 9, 2007, at 7:12 PM, Vitaly Bordug wrote:
>=20
> >
> > Recent update of asm-powerpc/io.h caused cpm-related stuff to
> > break in the
> > current kernel. Current patch fixes it, and includes other
> > overhaul and
> > improvements (incomplete list is below). Required for proper =20
> > functioning of
> > the 8xx stuff as well.
> >
> > - Updated dts with a chosen node with interrupt controller,
> > - fixed messed device IDs among CPM2 SoC devices,
> > - corrected odd header name and fixed type in defines,
> > - Added 82xx subdir to the powerpc/platforms Makefile, new
> >   solely-powerpc header for 8260 family (was using one from arch/=20
> > ppc, this
> >   one cleaned up from the extra stuff).
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
> >
> >  arch/powerpc/platforms/82xx/mpc82xx.c     |    2 +-
> >  arch/powerpc/platforms/82xx/mpc82xx_ads.c |    2 +-
> >  arch/powerpc/platforms/82xx/pq2ads.h      |    5 +++--
> >  arch/powerpc/platforms/Makefile           |    1 +
> >  drivers/net/fs_enet/fs_enet.h             |    1 +
> >  drivers/serial/cpm_uart/cpm_uart_cpm1.h   |    3 ---
> >  drivers/serial/cpm_uart/cpm_uart_cpm2.h   |    3 ---
> >  include/asm-powerpc/fs_pd.h               |    6 ++++++
> >  include/asm-powerpc/io.h                  |    6 ++++++
> >  9 files changed, 19 insertions(+), 10 deletions(-)
>=20
> > diff --git a/include/asm-powerpc/fs_pd.h
> > b/include/asm-powerpc/fs_pd.h index 3d0e819..2ba51b9 100644
> > --- a/include/asm-powerpc/fs_pd.h
> > +++ b/include/asm-powerpc/fs_pd.h
> > @@ -25,6 +25,12 @@ static inline int uart_clock(void)
> >          return ppc_proc_freq;
> >  }
> >
> > +#if defined(CONFIG_8260)
> > +#include <asm/mpc8260.h>
> > +#elif defined(CONFIG_85xx)
> > +#include <asm/mpc85xx.h>
> > +#endif
> > +
>=20
> what do we need these includes for?
>=20

This is to keep ppc stuff still working mostly. Basically, whole this
header is for such aim.
To be specific, both fs_enet and cpm_uart will bail the compilation out
failing to find CPM_MAP_ADDR:

drivers/net/fs_enet/fs_enet-main.c:1144: error: 'CPM_MAP_ADDR'
undeclared (first use in this function)

and so forth.
> >  #define
> > cpm2_map(member)						\
> > ({
> > \ u32 offset =3D offsetof(cpm2_map_t, member);
> > \
>=20
> - k

--Sig_BnOP51E+pKAz.gkJuol2M3L
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpVGsuOg9JvQhSEsRArMwAJ9bQ/G6r0k+rFMIpeIPRdi8/Jem5gCcDacA
2OZRvkpMW35WeOxR8LFjTg8=
=pS+e
-----END PGP SIGNATURE-----

--Sig_BnOP51E+pKAz.gkJuol2M3L--
