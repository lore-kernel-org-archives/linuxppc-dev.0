Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99FD5DE08E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:45:25 +1000 (EST)
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:45:15 +1000
Message-Id: <1180997115.31677.85.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 23:00 +1000, Michael Ellerman wrote:
> This patch adds support for the setup and decoding of MSIs
> on Axon-based Cell systems.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> This still needs a bit of cleanup, but sending now for an early review.
> 
>  arch/powerpc/platforms/cell/Makefile   |    2 +
>  arch/powerpc/platforms/cell/axon_msi.c |  412 ++++++++++++++++++++++++++++++++
>  2 files changed, 414 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
> index 869af89..6615d40 100644
> --- a/arch/powerpc/platforms/cell/Makefile
> +++ b/arch/powerpc/platforms/cell/Makefile
> @@ -23,3 +23,5 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
>  					   $(spu-priv1-y) \
>  					   $(spu-manage-y) \
>  					   spufs/
> +
> +obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> new file mode 100644
> index 0000000..2709853
> --- /dev/null
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -0,0 +1,412 @@
> +/*
> + * Copyright 2007, Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/msi.h>
> +#include <linux/reboot.h>
> +
> +#include <asm/dcr.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +
> +
> +/*
> + * MSIC Control Register
> + */
> +#define MSIC_CTRL_REG_ADDR	0x6F
> +
> +/* Flags */
> +#define MSIC_ENABLE		0x0001	/* Bit 31 */
> +#define MSIC_FIFO_FULL_ENABLE	0x0002	/* Bit 30 */
> +#define MSIC_IRQ_ENABLE		0x0008	/* Bit 28 */
> +#define MSIC_FULL_STOP_ENABLE	0x0010	/* Bit 27 */
> +
> +/* Size configuration constants */
> +#define MSIC_SIZE_MASK		0x0180	/* Bits 22:23 */
> +#define MSIC_SIZE_SHIFT		(7)
> +#define	MSIC_SIZE_32K		0x0
> +#define	MSIC_SIZE_64K		0x1
> +#define	MSIC_SIZE_128K		0x2
> +#define	MSIC_SIZE_256K		0x3
> +
> +/* The size we're actually using */
> +#define MSIC_FIFO_SIZE		MSIC_SIZE_32K
> +
> +/* Different representations of the fifo size */
> +#define MSIC_FIFO_SHIFT		(MSIC_FIFO_SIZE + 0xF)
> +#define MSIC_FIFO_BYTES		(1 << MSIC_FIFO_SHIFT)
> +#define MSIC_FIFO_MASK		(MSIC_FIFO_BYTES - 1)
> +#define MSIC_FIFO_ORDER		max(MSIC_FIFO_SHIFT - PAGE_SHIFT, 0)
> +
> +/*
> + * MSIC Base Address registers (FIFO location)
> + */
> +#define MSIC_BASE_ADDR_HI_REG	0x72
> +#define MSIC_BASE_ADDR_LO_REG	0x73
> +
> +#define MSIC_READ_OFFSET_REG	0x74
> +#define MSIC_WRITE_OFFSET_REG	0x75
> +
> +#define MSIC_DCR_BASE		MSIC_CTRL_REG_ADDR
> +#define MSIC_DCR_SIZE		(MSIC_WRITE_OFFSET_REG - MSIC_CTRL_REG_ADDR)
> +
> +
> +struct axon_msic {
> +	struct device_node *dn;
> +	struct irq_host *irq_host;
> +	void *fifo;
> +	dcr_host_t dcr_host;
> +	struct list_head list;
> +	u32 read_offset;
> +};
> +
> +
> +static LIST_HEAD(axon_msic_list);
> +
> +static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct axon_msic *msic = get_irq_data(irq);
> +	u32 write_offset, msi;
> +	unsigned int cirq;
> +
> +	write_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
> +	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
> +
> +	/* write_offset doesn't wrap properly, so we have to mask it */
> +	write_offset &= MSIC_FIFO_MASK;
> +
> +	while (msic->read_offset != write_offset) {
> +		msi  = le32_to_cpup((__le32*)(msic->fifo + msic->read_offset));
> +		msi &= 0xFFFF;
> +
> +		pr_debug("axon_msi: woff %x roff %x @ %p msi %x msi@0 %x\n",
> +			write_offset, msic->read_offset,
> +			msic->fifo + msic->read_offset, msi, *(u32*)msic->fifo);
> +
> +		msic->read_offset += 0x10;
> +		msic->read_offset &= MSIC_FIFO_MASK;
> +
> +		cirq = irq_linear_revmap(msic->irq_host, msi);
> +		if (cirq != NO_IRQ)
> +			generic_handle_irq(cirq);
> +		else
> +			pr_debug("axon_msi: mapped to NO_IRQ!\n");
> +	}
> +
> +	dcr_write(msic->dcr_host, MSIC_READ_OFFSET_REG, msic->read_offset);
> +
> +	desc->chip->eoi(irq);
> +}
> +
> +static struct axon_msic *find_msi_translator(struct pci_dev *dev)
> +{
> +	struct irq_host *irq_host;
> +	struct device_node *np, *tmp;
> +	const phandle *ph;
> +
> +	np = pci_device_to_OF_node(dev);
> +	if (!np) {
> +		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
> +		return NULL;
> +	}
> +
> +	for (; np; tmp = of_get_parent(np), of_node_put(np), np = tmp) {
> +		ph = of_get_property(np, "msi-translator", NULL);
> +		if (ph)
> +			break;
> +	}
> +
> +	if (!ph) {
> +		dev_dbg(&dev->dev, "axon_msi: no msi-translator found\n");
> +		goto out_error;
> +	}
> +
> +	tmp = np;
> +	np = of_find_node_by_phandle(*ph);
> +	if (!np) {
> +		dev_dbg(&dev->dev, "axon_msi: invalid msi-translator found\n");
> +		goto out_error;
> +	}
> +
> +	irq_host = irq_find_host(np);
> +	if (!irq_host) {
> +		dev_dbg(&dev->dev, "axon_msi: no irq_host found\n");
> +		goto out_error;
> +	}
> +
> +	return irq_host->host_data;
> +
> +out_error:
> +	of_node_put(np);
> +	of_node_put(tmp);
> +
> +	return NULL;
> +}
> +
> +static int axon_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +{
> +	if (!find_msi_translator(dev))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
> +{
> +	struct device_node *np, *tmp;
> +	int pos, len;
> +	u16 flags;
> +	const u32 *prop;
> +
> +	np = pci_device_to_OF_node(dev);
> +	if (!np) {
> +		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
> +		return -ENODEV;
> +	}
> +
> +	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +	if (!pos || pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &flags)) {
> +		dev_err(&dev->dev, "axon_msi: error reading config space!\n");
> +		return -EIO;
> +	}
> +
> +	for (; np; tmp = of_get_parent(np), of_node_put(np), np = tmp) {
> +		if (flags & PCI_MSI_FLAGS_64BIT) {
> +			prop = of_get_property(np, "msi-address-64", &len);
> +			if (prop)
> +				break;
> +		}
> +
> +		prop = of_get_property(np, "msi-address-32", &len);
> +		if (prop)
> +			break;
> +	}
> +	of_node_put(np);
> +
> +	if (!prop) {
> +		dev_dbg(&dev->dev, "axon_msi: no msi-address-(32|64) found\n");
> +		return -ENOENT;
> +	}
> +
> +	switch (len) {
> +	case 8:
> +		msg->address_hi = prop[0];
> +		msg->address_lo = prop[1];
> +		break;
> +	case 4:
> +		msg->address_hi = 0;
> +		msg->address_lo = prop[0];
> +		break;
> +	default:
> +		dev_dbg(&dev->dev, "axon_msi: malformed msi-address-(32|64)\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	unsigned int virq, rc;
> +	struct msi_desc *entry;
> +	struct msi_msg msg;
> +	struct axon_msic *msic;
> +
> +	msic = find_msi_translator(dev);
> +	if (!msic)
> +		return -ENODEV;
> +
> +	rc = setup_msi_msg_address(dev, &msg);
> +	if (rc)
> +		return rc;
> +
> +	/* We rely on being able to stash a virq in a u16 */
> +	BUILD_BUG_ON(NR_IRQS > 65536);
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		virq = irq_create_direct_mapping(msic->irq_host);
> +		if (virq == NO_IRQ) {
> +			pr_debug("axon_msi: virq allocation failed!\n");
> +			return -1;
> +		}
> +		pr_debug("axon_msi: allocated virq 0x%x for %s\n",
> +			 virq, pci_name(dev));
> +
> +		set_irq_msi(virq, entry);
> +		msg.data = virq;
> +		write_msi_msg(virq, &msg);
> +	}
> +
> +	return 0;
> +}
> +
> +static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *entry;
> +
> +	pr_debug("axon_msi: tearing down irqs for %s\n", pci_name(dev));
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		if (entry->irq == NO_IRQ)
> +			continue;
> +
> +		set_irq_msi(entry->irq, NULL);
> +		irq_dispose_mapping(entry->irq);
> +	}
> +}
> +
> +static struct irq_chip msic_irq_chip = {
> +	.mask		= mask_msi_irq,
> +	.unmask		= unmask_msi_irq,
> +	.shutdown	= unmask_msi_irq,
> +	.typename	= "AXON-MSI",
> +};
> +
> +static int msic_host_map(struct irq_host *h, unsigned int virq,
> +			 irq_hw_number_t hw)
> +{
> +	set_irq_chip_and_handler(virq, &msic_irq_chip, handle_simple_irq);
> +	return 0;
> +}
> +
> +static int msic_host_match(struct irq_host *host, struct device_node *node)
> +{
> +	struct axon_msic *msic = host->host_data;
> +	return msic->dn == node;
> +}
> +
> +static struct irq_host_ops msic_host_ops = {
> +	.match	= msic_host_match,
> +	.map	= msic_host_map,
> +};
> +
> +static int axon_msi_notify_reboot(struct notifier_block *nb,
> +				  unsigned long code, void *data)
> +{
> +	struct axon_msic *msic;
> +	u32 tmp;
> +
> +	list_for_each_entry(msic, &axon_msic_list, list) {
> +		tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG_ADDR);
> +		tmp &= ~MSIC_ENABLE;
> +		dcr_write(msic->dcr_host, MSIC_CTRL_REG_ADDR, tmp);
> +		pr_debug("axon_msi: disabling %s\n", msic->dn->full_name);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block axon_msi_reboot_notifier = {
> +	.notifier_call = axon_msi_notify_reboot
> +};
> +
> +static int axon_msi_setup_one(struct device_node *node)
> +{
> +	struct page *page;
> +	struct axon_msic *msic;
> +	unsigned int virq;
> +
> +	pr_debug("axon_msi: setting up dn %s\n", node->full_name);
> +
> +	msic = kzalloc(sizeof(struct axon_msic), GFP_KERNEL);
> +	if (!msic) {
> +		printk(KERN_ERR "axon_msi: couldn't allocate msic\n");
> +		goto out_put;
> +	}
> +
> +	msic->dn = node;
> +
> +	msic->dcr_host = dcr_map(node, MSIC_DCR_BASE, MSIC_DCR_SIZE);
> +	if (!DCR_MAP_OK(msic->dcr_host)) {
> +		printk(KERN_ERR "axon_msi: dcr_map failed\n");
> +		goto out_free_msic;
> +	}
> +
> +	page = alloc_pages_node(of_node_to_nid(node),
> +				GFP_KERNEL, MSIC_FIFO_ORDER);
> +	if (!page) {
> +		printk(KERN_ERR "axon_msi: couldn't allocate fifo\n");
> +		goto out_free_msic;
> +	}
> +
> +	msic->fifo = page_address(page);
> +
> +	msic->irq_host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, NR_IRQS,
> +					&msic_host_ops, 0);
> +	if (!msic->irq_host) {
> +		printk(KERN_ERR "axon_msi: couldn't allocate host\n");
> +		goto out_free_fifo;
> +	}
> +
> +	msic->irq_host->host_data = msic;
> +
> +	virq = irq_of_parse_and_map(node, 0);
> +	if (virq == NO_IRQ) {
> +		printk(KERN_ERR "axon_msi: irq parse/map failed!\n");
> +		goto out_free_host;
> +	}
> +
> +	set_irq_data(virq, msic);
> +	set_irq_chained_handler(virq, axon_msi_cascade);
> +	pr_debug("axon_msi: irq 0x%x setup for axon_msi!\n", virq);
> +
> +	/* Enable the MSIC hardware */
> +	dcr_write(msic->dcr_host, MSIC_BASE_ADDR_HI_REG,
> +				  (u64)msic->fifo >> 32);
> +	dcr_write(msic->dcr_host, MSIC_BASE_ADDR_LO_REG,
> +				  (u64)msic->fifo & 0xFFFFFFFF);
> +	dcr_write(msic->dcr_host, MSIC_CTRL_REG_ADDR,
> +				  MSIC_IRQ_ENABLE | MSIC_ENABLE |
> +				  (MSIC_FIFO_SIZE << MSIC_SIZE_SHIFT));
> +
> +	list_add(&msic->list, &axon_msic_list);
> +
> +	return 0;
> +
> +out_free_host:
> +	kfree(msic->irq_host);
> +out_free_fifo:
> +	__free_pages(virt_to_page(msic->fifo), MSIC_FIFO_ORDER);
> +out_free_msic:
> +	kfree(msic);
> +out_put:
> +	of_node_put(node);
> +
> +	return -1;
> +}
> +
> +static int axon_msi_init(void)
> +{
> +	struct device_node *node;
> +	int found = 0;
> +
> +	pr_debug("axon_msi: initialising ...\n");
> +
> +	for_each_compatible_node(node, NULL, "ibm,axon-msic") {
> +		if (axon_msi_setup_one(of_node_get(node)) == 0)
> +			found++;
> +	}
> +	of_node_put(node);
> +
> +	if (found) {
> +		ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
> +		ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
> +		ppc_md.msi_check_device = axon_msi_check_device;
> +
> +		register_reboot_notifier(&axon_msi_reboot_notifier);
> +
> +		pr_debug("axon_msi: registered callbacks!\n");
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(axon_msi_init);
