Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 54E0467C0C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 15:31:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9P5VCpZ022069
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 22:31:12 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9P5VALT017887
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 00:31:11 -0500 (CDT)
Subject: Re: MPC7448_HPC2 question
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1161753605.22582.42.camel@localhost.localdomain>
References: <1161753605.22582.42.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1161754306.31407.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Oct 2006 13:31:46 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 13:20, Benjamin Herrenschmidt wrote:
> Any reason why that:
> 
> void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
> {
>         struct pci_controller *hose;
>         struct device_node *node;
>         const unsigned int *interrupt;
>         int busnr;
>         int len;
>         u8 slot;
>         u8 pin;
> 
>         /* Lookup the hose */
>         busnr = dev->bus->number;
>         hose = pci_bus_to_hose(busnr);
>         if (!hose)
>                 printk(KERN_ERR "No pci hose found\n");
> 
>         /* Check it has an OF node associated */
>         node = (struct device_node *) hose->arch_data;
>         if (!node)
>                 printk(KERN_ERR "No pci node found\n");
> 
>         interrupt = get_property(node, "interrupt-map", &len);
>         slot = find_slot_by_devfn(interrupt, dev->devfn);
>         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>         if (pin == 0 || pin > 4)
>                 pin = 1;
>         pin--;
>         dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
>         DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
> }
> 
> Cannot be replaced by:
> 
>         pci_read_irq_line(dev);
> 
> I'm about to make pci_read_irq_line() called by default by the PCI
> code (with a new ppc_md.pci_irq_fixup for platforms that really need
> something else done) and so while "fixing" all platforms, I stumbled
> accross the code above which is a bit shocking :)
> 
> Cheers,
> 
> Ben.
> 
> 
> 

Ben, 
	Last week, I had tried to do the replacement. While, it did not work. I
had though some update of pci_read_irq_line() should be needed.
	Any way, I will investigate it and give the patch ASAP :-).

Roy
