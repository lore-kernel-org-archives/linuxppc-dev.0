Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0fwX6dFVzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 13:07:40 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id 77so32169593pfv.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 20:07:40 -0700 (PDT)
Subject: Re: [PATCH v9 20/26] powerpc/pci: Move pci_find_bus_by_node() around
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-21-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6cfcdcc9-ae76-a195-001a-9d85c03c389e@ozlabs.ru>
Date: Thu, 5 May 2016 13:07:17 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-21-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 03:41 PM, Gavin Shan wrote:
> This moves pci_find_bus_by_node() from arch/powerpc/platforms/
> pseries/pci_dlpar.c to arch/powerpc/kernel/pci-hotplug.c so that
> the function can be used by pSeries and PowerNV platform at the
> same time. Also, below cleanup applied. No functional changes
> introduced.
>
>    * Remove variable "busdn" in find_bus_among_children()
>    * Use PCI_DN() to convert device node to pci_dn
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/kernel/pci-hotplug.c          | 29 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci_dlpar.c | 31 ------------------------------
>  2 files changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 2d108e5..46587a1 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -21,6 +21,35 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
>
> +static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
> +					       struct device_node *dn)
> +{
> +	struct pci_bus *child = NULL;
> +	struct pci_bus *tmp;
> +
> +	if (pci_bus_to_OF_node(bus) == dn)
> +		return bus;
> +
> +	list_for_each_entry(tmp, &bus->children, node) {
> +		child = find_bus_among_children(tmp, dn);
> +		if (child)
> +			break;
> +	}
> +
> +	return child;
> +}
> +
> +struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
> +{
> +	struct pci_dn *pdn = PCI_DN(dn);
> +
> +	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> +		return NULL;
> +
> +	return find_bus_among_children(pdn->phb->bus, dn);
> +}
> +EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
> +
>  /**
>   * pcibios_release_device - release PCI device
>   * @dev: PCI device
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index aee22b4..906dbaa 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -34,37 +34,6 @@
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
> -struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
> -{
> -	struct pci_dn *pdn = dn->data;
> -
> -	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> -		return NULL;
> -
> -	return find_bus_among_children(pdn->phb->bus, dn);
> -}
> -EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
> -
>  struct pci_controller *init_phb_dynamic(struct device_node *dn)
>  {
>  	struct pci_controller *phb;
>


-- 
Alexey
