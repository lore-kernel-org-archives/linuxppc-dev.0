Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com
 [209.85.219.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65C0B1400BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:52:49 +1000 (EST)
Received: by mail-oa0-f42.google.com with SMTP id i4so3859362oah.15
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Apr 2014 22:52:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397728407-13909-2-git-send-email-geert+renesas@glider.be>
References: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
 <1397728407-13909-2-git-send-email-geert+renesas@glider.be>
Date: Mon, 21 Apr 2014 11:22:45 +0530
Message-ID: <CAKohpokx2uYH_xC0NZkuD06fQ3QiTLJKwW+YqKHcL-Zw+MGASw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: ppc: Fix integer overflow in expression
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
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
> On 32-bit, "12 * NSEC_PER_SEC" doesn't fit in "unsigned long"
> (NSEC_PER_SEC is a "long" constant), causing an integer overflow:
>
> drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init':
> drivers/cpufreq/ppc-corenet-cpufreq.c:211:9: warning: integer overflow in expression [-Woverflow]
>
> Force the intermediate to be 64-bit by adding an "ULL" suffix to the
> constant multiplier to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index e78f9c806de4..53881d78a931 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -208,7 +208,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 per_cpu(cpu_data, i) = data;
>
>         policy->cpuinfo.transition_latency =
> -                               (12 * NSEC_PER_SEC) / fsl_get_sys_freq();
> +                               (12ULL * NSEC_PER_SEC) / fsl_get_sys_freq();
>         of_node_put(np);
>
>         return 0;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
