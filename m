Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D10A614007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 18:04:21 +1000 (EST)
Received: by mail-lb0-f178.google.com with SMTP id s7so1146294lbd.37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 01:04:15 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
Date: Fri, 18 Apr 2014 10:04:15 +0200
Message-ID: <CAMuHMdXBNWum7UJ95uT2hwTd1b5C8ebF2LQ4T-A+RS80p7MH=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Leif Lindholm <leif.lindholm@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, patches@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leif,

On Thu, Apr 17, 2014 at 7:42 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> In order to deal with an firmware bug on a specific ppc32 platform
> (longtrail), early_init_dt_scan_memory() looks for a node called
> memory@0 on all platforms. Restrict this quirk to ppc32 kernels only.

This breaks backwards compatibilty with old DTSes (at least on ARM/MIPS,
where you added the missing property in patches 1 and 2 of the series)?

For the Longtrail, I don't care much anymore, as mine died in 2004.
AFAIK, there have never been many users anyway.

> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/of/fdt.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index fa16a91..7368472 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -887,14 +887,19 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>
>         /* We are scanning "memory" nodes only */
>         if (type == NULL) {
> +#ifdef CONFIG_PPC32
>                 /*
>                  * The longtrail doesn't have a device_type on the
>                  * /memory node, so look for the node called /memory@0.
>                  */
>                 if (depth != 1 || strcmp(uname, "memory@0") != 0)
>                         return 0;
> -       } else if (strcmp(type, "memory") != 0)
> +#else
> +               return 0;
> +#endif
> +       } else if (strcmp(type, "memory") != 0) {
>                 return 0;
> +       }
>
>         reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
>         if (reg == NULL)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
