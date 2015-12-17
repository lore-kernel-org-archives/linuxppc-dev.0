Return-Path: <ruscur@russell.cc>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95D0A1A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 23:16:13 +1100 (AEDT)
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6FB0A140213
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 23:16:13 +1100 (AEDT)
Message-ID: <1450354171.1669.4.camel@russell.cc>
Subject: Re: [PATCH] powerpc: add va_end()
From: Russell Currey <ruscur@russell.cc>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Date: Thu, 17 Dec 2015 23:09:31 +1100
In-Reply-To: <1450341660-31305-1-git-send-email-dja@axtens.net>
References: <1450341660-31305-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-17 at 19:41 +1100, Daniel Axtens wrote:
> cppcheck picked up that there were a couple of missing va_end()
> calls in functions using va_start().
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
Hey Daniel,

It's probably not worth a V2 but I think this could use a commit title that's a
bit more detailed.  Right now it doesn't really allude to what it fixes or what
it affects.

Reviewed-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/kernel/prom_init.c              | 1 +
>  arch/powerpc/platforms/powermac/bootx_init.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c
> b/arch/powerpc/kernel/prom_init.c
> index 92dea8df6b26..da5192590c44 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -389,6 +389,7 @@ static void __init prom_printf(const char *format, ...)
>  			break;
>  		}
>  	}
> +	va_end(args);
>  }
>  
>  
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c
> b/arch/powerpc/platforms/powermac/bootx_init.c
> index 76f5013c35e5..c3c9bbb3573a 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -84,6 +84,7 @@ static void __init bootx_printf(const char *format, ...)
>  			break;
>  		}
>  	}
> +	va_end(args);
>  }
>  #else /* CONFIG_BOOTX_TEXT */
>  static void __init bootx_printf(const char *format, ...) {}
