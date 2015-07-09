Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31ECE1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 20:37:21 +1000 (AEST)
Received: from [192.168.1.139] (ppp-93-104-85-152.dynamic.mnet-online.de
 [93.104.85.152]) by smtp.strato.de (RZmta 37.8 DYNA|AUTH)
 with ESMTPSA id J01ad5r69AbGOo4
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 9 Jul 2015 12:37:16 +0200 (CEST)
Subject: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
To: linuxppc-dev@lists.ozlabs.org
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
 <1436394990.3948.113.camel@kernel.crashing.org>
 <1436406135.18682.3.camel@ellerman.id.au>
 <1436428426.3948.117.camel@kernel.crashing.org>
 <559E3B07.5020307@xenosoft.de>
 <CAOJe8K189za27tBr-LwnyTAvUQAyaJfP7D0sktE+VKGxgSzxEg@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <559E4EDB.1060205@xenosoft.de>
Date: Thu, 9 Jul 2015 12:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAOJe8K189za27tBr-LwnyTAvUQAyaJfP7D0sktE+VKGxgSzxEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis

You're right. First I'd like to figure out what the problem is. Then 
I'll build a new kernel for our PA6T system. After that I'll test it. 
Afterwards the beta testers will test it. Finally I'd like to upstream 
the SB600 patch.

Rgds

Christian

On 09 July 2015 at 11:52 AM, Denis Kirjanov wrote:
> On 7/9/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> All
>>
>> I think you haven't received the SB600 patch yet. I have pasted it in
>> this email directly. Thank you for your help. I am sorry because of this
>> long patch but I hope you could help me a bit.
> But the first thing then is to upstream the sb600 patch...
>> Thanks
>>
>> Christian
>>
>> ------------- nemo_4.1-3.patch -------------
>>
>> diff -rupN linux-4.1/arch/powerpc/kernel/head_64.S
>> linux-4.1-nemo/arch/powerpc/kernel/head_64.S
>> --- linux-4.1/arch/powerpc/kernel/head_64.S    2015-06-22
>> 03:47:01.850778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/kernel/head_64.S    2015-06-22
>> 03:27:29.590650112 +0200
>> @@ -70,6 +70,13 @@ _GLOBAL(__start)
>>        /* NOP this out unconditionally */
>>    BEGIN_FTR_SECTION
>>        FIXUP_ENDIAN
>> +/* Hack for PWRficient platforms: Due to CFE(?) bug, the 64-bit
>> + * word at 0x8 needs to be set to 0. Patch it up here once we're
>> + * done executing it (we can be lazy and avoid invalidating
>> + * icache)
>> + */
>> +li     r0,0
>> +std    0,8(0)
>>        b    __start_initialization_multiplatform
>>    END_FTR_SECTION(0, 1)
>>
>> diff -rupN linux-4.1/arch/powerpc/kernel/pci-common.c
>> linux-4.1-nemo/arch/powerpc/kernel/pci-common.c
>> --- linux-4.1/arch/powerpc/kernel/pci-common.c    2015-06-22
>> 03:47:01.866778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/kernel/pci-common.c    2015-06-22
>> 03:27:29.603650164 +0200
>> @@ -721,6 +721,19 @@ void pci_process_bridge_OF_ranges(struct
>>                    isa_io_base =
>>                        (unsigned long)hose->io_base_virt;
>>    #endif /* CONFIG_PPC32 */
>> +
>> +
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +                       /* Workaround for lack of device tree. New for
>> kernel 3.17: range.cpu_addr instead of cpu_addr and range.size instead
>> of size Ch. Zigotzky */
>> +                       if (primary) {
>> +                               __ioremap_at(range.cpu_addr, (void
>> *)ISA_IO_BASE,
>> +                               range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
>> +                       hose->io_base_virt = (void *)_IO_BASE;
>> +               /* _IO_BASE needs unsigned long long for the kernel 3.17
>> Ch. Zigotzky */
>> +                       printk("Initialised io_base_virt 0x%lx _IO_BASE
>> 0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BASE);
>> +                    }
>> +#endif
>> +
>>                /* pci_io_size and io_base_phys always represent IO
>>                 * space starting at 0 so we factor in pci_addr
>>                 */
>> @@ -1194,6 +1207,7 @@ static void pcibios_allocate_bus_resourc
>>                    &ioport_resource : &iomem_resource;
>>            else {
>>                pr = pci_find_parent_resource(bus->self, res);
>> +#ifndef CONFIG_PPC_PASEMI_SB600
>>                if (pr == res) {
>>                    /* this happens when the generic PCI
>>                     * code (wrongly) decides that this
>> @@ -1201,6 +1215,7 @@ static void pcibios_allocate_bus_resourc
>>                     */
>>                    continue;
>>                }
>> +#endif
>>            }
>>
>>            pr_debug("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
>> @@ -1632,8 +1647,9 @@ void pcibios_scan_phb(struct pci_control
>>        pr_debug("PCI: Scanning PHB %s\n", of_node_full_name(node));
>>
>>        /* Get some IO space for the new PHB */
>> +#ifndef CONFIG_PPC_PASEMI_SB600
>>        pcibios_setup_phb_io_space(hose);
>> -
>> +#endif
>>        /* Wire up PHB bus resources */
>>        pcibios_setup_phb_resources(hose, &resources);
>>
>> diff -rupN linux-4.1/arch/powerpc/kernel/setup-common.c
>> linux-4.1-nemo/arch/powerpc/kernel/setup-common.c
>> --- linux-4.1/arch/powerpc/kernel/setup-common.c    2015-06-22
>> 03:47:01.879778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/kernel/setup-common.c    2015-06-22
>> 03:27:29.605650172 +0200
>> @@ -76,7 +76,15 @@ EXPORT_SYMBOL(ppc_md);
>>    struct machdep_calls *machine_id;
>>    EXPORT_SYMBOL(machine_id);
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +/* FIXME!!
>> + * Current PASemi code does not correctly update the value of boot_cpuid
>> + * As a temporary fix we use the default 0, which is known to work
>> + */
>> +int boot_cpuid = 0;
>> +#else
>>    int boot_cpuid = -1;
>> +#endif
>>    EXPORT_SYMBOL_GPL(boot_cpuid);
>>
>>    unsigned long klimit = (unsigned long) _end;
>> diff -rupN linux-4.1/arch/powerpc/platforms/pasemi/iommu.c
>> linux-4.1-nemo/arch/powerpc/platforms/pasemi/iommu.c
>> --- linux-4.1/arch/powerpc/platforms/pasemi/iommu.c    2015-06-22
>> 03:47:02.018778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/platforms/pasemi/iommu.c 2015-06-22
>> 03:27:29.611650196 +0200
>> @@ -1,3 +1,9 @@
>> +/* This is a modified copy of
>> +* usr/src/linux-2.6.39.4/arch/powerpc/platforms/pasemi/iommu.c
>> +* The mod is on line 150
>> +* By Len Karpowicz <twotat2z@embarqmail.com
>> +*/
>> +
>>    /*
>>     * Copyright (C) 2005-2008, PA Semi, Inc
>>     *
>> @@ -143,8 +149,11 @@ static void iommu_table_iobmap_setup(voi
>>        iommu_table_iobmap.it_page_shift = IOBMAP_PAGE_SHIFT;
>>
>>        /* it_size is in number of entries */
>> -    iommu_table_iobmap.it_size =
>> -        0x80000000 >> iommu_table_iobmap.it_page_shift;
>> +
>> +/* Note: changed 0x80000000 to 0x7FFFFFFF for SBLive! SB0220 */
>> +/* out of range problem on A-EON AmigaOne X1000 */
>> +       iommu_table_iobmap.it_size = 0x7FFFFFFF >> IOBMAP_PAGE_SHIFT;
>> +
>>
>>        /* Initialize the common IOMMU code */
>>        iommu_table_iobmap.it_base = (unsigned long)iob_l2_base;
>> diff -rupN linux-4.1/arch/powerpc/platforms/pasemi/Kconfig
>> linux-4.1-nemo/arch/powerpc/platforms/pasemi/Kconfig
>> --- linux-4.1/arch/powerpc/platforms/pasemi/Kconfig    2015-06-22
>> 03:47:02.017778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/platforms/pasemi/Kconfig 2015-06-22
>> 03:27:29.620650232 +0200
>> @@ -14,6 +14,13 @@ config PPC_PASEMI
>>    menu "PA Semi PWRficient options"
>>        depends on PPC_PASEMI
>>
>> +config PPC_PASEMI_SB600
>> +       bool "Nemo SB600 South Bridge Support"
>> +       depends on PPC_PASEMI
>> +       select PPC_I8259
>> +       help
>> +       Workarounds for the SB600 South Bridge.
>> +
>>    config PPC_PASEMI_IOMMU
>>        bool "PA Semi IOMMU support"
>>        depends on PPC_PASEMI
>> diff -rupN linux-4.1/arch/powerpc/platforms/pasemi/pci.c
>> linux-4.1-nemo/arch/powerpc/platforms/pasemi/pci.c
>> --- linux-4.1/arch/powerpc/platforms/pasemi/pci.c    2015-06-22
>> 03:47:02.019778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/platforms/pasemi/pci.c    2015-06-22
>> 03:27:29.621650236 +0200
>> @@ -108,6 +108,69 @@ static int workaround_5945(struct pci_bu
>>        return 1;
>>    }
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +static int sb600_bus = 5;
>> +static void __iomem *iob_mapbase = NULL;
>> +
>> +static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>> +                             int offset, int len, u32 *val);
>> +
>> +static void sb600_set_flag(int bus)
>> +{
>> +    struct resource res;
>> +    struct device_node *dn;
>> +       struct pci_bus *busp;
>> +       u32 val;
>> +       int err;
>> +
>> +       if (sb600_bus == -1)
>> +       {
>> +               busp = pci_find_bus(0, 0);
>> +               pa_pxp_read_config(busp, PCI_DEVFN(17,0),
>> PCI_SECONDARY_BUS, 1, &val);
>> +
>> +               sb600_bus = val;
>> +
>> +               printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
>> +       }
>> +
>> +       if (iob_mapbase == NULL)
>> +       {
>> +        dn = of_find_compatible_node(NULL, "io-bridge",
>> "pasemi,1682m-iob");
>> +        if (!dn)
>> +        {
>> +               printk(KERN_CRIT "NEMO SB600 missing iob node\n");
>> +                       return;
>> +               }
>> +
>> +               err = of_address_to_resource(dn, 0, &res);
>> +        of_node_put(dn);
>> +
>> +               if (err)
>> +               {
>> +               printk(KERN_CRIT "NEMO SB600 missing resource\n");
>> +                       return;
>> +               }
>> +
>> +               printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
>> +
>> +               iob_mapbase = ioremap(res.start + 0x100, 0x94);
>> +       }
>> +
>> +       if (iob_mapbase != NULL)
>> +       {
>> +               if (bus == sb600_bus)
>> +               {
>> +                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase +
>> 4) | 0x800);
>> +               }
>> +               else
>> +               {
>> +                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase +
>> 4) & ~0x800);
>> +               }
>> +       }
>> +}
>> +#endif
>> +
>> +
>>    static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>>                      int offset, int len, u32 *val)
>>    {
>> @@ -126,6 +189,10 @@ static int pa_pxp_read_config(struct pci
>>
>>        addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       sb600_set_flag(bus->number);
>> +#endif
>> +
>>        /*
>>         * Note: the caller has already checked that offset is
>>         * suitably aligned and that len is 1, 2 or 4.
>> diff -rupN linux-4.1/arch/powerpc/platforms/pasemi/setup.c
>> linux-4.1-nemo/arch/powerpc/platforms/pasemi/setup.c
>> --- linux-4.1/arch/powerpc/platforms/pasemi/setup.c    2015-06-22
>> 03:47:02.019778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/platforms/pasemi/setup.c 2015-06-22
>> 03:27:29.623650244 +0200
>> @@ -34,6 +34,7 @@
>>    #include <asm/prom.h>
>>    #include <asm/iommu.h>
>>    #include <asm/machdep.h>
>> +#include <asm/i8259.h>
>>    #include <asm/mpic.h>
>>    #include <asm/smp.h>
>>    #include <asm/time.h>
>> @@ -72,6 +73,17 @@ static void pas_restart(char *cmd)
>>            out_le32(reset_reg, 0x6000000);
>>    }
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +void pas_shutdown(void)
>> +{
>> +       /* (added by DStevens 19/06/13)
>> +          Set the PLD bit that makes the SB600 think the power button
>> is being pressed */
>> +       void __iomem *pld_map = ioremap(0xf5000000,4096);
>> +       while (1)
>> +               out_8(pld_map+7,0x01);
>> +}
>> +#endif
>> +
>>    #ifdef CONFIG_SMP
>>    static arch_spinlock_t timebase_lock;
>>    static unsigned long timebase;
>> @@ -183,6 +195,55 @@ static int __init pas_setup_mce_regs(voi
>>    }
>>    machine_device_initcall(pasemi, pas_setup_mce_regs);
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +static unsigned sb600_irq_to_vector(int irq)
>> +{
>> +       switch(irq) {
>> +       case 3: return 216;
>> +       case 4: return 217;
>> +       case 5: return 218;
>> +       case 6: return 219;
>> +       case 7: return 220;
>> +       case 8: return 222;
>> +       case 9: return 212;
>> +       case 10: return 213;
>> +       case 11: return 214;
>> +       case 12: return 215;
>> +       case 14: return 221;
>> +       default: return 0;
>> +       }
>> +}
>> +
>> +static void sb600_8259_cascade(unsigned int irq, struct irq_data *desc)
>> +{
>> +       unsigned int cascade_irq = i8259_irq();
>> +       unsigned vector = sb600_irq_to_vector(cascade_irq);
>> +       if (vector > 0)
>> +               generic_handle_irq(vector);
>> +       outb(0x20, 0xA0);       /* Non-specific EOI */
>> +       outb(0x20, 0x20);       /* Non-specific EOI to cascade */
>> +       desc->chip->irq_eoi(desc);
>> +}
>> +extern void i8259_unmask_irq(struct irq_data *d);
>> +
>> +__init void sb600_8259_init(void)
>> +{
>> +       int gpio_virq;
>> +
>> +       // Connect legacy i8259 controller in SB600
>> +       printk("Init i8259\n");
>> +       i8259_init(NULL, 0);
>> +
>> +       gpio_virq = irq_create_mapping(NULL, 3);
>> +       irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
>> +       irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>> +       mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>> +
>> +       // Initial mapping for RTC
>> +       irq_create_mapping(NULL, 222);
>> +}
>> +#endif
>> +
>>    static __init void pas_init_IRQ(void)
>>    {
>>        struct device_node *np;
>> @@ -246,6 +307,12 @@ static __init void pas_init_IRQ(void)
>>
>>        of_node_put(mpic_node);
>>        of_node_put(root);
>> +
>> +
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       sb600_8259_init();
>> +#endif
>> +
>>    }
>>
>>    static void __init pas_progress(char *s, unsigned short hex)
>> @@ -403,12 +470,39 @@ static const struct of_device_id pasemi_
>>        {},
>>    };
>>
>> -static int __init pasemi_publish_devices(void)
>> -{
>> -    pasemi_pcmcia_init();
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +
>> +/*
>> + This should come from OF tree. See sysdev/rtc_cmos_setup for details.
>> Need to get i8259 supported correctly first, so that
>> + as the standard support hard-codes IRQ 8.
>> + */
>> +
>> +
>> +static struct resource rtc_resource[] = {{
>> +       .name = "rtc",
>> +       .start = 0x70,
>> +       .end = 0x71,
>> +       .flags = IORESOURCE_IO,
>> +}, {
>> +       .name = "rtc",
>> +       .start = 222,
>> +       .end = 222,
>> +       .flags = IORESOURCE_IRQ,
>> +}};
>> +
>> +#endif
>> +
>> +
>> + static int __init pasemi_publish_devices(void)
>> + {
>> +        pasemi_pcmcia_init();
>> +
>> +        /* Publish OF platform devices for SDC and other non-PCI devices */
>> +        of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
>>
>> -    /* Publish OF platform devices for SDC and other non-PCI devices */
>> -    of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       platform_device_register_simple("rtc_cmos", -1, rtc_resource, 2);
>> +#endif
>>
>>        return 0;
>>    }
>> @@ -430,9 +524,20 @@ static int __init pas_probe(void)
>>
>>        alloc_iobmap_l2();
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       pm_power_off              = pas_shutdown;         // Varisys
>> provided a way to turn us off
>> +#endif
>>        return 1;
>>    }
>>
>> +
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +static int sb600_pci_probe_mode(struct pci_bus *bus)
>> +{
>> +       return PCI_PROBE_DEVTREE;
>> +}
>> +#endif
>> +
>>    define_machine(pasemi) {
>>        .name            = "PA Semi PWRficient",
>>        .probe            = pas_probe,
>> @@ -445,4 +550,7 @@ define_machine(pasemi) {
>>        .calibrate_decr        = generic_calibrate_decr,
>>        .progress        = pas_progress,
>>        .machine_check_exception = pas_machine_check_handler,
>> +#if 0 // def CONFIG_PPC_PASEMI_SB600
>> +       .pci_probe_mode = sb600_pci_probe_mode,
>> +#endif
>>    };
>> diff -rupN linux-4.1/arch/powerpc/sysdev/i8259.c
>> linux-4.1-nemo/arch/powerpc/sysdev/i8259.c
>> --- linux-4.1/arch/powerpc/sysdev/i8259.c    2015-06-22
>> 03:47:02.064778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/sysdev/i8259.c    2015-06-22
>> 03:27:29.631650275 +0200
>> @@ -103,11 +103,11 @@ static void i8259_set_irq_mask(int irq_n
>>        outb(cached_21,0x21);
>>    }
>>
>> -static void i8259_mask_irq(struct irq_data *d)
>> +void i8259_mask_irq(struct irq_data *d)
>>    {
>>        unsigned long flags;
>>
>> -    pr_debug("i8259_mask_irq(%d)\n", d->irq);
>> +    printk("i8259_mask_irq(%d)\n", d->irq);
>>
>>        raw_spin_lock_irqsave(&i8259_lock, flags);
>>        if (d->irq < 8)
>> @@ -118,11 +118,11 @@ static void i8259_mask_irq(struct irq_da
>>        raw_spin_unlock_irqrestore(&i8259_lock, flags);
>>    }
>>
>> -static void i8259_unmask_irq(struct irq_data *d)
>> +void i8259_unmask_irq(struct irq_data *d)
>>    {
>>        unsigned long flags;
>>
>> -    pr_debug("i8259_unmask_irq(%d)\n", d->irq);
>> +    printk("i8259_unmask_irq(%d)\n", d->irq);
>>
>>        raw_spin_lock_irqsave(&i8259_lock, flags);
>>        if (d->irq < 8)
>> @@ -229,6 +229,8 @@ void i8259_init(struct device_node *node
>>        /* initialize the controller */
>>        raw_spin_lock_irqsave(&i8259_lock, flags);
>>
>> +    printk("About to write to i8259\n");
>> +
>>        /* Mask all first */
>>        outb(0xff, 0xA1);
>>        outb(0xff, 0x21);
>> @@ -259,8 +261,12 @@ void i8259_init(struct device_node *node
>>        outb(cached_A1, 0xA1);
>>        outb(cached_21, 0x21);
>>
>> +    printk("Done write to i8259\n");
>> +
>>        raw_spin_unlock_irqrestore(&i8259_lock, flags);
>>
>> +#ifndef CONFIG_PPC_PASEMI_SB600
>> +
>>        /* create a legacy host */
>>        i8259_host = irq_domain_add_legacy_isa(node, &i8259_host_ops, NULL);
>>        if (i8259_host == NULL) {
>> @@ -268,6 +274,8 @@ void i8259_init(struct device_node *node
>>            return;
>>        }
>>
>> +#endif
>> +
>>        /* reserve our resources */
>>        /* XXX should we continue doing that ? it seems to cause problems
>>         * with further requesting of PCI IO resources for that range...
>> diff -rupN linux-4.1/arch/powerpc/sysdev/mpic.c
>> linux-4.1-nemo/arch/powerpc/sysdev/mpic.c
>> --- linux-4.1/arch/powerpc/sysdev/mpic.c    2015-06-22
>> 03:47:02.067778538 +0200
>> +++ linux-4.1-nemo/arch/powerpc/sysdev/mpic.c    2015-06-22
>> 03:27:29.634650287 +0200
>> @@ -661,6 +661,56 @@ static inline void mpic_eoi(struct mpic
>>     * Linux descriptor level callbacks
>>     */
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +
>> +static int sb600_vector_to_irq(unsigned vector)
>> +{
>> +       switch(vector) {
>> +       case 212: return 9;
>> +       case 213: return 10;
>> +       case 214: return 11;
>> +       case 215: return 12;
>> +       case 216: return 3;
>> +       case 217: return 4;
>> +       case 218: return 5;
>> +       case 219: return 6;
>> +       case 220: return 7;
>> +       case 221: return 14;
>> +       case 222: return 8;
>> +       default: return -1;
>> +       }
>> +}
>> +
>> +extern void i8259_mask_irq(struct irq_data *d);
>> +extern void i8259_unmask_irq(struct irq_data *d);
>> +
>> +int sb600_unmask_irq(unsigned irq)
>> +{
>> +       int vector = sb600_vector_to_irq(irq);
>> +       if (vector >= 0) {
>> +               i8259_unmask_irq(irq_get_irq_data(vector));
>> +               return 1;
>> +       } else
>> +               return 0;
>> +}
>> +
>> +int sb600_mask_irq(unsigned irq)
>> +{
>> +       int vector = sb600_vector_to_irq(irq);
>> +       if (vector >= 0) {
>> +               i8259_mask_irq(irq_get_irq_data(vector));
>> +               return 1;
>> +       } else
>> +               return 0;
>> +}
>> +
>> +int sb600_end_irq(unsigned irq)
>> +{
>> +       int vector = sb600_vector_to_irq(irq);
>> +       return (vector >= 0);
>> +}
>> +
>> +#endif
>>
>>    void mpic_unmask_irq(struct irq_data *d)
>>    {
>> @@ -668,7 +718,12 @@ void mpic_unmask_irq(struct irq_data *d)
>>        struct mpic *mpic = mpic_from_irq_data(d);
>>        unsigned int src = irqd_to_hwirq(d);
>>
>> -    DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, d->irq,
>> src);
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       if (sb600_unmask_irq(src))
>> +               return;
>> +#endif
>> +
>> +       DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq,
>> src);
>>
>>        mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
>>                   mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
>> @@ -689,7 +744,12 @@ void mpic_mask_irq(struct irq_data *d)
>>        struct mpic *mpic = mpic_from_irq_data(d);
>>        unsigned int src = irqd_to_hwirq(d);
>>
>> -    DBG("%s: disable_irq: %d (src %d)\n", mpic->name, d->irq, src);
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       if (sb600_mask_irq(src))
>> +               return;
>> +#endif
>> +
>> +       DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
>>
>>        mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
>>                   mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
>> @@ -709,6 +769,14 @@ void mpic_end_irq(struct irq_data *d)
>>    {
>>        struct mpic *mpic = mpic_from_irq_data(d);
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       unsigned int src = irqd_to_hwirq(d);
>> +
>> +       if (src >= 212 && src <= 222)
>> +               return;
>> +#endif
>> +
>> +
>>    #ifdef DEBUG_IRQ
>>        DBG("%s: end_irq: %d\n", mpic->name, d->irq);
>>    #endif
>> diff -rupN linux-4.1/drivers/ata/libata-sff.c
>> linux-4.1-nemo/drivers/ata/libata-sff.c
>> --- linux-4.1/drivers/ata/libata-sff.c    2015-06-22 03:47:03.376778537
>> +0200
>> +++ linux-4.1-nemo/drivers/ata/libata-sff.c    2015-06-22
>> 03:27:29.646650335 +0200
>> @@ -2438,9 +2438,9 @@ int ata_pci_sff_activate_host(struct ata
>>        if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
>>            u8 tmp8, mask;
>>
>> -        /* TODO: What if one channel is in native mode ... */
>> +        /* Don't look at dummy ports in the mask */
>>            pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
>> -        mask = (1 << 2) | (1 << 0);
>> +        mask = (! ata_port_is_dummy(host->ports[1]) << 2) | (!
>> ata_port_is_dummy(host->ports[0]) << 0);
>>            if ((tmp8 & mask) != mask)
>>                legacy_mode = 1;
>>        }
>> diff -rupN linux-4.1/drivers/ata/pata_atiixp.c
>> linux-4.1-nemo/drivers/ata/pata_atiixp.c
>> --- linux-4.1/drivers/ata/pata_atiixp.c    2015-06-22 03:47:03.384778537
>> +0200
>> +++ linux-4.1-nemo/drivers/ata/pata_atiixp.c    2015-06-22
>> 03:27:29.649650347 +0200
>> @@ -278,6 +278,11 @@ static int atiixp_init_one(struct pci_de
>>        };
>>        const struct ata_port_info *ppi[] = { &info, &info };
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       // Second port not wired on SB600, and config bit cannot be set
>> by BIOS
>> +       ppi[1] = &ata_dummy_port_info;
>> +#endif
>> +
>>        return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
>>                          ATA_HOST_PARALLEL_SCAN);
>>    }
>> diff -rupN linux-4.1/drivers/ata/pata_of_platform.c
>> linux-4.1-nemo/drivers/ata/pata_of_platform.c
>> --- linux-4.1/drivers/ata/pata_of_platform.c    2015-06-22
>> 03:47:03.400778537 +0200
>> +++ linux-4.1-nemo/drivers/ata/pata_of_platform.c    2015-06-22
>> 03:27:29.653650363 +0200
>> @@ -41,14 +41,36 @@ static int pata_of_platform_probe(struct
>>            return -EINVAL;
>>        }
>>
>> -    ret = of_address_to_resource(dn, 1, &ctl_res);
>> -    if (ret) {
>> -        dev_err(&ofdev->dev, "can't get CTL address from "
>> -            "device tree\n");
>> -        return -EINVAL;
>> +    if (of_device_is_compatible(dn, "electra-ide")) {
>> +        /* Altstatus is really at offset 0x3f6 from the primary window
>> +         * on electra-ide. Adjust ctl_res and io_res accordingly.
>> +         */
>> +        ctl_res = io_res;
>> +        ctl_res.start = ctl_res.start+0x3f6;
>> +        io_res.end = ctl_res.start-1;
>> +
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       } else if (of_device_is_compatible(dn, "electra-cf")) {
>> +               /* Task regs are at 0x800, with alt status @ 0x80e in
>> the primary window
>> +                * on electra-cf. Adjust ctl_res and io_res accordingly.
>> +                */
>> +               ctl_res = io_res;
>> +               io_res.start += 0x800;
>> +               ctl_res.start = ctl_res.start + 0x80e;
>> +               io_res.end = ctl_res.start-1;
>> +#endif
>> +    } else {
>> +        ret = of_address_to_resource(dn, 1, &ctl_res);
>> +        if (ret) {
>> +            dev_err(&ofdev->dev, "can't get CTL address from "
>> +                "device tree\n");
>> +            return -EINVAL;
>> +        }
>>        }
>>
>>        irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
>> +    if (irq_res)
>> +        irq_res->flags = 0;
>>
>>        prop = of_get_property(dn, "reg-shift", NULL);
>>        if (prop)
>> @@ -65,6 +87,11 @@ static int pata_of_platform_probe(struct
>>            dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
>>        }
>>
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       irq_res = 0;                    // force irq off (doesn't seem
>> to work)
>> +#endif
>> +
>> +
>>        pio_mask = 1 << pio_mode;
>>        pio_mask |= (1 << pio_mode) - 1;
>>
>> @@ -74,7 +101,11 @@ static int pata_of_platform_probe(struct
>>
>>    static struct of_device_id pata_of_platform_match[] = {
>>        { .compatible = "ata-generic", },
>> -    { },
>> +    { .compatible = "electra-ide", },
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       { .compatible = "electra-cf",},
>> +#endif
>> +    {},
>>    };
>>    MODULE_DEVICE_TABLE(of, pata_of_platform_match);
>>
>> diff -rupN linux-4.1/drivers/gpu/drm/radeon/radeon_pm.c
>> linux-4.1-nemo/drivers/gpu/drm/radeon/radeon_pm.c
>> --- linux-4.1/drivers/gpu/drm/radeon/radeon_pm.c    2015-06-22
>> 03:47:04.600778536 +0200
>> +++ linux-4.1-nemo/drivers/gpu/drm/radeon/radeon_pm.c    2015-06-22
>> 03:27:29.675650448 +0200
>> @@ -226,7 +226,10 @@ static void radeon_set_power_state(struc
>>            /* set memory clock */
>>            if (rdev->asic->pm.set_memory_clock && (mclk !=
>> rdev->pm.current_mclk)) {
>>                radeon_pm_debug_check_in_vbl(rdev, false);
>> +               /* D.Stevens 2012 for the A-EON AmigaOne X1000: Setting
>> memory clock only works on CAICOS and 6570, don't set for anything else
>> (We ignore 6570 here */
>> +               if (rdev->family == CHIP_CAICOS) {
>>                radeon_set_memory_clock(rdev, mclk);
>> +               }
>>                radeon_pm_debug_check_in_vbl(rdev, true);
>>                rdev->pm.current_mclk = mclk;
>>                DRM_DEBUG_DRIVER("Setting: m: %d\n", mclk);
>> @@ -1220,7 +1223,7 @@ static void radeon_pm_resume_old(struct
>>                            SET_VOLTAGE_TYPE_ASIC_VDDCI);
>>            if (rdev->pm.default_sclk)
>>                radeon_set_engine_clock(rdev, rdev->pm.default_sclk);
>> -        if (rdev->pm.default_mclk)
>> +        if (rdev->pm.default_mclk && (rdev->family == CHIP_CAICOS))
>> /* Fix for PPC systems HD6000 >6570 by A-EON Core Linux Support Team */
>>                radeon_set_memory_clock(rdev, rdev->pm.default_mclk);
>>        }
>>        /* asic init will reset the default power state */
>> @@ -1271,7 +1274,7 @@ dpm_resume_fail:
>>                            SET_VOLTAGE_TYPE_ASIC_VDDCI);
>>            if (rdev->pm.default_sclk)
>>                radeon_set_engine_clock(rdev, rdev->pm.default_sclk);
>> -        if (rdev->pm.default_mclk)
>> +        if (rdev->pm.default_mclk && (rdev->family == CHIP_CAICOS))
>> /* Fix for PPC & > HD6570 by A-EON Linux Core Support Team */
>>                radeon_set_memory_clock(rdev, rdev->pm.default_mclk);
>>        }
>>    }
>> @@ -1318,7 +1321,7 @@ static int radeon_pm_init_old(struct rad
>>                                SET_VOLTAGE_TYPE_ASIC_VDDCI);
>>                if (rdev->pm.default_sclk)
>>                    radeon_set_engine_clock(rdev, rdev->pm.default_sclk);
>> -            if (rdev->pm.default_mclk)
>> +            if (rdev->pm.default_mclk && (rdev->family ==
>> CHIP_CAICOS))     // D.Stevens 2013: fix for >HD6570 on PPC
>>                    radeon_set_memory_clock(rdev, rdev->pm.default_mclk);
>>            }
>>        }
>> @@ -1431,7 +1434,7 @@ dpm_failed:
>>                            SET_VOLTAGE_TYPE_ASIC_VDDCI);
>>            if (rdev->pm.default_sclk)
>>                radeon_set_engine_clock(rdev, rdev->pm.default_sclk);
>> -        if (rdev->pm.default_mclk)
>> +        if (rdev->pm.default_mclk && (rdev->family == CHIP_CAICOS))  //
>> D.Stevens 2013: Fix for >HD6570 on ppc
>>                radeon_set_memory_clock(rdev, rdev->pm.default_mclk);
>>        }
>>        DRM_ERROR("radeon: dpm initialization failed\n");
>> diff -rupN linux-4.1/drivers/pci/pci.c linux-4.1-nemo/drivers/pci/pci.c
>> --- linux-4.1/drivers/pci/pci.c    2015-06-22 03:47:08.817778536 +0200
>> +++ linux-4.1-nemo/drivers/pci/pci.c    2015-06-22 03:27:29.717650601 +0200
>> @@ -421,7 +421,16 @@ struct resource *pci_find_parent_resourc
>>        pci_bus_for_each_resource(bus, r, i) {
>>            if (!r)
>>                continue;
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +    /* The new code here checks for resources that are not allocated,
>> and no longer
>> +     * returns these, however the SB600 code uses this feature to
>> allocate IO ranges
>> +     * in the ISA map, and this breaks booting on the AmigaOneX1000.
>> +     * Temporary fix to get the kernel working, remove the resource
>> allocated check.
>> +     */
>> +        if (resource_contains(r, res)) {
>> +#else
>>            if (res->start && resource_contains(r, res)) {
>> +#endif
>>
>>                /*
>>                 * If the window is prefetchable but the BAR is
>> diff -rupN linux-4.1/drivers/pci/probe.c linux-4.1-nemo/drivers/pci/probe.c
>> --- linux-4.1/drivers/pci/probe.c    2015-06-22 03:47:08.824778536 +0200
>> +++ linux-4.1-nemo/drivers/pci/probe.c    2015-06-22 03:27:29.720650613
>> +0200
>> @@ -363,7 +363,11 @@ static void pci_read_bridge_io(struct pc
>>            limit |= ((unsigned long) io_limit_hi << 16);
>>        }
>>
>> -    if (base <= limit) {
>> +       if (base <= limit
>> +       #ifdef CONFIG_PPC_PASEMI_SB600
>> +               || child->busn_res.start == 5
>> +       #endif
>> +              ) {
>>            res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) |
>> IORESOURCE_IO;
>>            region.start = base;
>>            region.end = limit + io_granularity - 1;
>> @@ -1609,11 +1613,14 @@ static int only_one_child(struct pci_bus
>>
>>        if (!parent || !pci_is_pcie(parent))
>>            return 0;
>> +       #ifndef CONFIG_PPC_PASEMI_SB600
>> +       // SB600 has non-zero devices on non-root bus.
>>        if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
>>            return 1;
>>        if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM &&
>>            !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>>            return 1;
>> +    #endif
>>        return 0;
>>    }
>>
>> diff -rupN linux-4.1/drivers/rtc/rtc-cmos.c
>> linux-4.1-nemo/drivers/rtc/rtc-cmos.c
>> --- linux-4.1/drivers/rtc/rtc-cmos.c    2015-06-22 03:47:09.156778536 +0200
>> +++ linux-4.1-nemo/drivers/rtc/rtc-cmos.c    2015-06-22
>> 03:27:29.742650701 +0200
>> @@ -242,6 +242,13 @@ static int cmos_read_alarm(struct device
>>        }
>>
>>        rtc_control = CMOS_READ(RTC_CONTROL);
>> +
>> +#ifdef CONFIG_PPC_PASEMI_SB600
>> +       // Nemo BIOS does not init RTC
>> +       rtc_control = rtc_control | RTC_24H;
>> +       CMOS_WRITE(rtc_control, RTC_CONTROL);
>> +#endif
>> +
>>        spin_unlock_irq(&rtc_lock);
>>
>>        if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
>> diff -rupN linux-4.1/sound/pci/hda/patch_sigmatel.c
>> linux-4.1-nemo/sound/pci/hda/patch_sigmatel.c
>> --- linux-4.1/sound/pci/hda/patch_sigmatel.c    2015-06-22
>> 03:47:15.039778536 +0200
>> +++ linux-4.1-nemo/sound/pci/hda/patch_sigmatel.c    2015-06-22
>> 03:27:29.768650804 +0200
>> @@ -166,6 +166,7 @@ enum {
>>        STAC_D965_VERBS,
>>        STAC_DELL_3ST,
>>        STAC_DELL_BIOS,
>> +    STAC_NEMO_DEFAULT,
>>        STAC_DELL_BIOS_AMIC,
>>        STAC_DELL_BIOS_SPDIF,
>>        STAC_927X_DELL_DMIC,
>> @@ -1359,6 +1360,23 @@ static const struct hda_pintbl oqo9200_p
>>        {}
>>    };
>>
>> +static const struct hda_pintbl nemo_pin_configs[] = {
>> +   { 0x0a, 0x02214020 },
>> +   { 0x0b, 0x02A19080 },
>> +   { 0x0c, 0x0181304E },
>> +   { 0x0d, 0x01014010 },
>> +   { 0x0e, 0x01A19040 },
>> +   { 0x0f, 0x01011012 },
>> +   { 0x10, 0x01016011 },
>> +   { 0x11, 0x01012014 },
>> +   { 0x12, 0x103301F0 },
>> +   { 0x13, 0x00000000 },
>> +   { 0x14, 0x00000000 },
>> +   { 0x21, 0x01442170 },
>> +   { 0x22, 0x00000000 },
>> +   { 0x23, 0x00000000 },
>> +   {}
>> +};
>>
>>    static void stac9200_fixup_panasonic(struct hda_codec *codec,
>>                         const struct hda_fixup *fix, int action)
>> @@ -3868,6 +3886,10 @@ static const struct hda_fixup stac927x_f
>>            .type = HDA_FIXUP_PINS,
>>            .v.pins = d965_5st_no_fp_pin_configs,
>>        },
>> +    [STAC_NEMO_DEFAULT] = {
>> +               .type = HDA_FIXUP_PINS,
>> +        .v.pins = nemo_pin_configs,
>> +    },
>>        [STAC_DELL_3ST] = {
>>            .type = HDA_FIXUP_PINS,
>>            .v.pins = dell_3st_pin_configs,
>> @@ -3924,6 +3946,7 @@ static const struct hda_model_fixup stac
>>        { .id = STAC_D965_5ST_NO_FP, .name = "5stack-no-fp" },
>>        { .id = STAC_DELL_3ST, .name = "dell-3stack" },
>>        { .id = STAC_DELL_BIOS, .name = "dell-bios" },
>> +    { .id = STAC_NEMO_DEFAULT, .name = "nemo-default" },
>>        { .id = STAC_DELL_BIOS_AMIC, .name = "dell-bios-amic" },
>>        { .id = STAC_927X_VOLKNOB, .name = "volknob" },
>>        {}
>> @@ -3962,6 +3985,8 @@ static const struct snd_pci_quirk stac92
>>                   "Intel D965", STAC_D965_5ST),
>>        SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_INTEL, 0xff00, 0x2500,
>>                   "Intel D965", STAC_D965_5ST),
>> +    /* Nemo */
>> +    SND_PCI_QUIRK(0x1888, 0x1000, "AmigaOne X1000", STAC_NEMO_DEFAULT),
>>        /* volume-knob fixes */
>>        SND_PCI_QUIRK_VENDOR(0x10cf, "FSC", STAC_927X_VOLKNOB),
>>        {} /* terminator */
>> @@ -5035,6 +5060,7 @@ static const struct hda_codec_preset snd
>>         { .id = 0x83847683, .name = "STAC9221D A2", .patch =
>> patch_stac922x },
>>         { .id = 0x83847618, .name = "STAC9227", .patch = patch_stac927x },
>>         { .id = 0x83847619, .name = "STAC9227", .patch = patch_stac927x },
>> +    { .id = 0x83847638, .name = "STAC92HD700", .patch = patch_stac927x },
>>         { .id = 0x83847616, .name = "STAC9228", .patch = patch_stac927x },
>>         { .id = 0x83847617, .name = "STAC9228", .patch = patch_stac927x },
>>         { .id = 0x83847614, .name = "STAC9229", .patch = patch_stac927x },
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
