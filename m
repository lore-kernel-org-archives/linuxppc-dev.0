Return-Path: <jstancek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EE291A1E63
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 04:01:30 +1000 (AEST)
Date: Fri, 4 Sep 2015 20:01:22 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@in.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/powernv/pci-ioda: fix kdump with non-power-of-2
 crashkernel=
Message-ID: <20150904180108.GA30660@dustball.brq.redhat.com>
References: <20150904165938.GL47557@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150904165938.GL47557@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 04, 2015 at 09:59:38AM -0700, Nishanth Aravamudan wrote:
> The 32-bit TCE table initialization relies on the DMA window having a
> size equal to a power of 2 (and checks for it explicitly). But
> crashkernel= has no constraint that requires a power-of-2 be specified.
> This causes the kdump kernel to fail to boot as none of the PCI devices
> (including the disk controller) are successfully initialized.
> 
> After this change, the PCI devices successfully set up the 32-bit TCE
> table and kdump succeeds.
> 
> Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org # 4.2
> ---
> 
> Michael, I did this as a follow-on patch to my previous one. If you'd
> rather I made a v3 of that patch with the two fixes combined, I can
> resend.
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index f1c74c28e564..73914f4bd1ab 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2084,6 +2084,12 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
>  	 */
>  	const u64 window_size =
>  		min((u64)pe->table_group.tce32_size, memory_hotplug_max());
> +	/*
> +	 * crashkernel= specifies the kdump kernel's maximum memory at
> +	 * some offset and there is no guaranteed the result is a power
> +	 * of 2, which will cause errors later.
> +	 */
> +	window_size = __rounddown_pow_of_two(window_size);

Hi,

Just wondering if this won't hide potential alignment issues of
"table_group.tce32_size", that now trigger EINVAL down the road
and if it wouldn't be safer to round only "memory_hotplug_max()?

  const __u64 hotplug_max_p2 = __rounddown_pow_of_two(memory_hotplug_max());
  const __u64 window_size =
            min((u64)pe->table_group.tce32_size, hotplug_max_p2);

Regards,
Jan

>  
>  	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
>  			IOMMU_PAGE_SHIFT_4K,
