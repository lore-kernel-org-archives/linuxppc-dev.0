Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdCKc0W6vzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:20:03 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O5IlER049577
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 01:20:02 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chgmsvm4h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 01:20:01 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Aug 2017 15:19:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O5JuWV35389576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:19:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O5JuRL028870
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:19:56 +1000
Subject: Re: [PATCH kernel 5/5] powerpc/eeh: Remove unnecessary node from
 pci_dn
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823102629.539BD2803A@b01ledav001.gho.pok.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Aug 2017 15:19:55 +1000
MIME-Version: 1.0
In-Reply-To: <20170823102629.539BD2803A@b01ledav001.gho.pok.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <038c06f7-120f-5a42-286d-541634716525@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/17 20:19, Alexey Kardashevskiy wrote:
> The pci_dn struct caches a OF device node pointer in order to access
> the "ibm,loc-code" property when EEH is recovering.
> 
> However, when this happens in eeh_dev_check_failure(), we also have
> a pci_dev pointer which should have a valid pointer to the device node
> when pci_dn has one (both pointers are not NULL for physical functions
> and are NULL for virtual functions).
> 
> This removes the node pointer from the pci_dn struct and used pdev
> in eeh_dev_check_failure() instead.
> 
> This changes pci_remove_device_node_info() to look for a parent of
> the node being removed, just like pci_add_device_node_info() does when it
> references the parent node.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/include/asm/pci-bridge.h | 1 -
>   arch/powerpc/kernel/eeh.c             | 9 +++++----
>   arch/powerpc/kernel/pci_dn.c          | 8 +++++---
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 56c67d3f0108..0b8aa1fe2d5f 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -195,7 +195,6 @@ struct pci_dn {
>   	struct  pci_dn *parent;
>   	struct  pci_controller *phb;	/* for pci devices */
>   	struct	iommu_table_group *table_group;	/* for phb's or bridges */
> -	struct	device_node *node;	/* back-pointer to the device_node */
>   
>   	int	pci_ext_config_space;	/* for pci devices */
>   
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index c877014d11ce..2c926029adbe 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -435,7 +435,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>   	int ret;
>   	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
>   	unsigned long flags;
> -	struct pci_dn *pdn;
> +	struct device_node *dn;
>   	struct pci_dev *dev;
>   	struct eeh_pe *pe, *parent_pe, *phb_pe;
>   	int rc = 0;
> @@ -493,9 +493,10 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>   	if (pe->state & EEH_PE_ISOLATED) {
>   		pe->check_count++;
>   		if (pe->check_count % EEH_MAX_FAILS == 0) {
> -			pdn = eeh_dev_to_pdn(edev);
> -			if (pdn->node)
> -				location = of_get_property(pdn->node, "ibm,loc-code", NULL);
> +			dn = pci_device_to_OF_node(dev);
> +			if (dn)
> +				location = of_get_property(dn, "ibm,loc-code",
> +						NULL);
>   			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
>   				"location=%s driver=%s pci addr=%s\n",
>   				pe->check_count,
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 0256372b72de..0e395afbf0f4 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -293,7 +293,6 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>   	if (pdn == NULL)
>   		return NULL;
>   	dn->data = pdn;
> -	pdn->node = dn;
>   	pdn->phb = hose;
>   #ifdef CONFIG_PPC_POWERNV
>   	pdn->pe_number = IODA_INVALID_PE;
> @@ -342,6 +341,7 @@ EXPORT_SYMBOL_GPL(pci_add_device_node_info);
>   void pci_remove_device_node_info(struct device_node *dn)
>   {
>   	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
> +	struct device_node *parent;
>   #ifdef CONFIG_EEH
>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>   
> @@ -354,8 +354,10 @@ void pci_remove_device_node_info(struct device_node *dn)
>   
>   	WARN_ON(!list_empty(&pdn->child_list));
>   	list_del(&pdn->list);
> -	if (pdn->parent)
> -		of_node_put(pdn->parent->node);
> +
> +	parent = of_get_parent(dn);
> +	if (parent)
> +		of_node_put(parent);
>   
>   	dn->data = NULL;
>   	kfree(pdn);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
