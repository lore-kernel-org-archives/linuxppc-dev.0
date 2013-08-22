Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA38C2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:19:16 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kq13so1802313pab.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 00:19:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Tomasz Figa <tomasz.figa@gmail.com>, Mark Rutland <mark.rutland@arm.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <2207416.NJhrdSqkEZ@flatron>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130820000625.4443.23018@quantum>
 <20130821085015.GY3719@e106331-lin.cambridge.arm.com>
 <2207416.NJhrdSqkEZ@flatron>
Message-ID: <20130822071910.8231.47324@quantum>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Thu, 22 Aug 2013 00:19:10 -0700
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolin Chen <b42378@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
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

Quoting Tomasz Figa (2013-08-21 14:34:55)
> On Wednesday 21 of August 2013 09:50:15 Mark Rutland wrote:
> > On Tue, Aug 20, 2013 at 01:06:25AM +0100, Mike Turquette wrote:
> > > Quoting Mark Rutland (2013-08-19 02:35:43)
> > > =

> > > > On Sat, Aug 17, 2013 at 04:17:18PM +0100, Tomasz Figa wrote:
> > > > > On Saturday 17 of August 2013 16:53:16 Sascha Hauer wrote:
> > > > > > On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > > > > > > > Also I would make this option required. Use a dummy
> > > > > > > > > > clock for
> > > > > > > > > > mux
> > > > > > > > > > inputs that are grounded for a specific SoC.
> > > > > > > > > =

> > > > > > > > > Some clocks are not from CCM and we haven't defined in
> > > > > > > > > imx6q-clk.txt,
> > > > > > > > > so in most cases we can't provide a phandle for them, eg:
> > > > > > > > > spdif_ext.
> > > > > > > > > I think it's a bit hard to force it to be 'required'. An
> > > > > > > > > 'optional'
> > > > > > > > > looks more flexible to me and a default one is ensured
> > > > > > > > > even if
> > > > > > > > > it's
> > > > > > > > > missing.
> > > > > > > > =

> > > > > > > > <&clks 0> is the dummy clock. This can be used for all input
> > > > > > > > clocks
> > > > > > > > not
> > > > > > > > defined by the SoC.
> > > > > > > =

> > > > > > > Where does this assumption come from? Is it documented
> > > > > > > anywhere?
> > > > > > =

> > > > > > This is how all i.MX clock bindings currently are. See
> > > > > > Documentation/devicetree/bindings/clock/imx*-clock.txt
> > > > > =

> > > > > OK, thanks.
> > > > > =

> > > > > I guess we need some discussion on dummy clocks vs skipped clocks.
> > > > > I think we want some consistency on this, don't we?
> > > > > =

> > > > > If we really need a dummy clock, then we might also want a generic
> > > > > way to specify it.
> > > > =

> > > > What do we actually mean by a "dummy clock"? We already have
> > > > bindings
> > > > for "fixed-clock" and co friends describe relatively simple
> > > > preconfigured clocks.
> > > =

> > > Some platforms have a fake clock which defines noops callbacks and
> > > basically doesn't do anything. This is analogous to the dummy
> > > regulator
> > > implementation. A central one could be registered by the clock core,
> > > as
> > > is done by the regulator core.
> > =

> > When you say some platforms, you presumably mean the platform code in
> > Linux? A dummy clock sounds like a completely Linux-specific abstraction
> > rather than a description of the hardware, and I don't see why we need
> > that in the DT:
> > =

> > * If a clock is wired up and running (as presumably the dummy clock is),
> > then surely it's a fixed-clock (it's running, we and we have no control
> > over it, but we presumably know its rate) and can be described as such?
> > =

> > * If no clock is wired up, then we should be able to describe that. If a
> > driver believes that a clock is required when it isn't (for some level
> > of functionality), then that driver should be fixed up to support the
> > clock as being optional.
> > =

> > Am I missing something?
> =

> I second that.
> =

> Moreover, I don't think that device tree should deal with dummy anything. =

> It should be able to describe hardware that is available on given system, =

> not list what hardware is not available.

I wasn't clear. The dummy clock IS a completely Linux-specific
abstraction.

I'm not advocating a dummy clock in DT. I am advocating consolidation of
the implementation of a clock that does nothing into the clock core.
This code could easily live in drivers/clk/clk.c instead of having
everyone open-code it.

As far as specifying a dummy clock in DT? I dunno. DT should describe
real hardware so there isn't much use for a dummy clock.

I'm guessing one of the reasons for such a clock are drivers do not
honor the clk.h api and they freak out when clk_get gives them a NULL
pointer?

Regards,
Mike

> =

> Best regards,
> Tomasz
