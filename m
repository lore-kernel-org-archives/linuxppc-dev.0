Return-Path: <mturquette@baylibre.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlKnD1X8SzDr2Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 11:30:23 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id h14so1261802pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 18:30:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <oss@buserror.net>, "Russell King" <linux@armlinux.org.uk>,
 "Stephen Boyd" <sboyd@codeaurora.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1466058085-19353-2-git-send-email-oss@buserror.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com,
 xiaofeng.ren@nxp.com, "Scott Wood" <scottwood@freescale.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
Message-ID: <146785501714.73491.8643317356949121718@resonance>
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Wed, 06 Jul 2016 18:30:17 -0700
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2016-06-15 23:21:25)
> -static struct device_node *cpu_to_clk_node(int cpu)
> +static struct clk *cpu_to_clk(int cpu)
>  {
> -       struct device_node *np, *clk_np;
> +       struct device_node *np;
> +       struct clk *clk;
>  =

>         if (!cpu_present(cpu))
>                 return NULL;
> @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node(int cpu)
>         if (!np)
>                 return NULL;
>  =

> -       clk_np =3D of_parse_phandle(np, "clocks", 0);
> -       if (!clk_np)
> -               return NULL;
> -
> +       clk =3D of_clk_get(np, 0);

Why not use devm_clk_get here?

> @@ -221,17 +180,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
>                 goto err_nomem2;
>         }
>  =

> -       pnode =3D of_parse_phandle(np, "clocks", 0);
> -       if (!pnode) {
> -               pr_err("%s: could not get clock information\n", __func__);
> -               goto err_nomem2;
> -       }
> +       count =3D clk_get_num_parents(policy->clk);

We already have of_clk_get_parent_count. This is found in
clk-provider.h, which doesn't fit perfectly here since the cpufreq
driver is not a clock provider, but instead a consumer.

> @@ -240,23 +194,11 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
>                 goto err_pclk;
>         }
>  =

> -       if (fmask)
> -               mask =3D fmask[get_cpu_physical_id(cpu)];
> -       else
> -               mask =3D 0x0;
> -
>         for (i =3D 0; i < count; i++) {
> -               clk =3D of_clk_get(pnode, i);
> +               clk =3D clk_get_parent_by_index(policy->clk, i);
>                 data->pclk[i] =3D clk;
>                 freq =3D clk_get_rate(clk);
> -               /*
> -                * the clock is valid if its frequency is not masked
> -                * and large than minimum allowed frequency.
> -                */
> -               if (freq < min_cpufreq || (mask & (1 << i)))
> -                       table[i].frequency =3D CPUFREQ_ENTRY_INVALID;
> -               else
> -                       table[i].frequency =3D freq / 1000;
> +               table[i].frequency =3D freq / 1000;

Hmm, so you change cpu clock rate by selecting different clock sources
from a cpu clock mux, right? I wonder if you can just have a child mux
clock that selects parents from .set_rate (via a .determine_rate
callback)? Then you could just call clk_set_rate() on your cpu mux clock
and maybe skip most of the stuff this driver does?

Regards,
Mike
