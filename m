Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6BFC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1063206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1063206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g6ZC0Z7zzDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g6XR1VnJzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 02:52:55 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4578F3097063;
 Thu, 11 Apr 2019 16:52:53 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 568F55C219;
 Thu, 11 Apr 2019 16:52:52 +0000 (UTC)
Date: Thu, 11 Apr 2019 10:52:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3] powerpc/powernv: Isolate NVLinks between
 GV100GL on Witherspoon
Message-ID: <20190411105251.20165f1d@x1.home>
In-Reply-To: <20190411064844.8241-1-aik@ozlabs.ru>
References: <20190411064844.8241-1-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 11 Apr 2019 16:52:53 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 11 Apr 2019 16:48:44 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
> (on POWER9) NVLinks. In addition to that, GPUs themselves have direct
> peer-to-peer NVLinks in groups of 2 to 4 GPUs with no buffers/latches
> between GPUs.
> 
> Because of these interconnected NVLinks, the POWERNV platform puts such
> interconnected GPUs to the same IOMMU group. However users want to pass
> GPUs through individually which requires separate IOMMU groups.
> 
> Thankfully V100 GPUs implement an interface to disable arbitrary links
> by programming link disabling mask via the GPU's BAR0. Once a link is
> disabled, it only can be enabled after performing the secondary bus reset
> (SBR) on the GPU. Since these GPUs do not advertise any other type of
> reset, it is reset by the platform's SBR handler.
> 
> This adds an extra step to the POWERNV's SBR handler to block NVLinks to
> GPUs which do not belong to the same group as the GPU being reset.
> 
> This adds a new "isolate_nvlink" kernel parameter to force GPU isolation;
> when enabled, every GPU gets placed in its own IOMMU group. The new
> parameter is off by default to preserve the existing behaviour.
> 
> Before isolating:
> [nvdbg ~]$ nvidia-smi topo -m
>         GPU0    GPU1    GPU2    CPU Affinity
> GPU0     X      NV2     NV2     0-0
> GPU1    NV2      X      NV2     0-0
> GPU2    NV2     NV2      X      0-0
> 
> After isolating:
> [nvdbg ~]$ nvidia-smi topo -m
>         GPU0    GPU1    GPU2    CPU Affinity
> GPU0     X      PHB     PHB     0-0
> GPU1    PHB      X      PHB     0-0
> GPU2    PHB     PHB      X      0-0
> 
> Where:
>   X    = Self
>   PHB  = Connection traversing PCIe as well as a PCIe Host Bridge (typically the CPU)
>   NV#  = Connection traversing a bonded set of # NVLinks
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * added pci_err() for failed ioremap
> * reworked commit log
> 
> v2:
> * this is rework of [PATCH kernel RFC 0/2] vfio, powerpc/powernv: Isolate GV100GL
> but this time it is contained in the powernv platform
> ---
>  arch/powerpc/platforms/powernv/Makefile      |   2 +-
>  arch/powerpc/platforms/powernv/pci.h         |   1 +
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   1 +
>  arch/powerpc/platforms/powernv/npu-dma.c     |  24 +++-
>  arch/powerpc/platforms/powernv/nvlinkgpu.c   | 137 +++++++++++++++++++
>  5 files changed, 162 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/nvlinkgpu.c
> 
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index da2e99efbd04..60a10d3b36eb 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -6,7 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
>  obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
> -obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
> +obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o nvlinkgpu.o
>  obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
>  obj-$(CONFIG_EEH)	+= eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 8e36da379252..9fd3f391482c 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -250,5 +250,6 @@ extern void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
>  extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  		void *tce_mem, u64 tce_size,
>  		u64 dma_offset, unsigned int page_shift);
> +extern void pnv_try_isolate_nvidia_v100(struct pci_dev *gpdev);
>  
>  #endif /* __POWERNV_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index f38078976c5d..464b097d9635 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -937,6 +937,7 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>  		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>  		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>  	}
> +	pnv_try_isolate_nvidia_v100(dev);
>  }
>  
>  static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index dc23d9d2a7d9..d4f9ee6222b5 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -22,6 +22,23 @@
>  
>  #include "pci.h"
>  
> +static bool isolate_nvlink;
> +
> +static int __init parse_isolate_nvlink(char *p)
> +{
> +	bool val;
> +
> +	if (!p)
> +		val = true;
> +	else if (kstrtobool(p, &val))
> +		return -EINVAL;
> +
> +	isolate_nvlink = val;
> +
> +	return 0;
> +}
> +early_param("isolate_nvlink", parse_isolate_nvlink);
> +
>  /*
>   * spinlock to protect initialisation of an npu_context for a particular
>   * mm_struct.
> @@ -549,7 +566,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
>  
>  	hose = pci_bus_to_host(npdev->bus);
>  
> -	if (hose->npu) {
> +	if (hose->npu && !isolate_nvlink) {
>  		table_group = &hose->npu->npucomp.table_group;
>  
>  		if (!table_group->group) {
> @@ -559,7 +576,10 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
>  					pe->pe_number);
>  		}
>  	} else {
> -		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> +		/*
> +		 * Create a group for 1 GPU and attached NPUs for
> +		 * POWER8 (always) or POWER9 (when isolate_nvlink).
> +		 */
>  		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
>  		table_group = &pe->npucomp->table_group;
>  		table_group->ops = &pnv_npu_peers_ops;
> diff --git a/arch/powerpc/platforms/powernv/nvlinkgpu.c b/arch/powerpc/platforms/powernv/nvlinkgpu.c
> new file mode 100644
> index 000000000000..2a97cb15b6d0
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/nvlinkgpu.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * A helper to disable NVLinks between GPUs on IBM Withersponn platform.
> + *
> + * Copyright (C) 2019 IBM Corp.  All rights reserved.
> + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +
> +static int nvlinkgpu_is_ph_in_group(struct device *dev, void *data)
> +{
> +	return dev->of_node->phandle == *(phandle *) data;
> +}
> +
> +static u32 nvlinkgpu_get_disable_mask(struct device *dev)
> +{
> +	int npu, peer;
> +	u32 mask;
> +	struct device_node *dn;
> +	struct iommu_group *group;
> +
> +	dn = dev->of_node;
> +	if (!of_find_property(dn, "ibm,nvlink-peers", NULL))
> +		return 0;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return 0;
> +
> +	/*
> +	 * Collect links to keep which includes links to NPU and links to
> +	 * other GPUs in the same IOMMU group.
> +	 */
> +	for (npu = 0, mask = 0; ; ++npu) {
> +		u32 npuph = 0;
> +
> +		if (of_property_read_u32_index(dn, "ibm,npu", npu, &npuph))
> +			break;
> +
> +		for (peer = 0; ; ++peer) {
> +			u32 peerph = 0;
> +
> +			if (of_property_read_u32_index(dn, "ibm,nvlink-peers",
> +					peer, &peerph))
> +				break;
> +
> +			if (peerph != npuph &&
> +				!iommu_group_for_each_dev(group, &peerph,
> +					nvlinkgpu_is_ph_in_group))
> +				continue;
> +
> +			mask |= 1 << (peer + 16);
> +		}
> +	}
> +	iommu_group_put(group);
> +
> +	/* Disabling mechanism takes links to disable so invert it here */
> +	mask = ~mask & 0x3F0000;
> +
> +	return mask;
> +}
> +
> +void pnv_try_isolate_nvidia_v100(struct pci_dev *bridge)
> +{
> +	u32 mask, val;
> +	void __iomem *bar0_0, *bar0_120000, *bar0_a00000;
> +	struct pci_dev *pdev;
> +	u16 cmd = 0, cmdmask = PCI_COMMAND_MEMORY;
> +
> +	if (!bridge->subordinate)
> +		return;
> +
> +	pdev = list_first_entry_or_null(&bridge->subordinate->devices,
> +			struct pci_dev, bus_list);
> +	if (!pdev)
> +		return;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
> +		return;
> +
> +	mask = nvlinkgpu_get_disable_mask(&pdev->dev);
> +	if (!mask)
> +		return;
> +
> +	bar0_0 = pci_iomap_range(pdev, 0, 0, 0x10000);
> +	if (!bar0_0) {
> +		pci_err(pdev, "Error mapping BAR0 @0\n");
> +		return;
> +	}
> +	bar0_120000 = pci_iomap_range(pdev, 0, 0x120000, 0x10000);
> +	if (!bar0_120000) {
> +		pci_err(pdev, "Error mapping BAR0 @120000\n");
> +		goto bar0_0_unmap;
> +	}
> +	bar0_a00000 = pci_iomap_range(pdev, 0, 0xA00000, 0x10000);
> +	if (!bar0_a00000) {
> +		pci_err(pdev, "Error mapping BAR0 @A00000\n");
> +		goto bar0_120000_unmap;
> +	}

Is it really necessary to do three separate ioremaps vs one that would
cover them all here?  I suspect you're just sneaking in PAGE_SIZE with
the 0x10000 size mappings anyway.  Seems like it would simplify setup,
error reporting, and cleanup to to ioremap to the PAGE_ALIGN'd range
of the highest register accessed. Thanks,

Alex

> +
> +	pci_restore_state(pdev);
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	if ((cmd & cmdmask) != cmdmask)
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd | cmdmask);
> +
> +	/*
> +	 * The sequence is from "Tesla P100 and V100 SXM2 NVLink Isolation on
> +	 * Multi-Tenant Systems".
> +	 * The register names are not provided there either, hence raw values.
> +	 */
> +	iowrite32(0x4, bar0_120000 + 0x4C);
> +	iowrite32(0x2, bar0_120000 + 0x2204);
> +	val = ioread32(bar0_0 + 0x200);
> +	val |= 0x02000000;
> +	iowrite32(val, bar0_0 + 0x200);
> +	val = ioread32(bar0_a00000 + 0x148);
> +	val |= mask;
> +	iowrite32(val, bar0_a00000 + 0x148);
> +
> +	if ((cmd | cmdmask) != cmd)
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	pci_iounmap(pdev, bar0_a00000);
> +bar0_120000_unmap:
> +	pci_iounmap(pdev, bar0_120000);
> +bar0_0_unmap:
> +	pci_iounmap(pdev, bar0_0);
> +}

