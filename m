Return-Path: <jhubbard@nvidia.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvgpp5jw9zDr0V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 13:31:46 +1000 (AEST)
Subject: Re: [PATCH v3 1/6] mm, x86: Add ARCH_HAS_ZONE_DEVICE to Kconfig
To: Oliver O'Halloran <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
CC: <bsingharora@gmail.com>, <linux-mm@kvack.org>
References: <20170623083122.5992-1-oohall@gmail.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <ce32f815-24db-4656-78e2-df3af37da2bb@nvidia.com>
Date: Fri, 23 Jun 2017 20:26:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170623083122.5992-1-oohall@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2017 01:31 AM, Oliver O'Halloran wrote:
> Currently ZONE_DEVICE depends on X86_64 and this will get unwieldly as
> new architectures (and platforms) get ZONE_DEVICE support. Move to an
> arch selected Kconfig option to save us the trouble.
> 
> Cc: linux-mm@kvack.org
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v2: Added missing hunk.
> v3: No changes
> ---
>   arch/x86/Kconfig | 1 +
>   mm/Kconfig       | 6 +++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0efb4c9497bc..325429a3f32f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -59,6 +59,7 @@ config X86
>   	select ARCH_HAS_STRICT_KERNEL_RWX
>   	select ARCH_HAS_STRICT_MODULE_RWX
>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
> +	select ARCH_HAS_ZONE_DEVICE		if X86_64
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
>   	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/mm/Kconfig b/mm/Kconfig
> index beb7a455915d..790e52a8a486 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -683,12 +683,16 @@ config IDLE_PAGE_TRACKING
>   
>   	  See Documentation/vm/idle_page_tracking.txt for more details.
>   
> +# arch_add_memory() comprehends device memory
> +config ARCH_HAS_ZONE_DEVICE
> +	bool
> +
>   config ZONE_DEVICE
>   	bool "Device memory (pmem, etc...) hotplug support"
>   	depends on MEMORY_HOTPLUG
>   	depends on MEMORY_HOTREMOVE
>   	depends on SPARSEMEM_VMEMMAP
> -	depends on X86_64 #arch_add_memory() comprehends device memory
> +	depends on ARCH_HAS_ZONE_DEVICE
>   
>   	help
>   	  Device memory hotplug support allows for establishing pmem,
> 

Hi Oliver,

+1, this is nice to have, and it behaves as expected on x86_64 with and without HMM, at 
least with the small bit of Kconfig dependency testing I did here.

thanks,
john h
