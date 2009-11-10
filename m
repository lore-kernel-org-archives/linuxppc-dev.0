Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 9B950B6EDF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:55:18 +1100 (EST)
Date: Tue, 10 Nov 2009 21:26:17 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	(from grant.likely@secretlab.ca on Tue Nov 10 20:59:22 2009)
Message-Id: <1257884778.14374.5@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-81ycxAhqMXOMnZPelWux"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-81ycxAhqMXOMnZPelWux
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant:

Am 10.11.09 20:59 schrieb(en) Grant Likely:
> On Tue, Nov 10, 2009 at 12:43 PM, Albrecht Dre=DF <albrecht.dress@arcor.d=
e> wrote:
> > Use the MPC5200 GPT api for the WDT which drastically simplifies this f=
ile.
> >
> > Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> > ---
> >
> > =A0drivers/watchdog/mpc5200_wdt.c | =A0246 +++++++++++-----------------=
------------
> > =A01 files changed, 65 insertions(+), 181 deletions(-)
>=20
>=20
> Can the WDT functionality just be merged entirely into
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c, eliminating the need for
> this file entirely?  I think I'd rather have all the GPT "built in"
> behaviour handled by a single driver.

I also thought about it, as it has IMHO the cleaner code, and it would have=
 the extra benefit that the gpt-wdt api doesn't need to be public.

However, the reasons I hesitated to do so are:
- I don't want to remove a file someone else wrote (even it doesn't work);
- WDT code is shifted from drivers/watchdog to arch/powerpc/platforms/52xx =
which might not be the "logical" place from the directory layout's pov;
- a file living in arch/powerpc/platforms/52xx depends upon config options =
set from drivers/watchdog/Kconfig which may be confusing.

You see these are more political/cosmetical questions, so I would prefer to=
 leave the decision to the maintainers (i.e. you and Wim).  Preparing a ful=
ly merged driver is actually a matter of minutes!

Thanks,
Albrecht.

--=-81ycxAhqMXOMnZPelWux
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBK+cxqn/9unNAn/9ERAh3hAJ9eY3bJ7UukLvDlPOAk/qg9efPeswCgkc/H
sNcK29CrszMC7TgEmv13lRs=
=Z2ji
-----END PGP SIGNATURE-----

--=-81ycxAhqMXOMnZPelWux--
