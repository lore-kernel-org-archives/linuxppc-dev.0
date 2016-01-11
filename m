Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 649501A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 08:19:04 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scott.wood@nxp.com>, Hongtao Jia <hongtao.jia@nxp.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Scott Wood <oss@buserror.net>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Hongtao Jia <hongtao.jia@freescale.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH V3] cpufreq: qoriq: Register
 cooling device based on device tree
Date: Mon, 11 Jan 2016 22:13:06 +0100
Message-ID: <13735438.Yvdu0suV1m@wuerfel>
In-Reply-To: <AM3PR04MB530F71205574CA86CADE93191C90@AM3PR04MB530.eurprd04.prod.outlook.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
 <AM3PR04MB3376CC754973BD535CF3F99EBC90@AM3PR04MB337.eurprd04.prod.outlook.com>
 <AM3PR04MB530F71205574CA86CADE93191C90@AM3PR04MB530.eurprd04.prod.outlook.com>
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

On Monday 11 January 2016 17:34:52 Scott Wood wrote:
> >>
> >> I think you need a 'depends on THERMAL' to prevent the driver from being
> >> built-in when THERMAL=m.
> >>
> >> Arnd
> > 
> > Correct. I need to add following lines to the Kconfig file:
> > depends on !CPU_THERMAL || THERMAL=y
> > 
> > Hi Rafael,
> > Should I send a new patch include this fix or send a fix patch?
> 
> Why THERMAL=y and not just THERMAL, which would allow building this
> driver as a module?

Right, that would be better, and it is what all other drivers do.

For some reason, some drivers depend on !CPU_THERMAL and others
depend on !THERMAL_OF here, and I think the result is the same, but
we are a bit inconsistent here. CPU_THERMAL cannot be set if THERMAL_OF
is disabled, and the header file only uses the 'extern' declaration
if both are set.

	Arnd
