Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E2BEB6FE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 08:17:59 +1000 (EST)
Received: from mail106-ch1 (localhost [127.0.0.1])	by
 mail106-ch1-R.bigfish.com (Postfix) with ESMTP id 22ADA18046F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 22:17:54 +0000 (UTC)
Received: from CH1EHSMHS022.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail106-ch1.bigfish.com (Postfix) with ESMTP id
 DFEC6E0743
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 22:17:52 +0000 (UTC)
Message-ID: <4F8DEC0E.4060700@freescale.com>
Date: Tue, 17 Apr 2012 17:17:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add back condition for smp
References: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
In-Reply-To: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2012 04:39 PM, York Sun wrote:
> The timebase synchronization is only necessary if we need to reset a
> separate core.  Currently only KEXEC and CPU hotplug require resetting
> a single core. The following code should be in the condition of
> CONFIG_KEXEC or CONFIG_HOTPLUG_CPU
> 
>         .give_timebase  = smp_generic_give_timebase,
>         .take_timebase  = smp_generic_take_timebase,
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Acked-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/smp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 56942af..868c6d7 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -192,8 +192,10 @@ struct smp_ops_t smp_85xx_ops = {
>  	.cpu_disable	= generic_cpu_disable,
>  	.cpu_die	= generic_cpu_die,
>  #endif
> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
>  	.give_timebase	= smp_generic_give_timebase,
>  	.take_timebase	= smp_generic_take_timebase,
> +#endif
>  };
>  
>  #ifdef CONFIG_KEXEC

Note that this is only a temporary fix, that assumes the environments
where tbsync is problematic[1] (virtualization and simulation) do not
enable CONFIG_KEXEC or CONFIG_HOTPLUG_CPU.  Eventually the sync should
be done via CCSR like in U-Boot, and the decision on whether to do it
should be runtime.

-Scott

[1] More so than usual.
