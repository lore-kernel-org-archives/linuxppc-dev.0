Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 87664DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:14:12 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l163EAie011156
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 20:14:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l163E8dp026147
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:14:09 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 11:15:24 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41BC@zch01exm26.fsl.freescale.net>
In-Reply-To: <BC5F5DDA-2714-49DE-A197-52C3BD600831@kernel.crashing.org>
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
> Sent: Monday, February 05, 2007 11:04 PM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>=20
>=20
> On Feb 5, 2007, at 3:09 AM, Li Yang wrote:
>=20
> You have no description about what this patch does and why its needed.

Add cpu and board specific initialization code for USB to work in both
MPH and DR mode for MPC8349EMDS PB board.
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/platforms/83xx/Kconfig       |    4 ++
> > arch/powerpc/platforms/83xx/mpc834x_sys.c |   77 +++++++++++++++++++
> > ++++++++++
> > arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 +++++++++
> > 3 files changed, 104 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
> > platforms/83xx/Kconfig
> > index edcd5b8..5371645 100644
> > --- a/arch/powerpc/platforms/83xx/Kconfig
> > +++ b/arch/powerpc/platforms/83xx/Kconfig
> > @@ -59,4 +59,8 @@ config PPC_MPC836x
> > 	select PPC_INDIRECT_PCI
> > 	default y if MPC8360E_PB
> > +config 834x_USB_SUPPORT
> > +	bool
> > +	default y if MPC834x_SYS && (USB || USB_GADGET)
> > +
>=20
> Do we really need to introduce a new config option?

It will be neater to make use of the Kconfig feature than judging all
the macros and module variations.  It will be a very long #if defined
the other way.

> > @@ -65,6 +120,7 @@ static void __init mpc834x_sys_setup_arch(void)
> > 			loops_per_jiffy =3D 50000000 / HZ;
> > 		of_node_put(np);
> > 	}
> > +
> > #ifdef CONFIG_PCI
> > 	for (np =3D NULL; (np =3D of_find_node_by_type(np, "pci")) !=3D =
NULL;)
> > 		add_bridge(np);
> > @@ -72,6 +128,27 @@ static void __init mpc834x_sys_setup_arch(void)
> > 	ppc_md.pci_exclude_device =3D mpc83xx_exclude_device;
> > #endif
> > +#ifdef CONFIG_834x_USB_SUPPORT
> > +	mpc834x_usb_cfg();
> > +
> > +	/* Map BCSR area */
> > +	np =3D of_find_node_by_name(NULL, "bcsr");
> > +	if (np !=3D 0) {
> > +		struct resource res;
> > +
> > +		of_address_to_resource(np, 0, &res);
> > +		bcsr_regs =3D ioremap(res.start, res.end - res.start + 1);
> > +		of_node_put(np);
> > +	}
> > +
> > +	/*
> > +	 * if SYS board is plug into PIB board,
> > +	 * force to use the PHY on SYS board
> > +	 * */
> > +	if ((bcsr_regs !=3D NULL) && !(bcsr_regs[5] & BCSR5_INT_USB))
> > +		bcsr_regs[5] |=3D BCSR5_INT_USB;
>=20
> why not fold all this into mpc834x_usb_cfg() since its all board
> related config code?

Well, not quite.  The code in mpc834x_usb_cfg() is 834x CPU specific
initialization.  The bcsr is board specific.

- Leo
