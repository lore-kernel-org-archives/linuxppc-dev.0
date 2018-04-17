Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40QWWz0NYZzF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 02:52:46 +1000 (AEST)
Subject: Re: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
 other devices too
To: Nipun Gupta <nipun.gupta@nxp.com>, robh+dt@kernel.org,
 frowand.list@gmail.com
Cc: will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
 hch@lst.de, gregkh@linuxfoundation.org, joro@8bytes.org,
 m.szyprowski@samsung.com, shawnguo@kernel.org, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
Date: Tue, 17 Apr 2018 17:52:36 +0100
MIME-Version: 1.0
In-Reply-To: <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/04/18 11:21, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/iommu/of_iommu.c | 106 +++++++++++++++++++++++++++++++++++++++++++++--

Doesn't this break "msi-parent" parsing for !CONFIG_OF_IOMMU? I guess 
you don't want fsl-mc to have to depend on PCI, but this looks like a 
step in the wrong direction.

I'm not entirely sure where of_map_rid() fits best, but from a quick 
look around the least-worst option might be drivers/of/of_address.c, 
unless Rob and Frank have a better idea of where generic DT-based ID 
translation routines could live?

>   drivers/of/irq.c         |   6 +--
>   drivers/pci/of.c         | 101 --------------------------------------------
>   include/linux/of_iommu.h |  11 +++++
>   include/linux/of_pci.h   |  10 -----
>   5 files changed, 117 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c36a8b..4e7712f 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -138,6 +138,106 @@ static int of_iommu_xlate(struct device *dev,
>   	return ops->of_xlate(dev, iommu_spec);
>   }
>   
> +/**
> + * of_map_rid - Translate a requester ID through a downstream mapping.
> + * @np: root complex device node.
> + * @rid: device requester ID to map.
> + * @map_name: property name of the map to use.
> + * @map_mask_name: optional property name of the mask to use.
> + * @target: optional pointer to a target device node.
> + * @id_out: optional pointer to receive the translated ID.
> + *
> + * Given a device requester ID, look up the appropriate implementation-defined
> + * platform ID and/or the target device which receives transactions on that
> + * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
> + * @id_out may be NULL if only the other is required. If @target points to
> + * a non-NULL device node pointer, only entries targeting that node will be
> + * matched; if it points to a NULL value, it will receive the device node of
> + * the first matching target phandle, with a reference held.
> + *
> + * Return: 0 on success or a standard error code on failure.
> + */
> +int of_map_rid(struct device_node *np, u32 rid,
> +		   const char *map_name, const char *map_mask_name,
> +		   struct device_node **target, u32 *id_out)
> +{
> +	u32 map_mask, masked_rid;
> +	int map_len;
> +	const __be32 *map = NULL;
> +
> +	if (!np || !map_name || (!target && !id_out))
> +		return -EINVAL;
> +
> +	map = of_get_property(np, map_name, &map_len);
> +	if (!map) {
> +		if (target)
> +			return -ENODEV;
> +		/* Otherwise, no map implies no translation */
> +		*id_out = rid;
> +		return 0;
> +	}
> +
> +	if (!map_len || map_len % (4 * sizeof(*map))) {
> +		pr_err("%pOF: Error: Bad %s length: %d\n", np,
> +			map_name, map_len);
> +		return -EINVAL;
> +	}
> +
> +	/* The default is to select all bits. */
> +	map_mask = 0xffffffff;
> +
> +	/*
> +	 * Can be overridden by "{iommu,msi}-map-mask" property.
> +	 */
> +	if (map_mask_name)
> +		of_property_read_u32(np, map_mask_name, &map_mask);
> +
> +	masked_rid = map_mask & rid;
> +	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> +		struct device_node *phandle_node;
> +		u32 rid_base = be32_to_cpup(map + 0);
> +		u32 phandle = be32_to_cpup(map + 1);
> +		u32 out_base = be32_to_cpup(map + 2);
> +		u32 rid_len = be32_to_cpup(map + 3);
> +
> +		if (rid_base & ~map_mask) {
> +			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
> +				np, map_name, map_name,
> +				map_mask, rid_base);
> +			return -EFAULT;
> +		}
> +
> +		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
> +			continue;
> +
> +		phandle_node = of_find_node_by_phandle(phandle);
> +		if (!phandle_node)
> +			return -ENODEV;
> +
> +		if (target) {
> +			if (*target)
> +				of_node_put(phandle_node);
> +			else
> +				*target = phandle_node;
> +
> +			if (*target != phandle_node)
> +				continue;
> +		}
> +
> +		if (id_out)
> +			*id_out = masked_rid - rid_base + out_base;
> +
> +		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
> +			np, map_name, map_mask, rid_base, out_base,
> +			rid_len, rid, masked_rid - rid_base + out_base);
> +		return 0;
> +	}
> +
> +	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
> +		np, map_name, rid, target && *target ? *target : NULL);
> +	return -EFAULT;
> +}
> +
>   struct of_pci_iommu_alias_info {
>   	struct device *dev;
>   	struct device_node *np;
> @@ -149,9 +249,9 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>   	struct of_phandle_args iommu_spec = { .args_count = 1 };
>   	int err;
>   
> -	err = of_pci_map_rid(info->np, alias, "iommu-map",
> -			     "iommu-map-mask", &iommu_spec.np,
> -			     iommu_spec.args);
> +	err = of_map_rid(info->np, alias, "iommu-map",
> +			 "iommu-map-mask", &iommu_spec.np,
> +			 iommu_spec.args);

Super-nit: Apparently I missed rewrapping this to 2 lines in 
d87beb749281, but if it's being touched again, that would be nice ;)

Robin.

>   	if (err)
>   		return err == -ENODEV ? NO_IOMMU : err;
>   
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 02ad93a..b72eeec 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -22,7 +22,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
> -#include <linux/of_pci.h>
> +#include <linux/of_iommu.h>
>   #include <linux/string.h>
>   #include <linux/slab.h>
>   
> @@ -588,8 +588,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>   	 * "msi-map" property.
>   	 */
>   	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> -		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
> -				    "msi-map-mask", np, &rid_out))
> +		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
> +				"msi-map-mask", np, &rid_out))
>   			break;
>   	return rid_out;
>   }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a28355c..d2cebbe 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -362,107 +362,6 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>   EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
>   #endif /* CONFIG_OF_ADDRESS */
>   
> -/**
> - * of_pci_map_rid - Translate a requester ID through a downstream mapping.
> - * @np: root complex device node.
> - * @rid: PCI requester ID to map.
> - * @map_name: property name of the map to use.
> - * @map_mask_name: optional property name of the mask to use.
> - * @target: optional pointer to a target device node.
> - * @id_out: optional pointer to receive the translated ID.
> - *
> - * Given a PCI requester ID, look up the appropriate implementation-defined
> - * platform ID and/or the target device which receives transactions on that
> - * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
> - * @id_out may be NULL if only the other is required. If @target points to
> - * a non-NULL device node pointer, only entries targeting that node will be
> - * matched; if it points to a NULL value, it will receive the device node of
> - * the first matching target phandle, with a reference held.
> - *
> - * Return: 0 on success or a standard error code on failure.
> - */
> -int of_pci_map_rid(struct device_node *np, u32 rid,
> -		   const char *map_name, const char *map_mask_name,
> -		   struct device_node **target, u32 *id_out)
> -{
> -	u32 map_mask, masked_rid;
> -	int map_len;
> -	const __be32 *map = NULL;
> -
> -	if (!np || !map_name || (!target && !id_out))
> -		return -EINVAL;
> -
> -	map = of_get_property(np, map_name, &map_len);
> -	if (!map) {
> -		if (target)
> -			return -ENODEV;
> -		/* Otherwise, no map implies no translation */
> -		*id_out = rid;
> -		return 0;
> -	}
> -
> -	if (!map_len || map_len % (4 * sizeof(*map))) {
> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
> -			map_name, map_len);
> -		return -EINVAL;
> -	}
> -
> -	/* The default is to select all bits. */
> -	map_mask = 0xffffffff;
> -
> -	/*
> -	 * Can be overridden by "{iommu,msi}-map-mask" property.
> -	 * If of_property_read_u32() fails, the default is used.
> -	 */
> -	if (map_mask_name)
> -		of_property_read_u32(np, map_mask_name, &map_mask);
> -
> -	masked_rid = map_mask & rid;
> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> -		struct device_node *phandle_node;
> -		u32 rid_base = be32_to_cpup(map + 0);
> -		u32 phandle = be32_to_cpup(map + 1);
> -		u32 out_base = be32_to_cpup(map + 2);
> -		u32 rid_len = be32_to_cpup(map + 3);
> -
> -		if (rid_base & ~map_mask) {
> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
> -				np, map_name, map_name,
> -				map_mask, rid_base);
> -			return -EFAULT;
> -		}
> -
> -		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
> -			continue;
> -
> -		phandle_node = of_find_node_by_phandle(phandle);
> -		if (!phandle_node)
> -			return -ENODEV;
> -
> -		if (target) {
> -			if (*target)
> -				of_node_put(phandle_node);
> -			else
> -				*target = phandle_node;
> -
> -			if (*target != phandle_node)
> -				continue;
> -		}
> -
> -		if (id_out)
> -			*id_out = masked_rid - rid_base + out_base;
> -
> -		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
> -			np, map_name, map_mask, rid_base, out_base,
> -			rid_len, rid, masked_rid - rid_base + out_base);
> -		return 0;
> -	}
> -
> -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
> -		np, map_name, rid, target && *target ? *target : NULL);
> -	return -EFAULT;
> -}
> -
>   #if IS_ENABLED(CONFIG_OF_IRQ)
>   /**
>    * of_irq_parse_pci - Resolve the interrupt for a PCI device
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 4fa654e..432b53c 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -15,6 +15,10 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>   extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					struct device_node *master_np);
>   
> +int of_map_rid(struct device_node *np, u32 rid,
> +	       const char *map_name, const char *map_mask_name,
> +	       struct device_node **target, u32 *id_out);
> +
>   #else
>   
>   static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -30,6 +34,13 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	return NULL;
>   }
>   
> +static inline int of_map_rid(struct device_node *np, u32 rid,
> +			     const char *map_name, const char *map_mask_name,
> +			     struct device_node **target, u32 *id_out)
> +{
> +	return -EINVAL;
> +}
> +
>   #endif	/* CONFIG_OF_IOMMU */
>   
>   extern struct of_device_id __iommu_of_table;
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 091033a..a23b44a 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -17,9 +17,6 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>   int of_get_pci_domain_nr(struct device_node *node);
>   int of_pci_get_max_link_speed(struct device_node *node);
>   void of_pci_check_probe_only(void);
> -int of_pci_map_rid(struct device_node *np, u32 rid,
> -		   const char *map_name, const char *map_mask_name,
> -		   struct device_node **target, u32 *id_out);
>   #else
>   static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
>   					     unsigned int devfn)
> @@ -44,13 +41,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
>   	return -1;
>   }
>   
> -static inline int of_pci_map_rid(struct device_node *np, u32 rid,
> -			const char *map_name, const char *map_mask_name,
> -			struct device_node **target, u32 *id_out)
> -{
> -	return -EINVAL;
> -}
> -
>   static inline int
>   of_pci_get_max_link_speed(struct device_node *node)
>   {
> 
