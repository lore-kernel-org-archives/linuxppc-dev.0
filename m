Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6FA5767A75
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 16:16:38 +1100 (EST)
In-Reply-To: <3609259af610006a1a0b7b016f727500@freescale.com>
References: <3609259af610006a1a0b7b016f727500@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <61dc898b0ce55c51093c2b1c44d65434@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 23 Feb 2005 23:16:31 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom,

Here are the only usages of PVR_<CPU> that are in arch/ppc:

boot/simple/misc-ev64260.S:     cmplwi  r25,(PVR_7450 >> 16)
platforms/ev64260.c:    if (pvr !=3D PVR_VER(PVR_7450)) {
platforms/4xx/ebony.c:          case PVR_REV(PVR_440GP_RB):
platforms/4xx/ebony.c:          case PVR_REV(PVR_440GP_RC1):
syslib/ibm440gx_common.c:       if (pvr =3D=3D PVR_440GX_RA || pvr =3D=3D=20=

PVR_440GX_RB ||
syslib/ibm440gx_common.c:           (pvr =3D=3D PVR_440GX_RC && p->cpu >=20=

667000000))

What do you think should we just get ride of all the other cases that=20
are not actually used and leave these in asm/regs.h or should we move=20
them as follows:

PVR_7450 -> into platforms/ev64260.h
PVR_440GP* -> into platforms/4xx/ebony.c (or include/asm/ibm4xx.h)
PVR_440GX* -> into syslib/ibm440gx_common.h

- kumar

On Feb 23, 2005, at 4:52 PM, Kumar Gala wrote:

>
>
> On Feb 23, 2005, at 4:25 PM, Tom Rini wrote:
>
> > On Wed, Feb 23, 2005 at 08:48:25PM +0000, James Chapman wrote:
>  >=A0 > Signed-off-by: James Chapman <jchapman@katalix.com>
> > >
>  > > Trivial patch to add 7447A and 7457 CPU defs.
>  >
>  > Why?=A0 Most of the PVR definitions here can be removed (*muttering=20=

> about
>  >=A0 85xx ones being added).
>
> Yeah, yeah, will work on removing them.
>
> - kumar
>
> _______________________________________________
> Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
