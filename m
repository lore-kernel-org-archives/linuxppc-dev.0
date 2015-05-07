Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B13CB1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 08:12:30 +1000 (AEST)
Received: by iecnq11 with SMTP id nq11so50751335iec.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2015 15:12:28 -0700 (PDT)
Date: Thu, 7 May 2015 17:12:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/21] pci: Add pcibios_setup_bridge()
Message-ID: <20150507221224.GN24643@google.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430460188-31343-2-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

[Please run "git log --oneline drivers/pci/setup-bus.c" and observe the
capitalization convention.]

On Fri, May 01, 2015 at 04:02:48PM +1000, Gavin Shan wrote:
> Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
> which is called for once after PCI probing and resource assignment
> are completed, to allocate platform required resources for PCI devices:
> PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
> Obviously, it's not hotplug friendly.
> 
> The patch adds weak function pcibios_setup_bridge(), which is called
> by pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
> to assign above platform required resources to newly added PCI devices,
> in order to support PCI hotplug on PowerPC PowerNV platform.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c | 12 +++++++++---
>  include/linux/pci.h     |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4fd0cac..a7d0c3c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -674,7 +674,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
>  	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
>  }
>  
> -static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
> +
> +void pci_setup_bridge_resources(struct pci_bus *bus, unsigned long type)
>  {
>  	struct pci_dev *bridge = bus->self;
>  
> @@ -693,12 +694,17 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
>  	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
>  }
>  
> +void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
> +{
> +	pci_setup_bridge_resources(bus, type);
> +}

I'm not opposed to adding a pcibios_setup_bridge(), but I would rather do
the architected updates in the generic PCI core code instead of down in the
pcibios code.  In other words, I would rather have this:

  void pci_setup_bridge(struct pci_bus *bus)
  {
    pcibios_setup_bridge(bus, type);
    pci_setup_bridge_resources(bus, type);
  }

That way the default pcibios hook is empty, showing that by default there's
no arch-specific code in this path, and we only have to look at the generic
core code to verify that we actually do program the bridge windows.

Bjorn
