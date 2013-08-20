Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.202])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta8.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87AA12C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 12:28:12 +1000 (EST)
In-Reply-To: <1376012120.4514.86.camel@snotra.buserror.net>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <1376012120.4514.86.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFE172B06C.BE11BDC5-ONCA257BCC.007C0097-CA257BCD.000D984C@csc.com>
Date: Tue, 20 Aug 2013 13:28:20 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Stephen N Chivers <schivers@csc.com.au>,
 paulus@samba.org, Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 11:35:20 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: <benh@kernel.crashing.org>, <paulus@samba.org>, Chris Proctor 
> <cproctor@csc.com.au>, <linuxppc-dev@lists.ozlabs.org>
> Date: 08/09/2013 11:36 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> On Thu, 2013-08-08 at 11:03 +1100, Stephen N Chivers wrote:
> > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > 
> > The MVME5100 is a 6U form factor VME64 computer with:
> > 
> >         - A single MPC7410 or MPC750 CPU
> >         - A HAWK Processor Host Bridge (CPU to PCI) and
> >           MultiProcessor Interrupt Controller (MPIC)
> >         - Up to 500Mb of onboard memory
> >         - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> >         - Two 16550 compatible UARTS
> >         - Two Intel E100 Fast Ethernets
> >         - Two PCI Mezzanine Card (PMC) Slots
> >         - PPCBug Firmware
> > 
> > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > 
> > There is no onboard disk support. This is usually provided by 
installing a 
> > PMC
> > in first PMC slot.
> > 
> > This patch revives the board support, it was present in early 2.6
> > series kernels. The board support in those days was by Matt Porter of
> > MontaVista Software.
> > 
> > CSC Australia has around 31 of these boards in service. The kernel in 
use
> > for the boards is based on 2.6.31. The boards are operated without 
disks
> > from a file server. 
> > 
> > This patch is based on linux-3.11-rc4 and has been boot tested.
> > 
> > Signed-off-by: Stephen Chivers <schivers@csc.com>
> > ---
> >  arch/powerpc/boot/dts/mvme5100.dts            |  195 ++
> >  arch/powerpc/boot/mvme5100.c                  |   28 +
> >  arch/powerpc/configs/mvme5100_defconfig       | 2597 
> > +++++++++++++++++++++++++
> >  arch/powerpc/platforms/embedded6xx/mvme5100.c |  288 +++
> >  4 files changed, 3108 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/mvme5100.dts 
> > b/arch/powerpc/boot/dts/mvme5100.dts
> > new file mode 100644
> > index 0000000..17fdbc7
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/mvme5100.dts
> > @@ -0,0 +1,195 @@
> > +/*
> > + * Device Tree Souce for Motorola/Emerson MVME5100.
> > + *
> > + * Copyright 2013 CSC Australia Pty. Ltd.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without
> > + * any warranty of any kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       model = "MVME5100";
> > +       compatible = "MVME5100";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       aliases {
> > +               serial0 = &serial0;
> > +               pci0 = &pci0;
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               PowerPC,7410 {
> > +                       device_type = "cpu";
> > +                       reg = <0x0>;
> > +                       /* Following required by dtc but not used */
> > +                       d-cache-line-size = <32>;
> > +                       i-cache-line-size = <32>;
> > +                       i-cache-size = <32768>;
> > +                       d-cache-size = <32768>;
> > +                       timebase-frequency = <25000000>;
> > +                       clock-frequency = <500000000>;
> > +                        bus-frequency = <100000000>;
> 
> What does "following" mean?  certainly some of those are used, such as
> timebase-frequency.  In any case, it's not the device tree's job to
> document which properties are used by Linux.
> 
Agreed. Will remove.
The words were/are in the KuroboxHG.dts I modelled this dts on.
> > +               };
> > +       };
> > +
> > +       memory {
> > +               device_type = "memory";
> > +               reg = <0x0 0x20000000>;
> > +       };
> > +
> > +       hawk@fef8 {
> 
> Unit address does not match reg.
>
Will make it hawk@fef80000.

> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               device_type = "soc";
> 
> Is this really an SoC?  In any case, this use of device_type is
> deprecated.
> 
That was part of my early attempts to get legacy_serial to set up
the UARTS.
> > +               compatible = "mpc10x";
> 
> Don't use wildcards in compatible strings.
> 
> simple-bus may be applicable here (in addition to a specific
> compatible).
>
The HAWK ASIC is a difficult beast. I still cannot get a positive
identification as to what it is (Motorola/Freescale part number
unknown, not even the part number on the chip on the board helps....).
The best I can come up with is that it is a tsi108 without
the ethenets.
So device_type will be tsi-bridge and compatible will be
tsi108-bridge.
> > +               store-gathering = <0>;
> > +               ranges = <0x0 0xfef80000 0x10000>;
> > +               reg = <0xfef80000 0x10000>;
> 
> Where is "store-gathering" documented?
>
Good question. Again copied from the KuroboxHG dts (which
still has it).

> > +               serial0: serial@8000 {
> > +                       cell-index = <0>;
> > +                       device_type = "serial";
> > +                       compatible = "ns16550";
> > +                       reg = <0x8000 0x80>;
> > +                       reg-shift = <4>;
> > +                       clock-frequency = <1843200>;
> > +                       current-speed = <9600>;
> > +                       interrupts = <1 1>; // IRQ1 Level Active Low.
> > +                       interrupt-parent = <&mpic>;
> > +               };
> > +
> > +               serial1: serial@8200 {
> > +                       cell-index = <1>;
> > +                       device_type = "serial";
> > +                       compatible = "ns16550";
> > +                       reg = <0x8200 0x80>;
> > +                       reg-shift = <4>;
> > +                       clock-frequency = <1843200>;
> > +                       current-speed = <9600>;
> > +                       interrupts = <1 1>; // IRQ1 Level Active Low.
> > +                       interrupt-parent = <&mpic>;
> > +               };
> 
> What specifically does cell-index mean here?  Is it describing the
> hardware or just the terminology used in documentation?
>
Another case of a copying of what was already there. Will remove.

> > +       pci0: pci@feff0000 {
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               #interrupt-cells = <1>;
> > +               device_type = "pci";
> > +               compatible = "mpc10x-pci";
> > +               reg = <0xfec00000 0x400000>;
> > +               8259-interrupt-acknowledge = <0xfeff0030>;
> 
> Where is 8259-interrupt-acknowledge documented?
>
Good question. It is used in platforms/chrp/setup.c. It is also in the
amigaone dts, but that platform uses the PNP approach to managing its
8259 interrupts.
Will set compatible to "tsi108-pci" here.

> > +               ranges = <0x1000000 0x0        0x0 0xfe000000 0x0 
0x800000
> > +                         0x2000000 0x0 0x80000000 0x80000000 0x0 
> > 0x74000000>;
> > +               bus-range = <0 255>;
> > +               clock-frequency = <33333333>;
> > +               interrupt-parent = <&mpic>;
> > +               interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> > +               interrupt-map = <
> > +
> > +                       /*
> > +                        * This definition (IDSEL 11) duplicates the
> > +                        * interrupts definition in the i8259
> > +                        * interrupt controller below.
> > +                        *
> > +                        * It isn't essential to provide it and the
> > +                        * board will run happily without it.
> 
> Should it be present then?
>
The interrupt comes via the PCI as it is sourced from a winbond
PCI to ISA bridge (and that is on a iPMC712 PMC).
But the interrupt has to be acknowledged via the
8259 interrupt acknowledge. Will remove the "essential" comment.

> > +               isa {
> > +                       #address-cells = <2>;
> > +                       #size-cells = <1>;
> > +                       #interrupt-cells = <2>;
> > +                       device_type = "isa";
> > +                       compatible = "isa";
> > +                       ranges = <0x00000001 0 0x01000000 0 0x00000000 

> > 0x00001000>;
> > +                       interrupt-parent = <&i8259>;
> > +
> > +                       i8259: interrupt-controller@20 {
> > +                               #interrupt-cells = <2>;
> > +                               #address-cells = <0>;
> > +                               interrupts = <0 2>;
> > +                               device_type = "interrupt-controller";
> > +                               compatible = "chrp,iic";
> > +                               interrupt-controller;
> > +                               reg = <1 0x00000020 0x00000002
> > +                                       1 0x000000a0 0x00000002
> > +                                       1 0x000004d0 0x00000002>;
> > +                               clock-frequency = <0>;
> 
> Why does an i8259 have a clock-frequency?
>
Cut and paste considered harmful. Will remove.
> > +                               built-in;
> 
> What does this mean?
>
Don't know where I got that one from. Will remove.
> > diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c 
> > b/arch/powerpc/platforms/embedded6xx/mvme5100.c
> > new file mode 100644
> > index 0000000..cc9ed8a
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
> > @@ -0,0 +1,288 @@
> > +/*
> > + * Board setup routines for the Motorola/Emerson MVME5100.
> > + *
> > + * Copyright 2013 CSC Australia Pty. Ltd.
> > + *
> > + * Based on earlier code by:
> > + *
> > + *    Matt Porter, MontaVista Software Inc.
> > + *    Copyright 2001 MontaVista Software Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or 
modify 
> > it
> > + * under  the terms of  the GNU General  Public License as published 
by 
> > the
> > + * Free Software Foundation;  either version 2 of the  License, or 
(at 
> > your
> > + * option) any later version.
> > + *
> > + * Author: Stephen Chivers <schivers@csc.com>
> > + *
> > + */
> > +
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/i8259.h>
> > +#include <asm/pci-bridge.h>
> > +#include <asm/mpic.h>
> > +#include <asm/prom.h>
> > +#include <mm/mmu_decl.h>
> > +#include <asm/udbg.h>
> > +
> > +
> > +#define HAWK_MPIC_SIZE         0x00040000U
> > +#define MVME5100_PCI_MEM_OFFSET 0x00000000
> > +
> > +/* Board register addresses. */
> > +#define        BOARD_STATUS_REG        0xfef88080
> > +#define        BOARD_MODFAIL_REG       0xfef88090
> > +#define        BOARD_MODRST_REG        0xfef880a0
> > +#define        BOARD_TBEN_REG          0xfef880c0
> > +#define BOARD_SW_READ_REG      0xfef880e0
> > +#define        BOARD_GEO_ADDR_REG      0xfef880e8
> > +#define        BOARD_EXT_FEATURE1_REG  0xfef880f0
> > +#define        BOARD_EXT_FEATURE2_REG  0xfef88100
> > +
> > +static unsigned int pci_membase;
> > +
> > +
> > +#ifdef DEBUG
> > +#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## 
args)
> > +#else
> > +#define DBG(fmt, args...)
> > +#endif
> 
> Use pr_debug().
>
Ok.
> > +static void
> > +mvme5100_8259_cascade(unsigned int irq, struct irq_desc *desc)
> > +{
> > +       struct irq_chip *chip = irq_desc_get_chip(desc);
> > +       unsigned int cascade_irq = i8259_irq();
> > +
> > +
> 
> Only one blank line.
>
Ok.
> > +       if (cascade_irq != NO_IRQ)
> > +               generic_handle_irq(cascade_irq);
> > +
> > +       chip->irq_eoi(&desc->irq_data);
> > +}
> > +
> > +
> 
> Only one blank line.  Likewise elsewhere.
>
Ok.
> > +static void __init
> > +mvme5100_pic_init(void)
> 
> Don't put a newline before the function name.
>
Ok. Old habits..... (from 1980 when I was writing stuff for
Level 7 Unix on PDP11s....).
> > +{
> > +       struct mpic *mpic;
> > +       void __iomem *mpic_addr;
> > +       struct device_node *np;
> > +       struct device_node *cp = NULL;
> > +       unsigned int cirq;
> > +       unsigned long intack = 0;
> > +       const unsigned long *prop = NULL;
> 
> Do not use non-fixed-size-types to decode properties.  In particular,
> non-string properties are normally composed of 32-bit cells.
>
Ok.
> > +       np = of_find_node_by_type(NULL, "open-pic");
> > +       if (!np) {
> > +               pr_err("Could not find open-pic node\n");
> > +               return;
> > +       }
> > +
> > +
> > +       pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
> > +
> > +       mpic_addr = ioremap(pci_membase + MVME5100_PCI_MEM_OFFSET,
> > +                       HAWK_MPIC_SIZE);
> > +
> > +       pr_info("mvme5100_pic_init: mapped mpic_addr: 0x%p\n", 
mpic_addr);
> 
> The only thing you use this ioremap for is to print out the address.
>
Debug from initial port.
 
> > +       for_each_node_by_type(np, "interrupt-controller")
> > +               if (of_device_is_compatible(np, "chrp,iic")) {
> > +                       cp = np;
> > +                       break;
> > +               }
> > +
> 
> Please use braces around multi-line loop bodies.
>
Ok.

> Why not just look for a chrp,iic node directly?
>
I was following the model used in other places, like chrp/setup.c.

 
> > +       if ((np = of_find_compatible_node(NULL, "pci", "mpc10x-pci"))) 
{
> 
> Why insist on the device_type?
>
Following the model in the linkstation (kurobox) platform support. 
> > +static int __init
> > +mvme5100_add_bridge(struct device_node *dev)
> > +{
> > +       const int               *bus_range;
> > +       int                     len;
> > +       struct pci_controller   *hose;
> > +       unsigned short          devid;
> > +
> > +
> > +       pr_info("Adding PCI host bridge %s\n", dev->full_name);
> > +
> > +       bus_range = of_get_property(dev, "bus-range", &len);
> > +
> > +       if (bus_range == NULL || len < 2 * sizeof(int))
> > +               pr_warn("Can't get bus-range for %s, assuming bus 
0\n",
> > +                       dev->full_name);
> 
> Is this worth warning about?
>
Ok.
> > +       if (devid != PCI_DEVICE_ID_MOTOROLA_HAWK) {
> > +               pr_err("HAWK PHB not present?\n");
> > +
> > +               return 0;
> > +       }
> > +
> > +       early_read_config_dword( hose, 0, 0, PCI_BASE_ADDRESS_1, 
> > &pci_membase);
> 
> Patch is linewrapped.
>
Yes. Lotus Notes strikes again.
> > +static void
> > +mvme5100_restart(char *cmd)
> > +{
> > +       volatile ulong          i = 10000000;
> > +
> > +
> > +       local_irq_disable();
> > +       _nmask_and_or_msr(0, MSR_IP);
> 
> Does "mtmsr(mfmsr() | MSR_IP)" not work?
>
Don't know. Is from the original code by Matt Porter.

> > +       out_8((u_char *) BOARD_MODRST_REG, 0x01);
> > +
> > +       while (i-- > 0);
> 
> Do not use a loop to implement a delay.
>
Taken from the original code. But at this point the board
is going to reset and reboot via firmware, as /sbin/reboot
or /sbin/halt has been invoked.
 
> > +static void __init
> > +mvme5100_set_bat(void)
> > +{
> > +
> > +
> > +       mb();
> > +       mtspr(SPRN_DBAT1U, 0xf0001ffe);
> > +       mtspr(SPRN_DBAT1L, 0xf000002a);
> > +       mb();
> > +       setbat(1, 0xfe000000, 0xfe000000, 0x02000000, 
PAGE_KERNEL_NCG);
> > +}
> 
> It is no longer allowed to squat on random virtual address space like
> this.  If you really need a BAT you'll have to allocate the virtual
> address properly.
>
Yes. I found that this was an anathema when researching the port in
2010 but I couldn't find any practical solution at the time.
The code is called early to ensure that the hawk registers are available.
sysdev/cpm_common.c does the same thing.

What is the correct solution?
> -Scott
> 
> 
> 
Thanks for all the comments, they are appreciated.
