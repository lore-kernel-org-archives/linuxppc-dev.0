Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id 2CBA0DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 21:52:10 +1000 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id A4D5DCFB39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 16:55:51 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 7D8FACFB2Dfor
	<linuxppc-embedded@ozlabs.org>; Wed, 20 Jun 2007 16:55:51 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id l5KBVsi2012266for
	<linuxppc-embedded@ozlabs.org>; Wed, 20 Jun 2007 17:01:54 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-embedded@ozlabs.org
Subject: PCI Host Controller Structure Init Linux kernel 2.6
Date: Wed, 20 Jun 2007 18:01:54 +0630
Message-Id: <20070620113134.M4307@cdotd.ernet.in>
In-Reply-To: <20070620092822.M62113@cdotd.ernet.in>
References: <20070620092822.M62113@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I have certain doubts regarding initialization of PCI host controller in a MPC8560 based
custom board. The board has three 32bit PCI devices attached to MPC8560 PCI/X interface
and all of them are on same PCI bus. Moreover all the three devices do not understand
PCI I/O transactions(as per device datasheets). Each device has its own PCI memory range
and and are non-contigous in MPC8560 local memory address map . PCI memory is 1:1 mapped
to Local memory address range of MPC8560.

Consider the linux kernel 2.6 source code . The board specific function
mpc8560custom_setup_arch()  defined in "arch/ppc/platforms/85xx/mpc8560_custom.c" is
called during initialization as described below

static void __init
mpc8560custom_setup_arch(void)
{
...
...
...
#ifdef CONFIG_PCI
        /* setup PCI host bridges */
        mpc85xx_setup_hose();
#endif
...
...
...
...
}

The mpc8560custom_setup_arch(void) then calls mpc85xx_setup_hose() for setting up a PCI
Host Controller for MPC8560 PCI/X interface as described in file
"arch/ppc/syslib/ppc85xx_setup.c"

void __init
mpc85xx_setup_hose(void)
{
struct pci_controller *hose_a;
...
...
bd_t *binfo = (bd_t *) __res;

hose_a = pcibios_alloc_controller();

        if (!hose_a)
                return;

        ppc_md.pci_swizzle = common_swizzle;
        ppc_md.pci_map_irq = mpc85xx_map_irq;

        hose_a->first_busno = 0;
        hose_a->bus_offset = 0;
        hose_a->last_busno = 0xff;

        setup_indirect_pci(hose_a, binfo->bi_immr_base + PCI1_CFG_ADDR_OFFSET,
                           binfo->bi_immr_base + PCI1_CFG_DATA_OFFSET);
        hose_a->set_cfg_type = 1;

        mpc85xx_setup_pci1(hose_a);

        hose_a->pci_mem_offset = MPC85XX_PCI1_MEM_OFFSET;
        hose_a->mem_space.start = MPC85XX_PCI1_LOWER_MEM;
        hose_a->mem_space.end = MPC85XX_PCI1_UPPER_MEM;

        hose_a->io_space.start = MPC85XX_PCI1_LOWER_IO;
        hose_a->io_space.end = MPC85XX_PCI1_UPPER_IO;
        hose_a->io_base_phys = MPC85XX_PCI1_IO_BASE;
#ifdef CONFIG_85xx_PCI2
        isa_io_base =
                (unsigned long) ioremap(MPC85XX_PCI1_IO_BASE,
                                        MPC85XX_PCI1_IO_SIZE +
                                        MPC85XX_PCI2_IO_SIZE);
#else
        isa_io_base =
                (unsigned long) ioremap(MPC85XX_PCI1_IO_BASE,
                                        MPC85XX_PCI1_IO_SIZE);
#endif
        hose_a->io_base_virt = (void *) isa_io_base;

        /* setup resources */
        pci_init_resource(&hose_a->mem_resources[0],
                        MPC85XX_PCI1_LOWER_MEM,
                        MPC85XX_PCI1_UPPER_MEM,
                        IORESOURCE_MEM, "PCI1 host bridge");

        pci_init_resource(&hose_a->io_resource,
                        MPC85XX_PCI1_LOWER_IO,
                        MPC85XX_PCI1_UPPER_IO,
                        IORESOURCE_IO, "PCI1 host bridge");

        ppc_md.pci_exclude_device = mpc85xx_exclude_device;
...
...
...
...
}

The mpc85xx_setup_pci1(hose_a) function set up the outbound and inbound transaltion
windows as described below . I customized the function for supporting 3 PCI devices each
having one outbound and inbound window.

mpc85xx_setup_pci1(hose_a)
{
...
...
...
  /* Setup Phys:PCI 1:1 outbound mem window @ MPC85XX_PCI1_DEV1_LOWER_MEM */
        pci->potar1 = (MPC85XX_PCI1_DEVICE1_LOWER_MEM >> 12) & 0x000fffff;
        pci->potear1 = 0x00000000;
        pci->powbar1 = (MPC85XX_PCI1_56900_DEVICE1_MEM >> 12) & 0x000fffff;
        /* Enable, Mem R/W */
        pci->powar1 = 0x80044000 |
           (__ilog2(MPC85XX_PCI1_56900_DEVICE1_MEM - MPC85XX_PCI1_DEVICE1_LOWER_MEM + 1)
- 1);
and

        /* Setup Phys:PCI 1:1 inbound mem window @ MPC85XX_PCI1_DEVICE1_LOWER_MEM */
        pci->pitar1 = (MPC85XX_PCI1_DEVICE1_LOWER_MEM >> 12) & 0x000fffff;
        pci->pitear1 = 0x00000000;
        pci->piwbar1 = (MPC85XX_PCI1_DEVICE1_LOWER_MEM >> 12) & 0x000fffff;
        pci->piwar1 = 0xa0f5501e;       /* Enable, Prefetch, Local
                                           Mem, Snoop R/W, 2G */
...
...
...
}

I have following doubts for customizing this code for my custom board requirements

(1) As none of the devices understand PCI I/O transactions (as per device datasheets)
what need to be filled in hose_a->io_space.start, hose_a->io_space.end
,hose_a->io_base_phys variables in function mpc85xx_setup_hose(void)

(2) As the board has 3 devices with following MPC8560 local memory map locations
DEVICE1 80000000 to 800FFFFF
DEVICE2 90000000 to 900FFFFF
Other non PCI devices 
DEVICE3 B0000000 to BFFFFFFF

These memory locations are to be 1:1 memory mapped in PCI address space as
MPC85XX_PCI1_MEM_OFFSET is 00000000. Now my doublt is how to give this information in
following section of code

hose_a->pci_mem_offset = MPC85XX_PCI1_MEM_OFFSET;
hose_a->mem_space.start = MPC85XX_PCI1_LOWER_MEM;
hose_a->mem_space.end = MPC85XX_PCI1_UPPER_MEM;

As hose_a->mem_space.start and hose_a->mem_space.end are single variables how the all
devices info can be given (we need three elements)? Or we need to give this info as
following

/* setup resources */
   pci_init_resource(&hose_a->mem_resources[0],
                        MPC85XX_PCI1_DEV1_LOWER_MEM,
                        MPC85XX_PCI1_DEV1 UPPER_MEM,
                        IORESOURCE_MEM, "PCI1 host bridge Device 1");
   pci_init_resource(&hose_a->mem_resources[0],
                        MPC85XX_PCI1_DEV2_LOWER_MEM,
                        MPC85XX_PCI1_DEV2 UPPER_MEM,
                        IORESOURCE_MEM, "PCI1 host bridge Device 2");
   pci_init_resource(&hose_a->mem_resources[0],
                        MPC85XX_PCI1_DEV3_LOWER_MEM,
                        MPC85XX_PCI1_DEV3 UPPER_MEM,
                        IORESOURCE_MEM, "PCI1 host bridge Device 3");

(3) As no PCI I/O transaction are required with PCI device what needs to be filled in

pci_init_resource(&hose_a->io_resource,
                  MPC85XX_PCI1_LOWER_IO,
                  MPC85XX_PCI1_UPPER_IO,
                  IORESOURCE_IO, "PCI1 host bridge");
hose_a->io_resource?

(4) In case I had 4 or 5 PCI or more  devices where and what initialization I would have
done. Am I doing the customization at the right place?

I shall be gratful if anyone can tell be PCI setup required for above board
configuration and help me in understanding PCI init in Linux Kernel 2.6

Thanks in advance,

with warm regards,

Deepak Gaur
------- End of Forwarded Message -------


Deepak Gaur
