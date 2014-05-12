Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28FC3140084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 10:42:21 +1000 (EST)
Message-ID: <1399855324.17624.53.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix skipping call to
 early_init_fdt_scan_reserved_mem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Mon, 12 May 2014 10:42:04 +1000
In-Reply-To: <1398837832-30052-1-git-send-email-robherring2@gmail.com>
References: <1398837832-30052-1-git-send-email-robherring2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-30 at 01:03 -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The call to early_init_fdt_scan_reserved_mem will be skipped if
> reserved-ranges is not found. Move the call earlier so that it is called
> unconditionally.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Tested-by: Stephen Chivers <schivers@csc.com>
> ---
> I found this issue in testing of my fdt clean-up series (thanks to 
> Stephen). Since the reserved memory support is new, I don't think it is 
> critical to fix this for 3.15. I plan to include this with my fdt series 
> for 3.16 unless I hear otherwise.

Sure, go for it.

Cheers,
Ben.

> Rob
> 
>  arch/powerpc/kernel/prom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 668aa47..d657549 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -567,6 +567,8 @@ static void __init early_reserve_mem_dt(void)
>  	unsigned long i, len, dt_root;
>  	const __be32 *prop;
>  
> +	early_init_fdt_scan_reserved_mem();
> +
>  	dt_root = of_get_flat_dt_root();
>  
>  	prop = of_get_flat_dt_prop(dt_root, "reserved-ranges", &len);
> @@ -589,8 +591,6 @@ static void __init early_reserve_mem_dt(void)
>  			memblock_reserve(base, size);
>  		}
>  	}
> -
> -	early_init_fdt_scan_reserved_mem();
>  }
>  
>  static void __init early_reserve_mem(void)
