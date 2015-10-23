Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCAD71A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 13:59:56 +1100 (AEDT)
Message-ID: <1445569177.701.133.camel@freescale.com>
Subject: Re: [PATCH v12 3/6] CPM/QE: use genalloc to manage CPM/QE muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Thu, 22 Oct 2015 21:59:37 -0500
In-Reply-To: <1444806968-4627-3-git-send-email-qiang.zhao@freescale.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-3-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-14 at 15:16 +0800, Zhao Qiang wrote:
> Use genalloc to manage CPM/QE muram instead of rheap.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> Changes for v9:
>       - splitted from patch 3/5, modify cpm muram management functions.
> Changes for v10:
>       - modify cpm muram first, then move to qe_common
>       - modify commit.
> Changes for v11:
>       - factor out the common alloc code
>       - modify min_alloc_order to zero for cpm_muram_alloc_fixed.
> Changes for v12:
>       - Nil 
> 
>  arch/powerpc/include/asm/cpm.h   |   1 +
>  arch/powerpc/platforms/Kconfig   |   2 +-
>  arch/powerpc/sysdev/cpm_common.c | 129 +++++++++++++++++++++++++++---------
> ---
>  3 files changed, 93 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
> index 4398a6c..0e1ac3f 100644
> --- a/arch/powerpc/include/asm/cpm.h
> +++ b/arch/powerpc/include/asm/cpm.h
> @@ -161,6 +161,7 @@ int cpm_muram_init(void);
>  unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
>  int cpm_muram_free(unsigned long offset);
>  unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long 
> size);
> +unsigned long cpm_muram_alloc_common(unsigned long size, void *data);
>  void __iomem *cpm_muram_addr(unsigned long offset);
>  unsigned long cpm_muram_offset(void __iomem *addr);
>  dma_addr_t cpm_muram_dma(void __iomem *addr);
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index b7f9c40..01626be7 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -275,7 +275,7 @@ config TAU_AVERAGE
>  config QUICC_ENGINE
>       bool "Freescale QUICC Engine (QE) Support"
>       depends on FSL_SOC && PPC32
> -     select PPC_LIB_RHEAP
> +     select GENERIC_ALLOCATOR
>       select CRC32
>       help
>         The QUICC Engine (QE) is a new generation of communications
> diff --git a/arch/powerpc/sysdev/cpm_common.c 
> b/arch/powerpc/sysdev/cpm_common.c
> index 4f78695..ff47072 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -17,6 +17,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/genalloc.h>
>  #include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/spinlock.h>
> @@ -27,7 +28,6 @@
>  
>  #include <asm/udbg.h>
>  #include <asm/io.h>
> -#include <asm/rheap.h>
>  #include <asm/cpm.h>
>  
>  #include <mm/mmu_decl.h>
> @@ -65,14 +65,22 @@ void __init udbg_init_cpm(void)
>  }
>  #endif
>  
> +static struct gen_pool *muram_pool;
>  static spinlock_t cpm_muram_lock;
> -static rh_block_t cpm_boot_muram_rh_block[16];
> -static rh_info_t cpm_muram_info;
>  static u8 __iomem *muram_vbase;
>  static phys_addr_t muram_pbase;
>  
> -/* Max address size we deal with */
> +struct muram_block {
> +     struct list_head head;
> +     unsigned long start;
> +     int size;
> +};
> +
> +static LIST_HEAD(muram_block_list);
> +
> +/* max address size we deal with */
>  #define OF_MAX_ADDR_CELLS    4
> +#define GENPOOL_OFFSET               (4096 * 8)
>  
>  int cpm_muram_init(void)
>  {
> @@ -87,50 +95,52 @@ int cpm_muram_init(void)
>               return 0;
>  
>       spin_lock_init(&cpm_muram_lock);
> -     /* initialize the info header */
> -     rh_init(&cpm_muram_info, 1,
> -             sizeof(cpm_boot_muram_rh_block) /
> -             sizeof(cpm_boot_muram_rh_block[0]),
> -             cpm_boot_muram_rh_block);
> -
>       np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
>       if (!np) {
>               /* try legacy bindings */
>               np = of_find_node_by_name(NULL, "data-only");
>               if (!np) {
> -                     printk(KERN_ERR "Cannot find CPM muram data node");
> +                     pr_err("Cannot find CPM muram data node");
>                       ret = -ENODEV;
> -                     goto out;
> +                     goto out_muram;
>               }
>       }
>  
> +     muram_pool = gen_pool_create(0, -1);
>       muram_pbase = of_translate_address(np, zero);
>       if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> -             printk(KERN_ERR "Cannot translate zero through CPM muram node");
> +             pr_err("Cannot translate zero through CPM muram node");
>               ret = -ENODEV;
> -             goto out;
> +             goto out_pool;
>       }
>  
>       while (of_address_to_resource(np, i++, &r) == 0) {
>               if (r.end > max)
>                       max = r.end;
> +             ret = gen_pool_add(muram_pool, r.start - muram_pbase +
> +                                GENPOOL_OFFSET, resource_size(&r), -1);
> +             if (ret) {
> +                             pr_err("QE: couldn't add muram to pool!\n");
> +                             goto out_pool;
> +                     }
>  

Whitespace

> -             rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
> -                              resource_size(&r));
>       }
>  
>       muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
>       if (!muram_vbase) {
> -             printk(KERN_ERR "Cannot map CPM muram");
> +             pr_err("Cannot map QE muram");
>               ret = -ENOMEM;
> +             goto out_pool;
>       }
> -
> -out:
> +     goto out_muram;
> +out_pool:
> +     gen_pool_destroy(muram_pool);
> +out_muram:
>       of_node_put(np);
>       return ret;
>  }
>  
> -/**
> +/*
>   * cpm_muram_alloc - allocate the requested size worth of multi-user ram
>   * @size: number of bytes to allocate
>   * @align: requested alignment, in bytes
> @@ -141,59 +151,102 @@ out:
>   */
>  unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
>  {
> -     unsigned long start;
>       unsigned long flags;
> -
> +     unsigned long start;
> +     static struct genpool_data_align muram_pool_data;
>       spin_lock_irqsave(&cpm_muram_lock, flags);
> -     cpm_muram_info.alignment = align;
> -     start = rh_alloc(&cpm_muram_info, size, "commproc");
> -     memset(cpm_muram_addr(start), 0, size);
> +     muram_pool_data.align = align;
> +     gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
> +                       &muram_pool_data);
> +     start = cpm_muram_alloc_common(size, &muram_pool_data);
>       spin_unlock_irqrestore(&cpm_muram_lock, flags);
> -
>       return start;
>  }
>  EXPORT_SYMBOL(cpm_muram_alloc);

Why is muram_pool_data static?  Why is it being passed to 
gen_pool_set_algo()?  The whole reason we're adding gen_pool_alloc_data() is 
to avoid that.  Do we need gen_pool_alloc_algo() too?

Also, please maintain a blank line between variable declarations and code.

> +     return (unsigned long) -ENOMEM;

No space after casts.

-Scott
