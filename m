Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7XdF6LV0zDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 12:49:53 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id o1so15693546pga.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 18:49:53 -0700 (PDT)
Subject: Re: [PATCH kernel v2] powerpc/powernv: Reserve a hole which appears
 after enabling IOV
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20170927065231.20382-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5a9210f0-eaf5-856a-583c-482486e26d03@ozlabs.ru>
Date: Fri, 6 Oct 2017 12:49:44 +1100
MIME-Version: 1.0
In-Reply-To: <20170927065231.20382-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/09/17 16:52, Alexey Kardashevskiy wrote:
> In order to make generic IOV code work, the physical function IOV BAR
> should start from offset of the first VF. Since M64 segments share
> PE number space across PHB, and some PEs may be in use at the time
> when IOV is enabled, the existing code shifts the IOV BAR to the index
> of the first PE/VF. This creates a hole in IOMEM space which can be
> potentially taken by some other device.
> 
> This reserves a temporary hole on a parent and releases it when IOV is
> disabled; the temporary resources are stored in pci_dn to avoid
> kmalloc/free.
> 
> Cc: linux-pci@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>


Ben, Bjorn, ping?



> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I assume this goes to powerpc next branch but before this I'd like to
> get Bjorn's opinion as he continously commented on this bit.
> 
> This is the diff in /proc/iomem:
> 
> @@ -11,6 +11,7 @@
>          200800000000-200bffffffff : 0000:04:00.0
>  210000000000-21fdffffffff : /pciex@3fffe40100000
>    210000000000-21fdfff0ffff : PCI Bus 0001:01
> +    210000000000-210009ffffff : pnv_iov_reserved
>      21000a000000-2101ffffffff : 0001:01:00.0
>        21000a000000-21000bffffff : 0001:01:00.2
>          21000a000000-21000bffffff : mlx5_core
> 
> ---
> Changes:
> v2:
> * changed order - now devm_release_resource() is called before
> pci_update_resource(). Strangely the opposite did not produce a warning
> but still
> ---
>  arch/powerpc/include/asm/pci-bridge.h     |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c | 24 +++++++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 0b8aa1fe2d5f..62ed83db04ae 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -218,6 +218,7 @@ struct pci_dn {
>  #endif
>  	struct list_head child_list;
>  	struct list_head list;
> +	struct resource holes[PCI_SRIOV_NUM_BARS];
>  };
>  
>  /* Get the pointer to a device_node's pci_dn */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 57f9e55f4352..d66a758b8efb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1002,9 +1002,12 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  	}
>  
>  	/*
> -	 * After doing so, there would be a "hole" in the /proc/iomem when
> -	 * offset is a positive value. It looks like the device return some
> -	 * mmio back to the system, which actually no one could use it.
> +	 * Since M64 BAR shares segments among all possible 256 PEs,
> +	 * we have to shift the beginning of PF IOV BAR to make it start from
> +	 * the segment which belongs to the PE number assigned to the first VF.
> +	 * This creates a "hole" in the /proc/iomem which could be used for
> +	 * allocating other resources so we reserve this area below and
> +	 * release when IOV is released.
>  	 */
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -1018,7 +1021,22 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (%sabling %d VFs shifted by %d)\n",
>  			 i, &res2, res, (offset > 0) ? "En" : "Dis",
>  			 num_vfs, offset);
> +
> +		if (offset < 0) {
> +			devm_release_resource(&dev->dev, &pdn->holes[i]);
> +			memset(&pdn->holes[i], 0, sizeof(pdn->holes[i]));
> +		}
> +
>  		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
> +
> +		if (offset > 0) {
> +			pdn->holes[i].start = res2.start;
> +			pdn->holes[i].end = res2.start + size * offset - 1;
> +			pdn->holes[i].flags = IORESOURCE_BUS;
> +			pdn->holes[i].name = "pnv_iov_reserved";
> +			devm_request_resource(&dev->dev, res->parent,
> +					&pdn->holes[i]);
> +		}
>  	}
>  	return 0;
>  }
> 


-- 
Alexey
