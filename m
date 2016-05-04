Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r05Q86ZBBzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:57:52 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 May 2016 14:47:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 36C27357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:47:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444lVZg34013282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:47:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444l6dO018934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:47:07 +1000
Subject: Re: [PATCH v9 20/26] powerpc/pci: Move pci_find_bus_by_node() around
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-21-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alistair@popple.id.au
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <57297EB1.3090704@au1.ibm.com>
Date: Wed, 4 May 2016 14:46:41 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-21-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/16 15:41, Gavin Shan wrote:
> This moves pci_find_bus_by_node() from arch/powerpc/platforms/
> pseries/pci_dlpar.c to arch/powerpc/kernel/pci-hotplug.c so that
> the function can be used by pSeries and PowerNV platform at the
> same time. Also, below cleanup applied. No functional changes
> introduced.
>
>     * Remove variable "busdn" in find_bus_among_children()
>     * Use PCI_DN() to convert device node to pci_dn
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good to me

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/kernel/pci-hotplug.c          | 29 ++++++++++++++++++++++++++++
>   arch/powerpc/platforms/pseries/pci_dlpar.c | 31 ------------------------------
>   2 files changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 2d108e5..46587a1 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -21,6 +21,35 @@
>   #include <asm/firmware.h>
>   #include <asm/eeh.h>
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
>   /**
>    * pcibios_release_device - release PCI device
>    * @dev: PCI device
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index aee22b4..906dbaa 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -34,37 +34,6 @@
>
>   #include "pseries.h"
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
>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   {
>   	struct pci_controller *phb;
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
