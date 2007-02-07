Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 93DB1DDF52
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 16:15:07 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l175F5YN013831
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 22:15:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l175F1Bl002339
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:15:02 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 13:16:18 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D42CE@zch01exm26.fsl.freescale.net>
In-Reply-To: <30C0E418-9671-4278-B06D-94D01A41625F@kernel.crashing.org>
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

>=20
> > endmenu
> > diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/
> > powerpc/platforms/83xx/mpc834x_sys.c
> > index 80b735a..aff7ae3 100644
> > --- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
> > +++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
> > @@ -35,14 +35,88 @@
> > #include <asm/prom.h>
> > #include <asm/udbg.h>
> > #include <sysdev/fsl_soc.h>
> > +#include <linux/fsl_devices.h>
> > #include "mpc83xx.h"
> > +#include "mpc834x_sys.h"
> > #ifndef CONFIG_PCI
> > unsigned long isa_io_base =3D 0;
> > unsigned long isa_mem_base =3D 0;
> > #endif
> > +static volatile u8 *bcsr_regs =3D NULL;
> > +
> > +#ifdef CONFIG_834x_USB_SUPPORT
> > +/* Note: This is only for PB, not for PB+PIB
> > + * On PB only port0 is connected using ULPI */
>=20
> Can you tell if we are on PIB by what type of phy is used?

No, PIB supports all PHYs including ULPI.  We only deal with PB only
case for now, as PIB is far more complex.

- Leo
