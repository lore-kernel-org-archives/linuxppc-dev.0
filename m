Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A7F81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 07:20:19 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Li Yang <leoli@freescale.com>, devicetree@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Jia Hongtao <hongtao.jia@freescale.com>, edubezval@gmail.com,
 viresh.kumar@linaro.org, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Fri, 26 Feb 2016 21:20:04 +0100
Message-ID: <2396230.MApG9VTrxr@wuerfel>
In-Reply-To: <CADRPPNSqXBqD0of0ZorXFOKQc1OQaaJCPFUTMUezJexkegHY9A@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <3550740.QzZi28fbXg@wuerfel>
 <CADRPPNSqXBqD0of0ZorXFOKQc1OQaaJCPFUTMUezJexkegHY9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 26 February 2016 12:04:59 Li Yang wrote:
> On Fri, Dec 18, 2015 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 15 December 2015 00:58:26 Rafael J. Wysocki wrote:
> >> On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
> >> > Register the qoriq cpufreq driver as a cooling device, based on the
> >> > thermal device tree framework. When temperature crosses the passive trip
> >> > point cpufreq is used to throttle CPUs.
> >> >
> >> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> >> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >> Applied, thanks!
> >>
> >
> > I got a randconfig build error today:
> >
> > drivers/built-in.o: In function `qoriq_cpufreq_ready':
> > debugfs.c:(.text+0x1f4688): undefined reference to `of_cpufreq_cooling_register'
> >
> > CONFIG_OF=y
> > CONFIG_QORIQ_CPUFREQ=y
> > CONFIG_THERMAL=m
> > CONFIG_THERMAL_OF=y
> >
> > I think you need a 'depends on THERMAL' to prevent the driver from
> > being built-in when THERMAL=m.
> 
> Maybe this is not the best approach.  The cpufreq feature itself
> should be working independently without thermal framework.  I think we
> should make the qoriq_cpufreq_ready() defined as null function if
> THERMAL is not defined.

It already does this when CONFIG_THERMAL is not defined, and my
patch doesn't change that. I'm not sure what you are asking for now.

Do you want to allow using the cpufreq driver as a built-in driver
even when the thermal code is in a module, and then silently skip
all thermal management as if it was turned off?

That would be this patch:

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c156f5082758..a8d9241fc1bb 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -48,7 +48,7 @@ cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
  * @np: a valid struct device_node to the cooling device device tree node.
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
  */
-#ifdef CONFIG_THERMAL_OF
+#if IS_REACHABLE(CONFIG_THERMAL_OF)
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 			    const struct cpumask *clip_cpus);


but my feeling is that this would cause more surprises when users
find their thermal management is not active even though it was
enabled in Kconfig and the thermal module gets loaded.

	Arnd
