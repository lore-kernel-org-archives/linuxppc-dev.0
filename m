Message-Id: <m112VH2-0000WZC@tri-yann.crf.canon.fr>
Date: Fri, 9 Jul 1999 09:40:44 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: mporter@phx.mcd.mot.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.10.9907080916040.21213-100000@fwrsl-11.phx.mcd.mot.com>
	(message from Matt Porter on Thu, 8 Jul 1999 09:25:07 -0700 (MST))
Subject: Re: PREP IDE support is broken
References: <Pine.LNX.4.10.9907080916040.21213-100000@fwrsl-11.phx.mcd.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Matt" == Matt Porter <mporter@phx.mcd.mot.com> writes:

Matt> On Thu, 8 Jul 1999, Eric Vallete wrote:

Matt> Yes, we are using CF IDE disks on an MCP750.  Right now we just have some
Matt> hacks for supporting the edge/level changes and are working on some clean
Matt> code.

I have code that works quite well. Just the way calling it is bad...

Matt> I was just looking yesterday at what is the best way to clean up
Matt> prep_pci.c so that we can have a machine type available elsewhere as you
Matt> mention.  I want to move the machine detection code so it's running
Matt> earlier and just have a function to call for the PReP machine type.
Matt> Ultimately, I'd like to see board-specific items isolated in separate
Matt> files for a more modular architecture.

Thanks a lot. Of course I can send a patch but I've seen so many wasted...

  ----------------------------------- prep pci ----------------------
int mesquite __initdata = 0;
struct pci_dev *via_82c586_pci_isa_bridge;

static unsigned char mcp750_openpic_initsenses[] = {
    1,	/* MCP750_INT_PCB(8259) */
    0,	/* MCP750_INT_FALCON_ECC_ERR */
    1,	/* MCP750_INT_PCI_ETHERNET */
    1,	/* MCP750_INT_PCI_PMC */
    1,	/* MCP750_INT_PCI_WATCHDOG_TIMER1 */
    1,	/* MCP750_INT_PCI_PRST_SIGNAL */
    1,	/* MCP750_INT_PCI_FALL_SIGNAL */
    1,	/* MCP750_INT_PCI_DEG_SIGNAL */
    1,	/* MCP750_INT_PCI_BUS1_INTA */
    1,	/* MCP750_INT_PCI_BUS1_INTB */
    1,	/* MCP750_INT_PCI_BUS1_INTC */
    1,	/* MCP750_INT_PCI_BUS1_INTD */
    1,	/* MCP750_INT_PCI_BUS2_INTA */
    1,	/* MCP750_INT_PCI_BUS2_INTB */
    1,	/* MCP750_INT_PCI_BUS2_INTC */
    1,	/* MCP750_INT_PCI_BUS2_INTD */
};

__initfunc(int raven_init(void))
{
	unsigned int	devid;
	unsigned int	pci_membase;
	unsigned char	base_mod;

	/* Check to see if the Raven chip exists. */
	if ( _prep_type != _PREP_Motorola) {
		OpenPIC = NULL;
		return 0;
	}

	/* Check to see if this board is a type that might have a Raven. */
	if ((inb(MOTOROLA_CPUTYPE_REG) & 0xF0) != 0xE0) {
		OpenPIC = NULL;
		return 0;
	}

	/* Check the first PCI device to see if it is a Raven. */
	pcibios_read_config_dword(0, 0, PCI_VENDOR_ID, &devid);

	switch (devid & 0xffff0000) {
	case MPIC_RAVEN_ID:
		MotMPIC = MOT_RAVEN_PRESENT;
		break;
	case MPIC_HAWK_ID:
		MotMPIC = MOT_HAWK_PRESENT;
		break;
	default:
		OpenPIC = NULL;
		return 0;
	}


	/* Read the memory base register. */
	pcibios_read_config_dword(0, 0, PCI_BASE_ADDRESS_1, &pci_membase);

	if (pci_membase == 0) {
		OpenPIC = NULL;
		return 0;
	}

	/* Map the Raven MPIC registers to virtual memory. */
	OpenPIC = (struct OpenPIC *)ioremap(pci_membase+0xC0000000, 0x22000);

	if (mesquite) {
	  OpenPIC_InitSenses = mcp750_openpic_initsenses;
	  OpenPIC_NumInitSenses = sizeof(mcp750_openpic_initsenses);
	}
	else {
	  OpenPIC_InitSenses = mvme2600_openpic_initsenses;
	  OpenPIC_NumInitSenses = sizeof(mvme2600_openpic_initsenses);
	}

	ppc_md.do_IRQ = chrp_do_IRQ;
	
	/* If raven is present on Motorola store the system config register
	 * for later use.
	 */
	ProcInfo = (unsigned long *)ioremap(0xfef80400, 4);

	/* This is a hack.  If this is a 2300 or 2400 mot board then there is
	 * no keyboard controller and we have to indicate that.
	 */
	base_mod = inb(MOTOROLA_BASETYPE_REG);
	if ((MotMPIC == MOT_HAWK_PRESENT) || (base_mod == 0xF9) ||
	    (base_mod == 0xFA) || (base_mod == 0xE1))
		prep_keybd_present = 0;

	if (mesquite) {
	  struct pci_dev *dev;
	  unsigned int temp;
	  unsigned char tmp;
	  
	  for(dev=pci_devices; dev; dev=dev->next) {
	    pcibios_read_config_dword(dev->bus->number, dev->devfn, PCI_VENDOR_ID, &temp);
	     if ( (temp == (((unsigned short) PCI_VENDOR_ID_VIA) | (PCI_DEVICE_ID_VIA_82C586_1 << 16)))
		  ||
		  (temp == (((unsigned short) PCI_VENDOR_ID_VIA) | (PCI_DEVICE_ID_VIA_82C586_0 << 16)))
		  ) {
	       via_82c586_pci_isa_bridge = dev;
	       break;
	     }
	  }
	  tmp = inb(0x810);
	  if  ( !(tmp & 0x2)) {
	    printk("This is a second generation MCP750 board\n");
	    printk("We must reprogram the PCI/ISA bridge...\n");
	    pcibios_read_config_byte(via_82c586_pci_isa_bridge->bus->number,
				     via_82c586_pci_isa_bridge->devfn,
				     0x47,  &tmp);
	    printk(" PCI ISA bridge control2 = %x\n", (unsigned) tmp);
	    /*
	     * Enable 4D0/4D1 ISA interrupt level/edge config registers
	     */
	    tmp |= 0x20;
	    pcibios_write_config_byte(via_82c586_pci_isa_bridge->bus->number,
				     via_82c586_pci_isa_bridge->devfn,
				     0x47,  tmp);
	    /*
	     * Now program the ISA interrupt edge/level
	     */
	    tmp = ELCRS_INT9_LVL | ELCRS_INT10_LVL | ELCRS_INT11_LVL;
	    outb(tmp, ISA8259_S_ELCR);
	    tmp = ELCRM_INT5_LVL;
	    outb(tmp, ISA8259_M_ELCR);;
	    /*
	     * Set the Interrupt inputs to non-inverting level interrupt
	     */
	    pcibios_read_config_byte(via_82c586_pci_isa_bridge->bus->number,
				     via_82c586_pci_isa_bridge->devfn,
				     0x54, &tmp);
	    printk(" PCI ISA bridge PCI/IRQ Edge/Level Select = %x\n", (unsigned) tmp);
	    tmp = 0;
	    pcibios_write_config_byte(via_82c586_pci_isa_bridge->bus->number,
				     via_82c586_pci_isa_bridge->devfn,
				     0x54, tmp);
	  }

	}
	return 1;
}
  -------------------------------------------------------------------
-- eric

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
