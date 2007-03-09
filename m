Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 30053DDEB8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 14:53:44 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l293rf0P011708
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 20:53:41 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l293rd9w025519
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 21:53:40 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
Date: Fri, 9 Mar 2007 11:53:38 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A16@zch01exm23.fsl.freescale.net>
In-Reply-To: <20303D6D-C19A-4BDB-B540-9994AC538642@kernel.crashing.org>
References: <1173300525.23776.136.camel@ld0161-tx32>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
	<20303D6D-C19A-4BDB-B540-9994AC538642@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
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

>=20
> On Mar 8, 2007, at 9:32 PM, Zang Roy-r61911 wrote:
>=20
> >> This move sets the stage for the use of generic PCI=20
> Express code in=20
> >> 85xx and 86xx parts from FSL.  Subsequent patches for
> >> 8548 and 8544 will be able to use this shared code.
> >>
> >> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >> Acked-by: Andy Fleming <afleming@freescale.com>
> >> ---
> >>  arch/powerpc/Kconfig                               |    5 +++++
> >>  arch/powerpc/platforms/86xx/Makefile               |    2 +-
> >>  arch/powerpc/sysdev/Makefile                       |    1 +
> >>  .../86xx/mpc86xx_pcie.c =3D> sysdev/fsl_pcie.c}      |    2 --
> >>  4 files changed, 7 insertions(+), 3 deletions(-)  rename=20
> >> arch/powerpc/{platforms/86xx/mpc86xx_pcie.c =3D> sysdev/fsl_pcie.c} =

> >> (100%)
> >>
> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index=20
> >> 6dfbd52..f68de20 100644
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -168,6 +168,7 @@ config PPC_86xx
> >>  	bool "Freescale 86xx"
> >>  	select 6xx
> >>  	select FSL_SOC
> >> +	select FSL_PCIE
> >>  	select PPC_FPU
> >>  	select ALTIVEC
> >>  	help
> >> @@ -1022,6 +1023,10 @@ config SBUS
> >>  config FSL_SOC
> >>  	bool
> >>
> >> +config FSL_PCIE
> >> +	bool
> >> +	depends on PPC_86xx
> >> +
> > How about 8548 with pcie?
>=20
> There isn't any in tree 85xx user of PCIe at this point.
No!
At lease my original serial patches include the pcie support for 8548.
Roy
