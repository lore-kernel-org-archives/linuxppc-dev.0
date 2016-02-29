Return-Path: <rjwysocki@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5405D1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 01:33:42 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id h198so7191257lfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 06:33:42 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <8056913.EWiGLtcdOV@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <1456531704.5360.53.camel@buserror.net>
 <CADRPPNQhmb3bET9fV072ad5FEHAPrjuXSze1HwnRnKMRmFi8cg@mail.gmail.com>
 <8056913.EWiGLtcdOV@wuerfel>
Date: Mon, 29 Feb 2016 15:33:37 +0100
Message-ID: <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Li Yang <leoli@freescale.com>, Scott Wood <oss@buserror.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 29, 2016 at 11:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 18:41:06 Li Yang wrote:
>> >> >
>> >> > It would be perfect if this it true.  But I tried with the following
>> >> > change, it just makes QORIQ_CPUFREQ non-selectable if THERMAL=m.
>> >> >
>> >> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> >> > index dcb972a38fbc..ca05037dd565 100644
>> >> > --- a/drivers/cpufreq/Kconfig
>> >> > +++ b/drivers/cpufreq/Kconfig
>> >> > @@ -297,6 +297,7 @@ endif
>> >> >  config QORIQ_CPUFREQ
>> >> >         tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>> >> >         depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
>> >> > +       depends on !CPU_THERMAL || THERMAL=y
>> >> >         select CLK_QORIQ
>> >> >         help
>> >> >           This adds the CPUFreq driver support for Freescale QorIQ SoCs
>> >>
>
> Oops.
>
>> >> I find we can achieve your desired result with the following change instead:
>> >>
>> >> +       depends on (THERMAL=m && m) || THERMAL=y || THERMAL=n
>> >
>> > "depends on THERMAL || !THERMAL" should also work.
>>
>> Right.  And this is more simpler.
>
>
> Note the check on !CPU_THERMAL rather than !THERMAL in my patch, that
> part was correct. I think the line should be
>
>         depends on !CPU_THERMAL || THERMAL
>
> as some other drivers do. I must have copied the line
> from ARM_MT8173_CPUFREQ, which is a 'bool' symbol, when
> it should have been the same as ARM_BIG_LITTLE_CPUFREQ and
> CPUFREQ_DT.

OK, so any chance to update the patch?

Thanks,
Rafael
