Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlPPZ3ZwkzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:13:38 +1000 (AEST)
Message-ID: <1467864803.32358.63.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Turquette <mturquette@baylibre.com>, Russell King
 <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com,
 xiaofeng.ren@nxp.com
Date: Wed, 06 Jul 2016 23:13:23 -0500
In-Reply-To: <146785501714.73491.8643317356949121718@resonance>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
 <146785501714.73491.8643317356949121718@resonance>
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

On Wed, 2016-07-06 at 18:30 -0700, Michael Turquette wrote:
> Quoting Scott Wood (2016-06-15 23:21:25)
> > 
> > -static struct device_node *cpu_to_clk_node(int cpu)
> > +static struct clk *cpu_to_clk(int cpu)
> >  {
> > -       struct device_node *np, *clk_np;
> > +       struct device_node *np;
> > +       struct clk *clk;
> >  
> >         if (!cpu_present(cpu))
> >                 return NULL;
> > @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node(int cpu)
> >         if (!np)
> >                 return NULL;
> >  
> > -       clk_np = of_parse_phandle(np, "clocks", 0);
> > -       if (!clk_np)
> > -               return NULL;
> > -
> > +       clk = of_clk_get(np, 0);
> Why not use devm_clk_get here?

devm_clk_get() is a wrapper around clk_get() which is not the same as
of_clk_get().  What device would you pass to devm_clk_get(), and what name
would you pass?

> > 
> > @@ -221,17 +180,12 @@ static int qoriq_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> >                 goto err_nomem2;
> >         }
> >  
> > -       pnode = of_parse_phandle(np, "clocks", 0);
> > -       if (!pnode) {
> > -               pr_err("%s: could not get clock information\n", __func__);
> > -               goto err_nomem2;
> > -       }
> > +       count = clk_get_num_parents(policy->clk);
> We already have of_clk_get_parent_count. This is found in
> clk-provider.h, which doesn't fit perfectly here since the cpufreq
> driver is not a clock provider, but instead a consumer.

It's also a device tree function, and the clock parents in question aren't in
the device tree.

> > @@ -240,23 +194,11 @@ static int qoriq_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> >                 goto err_pclk;
> >         }
> >  
> > -       if (fmask)
> > -               mask = fmask[get_cpu_physical_id(cpu)];
> > -       else
> > -               mask = 0x0;
> > -
> >         for (i = 0; i < count; i++) {
> > -               clk = of_clk_get(pnode, i);
> > +               clk = clk_get_parent_by_index(policy->clk, i);
> >                 data->pclk[i] = clk;
> >                 freq = clk_get_rate(clk);
> > -               /*
> > -                * the clock is valid if its frequency is not masked
> > -                * and large than minimum allowed frequency.
> > -                */
> > -               if (freq < min_cpufreq || (mask & (1 << i)))
> > -                       table[i].frequency = CPUFREQ_ENTRY_INVALID;
> > -               else
> > -                       table[i].frequency = freq / 1000;
> > +               table[i].frequency = freq / 1000;
> Hmm, so you change cpu clock rate by selecting different clock sources
> from a cpu clock mux, right?

Yes.  You'd think such a simple thing would be more straightforward.

>  I wonder if you can just have a child mux
> clock that selects parents from .set_rate (via a .determine_rate
> callback)? Then you could just call clk_set_rate() on your cpu mux clock
> and maybe skip most of the stuff this driver does?

"Most of the stuff this driver does" is dealing with the cpufreq subsystem
(ask the cpufreq maintainers why it requires so much boilerplate), associating
clock muxes with cpus, etc.  It is also not obvious to me how to use
determine_rate() or that the end result would be any simpler or better.  It
seems like the implementation would just be reimplementing logic that already
exists in cpufreq, and the cpufreq driver would still need to be able to get a
list of possible frequencies, because cpufreq wants a table of them.

After nearly a year of non-response to these patches[1], a request to
completely rearchitect this driver[2] just to avoid exposing a couple
straightforward informational functions to clock consumers[3] was not quite
what I was hoping for.  What is wrong with clock consumers being able to query
the parent list, given that clock consumers have the ability to request a
particular parent?

-Scott

[1] Original versions:
http://www.spinics.net/lists/linux-clk/msg03069.html
http://www.spinics.net/lists/linux-clk/msg03070.html


[2] The only reason I'm touching this driver at all is because it currently
makes bad assumptions about clock provider internals (and clock provider
device tree structure) that are broken by the new bindings enabled by
commit 0dfc86b3173fee ("clk: qoriq: Move chip-specific knowledge into
driver").

[3] I initially discussed adding consumer APIs for this patchset in 
http://lkml.iu.edu/hypermail/linux/kernel/1509.2/02728.html
