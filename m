Return-Path: <Dai.Haruki@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id BD269679E2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 06:24:49 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k28JXQoq000533
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 12:33:26 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id k28JOkYJ013320
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 13:24:46 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix MPC8548CDS rebooting procedure
Date: Wed, 8 Mar 2006 12:24:30 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD332ECDEA@az33exm24.fsl.freescale.net>
From: "Haruki Dai-r35557" <Dai.Haruki@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
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
> Sent: Wednesday, March 08, 2006 12:33 PM
> To: Haruki Dai-r35557
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
>=20
>=20
> On Mar 8, 2006, at 11:22 AM, Haruki Dai-r35557 wrote:
>=20
> > This patch fixes the MPC8548 CDS rebooting procedure.
> > Without this patche, issuing reboot from shell doesn't reboot the=20
> > machine.
> >
> > Signed-off-by: Dai Haruki <dai.haruki@freescale.com>
>=20
> Dai, I'm avoid taking patches for 85xx that effect new=20
> functionality.  If you want change this to work with=20
> arch/powerpc and make it a run time check for 8548.

Hi Kumar, what kind of new feature is affected by this bug fix? 8548
requires reboot to set the hardware reset bits. The mpc85xx_restart() is
not ported to arch/powerpc yet. Which portion of the arch/powerpc code
should be modified in order to restart the machine correctly?=20
And how do you want me to do run time check? Check SVR?=20

Dai=20

>=20
> - kumar
>=20
> > ---
> >
> >  arch/ppc/syslib/ppc85xx_setup.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > 8f095006923385c3546165b0e10d73d3e057c120
> > diff --git a/arch/ppc/syslib/ppc85xx_setup.c=20
> > b/arch/ppc/syslib/ppc85xx_setup.c index e4dda43..45b1b2b 100644
> > --- a/arch/ppc/syslib/ppc85xx_setup.c
> > +++ b/arch/ppc/syslib/ppc85xx_setup.c
> > @@ -115,6 +115,11 @@ mpc85xx_early_serial_map(void)  void =20
> > mpc85xx_restart(char *cmd)  {
> > +#ifdef CONFIG_MPC8548
> > +	volatile unsigned int *rstcr;
> > +	u32 *pMem =3D (u32*) ioremap((BOARD_CCSRBAR + 0xe00b0),0x100);
> > +	*pMem =3D 0x2; /* Set HRESET_REQ flag */ #endif
> >  	local_irq_disable();
> >  	abort();
> >  }
> > --
> > 1.2.4
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
