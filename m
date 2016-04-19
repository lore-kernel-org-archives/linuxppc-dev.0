Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpvFd1V2QzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:48:37 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id n1so3149422pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 22:48:37 -0700 (PDT)
Subject: Re: [PATCH v8 28/45] powerpc/pci: Introduce
 pci_remove_device_node_info()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-29-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715C6AA.2060606@ozlabs.ru>
Date: Tue, 19 Apr 2016 15:48:26 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-29-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> This implements and exports pci_remove_device_node_info(). It's
> used to remove the pdn (struct pci_dn) for the indicated device
> node. The function is going to be used by PowerNV PCI hotplug
> driver.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Kind of strange that there is no such helper for pseries, is there?


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/include/asm/pci-bridge.h |  1 +
>   arch/powerpc/kernel/pci_dn.c          | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 72a9d4e..c6310e2 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -240,6 +240,7 @@ extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
>   extern void remove_dev_pci_data(struct pci_dev *pdev);
>   extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>   					       struct device_node *dn);
> +extern void pci_remove_device_node_info(struct device_node *dn);
>
>   static inline int pci_device_from_OF_node(struct device_node *np,
>   					  u8 *bus, u8 *devfn)
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 0a249ff..ce10281 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -331,6 +331,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
>   }
>   EXPORT_SYMBOL_GPL(pci_add_device_node_info);
>
> +void pci_remove_device_node_info(struct device_node *dn)
> +{
> +	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
> +#ifdef CONFIG_EEH
> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> +
> +	if (edev)
> +		edev->pdn = NULL;
> +#endif
> +
> +	if (!pdn)
> +		return;
> +
> +	WARN_ON(!list_empty(&pdn->child_list));
> +	list_del(&pdn->list);
> +	if (pdn->parent)
> +		of_node_put(pdn->parent->node);
> +
> +	dn->data = NULL;
> +	kfree(pdn);
> +}
> +EXPORT_SYMBOL_GPL(pci_remove_device_node_info);
> +
>   /*
>    * Traverse a device tree stopping each PCI device in the tree.
>    * This is done depth first.  As each node is processed, a "pre"
>


-- 
Alexey
