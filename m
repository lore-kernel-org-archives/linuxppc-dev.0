Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B54F31A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 02:34:48 +1000 (AEST)
Message-ID: <1440434073.30043.21.camel@freescale.com>
Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Mon, 24 Aug 2015 11:34:33 -0500
In-Reply-To: <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
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

On Mon, 2015-08-24 at 17:31 +0800, Zhao Qiang wrote:
> muram is used for qe, add qe_muram_ functions to manage
> muram.
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
> Changes for v5:
>       - using genalloc instead rheap to manage QE MURAM
>       - remove qe_reset from platform file, using 
>       - subsys_initcall to call qe_init function.

This patch should come before the one that moves the code.

> diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
> new file mode 100644
> index 0000000..7f1762c
> --- /dev/null
> +++ b/drivers/soc/fsl/qe/qe_common.c
> @@ -0,0 +1,193 @@
> +/*
> + * common qe code
> + *
> + * author: scott wood <scottwood@freescale.com>
> + *
> + * copyright 2007-2008,2010 freescale Semiconductor, Inc.
> + *
> + * some parts derived from commproc.c/qe2_common.c, which is:
> + * copyright (c) 1997 dan error_act (dmalek@jlc.net)
> + * copyright (c) 1999-2001 dan Malek <dan@embeddedalley.com>
> + * copyright (c) 2000 montavista Software, Inc (source@mvista.com)
> + * 2006 (c) montavista software, Inc.
> + * vitaly bordug <vbordug@ru.mvista.com>

Why did you lowercase everyone's names?  Why is this copying code rather than 
moving it?


> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 55da07e..aaf3dc2 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -30,6 +30,7 @@
>  #ifndef __GENALLOC_H__
>  #define __GENALLOC_H__
>  
> +#include <linux/types.h>
>  #include <linux/spinlock_types.h>
>  
>  struct device;

This does not belong in this patch.


> @@ -187,12 +190,41 @@ static inline int qe_alive_during_sleep(void)
>  }
>  
>  /* we actually use cpm_muram implementation, define this for convenience */
> -#define qe_muram_init cpm_muram_init
> -#define qe_muram_alloc cpm_muram_alloc
> -#define qe_muram_alloc_fixed cpm_muram_alloc_fixed
> -#define qe_muram_free cpm_muram_free
> -#define qe_muram_addr cpm_muram_addr
> -#define qe_muram_offset cpm_muram_offset
> +int qe_muram_init(void);
> +
> +#if defined(CONFIG_QUICC_ENGINE)
> +unsigned long qe_muram_alloc(unsigned long size, unsigned long align);
> +int qe_muram_free(unsigned long offset);
> +void __iomem *qe_muram_addr(unsigned long offset);
> +unsigned long qe_muram_offset(void __iomem *addr);
> +dma_addr_t qe_muram_dma(void __iomem *addr);
> +#else
> +static inline unsigned long qe_muram_alloc(unsigned long size,
> +                                         unsigned long align)
> +{
> +     return -ENOSYS;
> +}

What code calls these functions without CONFIG_QUICC_ENGINE?

Are you converting qe without cpm?  Why?

-Scott
