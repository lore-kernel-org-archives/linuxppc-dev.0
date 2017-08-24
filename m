Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdBZL2BGKzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:46:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O4jtKV099027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:45:59 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chgypgs40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:45:57 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Aug 2017 14:45:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O4jc3v37552380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:45:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O4jUfe009555
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:45:30 +1000
Subject: Re: [PATCH kernel 3/5] powerpc/eeh: Remove unnecessary pointer to phb
 from eeh_dev
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823101901.33961-4-aik@ozlabs.ru>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Aug 2017 14:45:37 +1000
MIME-Version: 1.0
In-Reply-To: <20170823101901.33961-4-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2faa9545-3440-9d37-1b4f-56595d704b93@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/17 20:18, Alexey Kardashevskiy wrote:
> The eeh_dev struct already holds a pointer to pci_dn which it does not
> exist without and pci_dn itself holds the very same pointer so just
> use it.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/include/asm/eeh.h               |  1 -
>   arch/powerpc/kernel/eeh.c                    |  7 +++----
>   arch/powerpc/kernel/eeh_dev.c                |  2 --
>   arch/powerpc/kernel/eeh_driver.c             |  2 +-
>   arch/powerpc/kernel/eeh_pe.c                 | 24 +++++++++++++-----------
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++---
>   6 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 26a6a43f8799..777d37aa0a7f 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -141,7 +141,6 @@ struct eeh_dev {
>   	struct eeh_pe *pe;		/* Associated PE		*/
>   	struct list_head list;		/* Form link list in the PE	*/
>   	struct list_head rmv_list;	/* Record the removed edevs	*/
> -	struct pci_controller *phb;	/* Associated PHB		*/
>   	struct pci_dn *pdn;		/* Associated PCI device node	*/
>   	struct pci_dev *pdev;		/* Associated PCI device	*/
>   	bool in_error;			/* Error flag for edev		*/
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 63992b2d8e15..c877014d11ce 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -169,10 +169,10 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
>   	char buffer[128];
>   
>   	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
> -		       edev->phb->global_number, pdn->busno,
> +		       pdn->phb->global_number, pdn->busno,
>   		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>   	pr_warn("EEH: of node=%04x:%02x:%02x.%01x\n",
> -		edev->phb->global_number, pdn->busno,
> +		pdn->phb->global_number, pdn->busno,
>   		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>   
>   	eeh_ops->read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
> @@ -1064,7 +1064,7 @@ core_initcall_sync(eeh_init);
>    */
>   void eeh_add_device_early(struct pci_dn *pdn)
>   {
> -	struct pci_controller *phb;
> +	struct pci_controller *phb = pdn ? pdn->phb : NULL;
>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>   
>   	if (!edev)
> @@ -1074,7 +1074,6 @@ void eeh_add_device_early(struct pci_dn *pdn)
>   		return;
>   
>   	/* USB Bus children of PCI devices will not have BUID's */
> -	phb = edev->phb;
>   	if (NULL == phb ||
>   	    (eeh_has_flag(EEH_PROBE_MODE_DEVTREE) && 0 == phb->buid))
>   		return;
> diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
> index d6b2ca70d14d..bdf4a3698a35 100644
> --- a/arch/powerpc/kernel/eeh_dev.c
> +++ b/arch/powerpc/kernel/eeh_dev.c
> @@ -50,7 +50,6 @@
>    */
>   struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
>   {
> -	struct pci_controller *phb = pdn->phb;
>   	struct eeh_dev *edev;
>   
>   	/* Allocate EEH device */
> @@ -64,7 +63,6 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
>   	/* Associate EEH device with OF node */
>   	pdn->edev = edev;
>   	edev->pdn = pdn;
> -	edev->phb = phb;
>   	INIT_LIST_HEAD(&edev->list);
>   	INIT_LIST_HEAD(&edev->rmv_list);
>   
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index c405c79e50cd..8b840191df59 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -428,7 +428,7 @@ static void *eeh_add_virt_device(void *data, void *userdata)
>   
>   	if (!(edev->physfn)) {
>   		pr_warn("%s: EEH dev %04x:%02x:%02x.%01x not for VF\n",
> -			__func__, edev->phb->global_number, pdn->busno,
> +			__func__, pdn->phb->global_number, pdn->busno,
>   			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>   		return NULL;
>   	}
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 84d79f3da7d6..419c3f07afd5 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -339,11 +339,12 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>   int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   {
>   	struct eeh_pe *pe, *parent;
> +	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>   
>   	/* Check if the PE number is valid */
>   	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
>   		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%x\n",
> -		       __func__, edev->config_addr, edev->phb->global_number);
> +		       __func__, edev->config_addr, pdn->phb->global_number);
>   		return -EINVAL;
>   	}
>   
> @@ -353,7 +354,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	 * PE should be composed of PCI bus and its subordinate
>   	 * components.
>   	 */
> -	pe = eeh_pe_get(edev->pdn->phb, edev->pe_config_addr,
> +	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr,
>   			edev->config_addr);
>   	if (pe && !(pe->type & EEH_PE_INVALID)) {
>   		/* Mark the PE as type of PCI bus */
> @@ -363,7 +364,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   		/* Put the edev to PE */
>   		list_add_tail(&edev->list, &pe->edevs);
>   		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
> -			edev->phb->global_number,
> +			 pdn->phb->global_number,
>   			edev->config_addr >> 8,
>   			PCI_SLOT(edev->config_addr & 0xFF),
>   			PCI_FUNC(edev->config_addr & 0xFF),
> @@ -386,7 +387,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   
>   		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Device "
>   			 "PE#%x, Parent PE#%x\n",
> -			edev->phb->global_number,
> +			 pdn->phb->global_number,
>   			edev->config_addr >> 8,
>                           PCI_SLOT(edev->config_addr & 0xFF),
>                           PCI_FUNC(edev->config_addr & 0xFF),
> @@ -396,9 +397,9 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   
>   	/* Create a new EEH PE */
>   	if (edev->physfn)
> -		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
> +		pe = eeh_pe_alloc(pdn->phb, EEH_PE_VF);
>   	else
> -		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
> +		pe = eeh_pe_alloc(pdn->phb, EEH_PE_DEVICE);
>   	if (!pe) {
>   		pr_err("%s: out of memory!\n", __func__);
>   		return -ENOMEM;
> @@ -414,10 +415,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	 */
>   	parent = eeh_pe_get_parent(edev);
>   	if (!parent) {
> -		parent = eeh_phb_pe_get(edev->phb);
> +		parent = eeh_phb_pe_get(pdn->phb);
>   		if (!parent) {
>   			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
> -				__func__, edev->phb->global_number);
> +				__func__, pdn->phb->global_number);
>   			edev->pe = NULL;
>   			kfree(pe);
>   			return -EEXIST;
> @@ -434,7 +435,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	edev->pe = pe;
>   	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
>   		 "Device PE#%x, Parent PE#%x\n",
> -		 edev->phb->global_number,
> +		 pdn->phb->global_number,
>   		 edev->config_addr >> 8,
>   		 PCI_SLOT(edev->config_addr & 0xFF),
>   		 PCI_FUNC(edev->config_addr & 0xFF),
> @@ -456,10 +457,11 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>   {
>   	struct eeh_pe *pe, *parent, *child;
>   	int cnt;
> +	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
>   
>   	if (!edev->pe) {
>   		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
> -			 __func__,  edev->phb->global_number,
> +			 __func__,  pdn->phb->global_number,
>   			 edev->config_addr >> 8,
>   			 PCI_SLOT(edev->config_addr & 0xFF),
>   			 PCI_FUNC(edev->config_addr & 0xFF));
> @@ -722,7 +724,7 @@ static void eeh_bridge_check_link(struct eeh_dev *edev)
>   		return;
>   
>   	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
> -		 __func__, edev->phb->global_number,
> +		 __func__, pdn->phb->global_number,
>   		 edev->config_addr >> 8,
>   		 PCI_SLOT(edev->config_addr & 0xFF),
>   		 PCI_FUNC(edev->config_addr & 0xFF));
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index ac8c01cd251c..552b0cd4e8ba 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -926,7 +926,6 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>   static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
>   				     int pos, u16 mask)
>   {
> -	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>   	int i, status = 0;
>   
>   	/* Wait for Transaction Pending bit to be cleared */
> @@ -940,7 +939,7 @@ static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
>   
>   	pr_warn("%s: Pending transaction while issuing %sFLR to %04x:%02x:%02x.%01x\n",
>   		__func__, type,
> -		edev->phb->global_number, pdn->busno,
> +		pdn->phb->global_number, pdn->busno,
>   		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>   }
>   
> @@ -1714,7 +1713,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>   	if (edev->physfn) {
>   		ret = pnv_eeh_restore_vf_config(pdn);
>   	} else {
> -		phb = edev->phb->private_data;
> +		phb = pdn->phb->private_data;
>   		ret = opal_pci_reinit(phb->opal_id,
>   				      OPAL_REINIT_PCI_DEV, edev->config_addr);
>   	}
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
