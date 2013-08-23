Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 6513F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 00:58:10 +1000 (EST)
Date: Fri, 23 Aug 2013 15:57:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130823145753.GA7015@e106331-lin.cambridge.arm.com>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130822210035.GB31036@pengutronix.de>
 <20130822224331.8231.75743@quantum> <34430785.ApIqfgatMc@flatron>
 <20130823063421.GF31036@pengutronix.de>
 <20130823125815.GG25856@e106331-lin.cambridge.arm.com>
 <20130823140128.GI31036@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130823140128.GI31036@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>, Mike Turquette <mturquette@linaro.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicolin Chen <b42378@freescale.com>, Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "timur@tabi.org" <timur@tabi.org>, "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[trimming a bit of useless context]

> > > > > > Background to why it might be a good idea to connect a ground clock
> > > > > > to the unconnected input pins is that a driver has a chance to
> > > > > > successfully grab all clocks. Otherwise how does the driver
> > > > > > distinguish
> > > > > > between an unconnected and an erroneous clock?
> > > > >
> > > > > Sorry, I don't follow this last question. Do you mean how to distinguish
> > > > > based on the value returned from clk_get?
> > > >
> > > > Hmm, in theory, a driver could want to distinguish an error case (e.g.
> > > > clock specified, but there is a problem with it) from no clock (e.g. clock
> > > > not specified in DT, because it is not available on particular board).
> > >
> > > Yes, that's what I meant. To illustrate the problem for this driver:
> > >
> > >     for (i = 0; i < STC_TXCLK_SRC_MAX; i++) {
> > >             sprintf(tmp, "rxtx%d", i);
> > >             clk = devm_clk_get(&pdev->dev, tmp);
> > >             if (IS_ERR(clk)) {
> >
> >               [...]
> >
> >                       /*
> >                        * ERR_PTR(-ENOENT) returned when clock not
> >                        * present in the dt (i.e. not wired up). We can
> >                        * live without this clock, so assign a dummy
> >                        * (NULL) to simplify the rest of the code. If
> >                        * the clock is present but something else went
> >                        * wrong, we'll get a different ERR_PTR value
> >                        * and actually fail.
> >                        */
> >                       if (clk == ERR_PTR(-ENOENT)
> >                               clk = NULL;
> >
> > >             }
> > >     }
> > >
> > > This could be solved by always specifying all input clocks in the
> > > devicetree.
> >
> > As far as I can see, the above is sufficient, and leaves the knowledge
> > of skippable clocks in the driver, where I believe it should be.
> 
> You miss my point. Once a clock is specified in the devicetree it is no
> longer optional. The driver currently can't find out whether a clock
> hasn't been specified (and it's ok that it's not there) or a clock has
> been specified, but some error prevents actually grabbing the clock (in
> which case the driver should bail out)

Unless I've misunderstood, that's exactly what I was trying to implement
above. As I understand it, what we want is:

* If a clock is not specified in the DT, but it's a clock that we know
  we can live without if not wired up, then continue along with a dummy
  clock (NULL). This could be changed to a different dummy, what exactly
  is needed is driver-specific.

* If a clock is not specified in the DT, but it's *not* an optional
  clock, then we must fail. Whether or not a clock is optional is
  knowledge only the driver can have.

* If a clock is specified in the DT, but we can't get it for some
  reason, fail.
 
* If a clock is specified in the DT, and we get it, use it.

I see we might also get PTR_ERR(-ENOENT) indirectly from
__of_parse_phandle_with_args, if the "clocks" property isn't present
(but clock-names is), or we're given the empty phandle. The empty
phandle case is arguable, but it would be possible to add a check for
the clocks property in of_clk_get_by_name early on where we could return
-EINVAL to prevent that being a problem.

Otherwise, it's trivial to add a function to explicitly test for this
case (see below). I don't see that we need to leak what is a Linux issue
into the dt.

Thanks,
Mark.

---->8----
>From f0d46f36426ded4ba3609d79664888852f9925e2 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 23 Aug 2013 15:46:33 +0100
Subject: [PATCH] clk: add of_clk_is_specified

There's currently no way to perfectly distinguish between an
of_clk_get_by_name that failed because a clock was not provided in
clock-names, or for some other reason (e.g. the clocks property itself
was missing). This is problematic for drivers for some pieces of
hardware that have optional clocks -- those which must be used if wired,
but may not be wired in all cases.

This patch adds a new function of_clk_is_specified, which may be used to
distinguish these cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clk/clkdev.c | 11 +++++++++++
 include/linux/clk.h  |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..7fdeca9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -91,6 +91,17 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	return clk;
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
+
+/**
+ *
+ * of_clk_is_specified - Test if a clock was provided by name in a device node
+ * @np: pointer to the clock consumer node
+ * @name: name of the consumer's clock input. Not NULL.
+ */
+bool of_clk_is_specified(struct device_node *np, const char *name)
+{
+	return of_property_match_string(np, "clock-names", name) >= 0;
+}
 #endif
 
 /*
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 9a6d045..bf44d94 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -368,6 +368,7 @@ struct of_phandle_args;
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
+bool of_clk_is_specified(struct device_node *np, const char *name);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
@@ -378,6 +379,10 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
+static bool of_clk_is_specified(struct device_node *np, const char *name)
+{
+	return false;
+}
 #endif
 
 #endif
-- 
1.8.1.1
