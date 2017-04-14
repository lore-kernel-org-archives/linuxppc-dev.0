Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4XDt43PszDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 08:21:18 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3EMJ0Rh035881
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 18:21:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29teu5sqx4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 18:21:12 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 16:21:11 -0600
Subject: Re: [PATCH 4/5] pseries/hotplug init: Convert new DRC memory property
 for hotplug runtime
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <149202212688.38498.11025778802721939795.stgit@powerkvm6.aus.stglabs.ibm.com>
 <149202223617.38498.4163495496103882812.stgit@powerkvm6.aus.stglabs.ibm.com>
Cc: nfont@linux.vnet.ibm.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 15:21:05 -0700
MIME-Version: 1.0
In-Reply-To: <149202223617.38498.4163495496103882812.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5cc09ba7-c9d8-8d88-1dc8-6c5ebb31a1bd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/12/2017 11:37 AM, Michael Bringmann wrote:
> hotplug_init: Simplify the code needed for runtime memory hotplug and
> maintenance with a conversion routine that transforms the compressed
> property "ibm,dynamic-memory-v2" to the form of "ibm,dynamic-memory"
> within the "ibm,dynamic-reconfiguration-memory" property.  Thus only

ibm,dynamic-reconfiguration-memory is a device tree node not a property.
So, s/property/node.

-Tyrel

> a single set of routines should be required at runtime to parse, edit,
> and manipulate the memory representation in the device tree.  Similarly,
> any userspace applications that need this information will only need
> to recognize the older format to be able to continue to operate.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/Makefile         |    4 -
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   96 +++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> index 8f4ba08..87eb665 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -5,14 +5,14 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
>  			   of_helpers.o \
>  			   setup.o iommu.o event_sources.o ras.o \
>  			   firmware.o power.o dlpar.o mobility.o rng.o \
> -			   pci.o pci_dlpar.o eeh_pseries.o msi.o
> +			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
> +			   hotplug-memory.o
>  obj-$(CONFIG_SMP)	+= smp.o
>  obj-$(CONFIG_SCANLOG)	+= scanlog.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
>  obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
> 
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
> -obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
> 
>  obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
>  obj-$(CONFIG_HVCS)		+= hvcserver.o
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index e104c71..92f41a1 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -24,8 +24,6 @@
>  #include <asm/sparsemem.h>
>  #include "pseries.h"
> 
> -static bool rtas_hp_event;
> -
>  unsigned long pseries_memory_block_size(void)
>  {
>  	struct device_node *np;
> @@ -69,6 +67,10 @@ unsigned long pseries_memory_block_size(void)
>  	return memblock_size;
>  }
> 
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +
> +static bool rtas_hp_event;
> +
>  static void dlpar_free_property(struct property *prop)
>  {
>  	kfree(prop->name);
> @@ -1165,11 +1167,101 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>  static struct notifier_block pseries_mem_nb = {
>  	.notifier_call = pseries_memory_notifier,
>  };
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> +
> +static int pseries_rewrite_dynamic_memory_v2(void)
> +{
> +	unsigned long memblock_size;
> +	struct device_node *dn;
> +	struct property *prop, *prop_v2;
> +	__be32 *p;
> +	struct of_drconf_cell *lmbs;
> +	u32 num_lmb_desc_sets, num_lmbs;
> +	int i, j, k;
> +
> +	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (!dn)
> +		return -EINVAL;
> +
> +	prop_v2 = of_find_property(dn, "ibm,dynamic-memory-v2", NULL);
> +	if (!prop_v2)
> +		return -EINVAL;
> +
> +	memblock_size = pseries_memory_block_size();
> +	if (!memblock_size)
> +		return -EINVAL;
> +
> +	/* The first int of the property is the number of lmb sets
> +	 * described by the property.
> +	 */
> +	p = (__be32 *)prop_v2->value;
> +	num_lmb_desc_sets = be32_to_cpu(*p++);
> +
> +	/* Count the number of LMBs for generating the alternate format
> +	 */
> +	for (i = 0, num_lmbs = 0; i < num_lmb_desc_sets; i++) {
> +		struct of_drconf_cell_v2 drmem;
> +
> +		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
> +		num_lmbs += drmem.num_seq_lmbs;
> +	}
> +
> +	/* Create an empty copy of the new 'ibm,dynamic-memory' property
> +	 */
> +	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +	if (!prop)
> +		return -ENOMEM;
> +	prop->name = kstrdup("ibm,dynamic-memory", GFP_KERNEL);
> +	prop->length = dyn_mem_v2_len(num_lmbs);
> +	prop->value = kzalloc(prop->length, GFP_KERNEL);
> +
> +	/* Copy/expand the ibm,dynamic-memory-v2 format to produce the
> +	 * ibm,dynamic-memory format.
> +	 */
> +	p = (__be32 *)prop->value;
> +	*p = cpu_to_be32(num_lmbs);
> +	p++;
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	p = (__be32 *)prop_v2->value;
> +	p++;
> +
> +	for (i = 0, k = 0; i < num_lmb_desc_sets; i++) {
> +		struct of_drconf_cell_v2 drmem;
> +
> +		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
> +
> +		for (j = 0; j < drmem.num_seq_lmbs; j++) {
> +			lmbs[k+j].base_addr = be64_to_cpu(drmem.base_addr);
> +			lmbs[k+j].drc_index = be32_to_cpu(drmem.drc_index);
> +			lmbs[k+j].aa_index  = be32_to_cpu(drmem.aa_index);
> +			lmbs[k+i].flags     = be32_to_cpu(drmem.flags);
> +
> +			drmem.base_addr += memblock_size;
> +			drmem.drc_index++;
> +		}
> +
> +		k += drmem.num_seq_lmbs;
> +	}
> +
> +	of_remove_property(dn, prop_v2);
> +
> +	of_add_property(dn, prop);
> +
> +	/* And disable feature flag since the property has gone away */
> +	powerpc_firmware_features &= ~FW_FEATURE_DYN_MEM_V2;
> +
> +	return 0;
> +}
> 
>  static int __init pseries_memory_hotplug_init(void)
>  {
> +	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2))
> +		pseries_rewrite_dynamic_memory_v2();
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
>  		of_reconfig_notifier_register(&pseries_mem_nb);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> 
>  	return 0;
>  }
> 
