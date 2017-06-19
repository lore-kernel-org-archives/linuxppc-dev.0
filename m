Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqv33mDvzDr0J
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:35 +1000 (AEST)
In-Reply-To: <20170529132628.10803-1-mopsfelder@gmail.com>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-watchdog@vger.kernel.org,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
Message-Id: <3wrqv32nQZz9s7v@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 13:26:28 UTC, Murilo Opsfelder Araujo wrote:
> drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
> which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
> setting CONFIG_PPC_RTAS throws the following errors:
> 
>     ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
>     ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!
> 
> This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
> CONFIG_PPC_RTAS was not set. Logs are here:
> 
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/
> 
> This patch fixes the issue by updating CONFIG_WATCHDOG_RTAS to depend on just
> CONFIG_PPC_RTAS, removing COMPILE_TEST entirely.
> 
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/42bed042556261b56aa92e05f4f388

cheers
