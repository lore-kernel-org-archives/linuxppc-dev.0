Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414971A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 10:07:14 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id n186so755772wmn.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 15:07:14 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <2396230.MApG9VTrxr@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <3550740.QzZi28fbXg@wuerfel>
 <CADRPPNSqXBqD0of0ZorXFOKQc1OQaaJCPFUTMUezJexkegHY9A@mail.gmail.com>
 <2396230.MApG9VTrxr@wuerfel>
Date: Fri, 26 Feb 2016 17:07:09 -0600
Message-ID: <CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
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

On Fri, Feb 26, 2016 at 2:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 12:04:59 Li Yang wrote:
>> On Fri, Dec 18, 2015 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 15 December 2015 00:58:26 Rafael J. Wysocki wrote:
>> >> On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
>> >> > Register the qoriq cpufreq driver as a cooling device, based on the
>> >> > thermal device tree framework. When temperature crosses the passive trip
>> >> > point cpufreq is used to throttle CPUs.
>> >> >
>> >> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
>> >> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >>
>> >> Applied, thanks!
>> >>
>> >
>> > I got a randconfig build error today:
>> >
>> > drivers/built-in.o: In function `qoriq_cpufreq_ready':
>> > debugfs.c:(.text+0x1f4688): undefined reference to `of_cpufreq_cooling_register'
>> >
>> > CONFIG_OF=y
>> > CONFIG_QORIQ_CPUFREQ=y
>> > CONFIG_THERMAL=m
>> > CONFIG_THERMAL_OF=y
>> >
>> > I think you need a 'depends on THERMAL' to prevent the driver from
>> > being built-in when THERMAL=m.
>>
>> Maybe this is not the best approach.  The cpufreq feature itself
>> should be working independently without thermal framework.  I think we
>> should make the qoriq_cpufreq_ready() defined as null function if
>> THERMAL is not defined.
>
> It already does this when CONFIG_THERMAL is not defined, and my
> patch doesn't change that. I'm not sure what you are asking for now.

Oh.  Actually I didn't see you just sent a patch for this.  I
accidentally get into this topic when I tried to find out why cpufreq
is not working on ARMv8 platforms.  I didn't notice that
of_cpufreq_cooling_register() is already ifdef-ed.

>
> Do you want to allow using the cpufreq driver as a built-in driver
> even when the thermal code is in a module, and then silently skip
> all thermal management as if it was turned off?

Having thermal code to be built as module and qoriq_cpufreq to be
built-in is a valid situation.  Making cpufreq not possible to be used
when thermal is a module doesn't seem to be right.

>
> That would be this patch:
>
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index c156f5082758..a8d9241fc1bb 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -48,7 +48,7 @@ cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
>   * @np: a valid struct device_node to the cooling device device tree node.
>   * @clip_cpus: cpumask of cpus where the frequency constraints will happen
>   */
> -#ifdef CONFIG_THERMAL_OF
> +#if IS_REACHABLE(CONFIG_THERMAL_OF)
>  struct thermal_cooling_device *
>  of_cpufreq_cooling_register(struct device_node *np,
>                             const struct cpumask *clip_cpus);
>
>
> but my feeling is that this would cause more surprises when users
> find their thermal management is not active even though it was
> enabled in Kconfig and the thermal module gets loaded.

I don't have a perfect solution either.  But I think this is still
better than making cpufreq not usable.  The cpufreq driver will print
out an error message if thermal is not reachable.  Maybe this can
relief the confusion a little bit?

Regards,
Leo
