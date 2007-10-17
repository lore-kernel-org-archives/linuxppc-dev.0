Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 8B7AFDDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:30:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1379446wri
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 08:30:06 -0700 (PDT)
Message-ID: <fa686aa40710170830n963e967g9152c9678687ec1c@mail.gmail.com>
Date: Wed, 17 Oct 2007 09:30:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 3/4] [POWERPC] Add restart support for mpc52xx based
	platforms
In-Reply-To: <471607A8.6050203@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47160689.4020301@semihalf.com> <471607A8.6050203@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Marian Balakowicz <m8@semihalf.com> wrote:
>
> Add common helper routines: mpc52xx_map_wdt() and mpc52xx_restart().
>
> This patch relies on Sascha Hauer's patch published in:
> http://patchwork.ozlabs.org/linuxppc/patch?id=8910.
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   45 +++++++++++++++++++++++++++
>  include/asm-powerpc/mpc52xx.h                |    3 +
>  2 files changed, 48 insertions(+)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> index 74b4b41..553937b 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -18,6 +18,13 @@ #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/mpc52xx.h>
>
> +/*
> + * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restart().
> + * Permanent mapping is required because mpc52xx_restart() can be called
> + * from interrupt context while node mapping (which calls iorenmap())
> + * cannot be used at such point.
> + */
> +static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
>
>  static void __iomem *
>  mpc52xx_map_node(struct device_node *ofn)
> @@ -126,3 +133,41 @@ mpc52xx_declare_of_platform_devices(void
>                         "Error while probing of_platform bus\n");
>  }
>
> +void __init
> +mpc52xx_map_wdt(void)
> +{
> +        const void *has_wdt;
> +       struct device_node *np;
> +
> +       /* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
> +        * possibly from a interrupt context. */
> +
> +       for (np = NULL;
> +           (np = of_find_compatible_node(np, NULL, "fsl,mpc5200-gpt")) != NULL;
> +           ) {
> +               /* wdt is only implement on gpt0, check has-wdt property. */
> +               has_wdt = of_get_property(np, "fsl,has-wdt", NULL);

Test for both "has-wdt" and "fsl,has-wdt" for now.

Otherwise, looks good.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
