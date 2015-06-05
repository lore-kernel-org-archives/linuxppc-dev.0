Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 000581A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 05:47:36 +1000 (AEST)
Received: by igbhj9 with SMTP id hj9so23155694igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2015 12:47:34 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:47:30 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Subject: Re: [PATCH v5 31/42] powerpc/pci: Move pcibios_find_pci_bus() around
Message-ID: <20150605194730.GO3631@google.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-32-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433400131-18429-32-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Move pcibios_find_pci_bus() from pSeries to generic powerpc code"?

On Thu, Jun 04, 2015 at 04:42:00PM +1000, Gavin Shan wrote:
> The patch moves pcibios_find_pci_bus() to PPC kerenl directory so

s/kerenl/kernel/

> that it can be reused by hotplug code for pSeries and PowerNV
> platform at the same time.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> v5:
>   * Derived from PATCH[v4 12/21]
> ---
>  arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
>  2 files changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index ca392fc..1482bc1 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -21,6 +21,42 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
>  
> +static struct pci_bus *find_pci_bus(struct pci_bus *bus,
> +				    struct device_node *dn)
> +{
> +	struct pci_bus *tmp, *child = NULL;
> +	struct device_node *busdn;
> +
> +	busdn = pci_bus_to_OF_node(bus);
> +	if (busdn == dn)
> +		return bus;
> +
> +	list_for_each_entry(tmp, &bus->children, node) {
> +		child = find_pci_bus(tmp, dn);
> +		if (child)
> +			break;
> +	}
> +
> +	return child;
> +}
> +
> +/**
> + * pcibios_find_pci_bus - find PCI bus according to the given device node
> + * @dn: Device node
> + *
> + * Find the corresponding PCI bus according to the given device node.
> + */
> +struct pci_bus *pcibios_find_pci_bus(struct device_node *dn)
> +{
> +	struct pci_dn *pdn = PCI_DN(dn);
> +
> +	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> +		return NULL;
> +
> +	return find_pci_bus(pdn->phb->bus, dn);
> +}
> +EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
> +
>  /**
>   * pcibios_release_device - release PCI device
>   * @dev: PCI device
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 5d4a3df..906dbaa 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -34,38 +34,6 @@
>  
>  #include "pseries.h"
>  
> -static struct pci_bus *
> -find_bus_among_children(struct pci_bus *bus,
> -                        struct device_node *dn)
> -{
> -	struct pci_bus *child = NULL;
> -	struct pci_bus *tmp;
> -	struct device_node *busdn;
> -
> -	busdn = pci_bus_to_OF_node(bus);
> -	if (busdn == dn)
> -		return bus;
> -
> -	list_for_each_entry(tmp, &bus->children, node) {
> -		child = find_bus_among_children(tmp, dn);
> -		if (child)
> -			break;
> -	};
> -	return child;
> -}
> -
> -struct pci_bus *
> -pcibios_find_pci_bus(struct device_node *dn)
> -{
> -	struct pci_dn *pdn = dn->data;
> -
> -	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> -		return NULL;
> -
> -	return find_bus_among_children(pdn->phb->bus, dn);
> -}
> -EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
> -
>  struct pci_controller *init_phb_dynamic(struct device_node *dn)
>  {
>  	struct pci_controller *phb;
> -- 
> 2.1.0
> 
