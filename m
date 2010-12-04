Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id 434B0B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 21:10:46 +1100 (EST)
Message-ID: <4CFA11A7.2090005@gate-nine.de>
Date: Sat, 04 Dec 2010 11:02:15 +0100
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v3] PPC4xx: Adding PCI(E) MSI support
References: <1291426393-1429-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1291426393-1429-1-git-send-email-tmarri@apm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

a few nitpicks here. I don't have any clue about MSI, but I have seen
some code-style related issues.

On 12/04/2010 02:33 AM, tmarri@apm.com wrote:
> +static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	int err = 0;
> +	int int_no = -ENOMEM;
> +	unsigned int virq;
> +	struct msi_msg msg;
> +	struct msi_desc *entry;
> +	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> +		if(int_no >= 0)
> +			break;
> +		if(int_no < 0) {
> +

Empty line here not needed.

> +			err = int_no;
> +			pr_debug("%s: fail allocating msi interrupt\n",
> +					__func__);
> +		}
> +		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
> +		if (virq == NO_IRQ) {
> +			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
> +			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
> +			err = -ENOSPC;
> +			goto out_free;
> +		}
> +		msi_data->msi_virqs[int_no] = virq;
> +		set_irq_data(virq, (void *)int_no);
> +		dev_dbg(&dev->dev, "%s: virq = %d \n", __func__, virq);
> +
> +		/* Setup msi address space */
> +		msg.address_hi = msi_data->msi_addr_hi;
> +		msg.address_lo = msi_data->msi_addr_lo;
> +
> +		set_irq_msi(virq, entry);
> +		msg.data = int_no;
> +		write_msi_msg(virq, &msg);
> +	}
> +
> +out_free:
> +	return err;
> +}

You don't really need the goto-style here, because you have nothing to
clean up when returning. You could instead return directly and save some
lines, because you don't have to assign err and then use goto all the time.


> +
> +void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *entry;
> +	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
> +
> +	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		if (entry->irq == NO_IRQ)
> +			continue;
> +		set_irq_msi(entry->irq, NULL);
> +		msi_bitmap_free_hwirqs(&msi_data->bitmap,
> +				virq_to_hw(entry->irq), 1);
> +		irq_dispose_mapping(entry->irq);
> +	}
> +
> +	return;

This return is not needed.


> +static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> +				 struct resource res, struct ppc4xx_msi *msi)
> +{
> +	const u32 *msi_data;
> +	const u32 *msi_mask;
> +	const u32 *sdr_addr;
> +	int err = 0;
> +	dma_addr_t msi_phys;
> +	void *msi_virt;
> +
> +	sdr_addr = of_get_property(dev->dev.of_node, "sdr-base", NULL);
> +	if (!sdr_addr)
> +		return -1;
> +
> +	SDR0_WRITE(sdr_addr, (u64)res.start >> 32);	 /*HIGH addr */
> +	SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> +
> +
> +	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> +	if (msi->msi_dev) {
> +		err = -ENODEV;
> +		goto error_out;
> +	}
> +	msi->msi_regs = of_iomap(msi->msi_dev, 0);
> +	if (!msi->msi_regs) {
> +		dev_err(&dev->dev, "of_iomap problem failed\n");
> +		return -ENOMEM;
> +	}

You directly return here and in all other bad cases this function
covers, you use the goto-style (which you don't really need here,
because there is no cleanup to do in case of a failure). Better use a
consistent way for returning.


> +	msi_data = of_get_property(dev->dev.of_node, "msi-data", NULL);
> +	if (!msi_data) {
> +		err = -1;
> +		goto error_out;
> +	}
> +
> +	msi_mask = of_get_property(dev->dev.of_node, "msi-mask", NULL);
> +	if (!msi_mask) {
> +		err = -1;
> +		goto error_out;
> +	}
> +
> +	/* Program MSI Expected data and Mask bits */
> +	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
> +	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
> +
> +	return err;
> +error_out:
> +	return err;
> +}

This was already mentioned by Josh Boyer.

> +
> +static int ppc4xx_of_msi_remove(struct platform_device *dev)
> +{
> +	struct ppc4xx_msi *msi = dev->dev.platform_data;
> +	int i;
> +	int virq;
> +
> +	for(i = 0; i < NR_MSI_IRQS; i++) {
> +		virq = msi->msi_virqs[i];
> +		if (virq != NO_IRQ)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	if (msi->bitmap.bitmap)
> +		msi_bitmap_free(&msi->bitmap);
> +	iounmap(msi->msi_regs);
> +	of_node_put(msi->msi_dev);
> +	kfree(msi);
> +
> +	return 0;
> +}
> +
> +static int __devinit ppc4xx_msi_probe(struct platform_device *dev,
> +				      const struct of_device_id *match)
> +{
> +	struct ppc4xx_msi *msi;
> +	struct resource res;
> +	int err = 0;
> +
> +	msi = &ppc4xx_msi;/*keep the msi data for further use*/
> +
> +	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
> +
> +	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
> +	if (!msi) {
> +		dev_err(&dev->dev, "No memory for MSI structure\n");
> +		err = -ENOMEM;
> +		goto error_out;
> +	}
> +	dev->dev.platform_data = msi;
> +
[...]
> +
> +error_out:
> +	ppc4xx_of_msi_remove(dev);
> +	return err;
> +}

If this function fails on allocating memory, you don't have to remove
your device because it was not created and therefore the expected
resources are not available in your *_remove function.



Hope this helps!


   Philipp
