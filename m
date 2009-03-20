Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 36F03DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 22:57:10 +1100 (EST)
Message-ID: <49C38492.8080507@grandegger.com>
Date: Fri, 20 Mar 2009 12:57:06 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
In-Reply-To: <fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
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

Grant Likely wrote:
> I agree 100% with David's comments, and I have some additional ones below.

OK.

> On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> +       soc8544@e0000000 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               device_type = "soc";
> 
> Drop device_type here too.
> 
>> +
>> +               ranges = <0x00000000 0xe0000000 0x00100000>;
>> +               reg = <0xe0000000 0x00001000>;  // CCSRBAR 1M
>> +               bus-frequency = <0>;            // Filled in by U-Boot
>> +               compatible = "fsl,socrates-immr", "simple-bus";
> 
> As David said, fix this to be SoC specific, not board specific.
> 
>> +       localbus {
>> +               compatible = "fsl,socrates-localbus",
>> +                            "fsl,mpc85xx-localbus",
>> +                            "fsl,pq3-localbus";
> 
> 1st entry shouldn't be there.
> 2nd entry should specify exact chip
> 3rd entry I don't like much, but others may debate me on it
> Also, add "simple-bus" to this list.  (important for a later comment)

OK.

> 
>> +               #address-cells = <2>;
>> +               #size-cells = <1>;
>> +               reg = <0xe0005000 0x40>;
>> +
>> +               ranges = <0 0 0xfc000000 0x04000000
>> +                         2 0 0xc8000000 0x04000000
>> +                         3 0 0xc0000000 0x00100000
>> +                       >; /* Overwritten by U-Boot */
> 
> Just curious, why is U-Boot overwriting the ranges property?

Because there are boards without FPGA or graphic controller on the local
bus.

>> +               fpga_pic: fpga-pic@3,10 {
>> +                       compatible = "abb,socrates-fpga-pic";
> 
> Is 'abb' the companies' stock ticker symbol?  If not, then use the
> real name and not an abbreviation.

Yes.

>> Index: linux-2.6/arch/powerpc/boot/wrapper
>> ===================================================================
>> --- linux-2.6.orig/arch/powerpc/boot/wrapper
>> +++ linux-2.6/arch/powerpc/boot/wrapper
>> @@ -183,7 +183,7 @@ cuboot*)
>>     *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555|*-ksi8560*)
>>         platformo=$object/cuboot-85xx-cpm2.o
>>         ;;
>> -    *-mpc85*|*-tqm85*|*-sbc85*)
>> +    *-mpc85*|*-tqm85*|*-sbc85*|*-socrates)
>>         platformo=$object/cuboot-85xx.o
>>         ;;
> 
> Is this a new or old platform?  Can U-Boot on the board boot with a
> uImage + dtb instead of a cuImage?  I'd prefer to avoid adding new
> cuImages to the wrapper script if at all possible.

It's a new platform. Therefore I will drop cuboot support.

>> Index: linux-2.6/arch/powerpc/configs/85xx/socrates_defconfig
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6/arch/powerpc/configs/85xx/socrates_defconfig
> 
> Is a socrates-specific defconfig really warranted?
> 
>> --- linux-2.6.orig/arch/powerpc/platforms/85xx/Makefile
>> +++ linux-2.6/arch/powerpc/platforms/85xx/Makefile
>> @@ -13,4 +13,6 @@ obj-$(CONFIG_STX_GP3)   += stx_gp3.o
>>  obj-$(CONFIG_TQM85xx)    += tqm85xx.o
>>  obj-$(CONFIG_SBC8560)     += sbc8560.o
>>  obj-$(CONFIG_SBC8548)     += sbc8548.o
>> +obj-$(CONFIG_SOCRATES)    += socrates.o
>> +obj-$(CONFIG_SOCRATES)    += socrates_fpga_pic.o
> 
> The pic stuff isn't all that big.  Personally I'd roll it all into the
> socrates.c file.

Well,

  $ wc -l socrates_fpga_pic.c
  156 socrates.c
  320 socrates_fpga_pic.c

Personally, I'd prefer to separate the pic from the board init code,
especially with that size.

>> --- /dev/null
>> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates.c
>> +static void __init socrates_pic_init(void)
>> +{
>> +       struct mpic *mpic;
>> +       struct resource r;
>> +       struct device_node *np;
>> +
>> +       np = of_find_node_by_type(NULL, "open-pic");
>> +       if (!np) {
>> +               printk(KERN_ERR "Could not find open-pic node\n");
>> +               return;
>> +       }
>> +
>> +       if (of_address_to_resource(np, 0, &r)) {
>> +               printk(KERN_ERR "Could not map mpic register space\n");
>> +               of_node_put(np);
>> +               return;
>> +       }
>> +
>> +       mpic = mpic_alloc(np, r.start,
>> +                       MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
>> +                       0, 256, " OpenPIC  ");
>> +       BUG_ON(mpic == NULL);
>> +       of_node_put(np);
>> +
>> +       mpic_init(mpic);
> 
> Heh, this is a block of code cloned between all the 85xx boards it
> seems.  Smells like a small refactoring candidate.  This isn't really
> a critique of this patch, but I noticed it so I thought I'd mention
> it.
> 
>> +static void socrates_show_cpuinfo(struct seq_file *m)
>> +{
>> +       uint pvid, svid, phid1;
>> +       uint memsize = total_memory;
>> +
>> +       pvid = mfspr(SPRN_PVR);
>> +       svid = mfspr(SPRN_SVR);
>> +
>> +       seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
>> +       seq_printf(m, "SVR\t\t: 0x%x\n", svid);
>> +
>> +       /* Display cpu Pll setting */
>> +       phid1 = mfspr(SPRN_HID1);
>> +       seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
>> +
>> +       /* Display the amount of memory */
>> +       seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
>> +}
> 
> Another block of duplicated code.  In fact, many platforms have
> dropped the cpuinfo hook entirely and just use the default output.

I can drop it for this board as well, no problem.

>> +
>> +static struct of_device_id __initdata of_bus_ids[] = {
>> +       { .name = "soc", },
>> +       { .type = "soc", },
>> +       { .name = "localbus", },
> 
> Drop these three lines.  It is considered bad form now to bind on
> either name or type for flattened device trees.  Instead add one {
> .compatible = "simple-bus", }, entry and make sure the immr and
> localbus nodes include "simple-bus" in the compatible string.
> 
>> +       {},
>> +};
>> +
>> +static int __init declare_of_platform_devices(void)
>> +{
>> +       of_platform_bus_probe(NULL, of_bus_ids, NULL);
>> +
>> +       return 0;
>> +}
>> +machine_device_initcall(socrates, declare_of_platform_devices);
> 
> Don't add an initcall for this.  Instead assign
> declar_of_platform_devices to the .init member of in the
> define_machine() block below.

OK.

>> Index: linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
>> @@ -0,0 +1,320 @@
>> +/*
>> + *  Copyright (C) 2008 Ilya Yanok, Emcraft Systems
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/io.h>
>> +
>> +#define SOCRATES_FPGA_NUM_IRQS 9
>> +
>> +#define FPGA_PIC_IRQCFG                (0x0)
>> +#define FPGA_PIC_IRQMASK(n)    (0x4 + 0x4 * (n))
>> +
>> +#define SOCRATES_FPGA_IRQ_MASK ((1 << SOCRATES_FPGA_NUM_IRQS) - 1)
>> +
>> +struct socrates_fpga_irq_info {
>> +       unsigned int irq_line;
>> +       int type;
>> +};
>> +
>> +/*
>> + * Interrupt routing and type table
>> + *
>> + * IRQ_TYPE_NONE means the interrupt type is configurable,
>> + * otherwise it's fixed to the specified value.
>> + */
>> +static struct socrates_fpga_irq_info fpga_irqs[SOCRATES_FPGA_NUM_IRQS] = {
>> +       [0] = {0, IRQ_TYPE_NONE},
>> +       [1] = {0, IRQ_TYPE_LEVEL_HIGH},
>> +       [2] = {0, IRQ_TYPE_LEVEL_LOW},
>> +       [3] = {0, IRQ_TYPE_NONE},
>> +       [4] = {0, IRQ_TYPE_NONE},
>> +       [5] = {0, IRQ_TYPE_NONE},
>> +       [6] = {0, IRQ_TYPE_NONE},
>> +       [7] = {0, IRQ_TYPE_NONE},
>> +       [8] = {0, IRQ_TYPE_LEVEL_HIGH},
>> +};
>> +
>> +#define socrates_fpga_irq_to_hw(virq)    ((unsigned int)irq_map[virq].hwirq)
>> +
>> +static DEFINE_SPINLOCK(socrates_fpga_pic_lock);
>> +
>> +static void __iomem *socrates_fpga_pic_iobase;
>> +static struct irq_host *socrates_fpga_pic_irq_host;
>> +static unsigned int socrates_fpga_irqs[3];
>> +
>> +static inline uint32_t socrates_fpga_pic_read(int reg)
>> +{
>> +       return in_be32(socrates_fpga_pic_iobase + reg);
>> +}
>> +
>> +static inline void socrates_fpga_pic_write(int reg, uint32_t val)
>> +{
>> +       out_be32(socrates_fpga_pic_iobase + reg, val);
>> +}
>> +
>> +static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
>> +{
>> +       uint32_t cause;
>> +       unsigned long flags;
>> +       int i;
>> +
>> +       for (i = 0; i < 3; i++) {
>> +               if (irq == socrates_fpga_irqs[i])
>> +                       break;
>> +       }
>> +       if (i == 3)
>> +               return NO_IRQ;
> 
> This is interesting.  What does it mean?  It would be helpful to have
> a theory of operation blurb in this file for stuff like this..

Just three interrupt lines are routed to the MPIC. A BUG_ON would be
more appropriate, though.

>> +static int socrates_fpga_pic_host_xlate(struct irq_host *h,
>> +               struct device_node *ct, u32 *intspec, unsigned int intsize,
>> +               irq_hw_number_t *out_hwirq, unsigned int *out_flags)
>> +{
>> +       struct socrates_fpga_irq_info *fpga_irq = &fpga_irqs[intspec[0]];
>> +
>> +       *out_hwirq = intspec[0];
>> +       if  (fpga_irq->type == IRQ_TYPE_NONE) {
>> +               /* type is configurable */
>> +               if (intspec[1] != IRQ_TYPE_LEVEL_LOW &&
>> +                   intspec[1] != IRQ_TYPE_LEVEL_HIGH) {
>> +                       printk(KERN_WARNING "FPGA PIC: invalid irq type, "
>> +                              "setting default active low\n");
> 
> Nit: pr_warn() perhaps?  And same through the rest of the file.

Yep, will fix the not commented issues as well.

Wolfgang.
