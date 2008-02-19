Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1CD0DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:28:53 +1100 (EST)
Subject: Re: [patch 1/4] PCI: split pcibios_enable_resources() out of
	pcibios_enable_device()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20080219044307.157131373@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.157131373@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:27:14 +1100
Message-Id: <1203402434.6740.90.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-02-18 at 21:39 -0700, Bjorn Helgaas wrote:
> plain text document attachment (make-pcibios_enable_resources)
> On x86, pcibios_enable_device() is factored into
> pcibios_enable_resources() and pcibios_enable_irq().  On several other
> architectures, the functional equivalent of pcibios_enable_resources()
> is expanded directly inside pcibios_enable_device().
> 
> This splits these pcibios_enable_device() implementations to make them
> more similar to the x86 implementation.
> 
> There should be no functional change from this patch.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> ---
>  arch/alpha/kernel/pci.c          |    8 +++++++-
>  arch/arm/kernel/bios32.c         |    9 +++++++--
>  arch/parisc/kernel/pci.c         |    6 +++++-
>  arch/powerpc/kernel/pci-common.c |   14 +++++++++-----
>  arch/sh/drivers/pci/pci.c        |    7 ++++++-
>  arch/sparc64/kernel/pci.c        |    7 ++++++-
>  arch/v850/kernel/rte_mb_a_pci.c  |    7 ++++++-
>  7 files changed, 46 insertions(+), 12 deletions(-)
> 
> Index: work6/arch/alpha/kernel/pci.c
> ===================================================================
> --- work6.orig/arch/alpha/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/alpha/kernel/pci.c	2008-02-18 10:45:14.000000000 -0700
> @@ -370,7 +370,7 @@
>  #endif
>  
>  int
> -pcibios_enable_device(struct pci_dev *dev, int mask)
> +pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, oldcmd;
>  	int i;
> @@ -396,6 +396,12 @@
>  	return 0;
>  }
>  
> +int
> +pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
> +
>  /*
>   *  If we set up a device for bus mastering, we need to check the latency
>   *  timer as certain firmware forgets to set it properly, as seen
> Index: work6/arch/arm/kernel/bios32.c
> ===================================================================
> --- work6.orig/arch/arm/kernel/bios32.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/arm/kernel/bios32.c	2008-02-18 10:45:14.000000000 -0700
> @@ -655,10 +655,10 @@
>  }
>  
>  /**
> - * pcibios_enable_device - Enable I/O and memory.
> + * pcibios_enable_resources - Enable I/O and memory.
>   * @dev: PCI device to be enabled
>   */
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, old_cmd;
>  	int idx;
> @@ -697,6 +697,11 @@
>  	return 0;
>  }
>  
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
> +
>  int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
>  			enum pci_mmap_state mmap_state, int write_combine)
>  {
> Index: work6/arch/parisc/kernel/pci.c
> ===================================================================
> --- work6.orig/arch/parisc/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/parisc/kernel/pci.c	2008-02-18 10:45:14.000000000 -0700
> @@ -285,7 +285,7 @@
>   * Drivers that do not need parity (eg graphics and possibly networking)
>   * can clear these bits if they want.
>   */
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd;
>  	int idx;
> @@ -317,6 +317,10 @@
>  	return 0;
>  }
>  
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
>  
>  /* PA-RISC specific */
>  void pcibios_register_hba(struct pci_hba_data *hba)
> Index: work6/arch/powerpc/kernel/pci-common.c
> ===================================================================
> --- work6.orig/arch/powerpc/kernel/pci-common.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/powerpc/kernel/pci-common.c	2008-02-18 10:45:14.000000000 -0700
> @@ -1153,16 +1153,12 @@
>  EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
>  #endif /* CONFIG_HOTPLUG */
>  
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, old_cmd;
>  	int idx;
>  	struct resource *r;
>  
> -	if (ppc_md.pcibios_enable_device_hook)
> -		if (ppc_md.pcibios_enable_device_hook(dev))
> -			return -EINVAL;
> -
>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  	old_cmd = cmd;
>  	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
> @@ -1193,3 +1189,11 @@
>  	return 0;
>  }
>  
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	if (ppc_md.pcibios_enable_device_hook)
> +		if (ppc_md.pcibios_enable_device_hook(dev))
> +			return -EINVAL;
> +
> +	return pcibios_enable_resources(dev, mask);
> +}
> Index: work6/arch/sh/drivers/pci/pci.c
> ===================================================================
> --- work6.orig/arch/sh/drivers/pci/pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/sh/drivers/pci/pci.c	2008-02-18 10:45:14.000000000 -0700
> @@ -131,7 +131,7 @@
>  	}
>  }
>  
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, old_cmd;
>  	int idx;
> @@ -163,6 +163,11 @@
>  	return 0;
>  }
>  
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
> +
>  /*
>   *  If we set up a device for bus mastering, we need to check and set
>   *  the latency timer as it may not be properly set.
> Index: work6/arch/sparc64/kernel/pci.c
> ===================================================================
> --- work6.orig/arch/sparc64/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/sparc64/kernel/pci.c	2008-02-18 10:45:14.000000000 -0700
> @@ -946,7 +946,7 @@
>  {
>  }
>  
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, oldcmd;
>  	int i;
> @@ -976,6 +976,11 @@
>  	return 0;
>  }
>  
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
> +
>  void pcibios_resource_to_bus(struct pci_dev *pdev, struct pci_bus_region *region,
>  			     struct resource *res)
>  {
> Index: work6/arch/v850/kernel/rte_mb_a_pci.c
> ===================================================================
> --- work6.orig/arch/v850/kernel/rte_mb_a_pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/v850/kernel/rte_mb_a_pci.c	2008-02-18 10:45:14.000000000 -0700
> @@ -217,7 +217,7 @@
>  }
>  
>  
> -int __nomods_init pcibios_enable_device (struct pci_dev *dev, int mask)
> +int __nomods_init pcibios_enable_resources (struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, old_cmd;
>  	int idx;
> @@ -245,6 +245,11 @@
>  	return 0;
>  }
>  
> +int __nomods_init pcibios_enable_device (struct pci_dev *dev, int mask)
> +{
> +	return pcibios_enable_resources(dev, mask);
> +}
> +
>  
>  /* Resource allocation.  */
>  static void __devinit pcibios_assign_resources (void)
> 
