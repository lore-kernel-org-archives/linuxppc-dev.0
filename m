Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 26F84679E9
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 15:17:13 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k294Y7ob007729
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 21:34:07 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k294QlRT011869
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Mar 2006 22:26:48 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix MPC8548CDS rebooting procedure
Date: Wed, 8 Mar 2006 21:16:55 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD332ECE57@az33exm24.fsl.freescale.net>
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
> Sent: Wednesday, March 08, 2006 9:14 PM
> To: Haruki Dai-r35557
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
>=20
>=20
> On Mar 8, 2006, at 1:24 PM, Haruki Dai-r35557 wrote:
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Wednesday, March 08, 2006 12:33 PM
> >> To: Haruki Dai-r35557
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
> >>
> >>
> >> On Mar 8, 2006, at 11:22 AM, Haruki Dai-r35557 wrote:
> >>
> >>> This patch fixes the MPC8548 CDS rebooting procedure.
> >>> Without this patche, issuing reboot from shell doesn't reboot the=20
> >>> machine.
> >>>
> >>> Signed-off-by: Dai Haruki <dai.haruki@freescale.com>
> >>
> >> Dai, I'm avoid taking patches for 85xx that effect new=20
> functionality. =20
> >> If you want change this to work with arch/powerpc and make=20
> it a run=20
> >> time check for 8548.
> >
> > Hi Kumar, what kind of new feature is affected by this bug=20
> fix? 8548=20
> > requires reboot to set the hardware reset bits. The mpc85xx_restart
> > () is
> > not ported to arch/powerpc yet. Which portion of the=20
> arch/powerpc code=20
> > should be modified in order to restart the machine correctly?
> > And how do you want me to do run time check? Check SVR?
>=20
> Restart has never worked properly on the 85xx boards from=20
> freescale since they never provided a reasonable way to reset=20
> the systems in software.  So I consider this new=20
> functionality at this point.
>=20
> The powerpc.git tree has an=20
> arch/powerpc/platforms/85xx/misc.c that has a mpc85xx_restart() in it.

Thanks. I didn't work on the powerpc.git tree.  I will submit the patch
based on the powerpc.git tree.

>=20
> As for run time checking, yes use something like SVR or PVR=20
> to determine the feature.  In this case its probably best to=20
> using something like PVR and check for E500r1.  I imagine=20
> 8540, 8541, 8555, 8560 don't support this feature (all=20
> e500r1), but all future 8548 and newer parts will (e500r2, etc.)

OK. I will modify it as you suggest.=20

regards,
Dai.

>=20
> - kumar
>=20
