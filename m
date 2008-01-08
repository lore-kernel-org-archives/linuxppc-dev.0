Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id BF090DE2DA
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:27:47 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1625125anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:27:46 -0800 (PST)
Message-ID: <fa686aa40801080927n11affc6cm15dd58af94712eb8@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:27:46 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 6/7] Add mpc512x_find_ips_freq
In-Reply-To: <1199808093-15929-7-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks good to me; but I'd just merge this one with the earlier patch
that adds 5121 board support.

Cheers,
g.

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> Added mpc512x_find_ips_freq needed by the following
> serial driver patch.  It is basically a renamed
> mpc512x_find_ipd_freq from 52xx.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/platforms/512x/mpc5121_ads.c |   28 ++++++++++++++++++++++++++++
>  include/asm-powerpc/mpc512x.h             |   22 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-powerpc/mpc512x.h
>
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
> index a860bf0..2f4cfee 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -36,6 +36,34 @@
>  #include <asm/time.h>
>  #include <asm/of_platform.h>
>
> +/**
> + *     mpc512x_find_ips_freq - Find the IPB bus frequency for a device
> + *     @node:  device node
> + *
> + *     Returns IPS bus frequency, or 0 if the bus frequency cannot be found.
> + */
> +unsigned long
> +mpc512x_find_ips_freq(struct device_node *node)
> +{
> +       struct device_node *np;
> +       const unsigned int *p_ips_freq = NULL;
> +
> +       of_node_get(node);
> +       while (node) {
> +               p_ips_freq = of_get_property(node, "bus-frequency", NULL);
> +               if (p_ips_freq)
> +                       break;
> +
> +               np = of_get_parent(node);
> +               of_node_put(node);
> +               node = np;
> +       }
> +       if (node)
> +               of_node_put(node);
> +
> +       return p_ips_freq ? *p_ips_freq : 0;
> +}
> +
>  static void __init mpc5121_ads_setup_arch(void)
>  {
>         if (ppc_md.progress)
> diff --git a/include/asm-powerpc/mpc512x.h b/include/asm-powerpc/mpc512x.h
> new file mode 100644
> index 0000000..c48a165
> --- /dev/null
> +++ b/include/asm-powerpc/mpc512x.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: John Rigby, <jrigby@freescale.com>, Friday Apr 13 2007
> + *
> + * Description:
> + * MPC5121 Prototypes and definitions
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#ifndef __ASM_POWERPC_MPC512x_H__
> +#define __ASM_POWERPC_MPC512x_H__
> +
> +extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
> +
> +#endif /* __ASM_POWERPC_MPC512x_H__ */
> +
> --
> 1.5.3.5.726.g41a7a
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
