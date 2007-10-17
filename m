Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id D667FDDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:12:53 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2987719wag
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 08:12:50 -0700 (PDT)
Message-ID: <fa686aa40710170812w6d472832re2c9170dad4ef27e@mail.gmail.com>
Date: Wed, 17 Oct 2007 09:12:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 2/4] [POWERPC] Update device tree binding for mpc5200 gpt
In-Reply-To: <4716074E.80903@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47160689.4020301@semihalf.com> <4716074E.80903@semihalf.com>
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
> Add 'fsl,' prefix to 'compatible' property for gpt nodes.
> Add 'fsl,' prefix to empty, GPT0 specific 'has-wdt' property.
>
> diff --git a/drivers/char/watchdog/mpc5200_wdt.c b/drivers/char/watchdog/mpc5200_wdt.c
> index 564143d..9aaba7a 100644
> --- a/drivers/char/watchdog/mpc5200_wdt.c
> +++ b/drivers/char/watchdog/mpc5200_wdt.c
> @@ -174,7 +174,7 @@ static int mpc5200_wdt_probe(struct of_d
>         const void *has_wdt;
>         int size;
>
> -       has_wdt = of_get_property(op->node, "has-wdt", NULL);
> +       has_wdt = of_get_property(op->node, "fsl,has-wdt", NULL);
>         if (!has_wdt)
>                 return -ENODEV;

Do this instead:

        has_wdt = of_get_property(op->node, "has-wdt", NULL);
+       if (!has_wdt)
+               has_wdt = of_get_property(op->node, "fsl,has-wdt", NULL);
        if (!has_wdt)
                return -ENODEV;

This will allow it to still work with older device trees.

>
> @@ -253,7 +253,7 @@ static int mpc5200_wdt_shutdown(struct o
>  }
>
>  static struct of_device_id mpc5200_wdt_match[] = {
> -       { .compatible = "mpc5200-gpt", },
> +       { .compatible = "fsl,mpc5200-gpt", },

Keep both the old and new in the match table for now for the same reason.

Otherwise, looks good.  Thanks.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
