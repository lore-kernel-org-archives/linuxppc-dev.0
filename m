Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A09281A09F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:10:20 +1100 (AEDT)
Message-ID: <1445569799.701.142.camel@freescale.com>
Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management functions to
 qe_common
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Thu, 22 Oct 2015 22:09:59 -0500
In-Reply-To: <1444806968-4627-4-git-send-email-qiang.zhao@freescale.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-4-git-send-email-qiang.zhao@freescale.com>
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
> QE and CPM have the same muram, they use the same management
> functions. Now QE support both ARM and PowerPC, it is necessary
> to move QE to "driver/soc", so move the muram management functions
> from cpm_common to qe_common for preparing to move QE code to "driver/soc"
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> Changes for v2:
>       - no changes
> Changes for v3:
>       - no changes
> Changes for v4:
>       - no changes
> Changes for v5:
>       - no changes
> Changes for v6:
>       - using genalloc instead rheap to manage QE MURAM
>       - remove qe_reset from platform file, using 
>       - subsys_initcall to call qe_init function.
> Changes for v7:
>       - move this patch from 3/3 to 2/3
>       - convert cpm with genalloc
>       - check for gen_pool allocation failure
> Changes for v8:
>       - rebase
>       - move BD_SC_* macro instead of copy
> Changes for v9:
>       - doesn't modify CPM, add a new patch to modify.
>       - rebase
> Changes for v10:
>       - rebase
> Changes for v11:
>       - remove renaming
>       - delete removing qe_reset and delete adding qe_init.
> Changes for v12:
>       - SPI_FSL_CPM depends on QE-MURAM, select QUICC_ENGINE for it. 

Why is the SPI change part of this patch?  Why is it even part of this 
patchset, rather than an independent patch sent to the SPI list and 
maintainer?  If it's tied to other changes you're making, explain that.  As 
is, there is zero mention of the SPI change in the part of the e-mail that 
will become the git changelog.

> 
>  arch/powerpc/include/asm/cpm.h                     |  44 -----
>  arch/powerpc/include/asm/qe.h                      |  16 ++
>  arch/powerpc/sysdev/cpm_common.c                   | 210 +-----------------
> ---
>  arch/powerpc/sysdev/qe_lib/Makefile                |   2 +-
>  .../sysdev/{cpm_common.c => qe_lib/qe_common.c}    | 188 +-----------------
>  drivers/spi/Kconfig                                |   1 +
>  6 files changed, 28 insertions(+), 433 deletions(-)
>  copy arch/powerpc/sysdev/{cpm_common.c => qe_lib/qe_common.c} (54%)
> 
> diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
> index 0e1ac3f..05a1c15 100644
> --- a/arch/powerpc/include/asm/cpm.h
> +++ b/arch/powerpc/include/asm/cpm.h
> @@ -155,50 +155,6 @@ typedef struct cpm_buf_desc {
>   */
>  #define BD_I2C_START         (0x0400)
>  
> -int cpm_muram_init(void);
> -
> -#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
> -unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
> -int cpm_muram_free(unsigned long offset);
> -unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long 
> size);
> -unsigned long cpm_muram_alloc_common(unsigned long size, void *data);
> -void __iomem *cpm_muram_addr(unsigned long offset);
> -unsigned long cpm_muram_offset(void __iomem *addr);
> -dma_addr_t cpm_muram_dma(void __iomem *addr);
> -#else
> -static inline unsigned long cpm_muram_alloc(unsigned long size,
> -                                         unsigned long align)
> -{
> -     return -ENOSYS;
> -}
> -
> -static inline int cpm_muram_free(unsigned long offset)
> -{
> -     return -ENOSYS;
> -}
> -
> -static inline unsigned long cpm_muram_alloc_fixed(unsigned long offset,
> -                                               unsigned long size)
> -{
> -     return -ENOSYS;
> -}
> -
> -static inline void __iomem *cpm_muram_addr(unsigned long offset)
> -{
> -     return NULL;
> -}
> -
> -static inline unsigned long cpm_muram_offset(void __iomem *addr)
> -{
> -     return -ENOSYS;
> -}
> -
> -static inline dma_addr_t cpm_muram_dma(void __iomem *addr)
> -{
> -     return 0;
> -}
> -#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
> -
>  #ifdef CONFIG_CPM
>  int cpm_command(u32 command, u8 opcode);
>  #else
> diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
> index 32b9bfa..c2dd8e6 100644
> --- a/arch/powerpc/include/asm/qe.h
> +++ b/arch/powerpc/include/asm/qe.h
> @@ -16,11 +16,15 @@
>  #define _ASM_POWERPC_QE_H
>  #ifdef __KERNEL__
>  
> +#include <linux/compiler.h>
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <asm/cpm.h>
>  #include <asm/immap_qe.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/types.h>
>  
>  #define QE_NUM_OF_SNUM       256     /* There are 256 serial number in QE */
>  #define QE_NUM_OF_BRGS       16
> @@ -92,6 +96,18 @@ extern void qe_reset(void);
>  static inline void qe_reset(void) {}
>  #endif
>  
> +int cpm_muram_init(void);
> +
> +#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
> +unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
> +int cpm_muram_free(unsigned long offset);
> +unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long 
> size);
> +unsigned long cpm_muram_alloc_common(unsigned long size, void *data);
> +void __iomem *cpm_muram_addr(unsigned long offset);
> +unsigned long cpm_muram_offset(void __iomem *addr);
> +dma_addr_t cpm_muram_dma(void __iomem *addr);
> +#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */

Why did you eliminate the stubs for when CPM/QUICC_ENGINE aren't selected?


> diff --git a/arch/powerpc/sysdev/cpm_common.c 
> b/arch/powerpc/sysdev/qe_lib/qe_common.c
> similarity index 54%
> copy from arch/powerpc/sysdev/cpm_common.c
> copy to arch/powerpc/sysdev/qe_lib/qe_common.c
> index ff47072..0aa74ca 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
> @@ -1,23 +1,18 @@
>  /*
> - * Common CPM code
> + * Freescale QE common code
>   *
> - * Author: Scott Wood <scottwood@freescale.com>
> + * Author: Zhao Qiang  <qiang.zhao@freescale.com>
>   *
> - * Copyright 2007-2008,2010 Freescale Semiconductor, Inc.
> - *
> - * Some parts derived from commproc.c/cpm2_common.c, which is:
> - * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
> - * Copyright (c) 1999-2001 Dan Malek <dan@embeddedalley.com>
> - * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
> - * 2006 (c) MontaVista Software, Inc.
> - * Vitaly Bordug <vbordug@ru.mvista.com>
> + * Copyright 2015 Freescale Semiconductor, Inc.

Please keep copyright notices intact when creating a new file derived from an 
existing file, unless you can show via git history that none of the lines 
copied are relevant.

Certainly not all of this code was first published in 2015.

>   *
>   * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

You don't get to add that "any later version" option to existing code 
copyrighted by others.

-Scott
