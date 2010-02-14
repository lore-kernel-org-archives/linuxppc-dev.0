Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 341FAB7D90
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 17:11:42 +1100 (EST)
Subject: Re: [PATCH 4/9] of/flattree: Don't assume HAVE_LMB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100213160247.4767.74578.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160247.4767.74578.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Feb 2010 17:11:23 +1100
Message-ID: <1266127883.16346.61.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> We don't always have lmb available, so make arches provide an
> early_init_dt_alloc_memory_arch() to handle the allocation of
> memory in the fdt code.
> 
> When we don't have lmb.h included, we need asm/page.h for __va.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  arch/microblaze/kernel/prom.c |    5 +++++
>  arch/powerpc/kernel/prom.c    |    5 +++++
>  drivers/of/fdt.c              |    9 ++++++---
>  include/linux/of_fdt.h        |    1 +
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 050b799..a7dcaf0 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -55,6 +55,11 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  	lmb_add(base, size);
>  }
>  
> +u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> +{
> +	return lmb_alloc(size, align);
> +}
> +
>  #ifdef CONFIG_EARLY_PRINTK
>  /* MS this is Microblaze specifig function */
>  static int __init early_init_dt_scan_serial(unsigned long node,
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 43c78d7..5bbbdb2 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -510,6 +510,11 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  	memstart_addr = min((u64)memstart_addr, base);
>  }
>  
> +u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> +{
> +	return lmb_alloc(size, align);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void __init early_init_dt_setup_initrd_arch(unsigned long start,
>  		unsigned long end)
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index b51f797..406757a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -10,16 +10,18 @@
>   */
>  
>  #include <linux/kernel.h>
> -#include <linux/lmb.h>
>  #include <linux/initrd.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> -
> +#include <linux/string.h>
> +#include <linux/errno.h>
>  
>  #ifdef CONFIG_PPC
>  #include <asm/machdep.h>
>  #endif /* CONFIG_PPC */
>  
> +#include <asm/page.h>
> +
>  int __initdata dt_root_addr_cells;
>  int __initdata dt_root_size_cells;
>  
> @@ -560,7 +562,8 @@ void __init unflatten_device_tree(void)
>  	pr_debug("  size is %lx, allocating...\n", size);
>  
>  	/* Allocate memory for the expanded device tree */
> -	mem = lmb_alloc(size + 4, __alignof__(struct device_node));
> +	mem = early_init_dt_alloc_memory_arch(size + 4,
> +			__alignof__(struct device_node));
>  	mem = (unsigned long) __va(mem);
>  
>  	((__be32 *)mem)[size / 4] = cpu_to_be32(0xdeadbeef);
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index c9cb8a7..a1ca92c 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -78,6 +78,7 @@ extern void early_init_dt_check_for_initrd(unsigned long node);
>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>  				     int depth, void *data);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
> +extern u64 early_init_dt_alloc_memory_arch(u64 size, u64 align);
>  extern u64 dt_mem_next_cell(int s, __be32 **cellp);
>  
>  /*
