Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 080CAB7CC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 15:35:10 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0Q4IxGU020035 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Tue, 26 Jan 2010 13:18:59 +0900
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0Q4ItlF021638 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Tue, 26 Jan 2010 13:18:56 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id BC3EB45DE50
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:18:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 981A345DE4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:18:55 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B9821DB8040
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:18:55 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 27BB41DB803C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:18:55 +0900 (JST)
Message-ID: <4B5E6D1D.5080503@jp.fujitsu.com>
Date: Tue, 26 Jan 2010 13:18:37 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
In-Reply-To: <4B5D9FC5.5070600@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ron Mercer <ron.mercer@qlogic.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Jay Vosburgh <fubar@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao wrote:
> Hello, 
> 
> I found that qlge is broken on PPC, and it got broken after commit 
> 06a1cbafb253c4c60d6a54a994887f5fbceabcc0. It happens because dev->pcie 
> is not set on PPC, because the function set_pcie_port_type(), who sets
> dev->pcie, is not being called on PPC PCI code.

Hi Breno,

I'm sorry for the regression. I didn't realize that PPC uses open-coded
PCI scan.

I guess the problem is caused by dev->pcie_cap, right? But I don't
understand what is happening clearly. Could you send me the detailed
information about the problem?

> 
> So, I have two ideas to fix it, the first one is to call 
> set_pcie_port_type() on pci_device_add() instead of pci_setup_device(). 
> Since that PPC device flow calls pci_device_add(), it fixes the problem
> without duplicating the caller for this function. 
> 

The set_pcie_port_type() needs to be called before pci_fixup_device() in
pci_setup_device() because fixup code might refer dev->pcie_cap. So I
don't think the first one is a good idea.

> OTOH, it's also possible to add set_pcie_port_type() on pci.h and call
> it inside the PPC PCI files, specifically on of_create_pci_dev().
> 
> I tested both ideas and they work perfect, so I'd like to figure out 
> which one is the most correct one. Both patches are attached here. 

I think the second one is better. But to prevent similar problems, I
think it would be better to remove open-coded PCI scan in PPC in a
long term, though I don't know the background about that.

Thanks,
Kenji Kaneshige


> 
> Thanks, 
> Breno
> 
> ----- First idea -----
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 98ffb2d..328c3ab 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -746,7 +746,6 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->hdr_type = hdr_type & 0x7f;
>  	dev->multifunction = !!(hdr_type & 0x80);
>  	dev->error_state = pci_channel_io_normal;
> -	set_pcie_port_type(dev);
>  	set_pci_aer_firmware_first(dev);
>  
>  	list_for_each_entry(slot, &dev->bus->slots, list)
> @@ -1052,6 +1051,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	/* Initialize various capabilities */
>  	pci_init_capabilities(dev);
>  
> +	set_pcie_port_type(dev);
>  	/*
>  	 * Add the device to our list of discovered devices
>  	 * and the bus list for fixup functions, etc.
> 
> ----- Second idea -----
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 7311fdf..f8820e8 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -160,6 +160,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  	dev->error_state = pci_channel_io_normal;
>  	dev->dma_mask = 0xffffffff;
>  
> +	set_pcie_port_type(dev);
>  	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
>  		/* a PCI-PCI bridge */
>  		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 98ffb2d..f787eea 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -681,7 +681,7 @@ static void pci_read_irq(struct pci_dev *dev)
>  	dev->irq = irq;
>  }
>  
> -static void set_pcie_port_type(struct pci_dev *pdev)
> +void set_pcie_port_type(struct pci_dev *pdev)
>  {
>  	int pos;
>  	u16 reg16;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 174e539..765095b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1269,6 +1269,7 @@ int pcibios_add_platform_entries(struct pci_dev *dev);
>  void pcibios_disable_device(struct pci_dev *dev);
>  int pcibios_set_pcie_reset_state(struct pci_dev *dev,
>  				 enum pcie_reset_state state);
> +extern void set_pcie_port_type(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_PCI_MMCONFIG
>  extern void __init pci_mmcfg_early_init(void);
> 
> 
