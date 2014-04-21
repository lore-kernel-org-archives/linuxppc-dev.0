Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A6C521400B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 16:01:08 +1000 (EST)
Received: by mail-oa0-f52.google.com with SMTP id l6so3830143oag.39
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Apr 2014 23:01:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397728407-13909-3-git-send-email-geert+renesas@glider.be>
References: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
 <1397728407-13909-3-git-send-email-geert+renesas@glider.be>
Date: Mon, 21 Apr 2014 11:31:05 +0530
Message-ID: <CAKohpo=GZxUBA63k8-vAQWvoUEikCBNGNrWK87vzn=geVL3_gQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: ppc: Fix handling of non-existent clocks
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Mike Turquette <mike.turquette@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17 April 2014 15:23, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If the clock doesn't exist, clk_get_rate() returns -EINVAL

You clk_get_rate() isn't written well then, it should return zero.
@Mike: I didn't see this clearly mentioned in clk.h, should we fix
that?

>, which becomes
> a large number (freq is u32), failing the "freq < min_cpufreq" test.
> Explicitly test for "(u32)-EINVAL" to fix this.

That's a bad check. We should have done this instead:

(s32)freq < 0; but that would be true for high values of clock. And that's
why clk_get_rate() must return zero for errors.

> Update the comment, and fix a grammer issue while we're at it.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 53881d78a931..7027eab814ce 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -179,10 +179,11 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 clk = of_clk_get(data->parent, i);
>                 freq = clk_get_rate(clk);
>                 /*
> -                * the clock is valid if its frequency is not masked
> -                * and large than minimum allowed frequency.
> +                * the clock is valid if it exists, its frequency is not
> +                * masked, and larger than minimum allowed frequency.
>                  */
> -               if (freq < min_cpufreq || (mask & (1 << i)))
> +               if (freq == (u32)-EINVAL || freq < min_cpufreq ||
> +                   (mask & (1 << i)))
>                         table[i].frequency = CPUFREQ_ENTRY_INVALID;
>                 else
>                         table[i].frequency = freq / 1000;
> --
> 1.7.9.5
>
