Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id DA11BDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:06:01 +1100 (EST)
Received: by gxk1 with SMTP id 1so4071775gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 22:05:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49C26434.30302@grandegger.com>
References: <49C26434.30302@grandegger.com>
Date: Thu, 19 Mar 2009 23:05:59 -0600
Message-ID: <fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I agree 100% with David's comments, and I have some additional ones below.

On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> + =A0 =A0 =A0 soc8544@e0000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";

Drop device_type here too.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x00000000 0xe0000000 0x0010000=
0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xe0000000 0x00001000>; =A0// CCSR=
BAR 1M
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =A0 =A0 =A0 =A0 =
=A0// Filled in by U-Boot
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,socrates-immr", "simple=
-bus";

As David said, fix this to be SoC specific, not board specific.

> + =A0 =A0 =A0 localbus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,socrates-localbus",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fsl,mpc85xx-loc=
albus",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fsl,pq3-localbu=
s";

1st entry shouldn't be there.
2nd entry should specify exact chip
3rd entry I don't like much, but others may debate me on it
Also, add "simple-bus" to this list.  (important for a later comment)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xe0005000 0x40>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0 0xfc000000 0x04000000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 0 0xc8000000 0x040000=
00
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3 0 0xc0000000 0x001000=
00
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >; /* Overwritten by U-Boot=
 */

Just curious, why is U-Boot overwriting the ranges property?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fpga_pic: fpga-pic@3,10 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "abb,socrate=
s-fpga-pic";

Is 'abb' the companies' stock ticker symbol?  If not, then use the
real name and not an abbreviation.

> Index: linux-2.6/arch/powerpc/boot/wrapper
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/boot/wrapper
> +++ linux-2.6/arch/powerpc/boot/wrapper
> @@ -183,7 +183,7 @@ cuboot*)
> =A0 =A0 *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555|*-ksi8560*)
> =A0 =A0 =A0 =A0 platformo=3D$object/cuboot-85xx-cpm2.o
> =A0 =A0 =A0 =A0 ;;
> - =A0 =A0*-mpc85*|*-tqm85*|*-sbc85*)
> + =A0 =A0*-mpc85*|*-tqm85*|*-sbc85*|*-socrates)
> =A0 =A0 =A0 =A0 platformo=3D$object/cuboot-85xx.o
> =A0 =A0 =A0 =A0 ;;

Is this a new or old platform?  Can U-Boot on the board boot with a
uImage + dtb instead of a cuImage?  I'd prefer to avoid adding new
cuImages to the wrapper script if at all possible.

> Index: linux-2.6/arch/powerpc/configs/85xx/socrates_defconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/arch/powerpc/configs/85xx/socrates_defconfig

Is a socrates-specific defconfig really warranted?

> --- linux-2.6.orig/arch/powerpc/platforms/85xx/Makefile
> +++ linux-2.6/arch/powerpc/platforms/85xx/Makefile
> @@ -13,4 +13,6 @@ obj-$(CONFIG_STX_GP3) =A0 +=3D stx_gp3.o
> =A0obj-$(CONFIG_TQM85xx) =A0 =A0+=3D tqm85xx.o
> =A0obj-$(CONFIG_SBC8560) =A0 =A0 +=3D sbc8560.o
> =A0obj-$(CONFIG_SBC8548) =A0 =A0 +=3D sbc8548.o
> +obj-$(CONFIG_SOCRATES) =A0 =A0+=3D socrates.o
> +obj-$(CONFIG_SOCRATES) =A0 =A0+=3D socrates_fpga_pic.o

The pic stuff isn't all that big.  Personally I'd roll it all into the
socrates.c file.

> --- /dev/null
> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates.c
> +static void __init socrates_pic_init(void)
> +{
> + =A0 =A0 =A0 struct mpic *mpic;
> + =A0 =A0 =A0 struct resource r;
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 np =3D of_find_node_by_type(NULL, "open-pic");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not find open-pic no=
de\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (of_address_to_resource(np, 0, &r)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not map mpic registe=
r space\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mpic =3D mpic_alloc(np, r.start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPIC_PRIMARY | MPIC_WANTS_R=
ESET | MPIC_BIG_ENDIAN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 256, " OpenPIC =A0");
> + =A0 =A0 =A0 BUG_ON(mpic =3D=3D NULL);
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 mpic_init(mpic);

Heh, this is a block of code cloned between all the 85xx boards it
seems.  Smells like a small refactoring candidate.  This isn't really
a critique of this patch, but I noticed it so I thought I'd mention
it.

> +static void socrates_show_cpuinfo(struct seq_file *m)
> +{
> + =A0 =A0 =A0 uint pvid, svid, phid1;
> + =A0 =A0 =A0 uint memsize =3D total_memory;
> +
> + =A0 =A0 =A0 pvid =3D mfspr(SPRN_PVR);
> + =A0 =A0 =A0 svid =3D mfspr(SPRN_SVR);
> +
> + =A0 =A0 =A0 seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> + =A0 =A0 =A0 seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +
> + =A0 =A0 =A0 /* Display cpu Pll setting */
> + =A0 =A0 =A0 phid1 =3D mfspr(SPRN_HID1);
> + =A0 =A0 =A0 seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3=
f));
> +
> + =A0 =A0 =A0 /* Display the amount of memory */
> + =A0 =A0 =A0 seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024=
));
> +}

Another block of duplicated code.  In fact, many platforms have
dropped the cpuinfo hook entirely and just use the default output.

> +
> +static struct of_device_id __initdata of_bus_ids[] =3D {
> + =A0 =A0 =A0 { .name =3D "soc", },
> + =A0 =A0 =A0 { .type =3D "soc", },
> + =A0 =A0 =A0 { .name =3D "localbus", },

Drop these three lines.  It is considered bad form now to bind on
either name or type for flattened device trees.  Instead add one {
.compatible =3D "simple-bus", }, entry and make sure the immr and
localbus nodes include "simple-bus" in the compatible string.

> + =A0 =A0 =A0 {},
> +};
> +
> +static int __init declare_of_platform_devices(void)
> +{
> + =A0 =A0 =A0 of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +machine_device_initcall(socrates, declare_of_platform_devices);

Don't add an initcall for this.  Instead assign
declar_of_platform_devices to the .init member of in the
define_machine() block below.

> Index: linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> @@ -0,0 +1,320 @@
> +/*
> + * =A0Copyright (C) 2008 Ilya Yanok, Emcraft Systems
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +
> +#define SOCRATES_FPGA_NUM_IRQS 9
> +
> +#define FPGA_PIC_IRQCFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0)
> +#define FPGA_PIC_IRQMASK(n) =A0 =A0(0x4 + 0x4 * (n))
> +
> +#define SOCRATES_FPGA_IRQ_MASK ((1 << SOCRATES_FPGA_NUM_IRQS) - 1)
> +
> +struct socrates_fpga_irq_info {
> + =A0 =A0 =A0 unsigned int irq_line;
> + =A0 =A0 =A0 int type;
> +};
> +
> +/*
> + * Interrupt routing and type table
> + *
> + * IRQ_TYPE_NONE means the interrupt type is configurable,
> + * otherwise it's fixed to the specified value.
> + */
> +static struct socrates_fpga_irq_info fpga_irqs[SOCRATES_FPGA_NUM_IRQS] =
=3D {
> + =A0 =A0 =A0 [0] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [1] =3D {0, IRQ_TYPE_LEVEL_HIGH},
> + =A0 =A0 =A0 [2] =3D {0, IRQ_TYPE_LEVEL_LOW},
> + =A0 =A0 =A0 [3] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [4] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [5] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [6] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [7] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [8] =3D {0, IRQ_TYPE_LEVEL_HIGH},
> +};
> +
> +#define socrates_fpga_irq_to_hw(virq) =A0 =A0((unsigned int)irq_map[virq=
].hwirq)
> +
> +static DEFINE_SPINLOCK(socrates_fpga_pic_lock);
> +
> +static void __iomem *socrates_fpga_pic_iobase;
> +static struct irq_host *socrates_fpga_pic_irq_host;
> +static unsigned int socrates_fpga_irqs[3];
> +
> +static inline uint32_t socrates_fpga_pic_read(int reg)
> +{
> + =A0 =A0 =A0 return in_be32(socrates_fpga_pic_iobase + reg);
> +}
> +
> +static inline void socrates_fpga_pic_write(int reg, uint32_t val)
> +{
> + =A0 =A0 =A0 out_be32(socrates_fpga_pic_iobase + reg, val);
> +}
> +
> +static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
> +{
> + =A0 =A0 =A0 uint32_t cause;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 3; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq =3D=3D socrates_fpga_irqs[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (i =3D=3D 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;

This is interesting.  What does it mean?  It would be helpful to have
a theory of operation blurb in this file for stuff like this..

> +static int socrates_fpga_pic_host_xlate(struct irq_host *h,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *ct, u32 *intspec, unsig=
ned int intsize,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t *out_hwirq, unsigned int *o=
ut_flags)
> +{
> + =A0 =A0 =A0 struct socrates_fpga_irq_info *fpga_irq =3D &fpga_irqs[ints=
pec[0]];
> +
> + =A0 =A0 =A0 *out_hwirq =3D intspec[0];
> + =A0 =A0 =A0 if =A0(fpga_irq->type =3D=3D IRQ_TYPE_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* type is configurable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intspec[1] !=3D IRQ_TYPE_LEVEL_LOW &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intspec[1] !=3D IRQ_TYPE_LEVEL_HIGH=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "FPGA P=
IC: invalid irq type, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"setting def=
ault active low\n");

Nit: pr_warn() perhaps?  And same through the rest of the file.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
