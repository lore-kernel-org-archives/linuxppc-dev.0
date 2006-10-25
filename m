Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6A7B67BB7
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 15:22:49 +1000 (EST)
Subject: MPC7448_HPC2 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 15:20:05 +1000
Message-Id: <1161753605.22582.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any reason why that:

void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
{
	struct pci_controller *hose;
	struct device_node *node;
	const unsigned int *interrupt;
	int busnr;
	int len;
	u8 slot;
	u8 pin;

	/* Lookup the hose */
	busnr = dev->bus->number;
	hose = pci_bus_to_hose(busnr);
	if (!hose)
		printk(KERN_ERR "No pci hose found\n");

	/* Check it has an OF node associated */
	node = (struct device_node *) hose->arch_data;
	if (!node)
		printk(KERN_ERR "No pci node found\n");

	interrupt = get_property(node, "interrupt-map", &len);
	slot = find_slot_by_devfn(interrupt, dev->devfn);
	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
	if (pin == 0 || pin > 4)
		pin = 1;
	pin--;
	dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
	DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
}

Cannot be replaced by:

	pci_read_irq_line(dev);

I'm about to make pci_read_irq_line() called by default by the PCI
code (with a new ppc_md.pci_irq_fixup for platforms that really need
something else done) and so while "fixing" all platforms, I stumbled
accross the code above which is a bit shocking :)

Cheers,

Ben.
