Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B6AABB6F64
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 12:25:38 +1100 (EST)
Message-ID: <1322789008.3729.42.camel@pasglop>
Subject: Re: [PATCH][v2] Enable CONFIG_STRICT_DEVMEM support for Powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 02 Dec 2011 12:23:28 +1100
In-Reply-To: <20111202001141.GA14860@us.ibm.com>
References: <20111202001141.GA14860@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 16:11 -0800, Sukadev Bhattiprolu wrote:
> >From aebed2e9fb9fba7dd0a34595780b828d7a545ba2 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Mon, 29 Aug 2011 14:12:08 -0700
> Subject: [PATCH 1/1][v2] Enable CONFIG_STRICT_DEVMEM support for Powerpc.
> 
> As described in the help text in the patch, this token restricts general
> access to /dev/mem as a way of increasing security. Specifically, access
> to exclusive IOMEM and kernel RAM is denied unless CONFIG_STRICT_DEVMEM is
> set to 'n'.
> 
> Implement the 'devmem_is_allowed()' interface for POWER. It will be
> called from range_is_allowed() when userpsace attempts to access /dev/mem.
> 
> This patch is based on an earlier patch from Steve Best and with input from
> Paul Mackerras.

A slightly different version of that patch is already in my -next branch
since earlier this week. Please send a followup patch adding the missing
rtas bit.

Note that I've dropped the generic printk change which has nothing to do
in that patch and can/should be submitted separately if it's really
needed.

Cheers,
Ben.


> A test for this patch:
> 
> 	# cat /proc/rtas/rmo_buffer 
> 	000000000f190000 10000
> 
> 	# python -c "print 0x000000000f190000 / 0x10000"
> 	3865
> 
> 	# dd if=/dev/mem of=/tmp/foo count=1 bs=64k skip=3865
> 	1+0 records in
> 	1+0 records out
> 	65536 bytes (66 kB) copied, 0.000205235 s, 319 MB/s
> 
> 	# dd if=/dev/mem of=/tmp/foo count=1 bs=64k skip=3864
> 	dd: reading `/dev/mem': Operation not permitted
> 	0+0 records in
> 	0+0 records out
> 	0 bytes (0 B) copied, 0.000226844 s, 0.0 kB/s
> 
> 	# dd if=/dev/mem of=/tmp/foo count=1 bs=64k skip=3866
> 	dd: reading `/dev/mem': Operation not permitted
> 	0+0 records in
> 	0+0 records out
> 	0 bytes (0 B) copied, 0.00023542 s, 0.0 kB/s
> 
> 	# dd if=/dev/mem of=/tmp/foo
> 	dd: reading `/dev/mem': Operation not permitted
> 	0+0 records in
> 	0+0 records out
> 	0 bytes (0 B) copied, 0.00022519 s, 0.0 kB/s
> 
> Changelog[v2]:
> 	- [Anton Blanchard] Punch a hole in devmem to allow librtas/dlpar
> 	  tools access to /dev/mem.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig.debug      |   12 ++++++++++++
>  arch/powerpc/include/asm/page.h |    1 +
>  arch/powerpc/kernel/rtas.c      |   10 ++++++++++
>  arch/powerpc/mm/mem.c           |   20 ++++++++++++++++++++
>  drivers/char/mem.c              |    5 +++--
>  5 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 067cb84..1cf1b00 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -298,4 +298,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
>  	  platform probing is done, all platforms selected must
>  	  share the same address.
>  
> +config STRICT_DEVMEM
> +	def_bool y
> +	prompt "Filter access to /dev/mem"
> +	help
> +	  This option restricts access to /dev/mem.  If this option is
> +	  disabled, you allow userspace access to all memory, including
> +	  kernel and userspace memory. Accidental memory access is likely
> +	  to be disastrous.
> +	  Memory access is required for experts who want to debug the kernel.
> +
> +	  If you are unsure, say Y.
> +
>  endmenu
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 2cd664e..dc2ec96 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -261,6 +261,7 @@ extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
>  extern void copy_user_page(void *to, void *from, unsigned long vaddr,
>  		struct page *p);
>  extern int page_is_ram(unsigned long pfn);
> +extern int devmem_is_allowed(unsigned long pfn);
>  
>  #ifdef CONFIG_PPC_SMLPAR
>  void arch_free_page(struct page *page, int order);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index d5ca823..07cf2cf 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -937,6 +937,16 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>  	return 0;
>  }
>  
> +int page_is_rtas(unsigned long pfn)
> +{
> +	unsigned long paddr = (pfn << PAGE_SHIFT);
> +
> +	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_RMOBUF_MAX))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Call early during boot, before mem init or bootmem, to retrieve the RTAS
>   * informations from the device-tree and allocate the RMO buffer for userland
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index c781bbc..d21dbc6 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -549,3 +549,23 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	hash_preload(vma->vm_mm, address, access, trap);
>  #endif /* CONFIG_PPC_STD_MMU */
>  }
> +
> +extern int page_is_rtas(unsigned long pfn);
> +
> +/*
> + * devmem_is_allowed(): check to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.
> + *
> + * Access has to be given to non-kernel-ram areas as well, these contain the
> + * PCI mmio resources as well as potential bios/acpi data regions.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))
> +		return 1;
> +	if (page_is_rtas(pfn))
> +		return 1;
> +	return 0;
> +}
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 8fc04b4..64917e8 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -29,6 +29,7 @@
>  
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> +#include <asm/page.h>
>  
>  #ifdef CONFIG_IA64
>  # include <linux/efi.h>
> @@ -66,8 +67,8 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
>  	while (cursor < to) {
>  		if (!devmem_is_allowed(pfn)) {
>  			printk(KERN_INFO
> -		"Program %s tried to access /dev/mem between %Lx->%Lx.\n",
> -				current->comm, from, to);
> +		"Program %s tried to access /dev/mem between %Lx->%Lx and "
> +			"pfn %lu.\n", current->comm, from, to, pfn);
>  			return 0;
>  		}
>  		cursor += PAGE_SIZE;
