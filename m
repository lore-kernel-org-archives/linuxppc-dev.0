Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1196394519.29683.8.camel@Guyver>
References: <1196394519.29683.8.camel@Guyver>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CLouIl4T9m1LIEHiRQzd"
Date: Mon, 03 Dec 2007 15:02:01 +1100
Message-Id: <1196654521.13554.32.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CLouIl4T9m1LIEHiRQzd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi r64360,

A few comments below :)

On Fri, 2007-11-30 at 11:48 +0800, Li Li wrote:
> The IPIC MSI is introduced on MPC837x chip.
> Implements the IPIC MSI as two level interrupt controller.
>=20
> Signed-off-by: Tony Li <tony.li@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_mds.dts     |   14 ++
>  arch/powerpc/boot/dts/mpc8378_mds.dts     |   14 ++
>  arch/powerpc/boot/dts/mpc8379_mds.dts     |   14 ++
>  arch/powerpc/platforms/83xx/Kconfig       |    6 +
>  arch/powerpc/platforms/83xx/mpc837x_mds.c |   11 +
>  arch/powerpc/sysdev/Makefile              |    1 +
>  arch/powerpc/sysdev/ipic_msi.c            |  359 +++++++++++++++++++++++=
++++++
>  include/asm-powerpc/ipic_msi.h            |   54 +++++
>  8 files changed, 473 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/ipic_msi.c
>  create mode 100644 include/asm-powerpc/ipic_msi.h
>=20
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dt=
s/mpc8377_mds.dts
> index 1f7819e..1068fe2 100644
> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -210,6 +210,20 @@
>  			#interrupt-cells =3D <2>;
>  			reg =3D <700 100>;
>  		};
> +
> +		ipic-msi@7c0 {
> +			compatible =3D "fsl,ipic-msi";
> +			reg =3D <7c0 40>;
> +			interrupts =3D < 43 8
> +				       4  8
> +				       51 8
> +				       52 8
> +				       56 8
> +				       57 8
> +				       58 8
> +				       59 8 >;
> +			interrupt-parent =3D < &ipic >;
> +		};
>  	};
> =20
>  	pci@e0008500 {
> diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dt=
s/mpc8378_mds.dts
> index 1503ae3..f12658f 100644
> --- a/arch/powerpc/boot/dts/mpc8378_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
> @@ -192,6 +192,20 @@
>  			#interrupt-cells =3D <2>;
>  			reg =3D <700 100>;
>  		};
> +
> +		ipic-msi@7c0 {
> +			compatible =3D "fsl,ipic-msi";
> +			reg =3D <7c0 40>;
> +			interrupts =3D < 43 8
> +				       4  8
> +				       51 8
> +				       52 8
> +				       56 8
> +				       57 8
> +				       58 8
> +				       59 8 >;
> +			interrupt-parent =3D < &ipic >;
> +		};
>  	};
> =20
>  	pci@e0008500 {
> diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dt=
s/mpc8379_mds.dts
> index cdb4426..9fe4bd2 100644
> --- a/arch/powerpc/boot/dts/mpc8379_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
> @@ -236,6 +236,20 @@
>  			#interrupt-cells =3D <2>;
>  			reg =3D <700 100>;
>  		};
> +
> +		ipic-msi@7c0 {
> +			compatible =3D "fsl,ipic-msi";
> +			reg =3D <7c0 40>;
> +			interrupts =3D < 43 8
> +				       4  8
> +				       51 8
> +				       52 8
> +				       56 8
> +				       57 8
> +				       58 8
> +				       59 8 >;
> +			interrupt-parent =3D < &ipic >;
> +		};
>  	};
> =20
>  	pci@e0008500 {
> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms=
/83xx/Kconfig
> index 00154c5..4c51f78 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -88,6 +88,12 @@ config PPC_MPC837x
>  	select FSL_SERDES
>  	default y if MPC837x_MDS
> =20
> +config IPIC_MSI
> +	bool
> +	depends on PCI_MSI
> +	default y if PPC_MPC837x
> +	default n
> +
>  config PPC_MPC83XX_PCIE
>  	bool "MPC837X PCI Express support"
>  	depends on PCIEPORTBUS && PPC_MPC837x
> diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/pla=
tforms/83xx/mpc837x_mds.c
> index 6048f1b..dbea34b 100644
> --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> @@ -17,6 +17,9 @@
> =20
>  #include <asm/time.h>
>  #include <asm/ipic.h>
> +#if CONFIG_IPIC_MSI
> +#include <asm/ipic_msi.h>
> +#endif
>  #include <asm/udbg.h>
>  #include <asm/prom.h>

I'd rather you just include it unconditionally.

> @@ -84,6 +87,14 @@ static void __init mpc837x_mds_init_IRQ(void)
>  	 * in case the boot rom changed something on us.
>  	 */
>  	ipic_set_default_priority();
> +
> +#if CONFIG_IPIC_MSI
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,ipic-msi");
> +	if (!np)
> +		return;
> +
> +	ipic_msi_init(np, ipic_msi_cascade);
> +#endif

If you have a no-op version of ipic_msi_init() in your header file then
you can remove the #ifdef in the C code - which I think is nicer.

Why do you pass the handler into the init routine, rather than have the
init routine just set the handler. Then you could make the handler
static.

>  }
> =20
>  /*
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 99a77d7..5946b6a 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -25,6 +25,7 @@ ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_PPC_INDIRECT_PCI)	+=3D indirect_pci.o
>  obj-$(CONFIG_PPC_I8259)		+=3D i8259.o
>  obj-$(CONFIG_PPC_83xx)		+=3D ipic.o
> +obj-$(CONFIG_IPIC_MSI)		+=3D ipic_msi.o
>  obj-$(CONFIG_4xx)		+=3D uic.o
>  obj-$(CONFIG_XILINX_VIRTEX)	+=3D xilinx_intc.o
>  endif
> diff --git a/arch/powerpc/sysdev/ipic_msi.c b/arch/powerpc/sysdev/ipic_ms=
i.c
> new file mode 100644
> index 0000000..57758f7
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ipic_msi.c
> @@ -0,0 +1,359 @@
> +/*
> + * arch/powerpc/sysdev/ipic_msi.c
> + *
> + * IPIC MSI routines implementations.
> + *
> + * Auther: Tony Li <tony.li@freescale.com>
> + *
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +
> +#include <linux/pci.h>
> +#include <linux/msi.h>
> +#include <linux/irq.h>
> +
> +#include <asm/ipic_msi.h>
> +
> +#define MSIR0	0x43
> +#define MSIR1	0x4
> +#define MSIR2	0x51
> +#define MSIR3	0x52
> +#define MSIR4	0x56
> +#define MSIR5	0x57
> +#define MSIR6	0x58
> +#define MSIR7	0x59
> +
> +
> +static struct ipic_msi *ipic_msi;
> +static DEFINE_SPINLOCK(ipic_msi_lock);
> +static DEFINE_SPINLOCK(ipic_msi_bitmap_lock);
> +
> +static inline u32 ipic_msi_read(volatile u32 __iomem *base, unsigned int=
 reg)
> +{
> +	return in_be32(base + (reg >> 2));
> +}
> +
> +static inline void ipic_msi_write(volatile u32 __iomem *base,
> +					unsigned int reg, u32 value)
> +{
> +	out_be32(base + (reg >> 2), value);
> +}
> +
> +static struct ipic_msi * ipic_msi_from_irq(unsigned int virq)
> +{
> +	return ipic_msi;
> +}
> +
> +#define	ipic_msi_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)

What's wrong with virq_to_hw() ?


> +static void ipic_msi_unmask(unsigned int virq)
> +{
> +	struct ipic_msi *msi =3D ipic_msi_from_irq(virq);
> +	unsigned int src =3D ipic_msi_irq_to_hw(virq);
> +	unsigned long flags;
> +	u32 temp;
> +
> +	spin_lock_irqsave(&ipic_msi_lock, flags);
> +	temp =3D ipic_msi_read(msi->regs, IPIC_MSIMR);
> +	ipic_msi_write(msi->regs, IPIC_MSIMR,
> +		temp & ~(1 << (src / msi->int_per_msir)));
> +
> +	spin_unlock_irqrestore(&ipic_msi_lock, flags);
> +}
> +
> +static void ipic_msi_mask(unsigned int virq)
> +{
> +	struct ipic_msi *msi =3D ipic_msi_from_irq(virq);
> +	unsigned int src =3D ipic_msi_irq_to_hw(virq);
> +	unsigned long flags;
> +	u32 temp;
> +
> +	spin_lock_irqsave(&ipic_msi_lock, flags);
> +
> +	temp =3D ipic_msi_read(msi->regs, IPIC_MSIMR);
> +	ipic_msi_write(msi->regs, IPIC_MSIMR,
> +		temp | (1 << (src / msi->int_per_msir)));
> +
> +	spin_unlock_irqrestore(&ipic_msi_lock, flags);
> +}
> +/*
> + * We do not need this actually. The MSIR register has been read once
> + * in ipic_msi_get_irq. So, this MSI interrupt has been acked
> + */
> +static void ipic_msi_ack(unsigned int virq)
> +{
> +	struct ipic_msi *msi =3D ipic_msi_from_irq(virq);
> +	unsigned int src =3D ipic_msi_irq_to_hw(virq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipic_msi_lock, flags);
> +
> +	ipic_msi_read(msi->regs, IPIC_MSIR0 + (4 * (src / msi->int_per_msir)));
> +
> +	spin_unlock_irqrestore(&ipic_msi_lock,flags);
> +}
> +
> +static struct irq_chip ipic_msi_chip =3D {
> +	.typename =3D " IPIC MSI ",
> +	.unmask =3D ipic_msi_unmask,
> +	.mask =3D ipic_msi_mask,
> +	.ack =3D ipic_msi_ack,
> +};
> +
> +static int ipic_msi_host_map(struct irq_host *h, unsigned int virq,
> +				irq_hw_number_t hw)
> +{
> +	struct ipic_msi *msi =3D h->host_data;
> +	struct irq_chip *chip =3D msi->hc_irq;
> +
> +	set_irq_chip_data(virq, msi);
> +	get_irq_desc(virq)->status |=3D IRQ_TYPE_EDGE_FALLING;
> +
> +	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
> +	return 0;
> +}
> +
> +static struct irq_host_ops ipic_msi_host_ops =3D {
> +	.map =3D ipic_msi_host_map,
> +};
> +
> +irq_hw_number_t ipic_msi_alloc_hwirqs(struct ipic_msi *msi, int num)
> +{
> +	unsigned long flags;
> +	int offset, order =3D get_count_order(num);
> +
> +	spin_lock_irqsave(&ipic_msi_bitmap_lock, flags);
> +
> +	offset =3D bitmap_find_free_region(msi->ipic_msi_bitmap,
> +			msi->nr_msir * msi->int_per_msir, order);
> +
> +	spin_unlock_irqrestore(&ipic_msi_bitmap_lock, flags);
> +
> +	pr_debug("%s: allocated 0x%x (2^%d) at offset 0x%x\n",
> +		__FUNCTION__, num, order, offset);
> +
> +	return offset;
> +}
> +
> +void ipic_msi_free_hwirqs(struct ipic_msi *msi, int offset, int num)
> +{
> +	unsigned long flags;
> +	int order =3D get_count_order(num);
> +
> +	pr_debug("%s: freeing 0x%x (2^%d) at offset 0x%x\n",
> +		__FUNCTION__, num, order, offset);
> +
> +	spin_lock_irqsave(&ipic_msi_bitmap_lock, flags);
> +	bitmap_release_region(msi->ipic_msi_bitmap, offset, order);
> +	spin_unlock_irqrestore(&ipic_msi_bitmap_lock, flags);
> +}
> +
> +static int ipic_msi_init_allocator(struct ipic_msi *msi)
> +{
> +	int size;
> +
> +	size =3D BITS_TO_LONGS(msi->nr_msir * msi->int_per_msir) * sizeof(long)=
;
> +	msi->ipic_msi_bitmap =3D alloc_maybe_bootmem(size, GFP_KERNEL);
> +
> +	if (msi->ipic_msi_bitmap =3D=3D NULL) {
> +		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
> +				__FUNCTION__);
> +		return -ENOMEM;
> +	}
> +	memset(msi->ipic_msi_bitmap, 0, size);
> +
> +	return 0;
> +}

The last three routines are almost identical to the mpic_msi.c ones, if
in future we have a third implementation that looks almost identical
maybe we should consolidate them.

> +
> +static void ipic_msi_compose_msg(struct ipic_msi *msi, int hwirq,
> +						struct msi_msg *msg)
> +{
> +	unsigned int srs;
> +	unsigned int ibs;
> +
> +	srs =3D hwirq / msi->int_per_msir;
> +	ibs =3D hwirq - srs * msi->int_per_msir;
> +
> +	msg->address_lo =3D msi->msi_addr_lo;
> +	msg->address_hi =3D msi->msi_addr_hi;
> +	msg->data =3D (srs << 5) | (ibs & 0x1F);
> +
> +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> +		__FUNCTION__, srs, ibs);
> +
> +}
> +
> +static int ipic_msi_setup_irqs(struct pci_dev *pdev, int nvec, int type)
> +{
> +	struct ipic_msi *msi =3D ipic_msi;
> +	irq_hw_number_t hwirq;
> +	unsigned int virq;
> +	struct msi_desc *entry;
> +	struct msi_msg msg;
> +
> +	list_for_each_entry(entry, &pdev->msi_list, list) {
> +		hwirq =3D ipic_msi_alloc_hwirqs(msi, 1);
> +		if (hwirq < 0) {
> +			pr_debug("%s: fail allocating msi interrupt\n",
> +					__FUNCTION__);
> +			return hwirq;
> +		}
> +
> +		/* This hwirq belongs to the irq_host other than irq_host of IPIC
> + 		 * So, it is independent to hwirq of IPIC */
> +		virq =3D irq_create_mapping(msi->irqhost, hwirq);
> +		if (virq =3D=3D NO_IRQ) {
> +			pr_debug("%s: fail mapping hwirq 0x%lx\n",
> +					__FUNCTION__, hwirq);
> +			ipic_msi_free_hwirqs(msi, hwirq, 1);
> +			return -ENOSPC;
> +		}
> +		set_irq_msi(virq, entry);
> +		ipic_msi_compose_msg(msi, hwirq, &msg);
> +		write_msi_msg(virq, &msg);
> +
> +		hwirq++;

                  ^^^^ this looks like my bug

> +	}
> +
> +	return 0;
> +}
> +
> +static void ipic_msi_teardown_irqs(struct pci_dev *pdev)
> +{
> +	struct msi_desc *entry;
> +	struct ipic_msi *msi =3D ipic_msi;
> +
> +	list_for_each_entry(entry, &pdev->msi_list, list) {
> +		if (entry->irq =3D=3D NO_IRQ)
> +			continue;
> +		set_irq_msi(entry->irq, NULL);
> +		ipic_msi_free_hwirqs(msi, virq_to_hw(entry->irq), 1);
> +		irq_dispose_mapping(entry->irq);
> +	}
> +
> +	return;
> +}
> +
> +void __init ipic_msi_init(struct device_node *node,
> +			void (*handler)(unsigned int irq, struct irq_desc *desc))
> +{
> +	struct ipic_msi *msi;
> +	struct resource res;
> +	int i;
> +	int rc =3D 0;
> +
> +	msi =3D alloc_maybe_bootmem(sizeof(*msi), GFP_KERNEL);
> +	if (msi =3D=3D NULL)
> +		return;
> +
> +	memset(msi, 0, sizeof(*msi));
> +
> +
> +	msi->irqhost =3D irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
> +					NR_MSIR, &ipic_msi_host_ops, 0);
> +	if (msi->irqhost =3D=3D NULL) {
> +		of_node_put(node);
> +		goto out;
> +	}
> +
> +	rc =3D of_address_to_resource(node, 0, &res);
> +	if (rc) {
> +		of_node_put(node);
> +		goto out;
> +	}
> +
> +	msi->regs =3D ioremap(res.start, res.end - res.start + 1);
> +	msi->irqhost->host_data =3D msi;
> +	msi->hc_irq =3D &ipic_msi_chip;
> +
> +	msi->msi_addr_lo =3D 0xE00007F8;
> +	msi->msi_addr_hi =3D 0;
> +	msi->nr_msir =3D ARRAY_SIZE(msi->msir);
> +	msi->int_per_msir =3D 32;
> +	for (i =3D 0; i < msi->nr_msir; i++) {
> +		unsigned int virt_msir =3D irq_of_parse_and_map(node, i);
> +		if (virt_msir !=3D NO_IRQ) {
> +			set_irq_data(virt_msir, msi);
> +			set_irq_chained_handler(virt_msir, handler);
> +			msi->msir[i] =3D virt_msir;
> +		} else
> +			msi->msir[i] =3D NO_IRQ;
> +	}
> +
> +	rc =3D ipic_msi_init_allocator(msi);
> +	if (rc)
		< missing of_node_put() ? >
> +		goto out;
> +
> +	ipic_msi =3D msi;
> +
> +	WARN_ON(ppc_md.setup_msi_irqs);
> +	ppc_md.setup_msi_irqs =3D ipic_msi_setup_irqs;
> +	ppc_md.teardown_msi_irqs =3D ipic_msi_teardown_irqs;
> +
	  return ?

> +out:
> +	if (mem_init_done)
> +		kfree(msi);
> +
> +	return;
> +}
> +
> +static int ipic_msi_get_irq(struct ipic_msi *msi, int virt_msir)
> +{
> +	int msir =3D -1;
> +	unsigned int temp;
> +	unsigned int offset;
> +	int i;
> +
> +	for (i =3D 0; i < msi->nr_msir; i++)
> +		if (virt_msir =3D=3D msi->msir[i]) {
> +			msir =3D i;
> +			break;
> +		}
> +
> +	if (i >=3D msi->nr_msir)
> +		return NO_IRQ;
> +
> +	temp =3D ipic_msi_read(msi->regs, IPIC_MSIR0 + (i * 4));
> +	offset =3D ffs(temp) - 1;
> +
> +	return irq_linear_revmap(msi->irqhost, (msir * msi->int_per_msir + offs=
et));
> +}
> +
> +void ipic_msi_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct ipic_msi *msi;
> +	unsigned int cascade_irq;
> +
> +	spin_lock(&desc->lock);
> +	if (desc->chip->mask_ack)
> +		desc->chip->mask_ack(irq);
> +	else {
> +		desc->chip->mask(irq);
> +		desc->chip->ack(irq);
> +	}
> +
> +	if (unlikely(desc->status & IRQ_INPROGRESS))
> +		goto unlock;
> +
> +	desc->status |=3D IRQ_INPROGRESS;
> +	msi =3D desc->handler_data;
> +	cascade_irq =3D ipic_msi_get_irq(msi, irq);
> +
> +	spin_unlock(&desc->lock);
> +
> +	if (cascade_irq !=3D NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +
> +	spin_lock(&desc->lock);
> +	desc->status &=3D ~IRQ_INPROGRESS;
> +	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> +		desc->chip->unmask(irq);
> +
> +unlock:
> +	spin_unlock(&desc->lock);
> +}

I don't know your hardware, but this looks a bit weird. Doesn't the
upstream handler do most of this logic for you?


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CLouIl4T9m1LIEHiRQzd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHU3+5dSjSd0sB4dIRAmRlAJ9HvG9lO3NYOJJwXV5GUxvuWasygACgjjSe
atx891Nuh9hQ+wZ4entfTkk=
=j6gF
-----END PGP SIGNATURE-----

--=-CLouIl4T9m1LIEHiRQzd--
