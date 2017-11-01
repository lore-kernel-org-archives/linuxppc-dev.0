Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRdpG38PpzDqvq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 17:38:29 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id m81so3929939ioi.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 23:38:29 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA window size
 check
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 Nicholas Piggin <npiggin@gmail.com>, Jonas Pfefferle1 <JPF@zurich.ibm.com>
References: <20171031040427.10909-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fd1a289f-6698-0b84-eab8-d4c67290bea8@ozlabs.ru>
Date: Wed, 1 Nov 2017 17:38:20 +1100
MIME-Version: 1.0
In-Reply-To: <20171031040427.10909-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/10/17 15:04, Alexey Kardashevskiy wrote:
> DMA windows can only have a size of power of two on IODA2 hardware and
> using memory_hotplug_max() to determine the upper limit won't work
> correcly if it returns not power of two value.
> 
> This relaxes the check by rounding up the value returned by
> memory_hotplug_max().
> 
> It is expected to impact DPDK on machines with non-power-of-two RAM size,
> mostly. KVM guests are less likely to be affected as usually guests get
> less than half of hosts RAM.


It was pointed out that this check is quite useless anyway as the vm_locked
memory limit should hit first, and if that is not set or the user got the
root privilege level, then there are easier ways to crash the host so I am
thinking of:


diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
b/arch/powerpc/platforms/powernv/pci-ioda.c
index 269f119e4b3c..a47e4cf343b2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2769,7 +2769,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid,
__u64 bus_offset,
        if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
                return -EINVAL;

-       if ((window_size > memory_hotplug_max()) ||
!is_power_of_2(window_size))
+       if (!is_power_of_2(window_size))
                return -EINVAL;



Makes sense?


> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 269f119e4b3c..4c62162da181 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2769,7 +2769,8 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>  	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
>  		return -EINVAL;
>  
> -	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
> +	if ((window_size > roundup_pow_of_two(memory_hotplug_max())) ||
> +			!is_power_of_2(window_size))
>  		return -EINVAL;
>  
>  	/* Adjust direct table size from window_size and levels */
> 


-- 
Alexey
