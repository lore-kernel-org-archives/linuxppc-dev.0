Return-Path: <pku.leo@gmail.com>
Received: from mail-wj0-x241.google.com (mail-wj0-x241.google.com
 [IPv6:2a00:1450:400c:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDp3c3LYkzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 05:11:40 +1100 (AEDT)
Received: by mail-wj0-x241.google.com with SMTP id ip10so1899037wjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 10:11:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DB6PR0401MB2648CA1169D59950CD8BEC78F0080@DB6PR0401MB2648.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
 <146785501714.73491.8643317356949121718@resonance>
 <1467864803.32358.63.camel@buserror.net>
 <146794477678.73491.8244253339435407853@resonance>
 <1468012014.32358.74.camel@buserror.net>
 <DB6PR0401MB2648CA1169D59950CD8BEC78F0080@DB6PR0401MB2648.eurprd04.prod.outlook.com>
From: Leo Li <pku.leo@gmail.com>
Date: Thu, 2 Feb 2017 12:11:36 -0600
Message-ID: <CADRPPNR0xh_9Q3FZ_-94QD-B7PP=aGBySSi1+n=RmmjvkpKYzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock implementation
 details
To: Yuantian Tang <yuantian.tang@nxp.com>
Cc: Scott Wood <oss@buserror.net>, Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 19, 2016 at 10:02 PM, Yuantian Tang <yuantian.tang@nxp.com> wrote:
>
> PING.
>
> Regards,
> Yuantian
>
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Saturday, July 09, 2016 5:07 AM
> > To: Michael Turquette <mturquette@baylibre.com>; Russell King
> > <linux@armlinux.org.uk>; Stephen Boyd <sboyd@codeaurora.org>; Viresh
> > Kumar <viresh.kumar@linaro.org>; Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: linux-clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Yuantian Tang <yuantian.tang@nxp.com>; Yang-Leo Li
> > <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>
> > Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock
> > implementation details
> >
> > On Thu, 2016-07-07 at 19:26 -0700, Michael Turquette wrote:
> > > Quoting Scott Wood (2016-07-06 21:13:23)
> > > >
> > > > On Wed, 2016-07-06 at 18:30 -0700, Michael Turquette wrote:
> > > > >
> > > > > Quoting Scott Wood (2016-06-15 23:21:25)
> > > > > >
> > > > > >
> > > > > > -static struct device_node *cpu_to_clk_node(int cpu)
> > > > > > +static struct clk *cpu_to_clk(int cpu)
> > > > > >  {
> > > > > > -       struct device_node *np, *clk_np;
> > > > > > +       struct device_node *np;
> > > > > > +       struct clk *clk;
> > > > > >
> > > > > >         if (!cpu_present(cpu))
> > > > > >                 return NULL;
> > > > > > @@ -112,37 +80,28 @@ static struct device_node
> > > > > > *cpu_to_clk_node(int
> > > > > > cpu)
> > > > > >         if (!np)
> > > > > >                 return NULL;
> > > > > >
> > > > > > -       clk_np = of_parse_phandle(np, "clocks", 0);
> > > > > > -       if (!clk_np)
> > > > > > -               return NULL;
> > > > > > -
> > > > > > +       clk = of_clk_get(np, 0);
> > > > > Why not use devm_clk_get here?
> > > > devm_clk_get() is a wrapper around clk_get() which is not the same
> > > > as of_clk_get().  What device would you pass to devm_clk_get(), and
> > > > what name would you pass?
> > > I'm fuzzy on whether or not you get a struct device from a cpufreq
> > > driver. If so, then that would be the one to use. I would hope that
> > > cpufreq drivers model cpus as devices, but I'm really not sure without
> > > looking into the code.
> >
> > It's not the cpufreq code that provides it, but get_cpu_device() could be
> > used.
> >
> > Do you have any comments on the first patch of this set?


Any action on this patch?  This patch is still a dependency for
cpufreq to work on all QorIQ platforms.

Regards,
Leo
