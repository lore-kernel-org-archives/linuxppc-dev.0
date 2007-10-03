Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id BD3E5DDE40
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:56:35 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5785660wag
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:56:34 -0700 (PDT)
Message-ID: <fa686aa40710030856u74054993q2d73cf18920665f2@mail.gmail.com>
Date: Wed, 3 Oct 2007 09:56:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
In-Reply-To: <87lkakxky1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/3/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> On non-QE processors (mpc831x/mpc834x) the SPI clock is the SoC clock.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   27 +++++++++++++++++++--------
>  1 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index a57fe56..59e4188 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
>  {
>         struct device_node *np;
>         unsigned int i;
> -       const u32 *sysclk;
> +       const u32 *qe_sysclk = 0, *soc_sysclk = 0;
>
>         np = of_find_node_by_type(NULL, "qe");
> -       if (!np)
> -               return -ENODEV;
> +       if (np)
> +               qe_sysclk = of_get_property(np, "bus-frequency", NULL);
> +
> +       np = of_find_node_by_type(NULL, "soc");
> +       if (np)
> +               soc_sysclk = of_get_property(np, "bus-frequency", NULL);

Why not just:

        np = of_find_node_by_type(NULL, "qe");
+       if (!np)
+               np = of_find_node_by_type(NULL, "soc");
        if (!np)
                return -ENODEV;

The other changes aren't needed that way.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
