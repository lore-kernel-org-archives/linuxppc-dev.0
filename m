Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id C142B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 18:50:33 +1000 (EST)
Date: Wed, 21 Aug 2013 09:50:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130821085015.GY3719@e106331-lin.cambridge.arm.com>
References: <cover.1376565456.git.b42378@freescale.com>
 <2805432.jMVhHxhr1m@flatron>
 <20130817145316.GT26614@pengutronix.de>
 <8770601.066pCcRnTh@flatron>
 <20130819093543.GF3719@e106331-lin.cambridge.arm.com>
 <20130820000625.4443.23018@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130820000625.4443.23018@quantum>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolin Chen <b42378@freescale.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "timur@tabi.org" <timur@tabi.org>, "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 20, 2013 at 01:06:25AM +0100, Mike Turquette wrote:
> Quoting Mark Rutland (2013-08-19 02:35:43)
> > On Sat, Aug 17, 2013 at 04:17:18PM +0100, Tomasz Figa wrote:
> > > On Saturday 17 of August 2013 16:53:16 Sascha Hauer wrote:
> > > > On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > > > > > Also I would make this option required. Use a dummy clock for
> > > > > > > > mux
> > > > > > > > inputs that are grounded for a specific SoC.
> > > > > > > 
> > > > > > > Some clocks are not from CCM and we haven't defined in
> > > > > > > imx6q-clk.txt,
> > > > > > > so in most cases we can't provide a phandle for them, eg:
> > > > > > > spdif_ext.
> > > > > > > I think it's a bit hard to force it to be 'required'. An
> > > > > > > 'optional'
> > > > > > > looks more flexible to me and a default one is ensured even if
> > > > > > > it's
> > > > > > > missing.
> > > > > > 
> > > > > > <&clks 0> is the dummy clock. This can be used for all input clocks
> > > > > > not
> > > > > > defined by the SoC.
> > > > > 
> > > > > Where does this assumption come from? Is it documented anywhere?
> > > > 
> > > > This is how all i.MX clock bindings currently are. See
> > > > Documentation/devicetree/bindings/clock/imx*-clock.txt
> > > 
> > > OK, thanks.
> > > 
> > > I guess we need some discussion on dummy clocks vs skipped clocks. I think 
> > > we want some consistency on this, don't we?
> > > 
> > > If we really need a dummy clock, then we might also want a generic way to 
> > > specify it.
> > 
> > What do we actually mean by a "dummy clock"? We already have bindings
> > for "fixed-clock" and co friends describe relatively simple
> > preconfigured clocks.
> 
> Some platforms have a fake clock which defines noops callbacks and
> basically doesn't do anything. This is analogous to the dummy regulator
> implementation. A central one could be registered by the clock core, as
> is done by the regulator core.

When you say some platforms, you presumably mean the platform code in
Linux? A dummy clock sounds like a completely Linux-specific abstraction
rather than a description of the hardware, and I don't see why we need
that in the DT:

* If a clock is wired up and running (as presumably the dummy clock is),
  then surely it's a fixed-clock (it's running, we and we have no
  control over it, but we presumably know its rate) and can be described
  as such?

* If no clock is wired up, then we should be able to describe that. If a
  driver believes that a clock is required when it isn't (for some level
  of functionality), then that driver should be fixed up to support the
  clock as being optional.

Am I missing something?

Thanks,
Mark.
