Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdBpt4dtLzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:56:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O4uSOf108380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:56:51 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chmm3xuxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:56:51 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Aug 2017 14:56:48 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O4tVG630081158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:55:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O4tMba020328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:55:22 +1000
Subject: Re: [PATCH kernel 4/5] powerpc/eeh: Remove unnecessary config_addr
 from eeh_dev
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823102546.29A77AE034@b01ledav005.gho.pok.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Aug 2017 14:55:30 +1000
MIME-Version: 1.0
In-Reply-To: <20170823102546.29A77AE034@b01ledav005.gho.pok.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d05774f5-b46e-ec7e-cd02-6071a5cd2508@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/17 20:19, Alexey Kardashevskiy wrote:
> The eeh_dev struct hold a config space address of an associated node
> and the very same address is also stored in the pci_dn struct which
> is always present during the eeh_dev lifetime.
> 
> This uses bus:devfn directly from pci_dn instead of cached and packed
> config_addr.
> 
> Since config_addr is made from device's bus:dev.fn, there is no point
> in keeping it in the debugfs either so remove that too.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/include/asm/eeh.h               |  1 -
>   arch/powerpc/kernel/eeh_pe.c                 | 42 ++++++++++++++--------------
>   arch/powerpc/kernel/eeh_sysfs.c              |  3 --
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  9 +++---
>   4 files changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 777d37aa0a7f..9847ae3a12d1 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -131,7 +131,6 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
>   struct eeh_dev {
>   	int mode;			/* EEH mode			*/
>   	int class_code;			/* Class code of the device	*/
> -	int config_addr;		/* Config address		*/
>   	int pe_config_addr;		/* PE config address		*/
>   	u32 config_space[16];		/* Saved PCI config space	*/
>   	int pcix_cap;			/* Saved PCIx capability	*/
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 419c3f07afd5..2e8d1b2b5af4 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -340,11 +340,12 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   {
>   	struct eeh_pe *pe, *parent;
>   	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
> +	int config_addr = (pdn->busno << 8) | (pdn->devfn);
>   
>   	/* Check if the PE number is valid */
>   	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
>   		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%x\n",
> -		       __func__, edev->config_addr, pdn->phb->global_number);
> +		       __func__, config_addr, pdn->phb->global_number);
>   		return -EINVAL;
>   	}
>   
> @@ -354,8 +355,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	 * PE should be composed of PCI bus and its subordinate
>   	 * components.
>   	 */
> -	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr,
> -			edev->config_addr);
> +	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr, config_addr);
>   	if (pe && !(pe->type & EEH_PE_INVALID)) {
>   		/* Mark the PE as type of PCI bus */
>   		pe->type = EEH_PE_BUS;
> @@ -365,10 +365,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   		list_add_tail(&edev->list, &pe->edevs);
>   		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
>   			 pdn->phb->global_number,
> -			edev->config_addr >> 8,
> -			PCI_SLOT(edev->config_addr & 0xFF),
> -			PCI_FUNC(edev->config_addr & 0xFF),
> -			pe->addr);
> +			 pdn->busno,
> +			 PCI_SLOT(pdn->devfn),
> +			 PCI_FUNC(pdn->devfn),
> +			 pe->addr);
>   		return 0;
>   	} else if (pe && (pe->type & EEH_PE_INVALID)) {
>   		list_add_tail(&edev->list, &pe->edevs);
> @@ -388,10 +388,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Device "
>   			 "PE#%x, Parent PE#%x\n",
>   			 pdn->phb->global_number,
> -			edev->config_addr >> 8,
> -                        PCI_SLOT(edev->config_addr & 0xFF),
> -                        PCI_FUNC(edev->config_addr & 0xFF),
> -			pe->addr, pe->parent->addr);
> +			 pdn->busno,
> +			 PCI_SLOT(pdn->devfn),
> +			 PCI_FUNC(pdn->devfn),
> +			 pe->addr, pe->parent->addr);
>   		return 0;
>   	}
>   
> @@ -405,7 +405,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   		return -ENOMEM;
>   	}
>   	pe->addr	= edev->pe_config_addr;
> -	pe->config_addr	= edev->config_addr;
> +	pe->config_addr	= config_addr;
>   
>   	/*
>   	 * Put the new EEH PE into hierarchy tree. If the parent
> @@ -436,9 +436,9 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
>   		 "Device PE#%x, Parent PE#%x\n",
>   		 pdn->phb->global_number,
> -		 edev->config_addr >> 8,
> -		 PCI_SLOT(edev->config_addr & 0xFF),
> -		 PCI_FUNC(edev->config_addr & 0xFF),
> +		 pdn->busno,
> +		 PCI_SLOT(pdn->devfn),
> +		 PCI_FUNC(pdn->devfn),
>   		 pe->addr, pe->parent->addr);
>   
>   	return 0;
> @@ -462,9 +462,9 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>   	if (!edev->pe) {
>   		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
>   			 __func__,  pdn->phb->global_number,
> -			 edev->config_addr >> 8,
> -			 PCI_SLOT(edev->config_addr & 0xFF),
> -			 PCI_FUNC(edev->config_addr & 0xFF));
> +			 pdn->busno,
> +			 PCI_SLOT(pdn->devfn),
> +			 PCI_FUNC(pdn->devfn));
>   		return -EEXIST;
>   	}
>   
> @@ -725,9 +725,9 @@ static void eeh_bridge_check_link(struct eeh_dev *edev)
>   
>   	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
>   		 __func__, pdn->phb->global_number,
> -		 edev->config_addr >> 8,
> -		 PCI_SLOT(edev->config_addr & 0xFF),
> -		 PCI_FUNC(edev->config_addr & 0xFF));
> +		 pdn->busno,
> +		 PCI_SLOT(pdn->devfn),
> +		 PCI_FUNC(pdn->devfn));
>   
>   	/* Check slot status */
>   	cap = edev->pcie_cap;
> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
> index 1ceecdda810b..797549289798 100644
> --- a/arch/powerpc/kernel/eeh_sysfs.c
> +++ b/arch/powerpc/kernel/eeh_sysfs.c
> @@ -51,7 +51,6 @@ static ssize_t eeh_show_##_name(struct device *dev,      \
>   static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
>   
>   EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
> -EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
>   EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
>   
>   static ssize_t eeh_pe_state_show(struct device *dev,
> @@ -103,7 +102,6 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
>   		return;
>   
>   	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
> -	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
>   	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
>   	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_state);
>   
> @@ -128,7 +126,6 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
>   	}
>   
>   	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
> -	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
>   	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
>   	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_state);
>   
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 552b0cd4e8ba..8864065eba22 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -352,6 +352,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>   	uint32_t pcie_flags;
>   	int ret;
> +	int config_addr = (pdn->busno << 8) | (pdn->devfn);
>   
>   	/*
>   	 * When probing the root bridge, which doesn't have any
> @@ -386,8 +387,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
>   		}
>   	}
>   
> -	edev->config_addr    = (pdn->busno << 8) | (pdn->devfn);
> -	edev->pe_config_addr = phb->ioda.pe_rmap[edev->config_addr];
> +	edev->pe_config_addr = phb->ioda.pe_rmap[config_addr];
>   
>   	/* Create PE */
>   	ret = eeh_add_to_parent_pe(edev);
> @@ -1699,6 +1699,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>   	struct pnv_phb *phb;
>   	s64 ret;
> +	int config_addr = (pdn->busno << 8) | (pdn->devfn);
>   
>   	if (!edev)
>   		return -EEXIST;
> @@ -1715,12 +1716,12 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>   	} else {
>   		phb = pdn->phb->private_data;
>   		ret = opal_pci_reinit(phb->opal_id,
> -				      OPAL_REINIT_PCI_DEV, edev->config_addr);
> +				      OPAL_REINIT_PCI_DEV, config_addr);
>   	}
>   
>   	if (ret) {
>   		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
> -			__func__, edev->config_addr, ret);
> +			__func__, config_addr, ret);
>   		return -EIO;
>   	}
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
