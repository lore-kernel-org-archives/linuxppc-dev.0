Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0113.outbound.protection.outlook.com [157.56.112.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg9tL2FCgzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 17:20:26 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Yuantian Tang <yuantian.tang@nxp.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
CC: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li
 <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>, Scott Wood
 <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Thu, 30 Jun 2016 05:46:42 +0000
Message-ID: <DB5PR0401MB1928B6A4F1049592292D348C91240@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <2091721.Cm4CVR1ptK@vostro.rjw.lan>
 <DBXPR04MB4958B5147DAA4F05BED4884F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
 <2040199.AxgevOCPID@vostro.rjw.lan>
 <DBXPR04MB4951CA4EFB4FB5A2BDE7542F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2016 10:02 PM, Yuantian Tang wrote:=0A=
>> -----Original Message-----=0A=
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]=0A=
>> Sent: Thursday, June 30, 2016 10:24 AM=0A=
>> To: Yuantian Tang <yuantian.tang@nxp.com>=0A=
>> Cc: Scott Wood <oss@buserror.net>; Russell King <linux@armlinux.org.uk>;=
=0A=
>> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd=0A=
>> <sboyd@codeaurora.org>; Viresh Kumar <viresh.kumar@linaro.org>; linux-=
=0A=
>> clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-=0A=
>> dev@lists.ozlabs.org; Yang-Leo Li <leoyang.li@nxp.com>; Xiaofeng Ren=0A=
>> <xiaofeng.ren@nxp.com>; Scott Wood <scottwood@freescale.com>=0A=
>> Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possi=
ble=0A=
>> parent clocks=0A=
>>=0A=
>> On Thursday, June 30, 2016 01:47:09 AM Yuantian Tang wrote:=0A=
>>>> -----Original Message-----=0A=
>>>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]=0A=
>>>> Sent: Thursday, June 30, 2016 9:47 AM=0A=
>>>> To: Yuantian Tang <yuantian.tang@nxp.com>=0A=
>>>> Cc: Scott Wood <oss@buserror.net>; Russell King=0A=
>>>> <linux@armlinux.org.uk>; Michael Turquette=0A=
>>>> <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>;=0A=
>>>> Viresh Kumar <viresh.kumar@linaro.org>; linux- clk@vger.kernel.org;=0A=
>>>> linux-pm@vger.kernel.org; linuxppc- dev@lists.ozlabs.org; Yang-Leo=0A=
>>>> Li <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>; Scott=0A=
>>>> Wood <scottwood@freescale.com>=0A=
>>>> Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering=0A=
>>>> possible parent clocks=0A=
>>>>=0A=
>>>> On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:=0A=
>>>>> Hi,=0A=
>>>>>=0A=
>>>>> This patch is acked by clock maintainer. If no comments from=0A=
>>>>> anyone else,=0A=
>>>> we will merge it in next week.=0A=
>>>>=0A=
>>>> There is a cpufreq commit depending on it.  Are you going to handle=0A=
>>>> that one too?=0A=
>>>>=0A=
>>> That one has been acked by cpufreq maintainer. You can get this from=0A=
>> patch comments.=0A=
>>=0A=
>> I know that it has been ACKed.=0A=
>>=0A=
>> My question is whether or not you are going to apply it along the [1/2].=
=0A=
>>=0A=
>> If not, it will have to be deferred until the [1/2] is merged and then a=
pplied=0A=
>> which may not be desirable.=0A=
>>=0A=
> I hope we can apply both at same time. Seems Scott has a few concerns.=0A=
> =0A=
> What you think about this patch? Can you apply it?=0A=
> If you have applied this patch, then I can push CPUfreq maintainer to app=
ly another one which will be delayed.=0A=
=0A=
My only concern was getting an ack for this patch (1/2) -- did I miss it=0A=
somewhere?=0A=
=0A=
-Scott=0A=
=0A=
