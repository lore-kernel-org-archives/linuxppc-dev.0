Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZkXg3ly3zDqdP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:34:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5N1Xomr141863
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:34:39 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n0evkybr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 21:34:38 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 11:34:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E42FD2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:34:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5N1YXhG11665816
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:34:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5N1YXOF029323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:34:33 +1000
Date: Thu, 23 Jun 2016 11:34:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, alistair@popple.id.au, aik@ozlabs.ru
Subject: Re: [PATCH v10 13/18] powerpc/pci: Delay populating pdn
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-14-git-send-email-gwshan@linux.vnet.ibm.com>
 <87por8lnxu.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87por8lnxu.fsf@possimpible.ozlabs.ibm.com>
Message-Id: <20160623013432.GA31770@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2016 at 10:59:57AM +1000, Daniel Axtens wrote:
>Hi,
>
>mpe merged this to his next yesterday, and my nightly scripts picked up
>the following cppcheck warning:
>
>[arch/powerpc/kernel/pci_dn.c:486]: (error) Memory leak: pdn
>
>That goes to the following function:
>
>static void *add_pdn(struct device_node *dn, void *data)
>{
>        struct pci_controller *hose = data;
>        struct pci_dn *pdn;
>
>        pdn = pci_add_device_node_info(hose, dn);
>        if (!pdn)
>                return ERR_PTR(-ENOMEM);
>
>        return NULL;
>}
>
>It looks like this is just called in pci_devs_phb_init_dynamic:
>
>        /* Update dn->phb ptrs for new phb and children devices */
>        pci_traverse_device_nodes(dn, add_pdn, phb);
>
>So my understanding is that this isn't a real memory leak but just
>cppcheck getting confused.
>
>Gavin, can you confirm that?
>

Daniel, thanks for the report. It's a false alarm: pci_traverse_device_nodes()
will be terminated immediate on non-NULL return value from add_pdn(). So the
function (add_pdn()) returns NULL intentionally. The newly created @pdn has
been attached to @dn. The @pdn is release when the @dn is released in PCI
hot remove time.

>Regards,
>Daniel
>

Thanks,
Gavin

>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> The pdn (struct pci_dn) instances are allocated from memblock or
>> bootmem when creating PCI controller (hoses) in setup_arch(). PCI
>> hotplug, which will be supported by proceeding patches, releases
>> PCI device nodes and their corresponding pdn on unplugging event.
>> The memory chunks for pdn instances allocated from memblock or
>> bootmem are hard to reused after being released.
>>
>> This delays creating pdn by pci_devs_phb_init() from setup_arch()
>> to core_initcall() so that they are allocated from slab. The memory
>> consumed by pdn can be released to system without problem during
>> PCI unplugging time. It indicates that pci_dn is unavailable in
>> setup_arch() and the the fixup on pdn (like AGP's) can't be carried
>> out that time. We have to do that in pcibios_root_bridge_prepare()
>> on maple/pasemi/powermac platforms where/when the pdn is available.
>> pcibios_root_bridge_prepare is called from subsys_initcall() which
>> is executed after core_initcall() so the code flow does not change.
>>
>> At the mean while, the EEH device is created when pdn is populated,
>> meaning pdn and EEH device have same life cycle. In turn, we needn't
>> call eeh_dev_init() to create EEH device explicitly.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/eeh.h         |  2 +-
>>  arch/powerpc/include/asm/ppc-pci.h     |  2 --
>>  arch/powerpc/kernel/eeh_dev.c          | 17 +++------------
>>  arch/powerpc/kernel/pci_dn.c           | 23 ++++++++++++++++----
>>  arch/powerpc/platforms/maple/pci.c     | 34 ++++++++++++++++++------------
>>  arch/powerpc/platforms/pasemi/pci.c    |  3 ---
>>  arch/powerpc/platforms/powermac/pci.c  | 38 +++++++++++++++++++++-------------
>>  arch/powerpc/platforms/powernv/pci.c   |  3 ---
>>  arch/powerpc/platforms/pseries/setup.c |  6 +-----
>>  9 files changed, 69 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index fb9f376..8721580 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -274,7 +274,7 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
>>  const char *eeh_pe_loc_get(struct eeh_pe *pe);
>>  struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>>  
>> -void *eeh_dev_init(struct pci_dn *pdn, void *data);
>> +struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
>>  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
>>  int eeh_init(void);
>>  int __init eeh_ops_register(struct eeh_ops *ops);
>> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
>> index 8753e4e..0f73de0 100644
>> --- a/arch/powerpc/include/asm/ppc-pci.h
>> +++ b/arch/powerpc/include/asm/ppc-pci.h
>> @@ -39,8 +39,6 @@ void *pci_traverse_device_nodes(struct device_node *start,
>>  void *traverse_pci_dn(struct pci_dn *root,
>>  		      void *(*fn)(struct pci_dn *, void *),
>>  		      void *data);
>> -
>> -extern void pci_devs_phb_init(void);
>>  extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
>>  
>>  /* From rtas_pci.h */
>> diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
>> index 7815095..d6b2ca7 100644
>> --- a/arch/powerpc/kernel/eeh_dev.c
>> +++ b/arch/powerpc/kernel/eeh_dev.c
>> @@ -44,14 +44,13 @@
>>  /**
>>   * eeh_dev_init - Create EEH device according to OF node
>>   * @pdn: PCI device node
>> - * @data: PHB
>>   *
>>   * It will create EEH device according to the given OF node. The function
>>   * might be called by PCI emunation, DR, PHB hotplug.
>>   */
>> -void *eeh_dev_init(struct pci_dn *pdn, void *data)
>> +struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
>>  {
>> -	struct pci_controller *phb = data;
>> +	struct pci_controller *phb = pdn->phb;
>>  	struct eeh_dev *edev;
>>  
>>  	/* Allocate EEH device */
>> @@ -69,7 +68,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
>>  	INIT_LIST_HEAD(&edev->list);
>>  	INIT_LIST_HEAD(&edev->rmv_list);
>>  
>> -	return NULL;
>> +	return edev;
>>  }
>>  
>>  /**
>> @@ -81,16 +80,8 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
>>   */
>>  void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
>>  {
>> -	struct pci_dn *root = phb->pci_data;
>> -
>>  	/* EEH PE for PHB */
>>  	eeh_phb_pe_create(phb);
>> -
>> -	/* EEH device for PHB */
>> -	eeh_dev_init(root, phb);
>> -
>> -	/* EEH devices for children OF nodes */
>> -	traverse_pci_dn(root, eeh_dev_init, phb);
>>  }
>>  
>>  /**
>> @@ -106,8 +97,6 @@ static int __init eeh_dev_phb_init(void)
>>  	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>>  		eeh_dev_phb_init_dynamic(phb);
>>  
>> -	pr_info("EEH: devices created\n");
>> -
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>> index ecdccce..9cbf95a 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -209,8 +209,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>  		}
>>  
>>  		/* Create the EEH device for the VF */
>> -		eeh_dev_init(pdn, pci_bus_to_host(pdev->bus));
>> -		edev = pdn_to_eeh_dev(pdn);
>> +		edev = eeh_dev_init(pdn);
>>  		BUG_ON(!edev);
>>  		edev->physfn = pdev;
>>  	}
>> @@ -289,8 +288,11 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>>  	const __be32 *regs;
>>  	struct device_node *parent;
>>  	struct pci_dn *pdn;
>> +#ifdef CONFIG_EEH
>> +	struct eeh_dev *edev;
>> +#endif
>>  
>> -	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
>> +	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
>>  	if (pdn == NULL)
>>  		return NULL;
>>  	dn->data = pdn;
>> @@ -319,6 +321,15 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>>  	/* Extended config space */
>>  	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
>>  
>> +	/* Create EEH device */
>> +#ifdef CONFIG_EEH
>> +	edev = eeh_dev_init(pdn);
>> +	if (!edev) {
>> +		kfree(pdn);
>> +		return NULL;
>> +	}
>> +#endif
>> +
>>  	/* Attach to parent node */
>>  	INIT_LIST_HEAD(&pdn->child_list);
>>  	INIT_LIST_HEAD(&pdn->list);
>> @@ -504,15 +515,19 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
>>   * pci device found underneath.  This routine runs once,
>>   * early in the boot sequence.
>>   */
>> -void __init pci_devs_phb_init(void)
>> +static int __init pci_devs_phb_init(void)
>>  {
>>  	struct pci_controller *phb, *tmp;
>>  
>>  	/* This must be done first so the device nodes have valid pci info! */
>>  	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>>  		pci_devs_phb_init_dynamic(phb);
>> +
>> +	return 0;
>>  }
>>  
>> +core_initcall(pci_devs_phb_init);
>> +
>>  static void pci_dev_pdn_setup(struct pci_dev *pdev)
>>  {
>>  	struct pci_dn *pdn;
>> diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
>> index a923230..a2f89e6 100644
>> --- a/arch/powerpc/platforms/maple/pci.c
>> +++ b/arch/powerpc/platforms/maple/pci.c
>> @@ -568,6 +568,26 @@ void maple_pci_irq_fixup(struct pci_dev *dev)
>>  	DBG(" <- maple_pci_irq_fixup\n");
>>  }
>>  
>> +static int maple_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
>> +	struct device_node *np, *child;
>> +
>> +	if (hose != u3_agp)
>> +		return 0;
>> +
>> +	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
>> +	 * assume there is no P2P bridge on the AGP bus, which should be a
>> +	 * safe assumptions hopefully.
>> +	 */
>> +	np = hose->dn;
>> +	PCI_DN(np)->busno = 0xf0;
>> +	for_each_child_of_node(np, child)
>> +		PCI_DN(child)->busno = 0xf0;
>> +
>> +	return 0;
>> +}
>> +
>>  void __init maple_pci_init(void)
>>  {
>>  	struct device_node *np, *root;
>> @@ -605,19 +625,7 @@ void __init maple_pci_init(void)
>>  	if (ht && maple_add_bridge(ht) != 0)
>>  		of_node_put(ht);
>>  
>> -	/* Setup the linkage between OF nodes and PHBs */ 
>> -	pci_devs_phb_init();
>> -
>> -	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
>> -	 * assume there is no P2P bridge on the AGP bus, which should be a
>> -	 * safe assumptions hopefully.
>> -	 */
>> -	if (u3_agp) {
>> -		struct device_node *np = u3_agp->dn;
>> -		PCI_DN(np)->busno = 0xf0;
>> -		for (np = np->child; np; np = np->sibling)
>> -			PCI_DN(np)->busno = 0xf0;
>> -	}
>> +	ppc_md.pcibios_root_bridge_prepare = maple_pci_root_bridge_prepare;
>>  
>>  	/* Tell pci.c to not change any resource allocations.  */
>>  	pci_add_flags(PCI_PROBE_ONLY);
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
>> index f3a68a0..10c4e8f 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -229,9 +229,6 @@ void __init pas_pci_init(void)
>>  			of_node_get(np);
>>  
>>  	of_node_put(root);
>> -
>> -	/* Setup the linkage between OF nodes and PHBs */
>> -	pci_devs_phb_init();
>>  }
>>  
>>  void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
>> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
>> index 59ab16f..6e06c3b 100644
>> --- a/arch/powerpc/platforms/powermac/pci.c
>> +++ b/arch/powerpc/platforms/powermac/pci.c
>> @@ -878,6 +878,29 @@ void pmac_pci_irq_fixup(struct pci_dev *dev)
>>  #endif /* CONFIG_PPC32 */
>>  }
>>  
>> +#ifdef CONFIG_PPC64
>> +static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
>> +	struct device_node *np, *child;
>> +
>> +	if (hose != u3_agp)
>> +		return 0;
>> +
>> +	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
>> +	 * assume there is no P2P bridge on the AGP bus, which should be a
>> +	 * safe assumptions for now. We should do something better in the
>> +	 * future though
>> +	 */
>> +	np = hose->dn;
>> +	PCI_DN(np)->busno = 0xf0;
>> +	for_each_child_of_node(np, child)
>> +		PCI_DN(child)->busno = 0xf0;
>> +
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PPC64 */
>> +
>>  void __init pmac_pci_init(void)
>>  {
>>  	struct device_node *np, *root;
>> @@ -914,20 +937,7 @@ void __init pmac_pci_init(void)
>>  	if (ht && pmac_add_bridge(ht) != 0)
>>  		of_node_put(ht);
>>  
>> -	/* Setup the linkage between OF nodes and PHBs */
>> -	pci_devs_phb_init();
>> -
>> -	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
>> -	 * assume there is no P2P bridge on the AGP bus, which should be a
>> -	 * safe assumptions for now. We should do something better in the
>> -	 * future though
>> -	 */
>> -	if (u3_agp) {
>> -		struct device_node *np = u3_agp->dn;
>> -		PCI_DN(np)->busno = 0xf0;
>> -		for (np = np->child; np; np = np->sibling)
>> -			PCI_DN(np)->busno = 0xf0;
>> -	}
>> +	ppc_md.pcibios_root_bridge_prepare = pmac_pci_root_bridge_prepare;
>>  	/* pmac_check_ht_link(); */
>>  
>>  #else /* CONFIG_PPC64 */
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index b1ee631..0f1b8bf 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -816,9 +816,6 @@ void __init pnv_pci_init(void)
>>  	for_each_compatible_node(np, NULL, "ibm,ioda2-npu-phb")
>>  		pnv_pci_init_npu_phb(np);
>>  
>> -	/* Setup the linkage between OF nodes and PHBs */
>> -	pci_devs_phb_init();
>> -
>>  	/* Configure IOMMU DMA hooks */
>>  	set_pci_dma_ops(&dma_iommu_ops);
>>  }
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 9883bc7..4eada28 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -265,11 +265,8 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
>>  	case OF_RECONFIG_ATTACH_NODE:
>>  		parent = of_get_parent(np);
>>  		pdn = parent ? PCI_DN(parent) : NULL;
>> -		if (pdn) {
>> -			/* Create pdn and EEH device */
>> +		if (pdn)
>>  			pci_add_device_node_info(pdn->phb, np);
>> -			eeh_dev_init(PCI_DN(np), pdn->phb);
>> -		}
>>  
>>  		of_node_put(parent);
>>  		break;
>> @@ -492,7 +489,6 @@ static void __init find_and_init_phbs(void)
>>  	}
>>  
>>  	of_node_put(root);
>> -	pci_devs_phb_init();
>>  
>>  	/*
>>  	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
>> -- 
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
