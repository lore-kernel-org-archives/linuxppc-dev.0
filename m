Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc5pG0WB3zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 05:07:17 +1000 (AEST)
Subject: Re: [PATCH v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20170529132628.10803-1-mopsfelder@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ea2c9fc6-068e-f9f6-f8eb-1399c9a6cf7a@roeck-us.net>
Date: Mon, 29 May 2017 12:07:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170529132628.10803-1-mopsfelder@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2017 06:26 AM, Murilo Opsfelder Araujo wrote:
> drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
> which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
> setting CONFIG_PPC_RTAS throws the following errors:
> 
>      ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
>      ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!
> 
> This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
> CONFIG_PPC_RTAS was not set. Logs are here:
> 
>      http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/
> 
> This patch fixes the issue by updating CONFIG_WATCHDOG_RTAS to depend on just
> CONFIG_PPC_RTAS, removing COMPILE_TEST entirely.
> 
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8b9049d..e6e31a1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1688,7 +1688,7 @@ config MEN_A21_WDT
>   
>   config WATCHDOG_RTAS
>   	tristate "RTAS watchdog"
> -	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
> +	depends on PPC_RTAS
>   	help
>   	  This driver adds watchdog support for the RTAS watchdog.
>   
> 
