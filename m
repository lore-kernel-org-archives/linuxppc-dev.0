Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 557491A0060
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 11:04:20 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id a4so11612422wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 16:04:20 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <CADRPPNSASmfxS=BWKvOxGKyCiqno9YvOuAfBaHwKL-Y=jQ2Dzw@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <2396230.MApG9VTrxr@wuerfel>
 <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
 <3593471.QAyZdAuTcW@wuerfel>
 <CADRPPNSASmfxS=BWKvOxGKyCiqno9YvOuAfBaHwKL-Y=jQ2Dzw@mail.gmail.com>
Date: Fri, 26 Feb 2016 18:04:17 -0600
Message-ID: <CADRPPNQPOUE-2_UnHbfMvGXCuuKYkX4a2Pp3Sb9Uc3vgMr-HuQ@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
From: Li Yang <leoli@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2016 at 5:31 PM, Li Yang <leoli@freescale.com> wrote:
> On Fri, Feb 26, 2016 at 5:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 26 February 2016 17:07:09 Li Yang wrote:
>>>
>>> I don't have a perfect solution either.  But I think this is still
>>> better than making cpufreq not usable.  The cpufreq driver will print
>>> out an error message if thermal is not reachable.  Maybe this can
>>> relief the confusion a little bit?
>>
>> With my patch, the configuration will just force the cpufreq
>> driver to be a loadable module as well if thermal is a module,
>> so the dependency can be resolved by loading the thermal module first.
>
> It would be perfect if this it true.  But I tried with the following
> change, it just makes QORIQ_CPUFREQ non-selectable if THERMAL=m.
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index dcb972a38fbc..ca05037dd565 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -297,6 +297,7 @@ endif
>  config QORIQ_CPUFREQ
>         tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>         depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
> +       depends on !CPU_THERMAL || THERMAL=y
>         select CLK_QORIQ
>         help
>           This adds the CPUFreq driver support for Freescale QorIQ SoCs


I find we can achieve your desired result with the following change instead:

+       depends on (THERMAL=m && m) || THERMAL=y || THERMAL=n

Regards,
Leo
