Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3EF6367B89
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 16:32:29 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6K7o6p4028792
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 01:50:06 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k6K6WL5I012104
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 01:32:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add USB to MPC8349 PB platform support
Date: Thu, 20 Jul 2006 14:32:43 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0705AE@zch01exm20.fsl.freescale.net>
In-Reply-To: <C3A460A5-612C-4B0D-9DDA-EB1AE3FEF6EB@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Kumar
> Gala
> Sent: Thursday, July 20, 2006 4:09 AM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org; linux-usb-devel@lists.sourceforge.net
> Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
>=20
>=20
> On Jul 14, 2006, at 6:52 AM, Li Yang wrote:
>=20
> > This adds USB platform support to MPC8349 PB.  It works with the
> > fsl_usb2_udc driver.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >
> > arch/powerpc/platforms/83xx/Kconfig       |   4  ++
> > arch/powerpc/platforms/83xx/mpc834x_sys.c |   72 +++++++++++++++++++
> > ++++++++++
> > arch/powerpc/platforms/83xx/mpc834x_sys.h |   24 ++++++++++
> > 3 files changed, 113 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
> > platforms/83xx/Kconfig
> > index 7675e67..8404cdf 100644
> > --- a/arch/powerpc/platforms/83xx/Kconfig
> > +++ b/arch/powerpc/platforms/83xx/Kconfig
> > @@ -24,4 +31,14 @@ config MPC834x
> > 	select PPC_INDIRECT_PCI
> > 	default y if MPC834x_SYS
> >
> > +config 834x_USB_SUPPORT
> > +	bool
> > +	default y if MPC834x_SYS && (USB || USB_GADGET)
> > +
> > endmenu
>=20
> I dont think we need this, we should be able to use the USB, and 834x
> CONFIG options in the code.
>=20
> > diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/
> > powerpc/platforms/83xx/mpc834x_sys.c
> > index 7e789d2..f10d4ae 100644
> > --- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
> > +++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
> > @@ -36,6 +36,7 @@ #include <asm/irq.h>
> > #include <asm/prom.h>
> > #include <asm/udbg.h>
> > #include <sysdev/fsl_soc.h>
> > +#include <linux/fsl_devices.h>
> > #include "mpc83xx.h"
> > @@ -71,6 +72,72 @@ mpc83xx_map_irq(struct pci_dev *dev, uns
> > }
> > #endif				/* CONFIG_PCI */
> > +#ifdef CONFIG_834x_USB_SUPPORT
>=20
> Just make it dependent on CONFIG_USB_EHCI_HCD or something like that.

Will need to check EHCI_HCD/GADGET and their _MODULE variations though.
Not very neat I think.  Anyway, it's your call.
>=20
> > +void mpc834x_usb_board_cfg(void)
> > +{
> > +	unsigned char __iomem *bcsr;
> > +	volatile unsigned char *bcsr5_p;
> > +
> > +	/*
> > +	 * if SYS board is plug into PIB board,
> > +	 * force to use the PHY on SYS board
> > +	 * */
> > +	bcsr =3D ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
> > +	bcsr5_p =3D bcsr + BCSR5_OFF;
> > +	if ( (*bcsr5_p & BCSR5_INT_USB) =3D=3D 0 )
> > +		*bcsr5_p =3D (*bcsr5_p | BCSR5_INT_USB);
> > +	iounmap(bcsr);
> > +}
> > +
> > +/* Note: This is only for PB, not for PB+PIB
> > + * On PB only port0 is connected using ULPI */
> > +static int mpc834x_usb_cfg(void)
> > +{
> > +	unsigned long sccr, sicrl;
> > +	volatile unsigned long *p;
> > +	unsigned long __iomem *immap;
> > +	struct device_node *np =3D NULL;
> > +	int port0_is_dr =3D 0;
> > +
> > +	if ((np =3D of_find_compatible_node(np, "usb", "fsl-usb2-dr")) =
!=3D
> > NULL)
> > +		port0_is_dr =3D 1;
> > +	if ((np =3D of_find_compatible_node(np, "usb", "fsl-usb2-mph")) =
!=3D
> > NULL){
> > +		if (port0_is_dr) {
> > +			printk(KERN_WARNING
> > +				"There is only one USB port on PB board!
\n");
> > +			return -1;
> > +		} else if (!port0_is_dr)
> > +			/* No usb port enabled */
> > +			return -1;
> > +	}
> > +
> > +	immap =3D ioremap(get_immrbase(), 0x100000);
> > +
> > +	/* Configure clock */
> > +	p =3D (volatile unsigned long *)((u32)immap + MPC83XX_SCCR_OFFS);
> > +	sccr =3D *p;
> > +	if (port0_is_dr)
> > +		sccr |=3D MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
> > +	else
> > +		sccr |=3D MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
> > +	*p =3D sccr;
>=20
> This really needs to take into account the platform frequency.  I
> guess technically, at 1:3 we will always be below the max 133Mhz.

Generally, I assume the user is using a core frequency around the
recommended frequency in spec.  In some special cases, they do need to
use a lower core frequency.  But, I think it's too special to be
addressed here.  Anyway it's easy to change for users.
>=20
> > +
> > +	/* Configure Pin */
> > +	p =3D (volatile unsigned long *)((u32)immap + MPC83XX_SICRL_OFFS);
> > +	sicrl =3D *p;
> > +	/* set port0 only */
> > +	if (port0_is_dr) +		sicrl |=3D MPC83XX_SICRL_USB0;
> > +	else +		sicrl &=3D ~(MPC83XX_SICRL_USB0);
> > +	*p =3D sicrl;
> > +
>=20
> Why dont we just do all this in fsl_usb_of_init

It's easier to do in fsl_usb_of_init.  But do you think it's ok to put
834x specific code there?
>=20
> > +	iounmap(immap);
> > +	return 0;
> > +}
> > +
> > +#endif /* CONFIG_834x_USB_SUPPORT */
> > +
> > /*
> >
**********************************************************************
> > **
> >  *
> >  * Setup the architecture
> > @@ -102,6 +169,11 @@ #ifdef CONFIG_PCI
> > 	ppc_md.pci_exclude_device =3D mpc83xx_exclude_device;
> > #endif
> > +#ifdef CONFIG_834x_USB_SUPPORT
> > +	mpc834x_usb_cfg();
> > +	mpc834x_usb_board_cfg();
> > +#endif
> > +
> > #ifdef  CONFIG_ROOT_NFS
> > 	ROOT_DEV =3D Root_NFS;
> > #else
> > diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/
> > powerpc/platforms/83xx/mpc834x_sys.h
> > index fedecb7..30e45e8 100644
> > --- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
> > +++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
> > @@ -20,4 +20,28 @@ #define PIRQB	MPC83xx_IRQ_EXT5
> > #define PIRQC	MPC83xx_IRQ_EXT6
> > #define PIRQD	MPC83xx_IRQ_EXT7
> > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > +#define BCSR_SIZE		((uint)(32 * 1024))
> > + +#define BCSR5_OFF		0x05
> > +#define BCSR5_INT_USB		0x02
> > +
> > +#define MPC83XX_SCCR_OFFS          0xA08
> > +#define MPC83XX_SCCR_USB_MPHCM_11  0x00c00000
> > +#define MPC83XX_SCCR_USB_MPHCM_01  0x00400000
> > +#define MPC83XX_SCCR_USB_MPHCM_10  0x00800000
> > +#define MPC83XX_SCCR_USB_DRCM_11   0x00300000
> > +#define MPC83XX_SCCR_USB_DRCM_01   0x00100000
> > +#define MPC83XX_SCCR_USB_DRCM_10   0x00200000
> > +
> > +/* system i/o configuration register low */
> > +#define MPC83XX_SICRL_OFFS         0x114
> > +#define MPC83XX_SICRL_USB0         0x40000000
> > +#define MPC83XX_SICRL_USB1         0x20000000
> > +
> > +/* system i/o configuration register high */
> > +#define MPC83XX_SICRH_OFFS         0x118
> > +#define MPC83XX_SICRH_USB_UTMI     0x00020000
>=20
> Are these really generic to all MPC83XX?  We should move these to
> include something like asm-ppc/mpc83xx.h

No, probably need to change the naming to MPC834x_*.  The offsets are
generic, but the USB bits are not.  If there is an asm/mpc834x.h, it
will be better there.
>=20
> > +
> > +
> > #endif				/* __MACH_MPC83XX_SYS_H__ */
>=20
> - kumar
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
