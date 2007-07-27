Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49311DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 19:03:09 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6R933YQ024889
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:03:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6R931WT028671
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 04:03:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 4/5 v3] Add RapidIO support to powerpc architecture.
Date: Fri, 27 Jul 2007 17:03:01 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74D156@zch01exm26.fsl.freescale.net>
In-Reply-To: <FFA9FE6D-81C8-429C-A0CD-FE356CF98C69@kernel.crashing.org>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
	<11854393763547-git-send-email-wei.zhang@freescale.com>
	<FFA9FE6D-81C8-429C-A0CD-FE356CF98C69@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> On Jul 26, 2007, at 3:42 AM, Zhang Wei wrote:
>=20
> > This patch adds the RapidIO support to the powerpc architecture.
> > Some files are moved from ppc. OF-tree and OF-device supports are =20
> > added.
> > New silicons such as MPC8548, MPC8641 with serial RapidIO =20
> > controller are
> > all supported.
> > Memory driver hardware operations are added.
> > Global mport variables are changed to master port private variables.
> > Multi master ports are supported.
> >
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > ---
> >  arch/powerpc/Kconfig          |    8 +
> >  arch/powerpc/kernel/Makefile  |    1 +
> >  arch/powerpc/kernel/rio.c     |   64 ++
> >  arch/powerpc/sysdev/Makefile  |    1 +
> >  arch/powerpc/sysdev/fsl_rio.c | 1455=20
> ++++++++++++++++++++++++++++++=20
> > +++++++++++
>=20
> how much of this moved from ppc85xx_rio.c?

>From the code size, 2/3 are moved from pcc85xx_rio.c with clean up, 1/3
are new coding.

>=20
> >  arch/powerpc/sysdev/fsl_rio.h |   20 +
> >  6 files changed, 1549 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/kernel/rio.c
> >  create mode 100644 arch/powerpc/sysdev/fsl_rio.c
> >  create mode 100644 arch/powerpc/sysdev/fsl_rio.h
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 00099ef..45f32f1 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -492,6 +492,14 @@ source "drivers/pci/Kconfig"
> >
> >  source "drivers/pcmcia/Kconfig"
> >
> > +config RAPIDIO
> > +	bool "RapidIO support" if MPC8540 || MPC8560 || MPC8641=20
> || MPC8548
> > +	help
> > +	  If you say Y here, the kernel will include drivers and
> > +	  infrastructure code to support RapidIO interconnect devices.
>=20
> why not make this depend on something like HAS_RAPIDIO and let the =20
> boards select HAS_RAPIDIO if they have it

It's more clear, We can know how many and which processors support
RapidIO. :-)

>=20
> > +
> > +source "drivers/rapidio/Kconfig"
> > +
> >  source "drivers/pci/hotplug/Kconfig"
> >
> >  endmenu
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/=20
> > Makefile
> > index 42c42ec..02d4100 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -70,6 +70,7 @@ pci64-$(CONFIG_PPC64)		+=3D=20
> pci_64.o pci_dn.o isa-=20
> > bridge.o
> >  pci32-$(CONFIG_PPC32)		:=3D pci_32.o
> >  obj-$(CONFIG_PCI)		+=3D $(pci64-y) $(pci32-y) pci-common.o
> >  obj-$(CONFIG_PCI_MSI)		+=3D msi.o
> > +obj-$(CONFIG_RAPIDIO)		+=3D rio.o
>=20
> should probably live in sysdev/rio.c

This just keep the same position of ppc arch.

Thanks!
-zw
