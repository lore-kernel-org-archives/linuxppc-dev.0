Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 64124DDFA7
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 02:40:02 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so813065ana
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 09:40:00 -0700 (PDT)
Message-ID: <4b73d43f0704270939g53ecc41cw740163a2b937fe2f@mail.gmail.com>
Date: Fri, 27 Apr 2007 10:39:57 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>, linuxppc <linuxppc-dev@ozlabs.org>
Subject: Fwd: [PATCH] Avoid putting cpu node twice
In-Reply-To: <4617E176.6040607@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4b73d43f0704061557v2f38991ep54bc66706672075d@mail.gmail.com>
	<4617E176.6040607@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This was originally sent to linuxppc-embedded.

---------- Forwarded message ----------
From: Sylvain Munaut <tnt@246tnt.com>
Date: Apr 7, 2007 12:22 PM
Subject: Re: [PATCH] Avoid putting cpu node twice
To: John Rigby <jcrigby@gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>, Grant Likely
<grant.likely@secretlab.ca>


John Rigby wrote:
> Call of_find_node_by_type with NULL instead of np
> so the cpu node does not get put twice.
> This was causing kref_put warnings.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
Acked-by: Sylvain Munaut <tnt@246tNt.com>

> ---
> arch/powerpc/platforms/52xx/lite5200.c |    6 ++++--
> 1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/lite5200.c
> b/arch/powerpc/platforms/52xx/lite5200.c
> index cc3b40d..d2f90eb 100644
> --- a/arch/powerpc/platforms/52xx/lite5200.c
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -108,9 +108,11 @@ static void __init lite5200_setup_arch(void)
>        lite5200_setup_cpu();   /* Platorm specific */
>
> #ifdef CONFIG_PCI
> -       np = of_find_node_by_type(np, "pci");
> -       if (np)
> +       np = of_find_node_by_type(NULL, "pci");
> +       if (np) {
>                mpc52xx_add_bridge(np);
> +               of_node_put(np);
> +       }
> #endif
>
> #ifdef CONFIG_BLK_DEV_INITRD
> --
> 1.5.0.6
>
