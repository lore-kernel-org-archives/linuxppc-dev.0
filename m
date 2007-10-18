Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA761DDE36
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 13:51:59 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9I3prdr000111
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 20:51:54 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9I3pqmc001475
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:51:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3 4/9] add platform support for MPC837x MDS board
Date: Thu, 18 Oct 2007 11:51:54 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5B3F@zch01exm26.fsl.freescale.net>
In-Reply-To: <F5AD4702-2832-4408-81DB-0E78B1883D76@kernel.crashing.org>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<F5AD4702-2832-4408-81DB-0E78B1883D76@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, October 17, 2007 9:47 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v3 4/9] add platform support for MPC837x MDS board
>=20
>=20
> On Oct 12, 2007, at 8:28 AM, Li Yang wrote:
>=20
> > The MPC837x MDS is a new member of Freescale MDS reference system.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/platforms/83xx/Kconfig       |   12 ++++
> >  arch/powerpc/platforms/83xx/Makefile      |    1 +
> >  arch/powerpc/platforms/83xx/mpc837x_mds.c |  103 ++++++++++++++++++
> > +++++++++++
> >  3 files changed, 116 insertions(+), 0 deletions(-)  create mode=20
> > 100644 arch/powerpc/platforms/83xx/mpc837x_mds.c
> >
> > diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/=20
> > platforms/83xx/Kconfig index ec305f1..0c61e7a 100644
> > --- a/arch/powerpc/platforms/83xx/Kconfig
> > +++ b/arch/powerpc/platforms/83xx/Kconfig
> > @@ -50,6 +50,11 @@ config MPC836x_MDS
> >  	help
> >  	  This option enables support for the MPC836x MDS=20
> Processor Board.
> >
> > +config MPC837x_MDS
> > +	bool "Freescale MPC837x MDS"
> > +	select DEFAULT_UIMAGE
> > +	help
> > +	  This option enables support for the MPC837x MDS=20
> Processor Board.
> >  endchoice
> >
> >  config PPC_MPC831x
> > @@ -75,3 +80,10 @@ config PPC_MPC836x
> >  	select PPC_UDBG_16550
> >  	select PPC_INDIRECT_PCI
> >  	default y if MPC836x_MDS
> > +
> > +config PPC_MPC837x
> > +	bool
> > +	select PPC_UDBG_16550
> > +	select PPC_INDIRECT_PCI
> > +	select FSL_SERDES
> > +	default y if MPC837x_MDS
>=20
> Do we really need this Kconfig option for anything?

The chip series can be used on other boards.  This option is a container
for CPU related selects and can be reused by other boards.

- Leo
