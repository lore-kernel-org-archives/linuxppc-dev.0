Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgnHk3yZHzDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 16:56:02 +1000 (AEST)
Message-ID: <1467356146.32358.32.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Scott Wood <scott.wood@nxp.com>
Cc: Yuantian Tang <yuantian.tang@nxp.com>, Russell King
 <linux@armlinux.org.uk>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar
 <viresh.kumar@linaro.org>,  "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng
 Ren <xiaofeng.ren@nxp.com>
Date: Fri, 01 Jul 2016 01:55:46 -0500
In-Reply-To: <3794032.AoZL3DhM7U@vostro.rjw.lan>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <DBXPR04MB4951CA4EFB4FB5A2BDE7542F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
 <DB5PR0401MB1928B6A4F1049592292D348C91240@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <3794032.AoZL3DhM7U@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-30 at 15:29 +0200, Rafael J. Wysocki wrote:
> On Thursday, June 30, 2016 05:46:42 AM Scott Wood wrote:
> > 
> > On 06/29/2016 10:02 PM, Yuantian Tang wrote:
> > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Thursday, June 30, 2016 10:24 AM
> > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > Cc: Scott Wood <oss@buserror.net>; Russell King <linux@armlinux.org.uk
> > > > >;
> > > > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > > > <sboyd@codeaurora.org>; Viresh Kumar <viresh.kumar@linaro.org>; linux-
> > > > clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> > > > dev@lists.ozlabs.org; Yang-Leo Li <leoyang.li@nxp.com>; Xiaofeng Ren
> > > > <xiaofeng.ren@nxp.com>; Scott Wood <scottwood@freescale.com>
> > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering
> > > > possible
> > > > parent clocks
> > > > 
> > > > On Thursday, June 30, 2016 01:47:09 AM Yuantian Tang wrote:
> > > > > 
> > > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > > Sent: Thursday, June 30, 2016 9:47 AM
> > > > > > To: Yuantian Tang <yuantian.tang@nxp.com>
> > > > > > Cc: Scott Wood <oss@buserror.net>; Russell King
> > > > > > <linux@armlinux.org.uk>; Michael Turquette
> > > > > > <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>;
> > > > > > Viresh Kumar <viresh.kumar@linaro.org>; linux- clk@vger.kernel.org
> > > > > > ;
> > > > > > linux-pm@vger.kernel.org; linuxppc- dev@lists.ozlabs.org; Yang-Leo
> > > > > > Li <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>;
> > > > > > Scott
> > > > > > Wood <scottwood@freescale.com>
> > > > > > Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering
> > > > > > possible parent clocks
> > > > > > 
> > > > > > On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > This patch is acked by clock maintainer. If no comments from
> > > > > > > anyone else,
> > > > > > we will merge it in next week.
> > > > > > 
> > > > > > There is a cpufreq commit depending on it.  Are you going to
> > > > > > handle
> > > > > > that one too?
> > > > > > 
> > > > > That one has been acked by cpufreq maintainer. You can get this from
> > > > patch comments.
> > > > 
> > > > I know that it has been ACKed.
> > > > 
> > > > My question is whether or not you are going to apply it along the
> > > > [1/2].
> > > > 
> > > > If not, it will have to be deferred until the [1/2] is merged and then
> > > > applied
> > > > which may not be desirable.
> > > > 
> > > I hope we can apply both at same time. Seems Scott has a few concerns.
> > > 
> > > What you think about this patch? Can you apply it?
> > > If you have applied this patch, then I can push CPUfreq maintainer to
> > > apply another one which will be delayed.
> > My only concern was getting an ack for this patch (1/2) -- did I miss it
> > somewhere?
> OK, so who's going to apply the series?

Ideally it should go via the cpufreq tree.

-Scott
