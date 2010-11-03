Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATHC v1] PPC4xx: Adding PCI(E) MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: tmarri@apm.com
In-Reply-To: <1288306514-9769-1-git-send-email-tmarri@apm.com>
References: <1288306514-9769-1-git-send-email-tmarri@apm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-2t+Q8pnW+Cmlm3067Urj"
Date: Wed, 03 Nov 2010 23:11:33 +1100
Message-ID: <1288786293.989.65.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-2t+Q8pnW+Cmlm3067Urj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-28 at 15:55 -0700, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
>=20
> This patch adds MSI support for 440SPe, 460Ex, 460Sx and 405Ex.

Hi Marri,

I don't know anything about your hardware, but I'll try and review the
other parts of your patch.

..

> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/=
40x/Kconfig
> index b721764..92aeee6 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -57,6 +57,8 @@ config KILAUEA
>  	select 405EX
>  	select PPC40x_SIMPLE
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI_MSI
> +	select 4xx_MSI
>  	help
>  	  This option enables support for the AMCC PPC405EX evaluation board.
> =20
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/=
44x/Kconfig
> index 0f979c5..3836353 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -74,6 +74,8 @@ config KATMAI
>  	select 440SPe
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI_MSI
> +	select 4xx_MSI
>  	help
>  	  This option enables support for the AMCC PPC440SPe evaluation board.
> =20
> @@ -119,6 +121,8 @@ config CANYONLANDS
>  	select 460EX
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI_MSI
> +	select 4xx_MSI
>  	select IBM_NEW_EMAC_RGMII
>  	select IBM_NEW_EMAC_ZMII
>  	help
> @@ -145,6 +149,8 @@ config REDWOOD
>  	select 460SX
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI_MSI
> +	select 4xx_MSI
>  	help
>  	  This option enables support for the AMCC PPC460SX Redwood board.
> =20
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 3965828..ec86000 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -7,6 +7,12 @@ config PPC4xx_PCI_EXPRESS
>  	depends on PCI && 4xx
>  	default n
> =20
> +config 4xx_MSI
> +	bool
> +	depends on PCI_MSI
> +	depends on PCI && 4xx

This can just be: depends on PCI_MSI && 4xx

Because PCI_MSI depends on PCI.

You only ever enable this via select, which ignores dependencies, but
it's probably still good to have the depends as documentation.

> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 0bef9da..30f4da4 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_XILINX_PCI)	+=3D xilinx_pci.o
>  obj-$(CONFIG_OF_RTC)		+=3D of_rtc.o
>  ifeq ($(CONFIG_PCI),y)
>  obj-$(CONFIG_4xx)		+=3D ppc4xx_pci.o
> +obj-$(CONFIG_4xx_MSI)		+=3D ppc4xx_msi.o

This needn't be inside the if PCI block, that's the whole point of
CONFIG_4xx_MSI. And you should send another patch to add a
CONFIG_4xx_PCI symbol and use that to build ppc4xx_pci.o in the same
way.

> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4x=
x_msi.c
> new file mode 100644
> index 0000000..9d5e0c9
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> @@ -0,0 +1,251 @@
> +/*
> + * Adding PCI-E MSI support for PPC4XX SoCs.
> + *
> + * Copyright (c) 2010, Applied Micro Circuits Corporation
> + * Authors: 	Tirumala R Marri <tmarri@apm.com>
> + * 		Feng Kan <fkan@apm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */

Blank line usually here.

> +#include <linux/irq.h>
> +#include <linux/bootmem.h>
> +#include <linux/pci.h>
> +#include <linux/msi.h>
> +#include <linux/of_platform.h>
> +#include <linux/interrupt.h>
> +#include <asm/prom.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +#include <boot/dcr.h>

Using headers in boot is "interesting".

> +#include <asm/msi_bitmap.h>

You don't use this, but maybe you should.

> +#define PEIH_TERMADH    0x00
> +#define PEIH_TERMADL    0x08
> +#define PEIH_MSIED      0x10
> +#define PEIH_MSIMK      0x18
> +#define PEIH_MSIASS     0x20
> +#define PEIH_FLUSH0     0x30
> +#define PEIH_FLUSH1     0x38
> +#define PEIH_CNTRST     0x48
> +
> +#define  UPPER_4BITS_OF36BIT 32
> +#define  LOWER_32BITS_OF36BIT 0xFFFFFFFF

These are badly named IMHO, it's not really clear that the first is a
shift and the second is a mask. I'd just get rid of them, everyone will
know what the code is doing.

> +struct ppc4xx_msi {
> +	u32 msi_addr_lo;
> +	u32 msi_addr_hi;
> +	void __iomem *msi_regs;
> +	u32 feature;
             ^
Unused AFAICS.

> +};
> +
> +static struct ppc4xx_msi *ppc4xx_msi;
> +struct ppc4xx_msi_feature {
> +	u32 ppc4xx_pic_ip;
> +	u32 msiir_offset;
> +};
> +
> +static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type=
)
> +{
> +	struct msi_desc *entry;
> +	unsigned int virq =3D 0;

Don't need =3D 0.

> +	struct msi_msg msg;
> +	struct ppc4xx_msi *msi_data =3D ppc4xx_msi;

Just use the global.

> +	static int int_no =3D 0;	/* To remember last used interrupt */

This is a worry. There is nothing AFAIK to stop two drivers (eg. network
& scsi) calling into here at the same time, which could lead to
corrupting int_no. If you just want a global counter you need a lock.

But, AFAICS this is broken anyway. You never free the interrupt numbers,
so you're going to run out. Some of your device tree entries only have 3
(!!), so ifup/ifdown x 3 will exhaust the supply, won't it?

I realise I never replied to your mail the other week about the bitmap
code, so perhaps it's my fault :)

> +	struct device_node *msi_dev =3D NULL;
> +	const u32 *count;
> +
> +	msi_dev =3D of_find_node_by_name(NULL, "ppc4xx-msi");
> +	if (msi_dev)
> +		return -ENODEV;
> +
>+
> +	count =3D of_get_property(msi_dev, "interrupt-count", NULL);
> +	if (!count) {
> +		dev_err(&dev->dev, "no interrupts property found \n");
> +		return -ENODEV;
> +	}

You should grab this at probe time and store it in ppc4xx_msi to save
yourself parsing it over and over.

> +	if (int_no > *count)
> +		return -EINVAL;
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		virq =3D irq_of_parse_and_map(msi_dev, int_no);
> +		printk("virq =3D 0x%x\n", virq);

Either turn into a pr_debug() or remove.

> +		if (virq =3D=3D NO_IRQ) {
> +			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
> +			return -EINVAL;
> +		} else
> +			set_irq_data(virq, (void *)int_no);

Needn't be in the else block given the code flow. And why do you do
this?

> +		dev_dbg(&dev->dev, "%s: virq =3D %d \n", __func__, virq);
> +
> +		/* Setup msi address space */
> +		msg.address_hi =3D msi_data->msi_addr_hi;
> +		msg.address_lo =3D msi_data->msi_addr_lo;
> +
> +		set_irq_msi(virq, entry);
> +		msg.data =3D int_no;
> +		int_no++;
> +		write_msi_msg(virq, &msg);
> +	}
> +
> +	return 0;
> +}
> +
> +void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *entry;
> +
> +	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		if (entry->irq =3D=3D NO_IRQ)
> +			continue;
> +		set_irq_msi(entry->irq, NULL);
> +		irq_dispose_mapping(entry->irq);

No free of int_no?!

> +	}
> +
> +	return;
> +}
> +
> +static int ppc4xx_msi_check_device(struct pci_dev *pdev, int nvec, int t=
ype)
> +{
> +	dev_dbg(&pdev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
> +		__func__, nvec, type);

No constraints at all? What about MSI-X ?

> +	return 0;
> +}
> +
> +static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> +				 struct resource res, struct ppc4xx_msi *msi)
> +{
> +	const u32 *msi_data;
> +	const u32 *msi_mask;
> +	const u32 *sdr_addr;
> +	int rc =3D 0;
> +	dma_addr_t msi_phys;
> +	void *msi_virt;
> +
> +	sdr_addr =3D of_get_property(dev->dev.of_node, "sdr-base", NULL);
> +	if (!sdr_addr)
> +		return -1;
> +
> +	SDR0_WRITE(sdr_addr, (u64)res.start >> UPPER_4BITS_OF36BIT);	/*HIGH add=
r */
> +	SDR0_WRITE(sdr_addr + 1, res.start & LOWER_32BITS_OF36BIT);	/* Low addr=
 */
> +
> +	msi->msi_regs =3D ioremap((u64) res.start, res.end - res.start + 1);

You should be able to just use of_iomap() here.

> +	if (!msi->msi_regs) {
> +		dev_err(&dev->dev, "ioremap problem failed\n");
> +		return ENOMEM;
> +	}
> +	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
> +		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
> +
> +	msi_virt =3D dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
> +	msi->msi_addr_hi =3D 0x0;
> +	msi->msi_addr_lo =3D (u32) msi_phys;
> +	dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x \n", msi->msi_addr_lo);

So your MSI is a write to just some arbitrary address?

> +	/* Progam the Interrupt handler Termination addr registers */
> +	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
> +	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);

And the hardware detects it by catching writes to that address? But the
write still lands?

> +	msi_data =3D of_get_property(dev->dev.of_node, "msi-data", NULL);
> +	if (!msi_data) {
> +		rc =3D -1;
> +		goto error_out;
> +	}

Never used?

> +	msi_mask =3D of_get_property(dev->dev.of_node, "msi-mask", NULL);
> +	if (!msi_mask) {
> +		rc =3D -1;
> +		goto error_out;
> +	}
> +
> +	/* Program MSI Expected data and Mask bits */
> +	out_be32(msi->msi_regs + PEIH_MSIED, 0);
> +	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
> +
> +	return 0;
> +      error_out:

Goto label should start in column 0.

> +	iounmap(msi->msi_regs);

You don't cleanup/undo any of the rest though? Ideally you'd structure
the routine so that you don't touch the hardware until you know you
can't fail.

> +	return rc;
> +}
> +static int __devinit ppc4xx_msi_probe(struct platform_device *dev,
> +				      const struct of_device_id *match)
> +{
> +	struct ppc4xx_msi *msi;
> +	struct resource res;
> +	int err =3D 0;
> +
> +	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
> +
> +	msi =3D kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
> +	if (!msi) {
> +		dev_err(&dev->dev, "No memory for MSI structure\n");
> +		err =3D -ENOMEM;
> +		goto error_out;
> +	}
> +	/* Get MSI ranges */
> +	err =3D of_address_to_resource(dev->dev.of_node, 0, &res);
> +	if (err) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +			dev->dev.of_node->full_name);
> +		goto error_out;
> +	}

Just use of_iomap().

> +	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
> +		goto error_out;
> +
> +	ppc4xx_msi =3D msi;

You know there's only ever one in a system?

> +	WARN_ON(ppc_md.setup_msi_irqs);
> +	ppc_md.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;
> +	ppc_md.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;
> +	ppc_md.msi_check_device =3D ppc4xx_msi_check_device;

Don't bother setting check if yours does nothing.

> +	return 0;
> +
> +      error_out:
> +	kfree(msi);
> +	return err;
> +}

Blank line.

> +static const struct ppc4xx_msi_feature ppc4xx_msi_feature =3D {
> +	.ppc4xx_pic_ip =3D 0,
> +	.msiir_offset =3D 0x140,
> +};

This looks to be unused?

> +static const struct of_device_id ppc4xx_msi_ids[] =3D {
> +	{
> +	 .compatible =3D "amcc,ppc4xx-msi",
> +	 .data =3D (void *)&ppc4xx_msi_feature,

I know it's "used" here, but I don't see where you use that.

> +	 },
> +	{}
> +};
> +
> +static struct of_platform_driver ppc4xx_msi_driver =3D {
> +	.driver =3D {
> +		   .name =3D "ppc4xx-msi",
> +		   .owner =3D THIS_MODULE,
> +		   .of_match_table =3D ppc4xx_msi_ids,
> +		   },
> +	.probe =3D ppc4xx_msi_probe,
> +};
> +
> +static __init int ppc4xx_msi_init(void)
> +{
> +	return of_register_platform_driver(&ppc4xx_msi_driver);
> +}
> +
> +subsys_initcall(ppc4xx_msi_init);



--=-2t+Q8pnW+Cmlm3067Urj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzRUXMACgkQdSjSd0sB4dJwhgCfVYAqn99CetfKhf+9YnBeN2Sy
psgAn0dxAiiKvSDS6ahiiV3Qnz0OrZD9
=rS2A
-----END PGP SIGNATURE-----

--=-2t+Q8pnW+Cmlm3067Urj--
