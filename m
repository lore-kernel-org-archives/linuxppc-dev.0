Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmRrX3JfqzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 07:07:08 +1000 (AEST)
Message-ID: <1468012014.32358.74.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Turquette <mturquette@baylibre.com>, Russell King
 <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com,
 xiaofeng.ren@nxp.com
Date: Fri, 08 Jul 2016 16:06:54 -0500
In-Reply-To: <146794477678.73491.8244253339435407853@resonance>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
 <146785501714.73491.8643317356949121718@resonance>
 <1467864803.32358.63.camel@buserror.net>
 <146794477678.73491.8244253339435407853@resonance>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock
 implementation details
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-07 at 19:26 -0700, Michael Turquette wrote:
> Quoting Scott Wood (2016-07-06 21:13:23)
> > 
> > On Wed, 2016-07-06 at 18:30 -0700, Michael Turquette wrote:
> > > 
> > > Quoting Scott Wood (2016-06-15 23:21:25)
> > > > 
> > > > 
> > > > -static struct device_node *cpu_to_clk_node(int cpu)
> > > > +static struct clk *cpu_to_clk(int cpu)
> > > >  {
> > > > -       struct device_node *np, *clk_np;
> > > > +       struct device_node *np;
> > > > +       struct clk *clk;
> > > >  
> > > >         if (!cpu_present(cpu))
> > > >                 return NULL;
> > > > @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node(int
> > > > cpu)
> > > >         if (!np)
> > > >                 return NULL;
> > > >  
> > > > -       clk_np = of_parse_phandle(np, "clocks", 0);
> > > > -       if (!clk_np)
> > > > -               return NULL;
> > > > -
> > > > +       clk = of_clk_get(np, 0);
> > > Why not use devm_clk_get here?
> > devm_clk_get() is a wrapper around clk_get() which is not the same as
> > of_clk_get().  What device would you pass to devm_clk_get(), and what name
> > would you pass?
> I'm fuzzy on whether or not you get a struct device from a cpufreq
> driver. If so, then that would be the one to use. I would hope that
> cpufreq drivers model cpus as devices, but I'm really not sure without
> looking into the code.

It's not the cpufreq code that provides it, but get_cpu_device() could be
used.

Do you have any comments on the first patch of this set?

-Scott
