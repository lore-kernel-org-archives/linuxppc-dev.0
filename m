Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 22BF0DDEBB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:45:35 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l163jYLs017950
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 20:45:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l163jUEY003319
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:45:31 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 11:46:46 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41CE@zch01exm26.fsl.freescale.net>
In-Reply-To: <501DC278-8AC8-4874-A213-3CC729E86B8B@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, February 06, 2007 11:31 AM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>=20
>=20
> On Feb 5, 2007, at 9:15 PM, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Monday, February 05, 2007 11:04 PM
> >> To: Li Yang-r58472
> >> Cc: Paul; linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
> >>
> >>
> >> On Feb 5, 2007, at 3:09 AM, Li Yang wrote:
> >>
> >> You have no description about what this patch does and why its
> >> needed.
> >
> > Add cpu and board specific initialization code for USB to work in
both
> > MPH and DR mode for MPC8349EMDS PB board.
> >>
> >>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>> ---
> >>> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
> >>> arch/powerpc/platforms/83xx/mpc834x_sys.c |   77
+++++++++++++++++++
> >>> ++++++++++
> >>> arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 +++++++++
> >>> 3 files changed, 104 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
> >>> platforms/83xx/Kconfig
> >>> index edcd5b8..5371645 100644
> >>> --- a/arch/powerpc/platforms/83xx/Kconfig
> >>> +++ b/arch/powerpc/platforms/83xx/Kconfig
> >>> @@ -59,4 +59,8 @@ config PPC_MPC836x
> >>> 	select PPC_INDIRECT_PCI
> >>> 	default y if MPC8360E_PB
> >>> +config 834x_USB_SUPPORT
> >>> +	bool
> >>> +	default y if MPC834x_SYS && (USB || USB_GADGET)
> >>> +
> >>
> >> Do we really need to introduce a new config option?
> >
> > It will be neater to make use of the Kconfig feature than judging
all
> > the macros and module variations.  It will be a very long #if
defined
> > the other way.
>=20
> Huh, it would look like:
>=20
> #if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET).

Are you sure we don't need CONFIG_USB_MODULE and
CONFIG_USB_GADGET_MODULE any more?  At least in some early kernel
version, they are needed explicitly.

- Leo
