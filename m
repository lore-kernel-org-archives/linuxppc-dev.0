Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DF1D1A04EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 15:24:46 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so32279356pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 20:24:43 -0800 (PST)
Subject: Re: [PATCH v7 34/50] powerpc/pci: Delay populating pdn
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-35-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564BFD83.9040408@ozlabs.ru>
Date: Wed, 18 Nov 2015 15:24:35 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-35-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> The pdn (struct pci_dn) instances are allocated from memblock or
> bootmem when creating PCI controller (hoses) in setup_arch(). PCI
> hotplug, which will be supported by proceeding patches, release
> PCI device nodes and their corresponding pdn on unplugging event.
> The memory chunks for pdn instances allocated from memblock or
> bootmem are hard to reused after being released.
>
> This delays creating pdn in core_initcall_sync(eeh_dev_phb_init) so
> that they are allocated from slab. In turn, the memory chunks for
> them can be reused after being released without problem. Since the
> pdn and eeh_dev has same life cycle, the eeh_dev is created when
> pdn is populated. We needn't create eeh_dev with another initcall.
> The time to create PHB PEs is delayed a bit from core_initcall() to
> core_initcall_sync().

Why is delayed? I mean what needs to be called before eeh_dev_phb_init()?

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/eeh.h         |  2 +-
>   arch/powerpc/include/asm/ppc-pci.h     |  2 --
>   arch/powerpc/kernel/eeh_dev.c          | 19 ++++-------------
>   arch/powerpc/kernel/pci_dn.c           | 20 ++++++++++++++++--
>   arch/powerpc/platforms/maple/pci.c     | 34 ++++++++++++++++++------------
>   arch/powerpc/platforms/pasemi/pci.c    |  3 ---
>   arch/powerpc/platforms/powermac/pci.c  | 38 +++++++++++++++++++++-------------
>   arch/powerpc/platforms/powernv/pci.c   |  3 ---
>   arch/powerpc/platforms/pseries/setup.c |  6 +-----
>   9 files changed, 69 insertions(+), 58 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index c5eb86f..27352f4 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -268,7 +268,7 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
>   const char *eeh_pe_loc_get(struct eeh_pe *pe);
>   struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>
> -void *eeh_dev_init(struct pci_dn *pdn, void *data);
> +struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
>   void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
>   int eeh_init(void);
>   int __init eeh_ops_register(struct eeh_ops *ops);
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
> index 8753e4e..0f73de0 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -39,8 +39,6 @@ void *pci_traverse_device_nodes(struct device_node *start,
>   void *traverse_pci_dn(struct pci_dn *root,
>   		      void *(*fn)(struct pci_dn *, void *),
>   		      void *data);
> -
> -extern void pci_devs_phb_init(void);
>   extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
>
>   /* From rtas_pci.h */
> diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
> index aabba94..1c4bc35 100644
> --- a/arch/powerpc/kernel/eeh_dev.c
> +++ b/arch/powerpc/kernel/eeh_dev.c
> @@ -44,14 +44,13 @@
>   /**
>    * eeh_dev_init - Create EEH device according to OF node
>    * @pdn: PCI device node
> - * @data: PHB
>    *
>    * It will create EEH device according to the given OF node. The function
>    * might be called by PCI emunation, DR, PHB hotplug.
>    */
> -void *eeh_dev_init(struct pci_dn *pdn, void *data)
> +struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
>   {
> -	struct pci_controller *phb = data;
> +	struct pci_controller *phb = pdn->phb;
>   	struct eeh_dev *edev;
>
>   	/* Allocate EEH device */
> @@ -68,7 +67,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
>   	edev->phb = phb;
>   	INIT_LIST_HEAD(&edev->list);
>
> -	return NULL;
> +	return edev;
>   }
>
>   /**
> @@ -80,16 +79,8 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
>    */
>   void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
>   {
> -	struct pci_dn *root = phb->pci_data;
> -
>   	/* EEH PE for PHB */
>   	eeh_phb_pe_create(phb);
> -
> -	/* EEH device for PHB */
> -	eeh_dev_init(root, phb);
> -
> -	/* EEH devices for children OF nodes */
> -	traverse_pci_dn(root, eeh_dev_init, phb);
>   }
>
>   /**
> @@ -105,9 +96,7 @@ static int __init eeh_dev_phb_init(void)
>   	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>   		eeh_dev_phb_init_dynamic(phb);
>
> -	pr_info("EEH: devices created\n");
> -
>   	return 0;
>   }
>
> -core_initcall(eeh_dev_phb_init);
> +core_initcall_sync(eeh_dev_phb_init);


May be remove core_initcall_sync and call eeh_dev_phb_init_dynamic() 
directly from the loop in pci_devs_phb_init()?



> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index aa4110f..581612c 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -272,8 +272,11 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>   	const __be32 *regs;
>   	struct device_node *parent;
>   	struct pci_dn *pdn;
> +#ifdef CONFIG_EEH
> +	struct eeh_dev *edev;
> +#endif
>
> -	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
> +	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
>   	if (pdn == NULL)
>   		return NULL;
>   	dn->data = pdn;
> @@ -302,6 +305,15 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>   	/* Extended config space */
>   	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
>
> +	/* Create EEH device */
> +#ifdef CONFIG_EEH
> +	edev = eeh_dev_init(pdn);
> +	if (!edev) {
> +		kfree(pdn);
> +		return NULL;
> +	}
> +#endif
> +
>   	/* Attach to parent node */
>   	INIT_LIST_HEAD(&pdn->child_list);
>   	INIT_LIST_HEAD(&pdn->list);
> @@ -486,15 +498,19 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
>    * pci device found underneath.  This routine runs once,
>    * early in the boot sequence.
>    */
> -void __init pci_devs_phb_init(void)
> +static int __init pci_devs_phb_init(void)
>   {
>   	struct pci_controller *phb, *tmp;
>
>   	/* This must be done first so the device nodes have valid pci info! */
>   	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>   		pci_devs_phb_init_dynamic(phb);
> +
> +	return 0;
>   }
>
> +core_initcall(pci_devs_phb_init);
> +
>   static void pci_dev_pdn_setup(struct pci_dev *pdev)
>   {
>   	struct pci_dn *pdn;
> diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
> index a923230..a2f89e6 100644
> --- a/arch/powerpc/platforms/maple/pci.c
> +++ b/arch/powerpc/platforms/maple/pci.c
> @@ -568,6 +568,26 @@ void maple_pci_irq_fixup(struct pci_dev *dev)
>   	DBG(" <- maple_pci_irq_fixup\n");
>   }
>
> +static int maple_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
> +	struct device_node *np, *child;
> +
> +	if (hose != u3_agp)
> +		return 0;
> +
> +	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
> +	 * assume there is no P2P bridge on the AGP bus, which should be a
> +	 * safe assumptions hopefully.
> +	 */
> +	np = hose->dn;
> +	PCI_DN(np)->busno = 0xf0;
> +	for_each_child_of_node(np, child)
> +		PCI_DN(child)->busno = 0xf0;
> +
> +	return 0;
> +}
> +
>   void __init maple_pci_init(void)
>   {
>   	struct device_node *np, *root;
> @@ -605,19 +625,7 @@ void __init maple_pci_init(void)
>   	if (ht && maple_add_bridge(ht) != 0)
>   		of_node_put(ht);
>
> -	/* Setup the linkage between OF nodes and PHBs */
> -	pci_devs_phb_init();
> -
> -	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
> -	 * assume there is no P2P bridge on the AGP bus, which should be a
> -	 * safe assumptions hopefully.
> -	 */
> -	if (u3_agp) {
> -		struct device_node *np = u3_agp->dn;
> -		PCI_DN(np)->busno = 0xf0;
> -		for (np = np->child; np; np = np->sibling)
> -			PCI_DN(np)->busno = 0xf0;
> -	}
> +	ppc_md.pcibios_root_bridge_prepare = maple_pci_root_bridge_prepare;


This seems an unrelated change.

What is this pcibios_root_bridge_prepare()? How come you do not need one 
for the powernv platform but do need for others? Same question about powermac.

>
>   	/* Tell pci.c to not change any resource allocations.  */
>   	pci_add_flags(PCI_PROBE_ONLY);
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index f3a68a0..10c4e8f 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -229,9 +229,6 @@ void __init pas_pci_init(void)
>   			of_node_get(np);
>
>   	of_node_put(root);
> -
> -	/* Setup the linkage between OF nodes and PHBs */
> -	pci_devs_phb_init();
>   }
>
>   void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
> index 59ab16f..6e06c3b 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -878,6 +878,29 @@ void pmac_pci_irq_fixup(struct pci_dev *dev)
>   #endif /* CONFIG_PPC32 */
>   }
>
> +#ifdef CONFIG_PPC64
> +static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
> +	struct device_node *np, *child;
> +
> +	if (hose != u3_agp)
> +		return 0;
> +
> +	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
> +	 * assume there is no P2P bridge on the AGP bus, which should be a
> +	 * safe assumptions for now. We should do something better in the
> +	 * future though
> +	 */
> +	np = hose->dn;
> +	PCI_DN(np)->busno = 0xf0;
> +	for_each_child_of_node(np, child)
> +		PCI_DN(child)->busno = 0xf0;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PPC64 */
> +
>   void __init pmac_pci_init(void)
>   {
>   	struct device_node *np, *root;
> @@ -914,20 +937,7 @@ void __init pmac_pci_init(void)
>   	if (ht && pmac_add_bridge(ht) != 0)
>   		of_node_put(ht);
>
> -	/* Setup the linkage between OF nodes and PHBs */
> -	pci_devs_phb_init();
> -
> -	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
> -	 * assume there is no P2P bridge on the AGP bus, which should be a
> -	 * safe assumptions for now. We should do something better in the
> -	 * future though
> -	 */
> -	if (u3_agp) {
> -		struct device_node *np = u3_agp->dn;
> -		PCI_DN(np)->busno = 0xf0;
> -		for (np = np->child; np; np = np->sibling)
> -			PCI_DN(np)->busno = 0xf0;
> -	}
> +	ppc_md.pcibios_root_bridge_prepare = pmac_pci_root_bridge_prepare;
>   	/* pmac_check_ht_link(); */
>
>   #else /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index fa99daf..d8832ea 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -807,9 +807,6 @@ void __init pnv_pci_init(void)
>   	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
>   		pnv_pci_init_ioda2_phb(np);
>
> -	/* Setup the linkage between OF nodes and PHBs */
> -	pci_devs_phb_init();
> -
>   	/* Configure IOMMU DMA hooks */
>   	set_pci_dma_ops(&dma_iommu_ops);
>   }
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 6c274cb..bdf93a1 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -262,11 +262,8 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
>   	case OF_RECONFIG_ATTACH_NODE:
>   		parent = of_get_parent(np);
>   		pdn = parent ? PCI_DN(parent) : NULL;
> -		if (pdn) {
> -			/* Create pdn and EEH device */
> +		if (pdn)
>   			pci_add_device_node_info(pdn->phb, np);
> -			eeh_dev_init(PCI_DN(np), pdn->phb);
> -		}
>
>   		of_node_put(parent);
>   		break;
> @@ -489,7 +486,6 @@ static void __init find_and_init_phbs(void)
>   	}
>
>   	of_node_put(root);
> -	pci_devs_phb_init();
>
>   	/*
>   	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
>


-- 
Alexey
