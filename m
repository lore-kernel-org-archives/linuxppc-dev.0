Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 428691007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:40:51 +1100 (EST)
Received: by ywh17 with SMTP id 17so4650487ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:40:49 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:40:28 -0700
Message-ID: <fa686aa40911221540j3b2308bbse446b5b523fcfc98@mail.gmail.com>
Subject: Re: [RFC PATCH 16/19] powerpc: wii: hollywood interrupt controller
	support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add support for the dual interrupt controller included in the "Hollywood"
> chipset of the Nintendo Wii video game console.
> This interrupt controller serves both the Broadway processor (as a cascad=
e)
> and the Starlet processor, and is used to manage interrupts for the
> non-classic hardware.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

On brief glance...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/platforms/embedded6xx/Kconfig =A0 =A0| =A0 =A05 +
> =A0arch/powerpc/platforms/embedded6xx/Makefile =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.c | =A0238 +++++++++++++++=
++++++++++
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.h | =A0 22 +++
> =A04 files changed, 266 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/pl=
atforms/embedded6xx/Kconfig
> index efb2ea1..490f89e 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -122,3 +122,8 @@ config GAMECUBE
> =A0 =A0 =A0 =A0 =A0Select GAMECUBE if configuring for the Nintendo GameCu=
be.
> =A0 =A0 =A0 =A0 =A0More information at: <http://gc-linux.sourceforge.net/=
>
>
> +config HLWD_PIC
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on STARLET_MINI
> + =A0 =A0 =A0 default y
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/p=
latforms/embedded6xx/Makefile
> index b0324ed..c1dcc54 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_PPC_C2K) =A0 =A0 =A0 =A0 +=3D c2k.o
> =A0obj-$(CONFIG_USBGECKO_UDBG) =A0 =A0+=3D usbgecko_udbg.o
> =A0obj-$(CONFIG_FLIPPER_PIC) =A0 =A0 =A0+=3D flipper-pic.o
> =A0obj-$(CONFIG_GAMECUBE) =A0 =A0 =A0 =A0 +=3D gamecube.o gamecube_dev.o
> +obj-$(CONFIG_HLWD_PIC) =A0 =A0 =A0 =A0 +=3D hlwd-pic.o
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc=
/platforms/embedded6xx/hlwd-pic.c
> new file mode 100644
> index 0000000..b024800
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> @@ -0,0 +1,238 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> + *
> + * Nintendo Wii "Hollywood" interrupt controller support.
> + * Copyright (C) 2009 The GameCube Linux Team
> + * Copyright (C) 2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +#define DRV_MODULE_NAME "hlwd-pic"
> +#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <asm/io.h>
> +
> +#include "hlwd-pic.h"
> +
> +#define HLWD_NR_IRQS =A0 32
> +
> +/*
> + * Each interrupt has a corresponding bit in both
> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
> + *
> + * Enabling/disabling an interrupt line involves asserting/clearing
> + * the corresponding bit in IMR. ACK'ing a request simply involves
> + * asserting the corresponding bit in ICR.
> + */
> +#define HW_BROADWAY_ICR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> +#define HW_BROADWAY_IMR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
> +
> +
> +/*
> + * IRQ chip hooks.
> + *
> + */
> +
> +static void hlwd_pic_mask_and_ack(unsigned int virq)
> +{
> + =A0 =A0 =A0 int irq =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void __iomem *io_base =3D get_irq_chip_data(virq);
> +
> + =A0 =A0 =A0 clear_bit(irq, io_base + HW_BROADWAY_IMR);
> + =A0 =A0 =A0 set_bit(irq, io_base + HW_BROADWAY_ICR);
> +}
> +
> +static void hlwd_pic_ack(unsigned int virq)
> +{
> + =A0 =A0 =A0 int irq =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void __iomem *io_base =3D get_irq_chip_data(virq);
> +
> + =A0 =A0 =A0 set_bit(irq, io_base + HW_BROADWAY_ICR);
> +}
> +
> +static void hlwd_pic_mask(unsigned int virq)
> +{
> + =A0 =A0 =A0 int irq =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void __iomem *io_base =3D get_irq_chip_data(virq);
> +
> + =A0 =A0 =A0 clear_bit(irq, io_base + HW_BROADWAY_IMR);
> +}
> +
> +static void hlwd_pic_unmask(unsigned int virq)
> +{
> + =A0 =A0 =A0 int irq =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void __iomem *io_base =3D get_irq_chip_data(virq);
> +
> + =A0 =A0 =A0 set_bit(irq, io_base + HW_BROADWAY_IMR);
> +}
> +
> +
> +static struct irq_chip hlwd_pic =3D {
> + =A0 =A0 =A0 .typename =A0 =A0 =A0 =3D "hlwd-pic",
> + =A0 =A0 =A0 .ack =A0 =A0 =A0 =A0 =A0 =A0=3D hlwd_pic_ack,
> + =A0 =A0 =A0 .mask_ack =A0 =A0 =A0 =3D hlwd_pic_mask_and_ack,
> + =A0 =A0 =A0 .mask =A0 =A0 =A0 =A0 =A0 =3D hlwd_pic_mask,
> + =A0 =A0 =A0 .unmask =A0 =A0 =A0 =A0 =3D hlwd_pic_unmask,
> +};
> +
> +/*
> + * IRQ host hooks.
> + *
> + */
> +
> +static struct irq_host *hlwd_irq_host;
> +
> +static int hlwd_pic_map(struct irq_host *h, unsigned int virq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hwir=
q)
> +{
> + =A0 =A0 =A0 set_irq_chip_data(virq, h->host_data);
> + =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 set_irq_chip_and_handler(virq, &hlwd_pic, handle_level_irq)=
;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void hlwd_pic_unmap(struct irq_host *h, unsigned int irq)
> +{
> + =A0 =A0 =A0 set_irq_chip_data(irq, NULL);
> + =A0 =A0 =A0 set_irq_chip(irq, NULL);
> +}
> +
> +static struct irq_host_ops hlwd_irq_host_ops =3D {
> + =A0 =A0 =A0 .map =3D hlwd_pic_map,
> + =A0 =A0 =A0 .unmap =3D hlwd_pic_unmap,
> +};
> +
> +static unsigned int __hlwd_pic_get_irq(struct irq_host *h)
> +{
> + =A0 =A0 =A0 void __iomem *io_base =3D h->host_data;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 u32 irq_status;
> +
> + =A0 =A0 =A0 irq_status =3D in_be32(io_base + HW_BROADWAY_ICR) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_be32(io_base + HW_BROADWAY_IM=
R);
> + =A0 =A0 =A0 if (irq_status =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ_IGNORE; =A0 /* no more IRQs p=
ending */
> +
> + =A0 =A0 =A0 __asm__ __volatile__("cntlzw %0,%1" : "=3Dr"(irq) : "r"(irq=
_status));
> + =A0 =A0 =A0 return irq_linear_revmap(h, 31 - irq);
> +}
> +
> +static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct irq_desc *desc)
> +{
> + =A0 =A0 =A0 struct irq_host *irq_host =3D get_irq_data(cascade_virq);
> + =A0 =A0 =A0 unsigned int virq;
> +
> + =A0 =A0 =A0 spin_lock(&desc->lock);
> + =A0 =A0 =A0 desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
> + =A0 =A0 =A0 spin_unlock(&desc->lock);
> +
> + =A0 =A0 =A0 virq =3D __hlwd_pic_get_irq(irq_host);
> + =A0 =A0 =A0 if (virq !=3D NO_IRQ_IGNORE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(virq);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("spurious interrupt!\n");
> +
> + =A0 =A0 =A0 spin_lock(&desc->lock);
> + =A0 =A0 =A0 desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
> + =A0 =A0 =A0 if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->chip->unmask(cascade_virq);
> + =A0 =A0 =A0 spin_unlock(&desc->lock);
> +}
> +
> +/*
> + * Platform hooks.
> + *
> + */
> +
> +static void __hlwd_quiesce(void __iomem *io_base)
> +{
> + =A0 =A0 =A0 /* mask and ack all IRQs */
> + =A0 =A0 =A0 out_be32(io_base + HW_BROADWAY_IMR, 0);
> + =A0 =A0 =A0 out_be32(io_base + HW_BROADWAY_ICR, ~0);
> +}
> +
> +struct irq_host *hlwd_pic_init(struct device_node *np)
> +{
> + =A0 =A0 =A0 struct irq_host *irq_host;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 void __iomem *io_base;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 retval =3D of_address_to_resource(np, 0, &res);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("no io memory range found\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 io_base =3D ioremap(res.start, resource_size(&res));
> + =A0 =A0 =A0 if (!io_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("ioremap failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_info("controller at 0x%08x mapped to 0x%p\n", res.start,=
 io_base);
> +
> + =A0 =A0 =A0 __hlwd_quiesce(io_base);
> +
> + =A0 =A0 =A0 irq_host =3D irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, HLWD_N=
R_IRQS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hlwd_i=
rq_host_ops, NO_IRQ_IGNORE);
> + =A0 =A0 =A0 if (!irq_host) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to allocate irq_host\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 irq_host->host_data =3D io_base;
> +
> + =A0 =A0 =A0 return irq_host;
> +}
> +
> +unsigned int hlwd_pic_get_irq(void)
> +{
> + =A0 =A0 =A0 return __hlwd_pic_get_irq(hlwd_irq_host);
> +}
> +
> +/*
> + * Probe function.
> + *
> + */
> +
> +void hlwd_pic_probe(void)
> +{
> + =A0 =A0 =A0 struct irq_host *host;
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 const u32 *interrupts;
> + =A0 =A0 =A0 int cascade_virq;
> +
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "nintendo,hollywood-pic"=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D of_get_property(np, "interru=
pts", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (interrupts) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D hlwd_pic_init(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cascade_virq =3D irq_of_par=
se_and_map(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_data(cascade_virq, =
host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_chained_handler(cas=
cade_virq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 hlwd_pic_irq_cascade);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * hlwd_quiesce() - quiesce hollywood irq controller
> + *
> + * Mask and ack all interrupt sources.
> + *
> + */
> +void hlwd_quiesce(void)
> +{
> + =A0 =A0 =A0 void __iomem *io_base =3D hlwd_irq_host->host_data;
> +
> + =A0 =A0 =A0 __hlwd_quiesce(io_base);
> +}
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.h b/arch/powerpc=
/platforms/embedded6xx/hlwd-pic.h
> new file mode 100644
> index 0000000..d2e5a09
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.h
> @@ -0,0 +1,22 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/hlwd-pic.h
> + *
> + * Nintendo Wii "Hollywood" interrupt controller support.
> + * Copyright (C) 2009 The GameCube Linux Team
> + * Copyright (C) 2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#ifndef __HLWD_PIC_H
> +#define __HLWD_PIC_H
> +
> +extern unsigned int hlwd_pic_get_irq(void);
> +extern void hlwd_pic_probe(void);
> +extern void hlwd_quiesce(void);
> +
> +#endif
> --
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
