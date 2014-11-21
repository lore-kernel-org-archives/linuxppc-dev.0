Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7E851A1272
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:54:58 +1100 (AEDT)
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 616F0140082
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 18:54:57 +1100 (AEDT)
Received: by mail-oi0-f49.google.com with SMTP id i138so3199157oig.8
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 23:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 21 Nov 2014 13:24:54 +0530
Message-ID: <CAKohpok0yOJTfZ7arkW8N2YORk+-U_NqQvp+dx52FA1m3gh4MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq: qoriq: Make the driver usable on all
 QorIQ platforms
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: r64188@freescale.com, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 November 2014 12:58, Tang Yuantian <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 83a75dc..1925ae94 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -247,3 +247,11 @@ config ARM_TEGRA_CPUFREQ
>         default y
>         help
>           This adds the CPUFreq driver support for TEGRA SOCs.
> +
> +config QORIQ_CPUFREQ
> +       tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +       depends on OF && COMMON_CLK
> +       select CLK_PPC_CORENET
> +       help
> +         This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +         which are capable of changing the CPU's frequency dynamically.
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 72564b7..3a34248 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -23,14 +23,13 @@ config CPU_FREQ_MAPLE
>           This adds support for frequency switching on Maple 970FX
>           Evaluation Board and compatible boards (IBM JS2x blades).
>
> -config PPC_CORENET_CPUFREQ
> -       tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> -       depends on PPC_E500MC && OF && COMMON_CLK
> +config QORIQ_CPUFREQ
> +       tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +       depends on OF && COMMON_CLK
>         select CLK_PPC_CORENET
>         help
> -         This adds the CPUFreq driver support for Freescale e500mc,
> -         e5500 and e6500 series SoCs which are capable of changing
> -         the CPU's frequency dynamically.
> +         This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +         which are capable of changing the CPU's frequency dynamically.
>
>  config CPU_FREQ_PMAC
>         bool "Support for Apple PowerBooks"

Now that following patch is pushed into linux-next:

f41f481 cpufreq: Kconfig: Remove architecture specific menu entries

you can move above config entries directly to drivers/cpufreq/Kconfig
instead of replicating them.
