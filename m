Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08ABC1A1A14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 09:32:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jia Hongtao <hongtao.jia@freescale.com>, edubezval@gmail.com,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 scottwood@freescale.com
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Fri, 18 Dec 2015 23:32:33 +0100
Message-ID: <3550740.QzZi28fbXg@wuerfel>
In-Reply-To: <1697588.dLcbZBRWO4@vostro.rjw.lan>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <1697588.dLcbZBRWO4@vostro.rjw.lan>
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

On Tuesday 15 December 2015 00:58:26 Rafael J. Wysocki wrote:
> On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
> > Register the qoriq cpufreq driver as a cooling device, based on the
> > thermal device tree framework. When temperature crosses the passive trip
> > point cpufreq is used to throttle CPUs.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Applied, thanks!
> 

I got a randconfig build error today:

drivers/built-in.o: In function `qoriq_cpufreq_ready':
debugfs.c:(.text+0x1f4688): undefined reference to `of_cpufreq_cooling_register'

CONFIG_OF=y
CONFIG_QORIQ_CPUFREQ=y
CONFIG_THERMAL=m
CONFIG_THERMAL_OF=y

I think you need a 'depends on THERMAL' to prevent the driver from
being built-in when THERMAL=m.

	Arnd
