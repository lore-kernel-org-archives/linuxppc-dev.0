Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B85E567AC6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:12:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k4I8S5nH026327
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:28:05 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4I7CQvD008338
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:12:27 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 15:12:24 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm not repeating Kumar's comments about that CONFIG_7xxx 
> thing and that
> 7xxx/ directory, it should all go.
> 

Should I move my code to embedded6xx?

> Some more bits:
> 
> > +static u_char mpc7448_hpc2_pic_initsenses[] __initdata = {
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 
> INT[0] XINT0 from FPGA */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 
> INT[1] XINT1 from FPGA */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 
> INT[2] PHY_INT from both GIGE */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 
> INT[3] RESERVED */
> > +};
> > +
> > +/*
> > + * mpc7448hpc2 PCI interrupt routing. all PCI interrupt comes from
> > + * external PCI source at 23. need to program pci 
> interrupt control registers
> > + * to route per slot IRQs.
> > + */
> > +
> > +static inline int
> > +mpc7448_hpc2_map_irq(struct pci_dev *dev, unsigned char idsel,
> > +		     unsigned char pin)
> > +{
> > +	static char pci_irq_table[][4] =
> > +	    /*
> > +	     *      PCI IDSEL/INTPIN->INTLINE
> > +	     *         A     B     C     D
> > +	     */
> > +	{
> > +		{IRQ_PCI_INTA, IRQ_PCI_INTB, IRQ_PCI_INTC, 
> IRQ_PCI_INTD},	/* A SLOT 1 IDSEL 17 */
> > +		{IRQ_PCI_INTB, IRQ_PCI_INTC, IRQ_PCI_INTD, 
> IRQ_PCI_INTA},	/* B SLOT 2 IDSEL 18 */
> > +		{IRQ_PCI_INTC, IRQ_PCI_INTD, IRQ_PCI_INTA, 
> IRQ_PCI_INTB},	/* C SATA IDSEL 19 */
> > +		{IRQ_PCI_INTD, IRQ_PCI_INTA, IRQ_PCI_INTB, 
> IRQ_PCI_INTC},	/* D USB IDSEL 20 */
> > +	};
> > +
> > +	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
> > +	return PCI_IRQ_TABLE_LOOKUP;
> > +}
> 
> This whole irq map stuff is excactly what the device-tree is 
> there for .
> Please implement proper interrupt maps in the device-tree and 
> get rid of
> those tables.

I will get rid of those tables.  I can see that in file
 arch/powerpc/platforms/85xx/mpc85xx_ads.c (2.6.17-rc4), there is
a similar table. Should it be removed in future :)?

> 
> > +static void __init mpc7448_hpc2_map_io(void)
> > +{
> > +	/* PCI IO  mapping */
> > +	io_block_mapping(MPC7448_HPC2_PCI_IO_BASE_VIRT,
> > +			 MPC7448_HPC2_PCI_IO_BASE_PHYS, 
> 0x00800000, _PAGE_IO);
> > +	/* Tsi108 CSR mapping */
> > +	io_block_mapping(TSI108_CSR_ADDR_VIRT, TSI108_CSR_ADDR_PHYS,
> > +			 0x100000, _PAGE_IO);
> > +
> > +	/* PCI Config mapping */
> > +	io_block_mapping(MPC7448_HPC2_PCI_CFG_BASE_VIRT,
> > +			 MPC7448_HPC2_PCI_CFG_BASE_PHYS,
> > +			 MPC7448_HPC2_PCI_CFG_SIZE, _PAGE_IO);
> > +
> > +	tsi108_pci_cfg_base = MPC7448_HPC2_PCI_CFG_BASE_VIRT;
> > +	/* NVRAM mapping */
> > +	io_block_mapping(MPC7448_HPC2_NVRAM_BASE_ADDR,
> > +			 MPC7448_HPC2_NVRAM_BASE_ADDR, 
> MPC7448_HPC2_NVRAM_SIZE,
> > +			 _PAGE_IO);
> > +}
> 
> io_block_mapping is bad ! see endless discussions in the archives of
> why ... Use ioremap.

OK!

> 
> > +static int __init mpc7448_hpc2_probe(void)
> > +{
> > +	/* We always match for now, eventually we should look 
> at the flat
> > +	   dev tree to ensure this is the board we are suppose to run on
> > +	 */
> > +	return 1;
> > +}
> 
> Yes, please do so, we will not accept a board that does the above :)

I just do the same thing as 85xx :).

> 
> > +extern int tsi108_direct_write_config(struct pci_bus *bus, 
> unsigned int devfn,
> > +				      int offset, int len, u32 val);
> > +extern int tsi108_direct_read_config(struct pci_bus *bus, 
> unsigned int devfn,
> > +				     int offset, int len, u32 * val);
> >
> > +void tsi108_clear_pci_error(u32 pci_cfg_base);
> > +
> > +extern int
> > +tsi108_read_config(int bus, unsigned int devfn, int 
> offset, int len, u32 * val);
> > +#ifdef CONFIG_PCI
> > +static struct pci_ops direct_pci_ops = {
> > +	tsi108_direct_read_config,
> > +	tsi108_direct_write_config
> > +};
> 
> That sounds bogus. You should instead have a tsi108_pci.c file that
> contains all of the functions _and_ the pci_ops structure 
> (with a better
> name please) and exports some kind of setup_tsi108_pci(device_node *).
> 

OK!

> > +void tsi108_clear_pci_cfg_error(void)
> > +{
> > +	tsi108_clear_pci_error(MPC7448_HPC2_PCI_CFG_BASE_PHYS);
> > +}
> > +
> > +int __init add_bridge(struct device_node *dev)
> > +{
> > +	int len;
> > +	struct pci_controller *hose;
> > +	struct resource rsrc;
> > +	int *bus_range;
> > +	int primary = 0, has_address = 0;
> > +
> > +	DBG("TSI_PCI: %s tsi108_pci_cfg_base=0x%x\n", __FUNCTION__,
> > +	    tsi108_pci_cfg_base);
> > +
> > +	/* Fetch host bridge registers address */
> > +	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
> > +
> > +	/* Get bus range if any */
> > +	bus_range = (int *)get_property(dev, "bus-range", &len);
> > +	if (bus_range == NULL || len < 2 * sizeof(int)) {
> > +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> > +		       " bus 0\n", dev->full_name);
> > +	}
> > +
> > +	hose = pcibios_alloc_controller();
> > +
> > +	if (!hose) {
> > +		printk("PCI Host bridge init failed\n");
> > +		return -ENOMEM;
> > +	}
> > +	hose->arch_data = dev;
> > +	hose->set_cfg_type = 1;
> > +
> > +	hose->first_busno = bus_range ? bus_range[0] : 0;
> > +	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> > +
> > +	(hose)->ops = &direct_pci_ops;
> > +
> > +	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08lx. "
> > +	       "Firmware bus number: %d->%d\n",
> > +	       rsrc.start, hose->first_busno, hose->last_busno);
> > +
> > +	/* Interpret the "ranges" property */
> > +	/* This also maps the I/O region and sets isa_io/mem_base */
> > +	pci_process_bridge_OF_ranges(hose, dev, primary);
> > +	return 0;
> > +
> > +}
> 
> We need a generic add_bridge that goes through PCI bridges and
> instanciate based on their type as provided by the device-tree. You
> should try to work in that direction...
OK!

 
 
