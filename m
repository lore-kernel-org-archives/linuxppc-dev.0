Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 641FB1A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 05:44:38 +1000 (AEST)
Received: by igbsb11 with SMTP id sb11so22290107igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2015 12:44:36 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:44:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Subject: Re: [PATCH v5 01/42] PCI: Add pcibios_setup_bridge()
Message-ID: <20150605194432.GN3631@google.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433400131-18429-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2015 at 04:41:30PM +1000, Gavin Shan wrote:
> Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
> which is called for once after PCI probing and resource assignment
> are completed, to allocate platform required resources for PCI devices:
> PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
> Obviously, it's not hotplug friendly.
> 
> The patch adds weak function pcibios_setup_bridge(), which is called
> by pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
> to assign above platform required resources to newly added PCI devices,
> in order to support PCI hotplug in subsequent patches.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v5:
>   * Corrected subject as Bjorn suggested
>   * pci_setup_bridge() calls pcibios_setup_bridge() and __pci_setup_bridge()
> ---
>  drivers/pci/setup-bus.c | 5 +++++
>  include/linux/pci.h     | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4fd0cac..623dee3 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -693,11 +693,16 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>  	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
>  }
>  
> +void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
> +{
> +}
> +
>  void pci_setup_bridge(struct pci_bus *bus)
>  {
>  	unsigned long type = IORESOURCE_IO | IORESOURCE_MEM |
>  				  IORESOURCE_PREFETCH;
>  
> +	pcibios_setup_bridge(bus, type);
>  	__pci_setup_bridge(bus, type);
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 94bacfa..5aacd0a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -811,6 +811,7 @@ void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
>  void pci_stop_root_bus(struct pci_bus *bus);
>  void pci_remove_root_bus(struct pci_bus *bus);
>  void pci_setup_cardbus(struct pci_bus *bus);
> +void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
>  void pci_sort_breadthfirst(void);
>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
>  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
> -- 
> 2.1.0
> 
