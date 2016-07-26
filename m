Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz9W73z1TzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 17:59:14 +1000 (AEST)
Message-ID: <1469519945.25630.105.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Alessio Igor Bogani
 <alessio.bogani@elettra.eu>,  Daniel Axtens <dja@axtens.net>,
 linux-kernel@vger.kernel.org
Date: Tue, 26 Jul 2016 02:59:05 -0500
In-Reply-To: <1469507114-5788-3-git-send-email-andrew.smirnov@gmail.com>
References: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
 <1469507114-5788-3-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] powerpc: Convert fsl_rstcr_restart to a reset handler
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-25 at 21:25 -0700, Andrey Smirnov wrote:
> Convert fsl_rstcr_restart into a function to be registered with
> register_reset_handler() API and introduce fls_rstcr_restart_register()
> function that can be added as an initcall that would do aforementioned
> registration.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Is there a particular motivation for this (e.g. new handlers you plan to
register elsewhere)?

> diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c
> b/arch/powerpc/platforms/85xx/bsc913x_qds.c
> index 07dd6ae..14ea7a0 100644
> --- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
> +++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
> @@ -53,6 +53,7 @@ static void __init bsc913x_qds_setup_arch(void)
>  }
>  
>  machine_arch_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
> +machine_arch_initcall(bsc9133_qds, fsl_rstcr_restart_register);

Do we really still need to call the registration on a per-board basis, now
that boards have a way of registering a higher-priority notifier?  Can't we
just have setup_rstcr() do the registration when it finds the appropriate
device tree node?

> +int fsl_rstcr_restart_register(void)
> +{
> +	static struct notifier_block restart_handler;
> +
> +	restart_handler.notifier_call = fsl_rstcr_restart;
> +	restart_handler.priority = 128;
> +
> +	return register_restart_handler(&restart_handler);
> +}
> +EXPORT_SYMBOL(fsl_rstcr_restart_register);

When would this ever get called from a module?

-Scott
