Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1045A67B54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 05:52:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Converting to new IRQ code
Date: Mon, 28 Aug 2006 14:40:27 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DF1E@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.


Can anybody help me convert the following IRQ demux code to the new IRQ
setup?
I tried just changing irq_desc[irq].handler to irq_desc_[irq].chip, but
then it dumps in _do_IRQ()

This is on a MPC8280 with an ecternal (in FPGA) PCI IRQ mux


static volatile unsigned short * pci_status_reg;
static volatile unsigned short * pci_mask_reg;

static inline int
innsys_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char
pin)
{
    //struct pci_controller *hose =3D pci_bus_to_hose(dev->bus->number);
    //int temp;
    if (!dev->bus->number)  // PCI bus 0
    {
	    static char pci_irq_table[][4] =3D
	    /*
	     *	PCI IDSEL/INTPIN->INTLINE
	     * 	  A      B      C      D
	     */
	    {
		    { PIRQ0, PIRQ0, PIRQ0, PIRQ0 },	/* IDSEL 16 -
CPU2 */
		    { PIRQ5, PIRQ5, PIRQ5, PIRQ5 },	/* IDSEL 17 -
IDE controller */
		    { PIRQ1, PIRQ2, PIRQ3, PIRQ4 },	/* IDSEL 18 -
Bridge */
	    };

	    const long min_idsel =3D 0x10, max_idsel =3D 0x12, irqs_per_slot
=3D 4;
        //temp =3D PCI_IRQ_TABLE_LOOKUP;
        //printk("<1>0: PCI map IRQ for bus %d, device %d; IDsel =3D %d,
pin %d, irq =3D %d\n",
        //        dev->bus->number, dev->bus->device, idsel, pin, temp);
	    return PCI_IRQ_TABLE_LOOKUP;
        //return temp;
    }
    else  // PCI bus 1
    {
	    static char pci_irq_table[][4] =3D
	    /*
	     *	PCI IDSEL/INTPIN->INTLINE
	     * 	  A      B      C      D
	     */
	    {
		    { PIRQ1, PIRQ2, PIRQ3, PIRQ4 },	/* IDSEL 16 -
DSP 0 */
		    { PIRQ2, PIRQ2, PIRQ2, PIRQ2 },	/* IDSEL 17 -
DSP 1 */
		    { PIRQ3, PIRQ3, PIRQ3, PIRQ3 },	/* IDSEL 18 -
DSP 2 */
		    { PIRQ4, PIRQ4, PIRQ4, PIRQ4 },	/* IDSEL 19 -
DSP 2 */
	    };

	    const long min_idsel =3D 18, max_idsel =3D 18, irqs_per_slot =3D
4;
	    return PCI_IRQ_TABLE_LOOKUP;  =20
        //temp =3D PCI_IRQ_TABLE_LOOKUP;
        //printk("<1>1: PCI map IRQ for bus %d, device %d; IDsel =3D %d,
pin %d, irq =3D %d\n",
        //        dev->bus->number, dev->bus->device, idsel, pin, temp);
	    //return PCI_IRQ_TABLE_LOOKUP;
        //return temp;

    }
}

static void
innsys_mask_irq(unsigned int irq)
{
	int bit =3D irq - PCI_INT_OFFSET;
    // 0 is masked, 1 is enabled
	//*(volatile unsigned short *) PCI_INT_MASK_REG &=3D  ~(1 << bit);
	*pci_mask_reg &=3D  ~(1 << bit);
	return;
}

static void
innsys_unmask_irq(unsigned int irq)
{
	int bit =3D irq - PCI_INT_OFFSET;

	//*(volatile unsigned short *) PCI_INT_MASK_REG |=3D (1 << bit);
	*pci_mask_reg |=3D (1 << bit);
	return;
}

static void
innsys_mask_and_ack(unsigned int irq)
{
	int bit =3D irq - PCI_INT_OFFSET;

	//*(volatile unsigned short *) PCI_INT_MASK_REG &=3D  ~(1 << bit);
	*pci_mask_reg &=3D  ~(1 << bit);
    //__asm("sync");
	return;
}

static void
innsys_end_irq(unsigned int irq)
{
	int bit =3D irq - PCI_INT_OFFSET;

	//*(volatile unsigned short *) PCI_INT_MASK_REG |=3D (1 << bit);
	*pci_mask_reg |=3D (1 << bit);
	return;
}

struct hw_interrupt_type innsys_ic =3D {
	" AP2PCI   ",
	NULL,
	NULL,
	innsys_unmask_irq,
	innsys_mask_irq,
	innsys_mask_and_ack,
	innsys_end_irq,
	0
};

static irqreturn_t
pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
{
	unsigned short stat, mask, pend;
	int bit;

	for(;;) {
		//stat =3D *(volatile unsigned short *) PCI_INT_STAT_REG;
		//mask =3D *(volatile unsigned short *) PCI_INT_MASK_REG;
		stat =3D *pci_status_reg;
		mask =3D *pci_mask_reg;
	=09
		pend =3D stat & mask & 0x3f;
        //printk("<1>\tInt status =3D 0x%04x, mask =3D 0x%04x, pend =3D
0x%04x\n", stat, mask, pend);=09
		if (!pend)
			break;
		for (bit =3D 0; pend !=3D 0; ++bit, pend >>=3D 1) {
			if (pend & 1)
            {
                //printk("<1> dispatch int %d\n", PCI_INT_OFFSET + bit);
				//ppc_irq_dispatch_handler(regs,
PCI_INT_OFFSET + bit);
				__do_IRQ((PCI_INT_OFFSET + bit), regs);
            }
		}
	}
	return IRQ_HANDLED;
}


static struct irqaction innsys_pci_action =3D {
    .handler=3D pci_irq_demux,
    .flags          =3D SA_INTERRUPT,
    .mask           =3D CPU_MASK_NONE,
    .name           =3D "PCI IRQ demux",
};

void
innsys_init_irq(void)
{
	int irq;
	void * tmp;
	volatile cpm2_map_t *immap =3D cpm2_immr;
	uint32_t fpga_base;
	tmp =3D innsys_map_irq;

    // map mask and status registers
    fpga_base =3D immap->im_memctl.memc_br5 & 0xffff8000;
    pci_status_reg =3D (unsigned short *)(fpga_base + PCI_INT_STAT_REG);
    pci_mask_reg =3D (unsigned short *)(fpga_base + PCI_INT_MASK_REG);
=09
	for (irq =3D PCI_INT_OFFSET; irq < PCI_INT_OFFSET + NUM_PCI_INTS;
irq++)
                irq_desc[irq].handler =3D &innsys_ic;

	/* make IRQ7 level sensitive */
	((volatile cpm2_map_t *) CPM_MAP_ADDR)->im_intctl.ic_siexr &=3D
		~(1 << (14 - (SIU_INT_IRQ7 - SIU_INT_IRQ1)));
=09
	/* mask all PCI interrupts */
	//*(volatile unsigned short *) PCI_INT_MASK_REG =3D 0;
	*pci_mask_reg =3D 0;

	/* install the demultiplexer for the PCI cascade interrupt */

    setup_irq(SIU_INT_IRQ7, &innsys_pci_action);
	return;
}
