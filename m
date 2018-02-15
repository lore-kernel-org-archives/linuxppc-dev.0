Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhlb34G6FzF1KZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 16:44:31 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id k6so17628554ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 21:44:31 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id
 i189sm13738521itf.33.2018.02.14.21.44.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Feb 2018 21:44:28 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/init: Do not advertise radix during
 client-architecture-support
To: linuxppc-dev@lists.ozlabs.org
References: <20180109054520.31704-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <111a5e87-2336-c107-74be-af0330be48eb@ozlabs.ru>
Date: Thu, 15 Feb 2018 16:44:25 +1100
MIME-Version: 1.0
In-Reply-To: <20180109054520.31704-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/18 16:45, Alexey Kardashevskiy wrote:
> Currently the pseries kernel advertises radix MMU support even if
> the actual support is disabled via the CONFIG_PPC_RADIX_MMU option.
> 
> This adds a check for CONFIG_PPC_RADIX_MMU to avoid advertising radix
> to the hypervisor.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Ping?


> ---
>  arch/powerpc/kernel/prom_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 02190e9..65879df 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1109,7 +1109,8 @@ static void __init prom_check_platform_support(void)
>  		}
>  	}
>  
> -	if (supported.radix_mmu && supported.radix_gtse) {
> +	if (supported.radix_mmu && supported.radix_gtse &&
> +	    IS_ENABLED(CONFIG_PPC_RADIX_MMU)) {
>  		/* Radix preferred - but we require GTSE for now */
>  		prom_debug("Asking for radix with GTSE\n");
>  		ibm_architecture_vec.vec5.mmu = OV5_FEAT(OV5_MMU_RADIX);
> 


-- 
Alexey
