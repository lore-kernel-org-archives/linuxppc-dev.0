Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 07DBCDDDD5
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 06:39:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Sun, 29 Jul 2007 16:06:21 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
In-Reply-To: <20070726222225.GB10427@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707291606.21612.arnd@arndb.de>
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 27 July 2007, Dave Jiang wrote:
> +static struct of_device_id mpc85xx_pci_err_of_match[] =3D {
> +       {
> +        .type =3D "pci",
> +        .compatible =3D "fsl,mpc8540-pci",
> +        },
> +       {},
> +};
> +
> +static struct of_platform_driver mpc85xx_pci_err_driver =3D {
> +       .owner =3D THIS_MODULE,
> +       .name =3D "mpc85xx_pci_err",
> +       .match_table =3D mpc85xx_pci_err_of_match,
> +       .probe =3D mpc85xx_pci_err_probe,
> +       .remove =3D mpc85xx_pci_err_remove,
> +       .driver =3D {
> +                  .name =3D "mpc85xx_pci_err",
> +                  .owner =3D THIS_MODULE,
> +                  },
> +};

This is  a little problematic, if we want to make the PCI bus implementation
use the PCI code from arch/powerpc/kernel/of_platform.c in the future.
Right now this is not possible, because that code is still 64-bit only,
but that may change in the future. Since only one driver can bind
to the pci host bridge device, the mpc85xx_pci_err driver would conflict
with the PCI driver itself, which you probably don't intend.

I'd suggest either to integrate EDAC into the 85xx specific PCI code,
or to have an extra device in the device tree for this.

> +=A0=A0=A0=A0=A0=A0=A0res =3D of_register_platform_driver(&mpc85xx_mc_err=
_driver) ? : res;
> +
> +=A0=A0=A0=A0=A0=A0=A0res =3D of_register_platform_driver(&mpc85xx_l2_err=
_driver) ? : res;
> +
> +#ifdef CONFIG_PCI
> +=A0=A0=A0=A0=A0=A0=A0res =3D of_register_platform_driver(&mpc85xx_pci_er=
r_driver) ? : res;
> +#endif
> +
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * need to clear HID1[RFXE] to disable machine chec=
k int
> +=A0=A0=A0=A0=A0=A0=A0 * so we can catch it
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0if (edac_op_state =3D=3D EDAC_OPSTATE_INT) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0orig_hid1 =3D mfspr(SPRN_HI=
D1);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mtspr(SPRN_HID1, (orig_hid1=
 & ~0x20000));
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0return res;
> +}

The error handling could use some improvement here. In particular, you shou=
ld
unregister the buses in the failure path, maybe you need to clean up other
parts as well.

	Arnd <><
