Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpvJd2gTczDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:51:13 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id zm5so3112785pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 22:51:13 -0700 (PDT)
Subject: Re: [PATCH v8 29/45] powerpc/pci: Export pci_traverse_device_nodes()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-30-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715C747.4080005@ozlabs.ru>
Date: Tue, 19 Apr 2016 15:51:03 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-30-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This renames traverse_pci_devices() to pci_traverse_device_nodes().
> The function traverses all subordinate device nodes of the specified
> one. Also, below cleanup applied to the function. No logical changes
> introduced.
>
>     * Rename "pre" to "fn".
>     * Avoid assignment in if condition reported from checkpatch.pl.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/ppc-pci.h   |  6 +++---
>   arch/powerpc/kernel/pci_dn.c         | 15 ++++++++++-----
>   arch/powerpc/platforms/pseries/msi.c |  4 ++--
>   3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
> index ca0c5bf..8753e4e 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -33,9 +33,9 @@ extern struct pci_dev *isa_bridge_pcidev;	/* may be NULL if no ISA bus */
>   struct device_node;
>   struct pci_dn;
>
> -typedef void *(*traverse_func)(struct device_node *me, void *data);



Why removing this typedef? Typedef's are good.

Anyway,


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> -void *traverse_pci_devices(struct device_node *start, traverse_func pre,
> -		void *data);
> +void *pci_traverse_device_nodes(struct device_node *start,
> +				void *(*fn)(struct device_node *, void *),
> +				void *data);
>   void *traverse_pci_dn(struct pci_dn *root,
>   		      void *(*fn)(struct pci_dn *, void *),
>   		      void *data);
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index ce10281..ecdccce 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -372,8 +372,9 @@ EXPORT_SYMBOL_GPL(pci_remove_device_node_info);
>    * one of these nodes we also assume its siblings are non-pci for
>    * performance.
>    */
> -void *traverse_pci_devices(struct device_node *start, traverse_func pre,
> -		void *data)
> +void *pci_traverse_device_nodes(struct device_node *start,
> +				void *(*fn)(struct device_node *, void *),
> +				void *data)
>   {
>   	struct device_node *dn, *nextdn;
>   	void *ret;
> @@ -388,8 +389,11 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
>   		if (classp)
>   			class = of_read_number(classp, 1);
>
> -		if (pre && ((ret = pre(dn, data)) != NULL))
> -			return ret;
> +		if (fn) {
> +			ret = fn(dn, data);
> +			if (ret)
> +				return ret;
> +		}
>
>   		/* If we are a PCI bridge, go down */
>   		if (dn->child && ((class >> 8) == PCI_CLASS_BRIDGE_PCI ||
> @@ -411,6 +415,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
>   	}
>   	return NULL;
>   }
> +EXPORT_SYMBOL_GPL(pci_traverse_device_nodes);
>
>   static struct pci_dn *pci_dn_next_one(struct pci_dn *root,
>   				      struct pci_dn *pdn)
> @@ -487,7 +492,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
>   	}
>
>   	/* Update dn->phb ptrs for new phb and children devices */
> -	traverse_pci_devices(dn, add_pdn, phb);
> +	pci_traverse_device_nodes(dn, add_pdn, phb);
>   }
>
>   /**
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 272e9ec..543a638 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -305,7 +305,7 @@ static int msi_quota_for_device(struct pci_dev *dev, int request)
>   	memset(&counts, 0, sizeof(struct msi_counts));
>
>   	/* Work out how many devices we have below this PE */
> -	traverse_pci_devices(pe_dn, count_non_bridge_devices, &counts);
> +	pci_traverse_device_nodes(pe_dn, count_non_bridge_devices, &counts);
>
>   	if (counts.num_devices == 0) {
>   		pr_err("rtas_msi: found 0 devices under PE for %s\n",
> @@ -320,7 +320,7 @@ static int msi_quota_for_device(struct pci_dev *dev, int request)
>   	/* else, we have some more calculating to do */
>   	counts.requestor = pci_device_to_OF_node(dev);
>   	counts.request = request;
> -	traverse_pci_devices(pe_dn, count_spare_msis, &counts);
> +	pci_traverse_device_nodes(pe_dn, count_spare_msis, &counts);
>
>   	/* If the quota isn't an integer multiple of the total, we can
>   	 * use the remainder as spare MSIs for anyone that wants them. */
>


-- 
Alexey
