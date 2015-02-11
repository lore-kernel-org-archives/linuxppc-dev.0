Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AB0E1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:11:34 +1100 (AEDT)
Message-ID: <1423620688.5891.30.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/boot/fdt: Add little-endian support to
 libfdt wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 13:11:28 +1100
In-Reply-To: <1423570510.218330.214724142596.1.gpush@pablo>
References: <1423570510.218330.214724142596.1.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 20:15 +0800, Jeremy Kerr wrote:
> For epapr-style boot, we may be little-endian. This change implements
> the proper conversion for fdt*_to_cpu and cpu_to_fdt*. We also need the
> full cpu_to_* and *_to_cpu macros for this.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/boot/libfdt_env.h |   14 ++++++++------
>  arch/powerpc/boot/of.h         |    8 ++++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
> index c89fdb1..8dcd744 100644
> --- a/arch/powerpc/boot/libfdt_env.h
> +++ b/arch/powerpc/boot/libfdt_env.h
> @@ -4,15 +4,17 @@
>  #include <types.h>
>  #include <string.h>
>  
> +#include "of.h"
> +
>  typedef u32 uint32_t;
>  typedef u64 uint64_t;
>  typedef unsigned long uintptr_t;
>  
> -#define fdt16_to_cpu(x)		(x)
> -#define cpu_to_fdt16(x)		(x)
> -#define fdt32_to_cpu(x)		(x)
> -#define cpu_to_fdt32(x)		(x)
> -#define fdt64_to_cpu(x)		(x)
> -#define cpu_to_fdt64(x)		(x)
> +#define fdt16_to_cpu(x)		be16_to_cpu(x)
> +#define cpu_to_fdt16(x)		cpu_to_be16(x)
> +#define fdt32_to_cpu(x)		be32_to_cpu(x)
> +#define cpu_to_fdt32(x)		cpu_to_be32(x)
> +#define fdt64_to_cpu(x)		be64_to_cpu(x)
> +#define cpu_to_fdt64(x)		cpu_to_be64(x)
>  
>  #endif /* _ARCH_POWERPC_BOOT_LIBFDT_ENV_H */
> diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
> index c8c1750..5603320 100644
> --- a/arch/powerpc/boot/of.h
> +++ b/arch/powerpc/boot/of.h
> @@ -24,11 +24,19 @@ void of_console_init(void);
>  typedef u32			__be32;
>  
>  #ifdef __LITTLE_ENDIAN__
> +#define cpu_to_be16(x) swab16(x)
> +#define be16_to_cpu(x) swab16(x)
>  #define cpu_to_be32(x) swab32(x)
>  #define be32_to_cpu(x) swab32(x)
> +#define cpu_to_be64(x) swab64(x)
> +#define be64_to_cpu(x) swab64(x)
>  #else
> +#define cpu_to_be16(x) (x)
> +#define be16_to_cpu(x) (x)
>  #define cpu_to_be32(x) (x)
>  #define be32_to_cpu(x) (x)
> +#define cpu_to_be64(x) (x)
> +#define be64_to_cpu(x) (x)
>  #endif
>  
>  #define PROM_ERROR (-1u)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
