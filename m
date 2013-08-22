Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22e.google.com (mail-bk0-x22e.google.com
 [IPv6:2a00:1450:4008:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAD922C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 08:49:31 +1000 (EST)
Received: by mail-bk0-f46.google.com with SMTP id 6so917276bkj.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:49:25 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Fri, 23 Aug 2013 00:49:19 +0200
Message-ID: <34430785.ApIqfgatMc@flatron>
In-Reply-To: <20130822224331.8231.75743@quantum>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130822210035.GB31036@pengutronix.de> <20130822224331.8231.75743@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On Thursday 22 of August 2013 15:43:31 Mike Turquette wrote:
> Quoting Sascha Hauer (2013-08-22 14:00:35)
> 
> > On Thu, Aug 22, 2013 at 01:09:31PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 22, 2013 at 08:19:10AM +0100, Mike Turquette wrote:
> > > > Quoting Tomasz Figa (2013-08-21 14:34:55)
> > > > 
> > > > > On Wednesday 21 of August 2013 09:50:15 Mark Rutland wrote:
> > > > > > On Tue, Aug 20, 2013 at 01:06:25AM +0100, Mike Turquette 
wrote:
> > > > > > > Quoting Mark Rutland (2013-08-19 02:35:43)
> > > > > > > 
> > > > > > > > On Sat, Aug 17, 2013 at 04:17:18PM +0100, Tomasz Figa 
wrote:
> > > > > > > > > On Saturday 17 of August 2013 16:53:16 Sascha Hauer 
wrote:
> > > > > > > > > > On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa 
wrote:
> > > > > > > > > > > > > > Also I would make this option required. Use a
> > > > > > > > > > > > > > dummy
> > > > > > > > > > > > > > clock for
> > > > > > > > > > > > > > mux
> > > > > > > > > > > > > > inputs that are grounded for a specific SoC.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Some clocks are not from CCM and we haven't
> > > > > > > > > > > > > defined in
> > > > > > > > > > > > > imx6q-clk.txt,
> > > > > > > > > > > > > so in most cases we can't provide a phandle for
> > > > > > > > > > > > > them, eg:
> > > > > > > > > > > > > spdif_ext.
> > > > > > > > > > > > > I think it's a bit hard to force it to be
> > > > > > > > > > > > > 'required'. An
> > > > > > > > > > > > > 'optional'
> > > > > > > > > > > > > looks more flexible to me and a default one is
> > > > > > > > > > > > > ensured
> > > > > > > > > > > > > even if
> > > > > > > > > > > > > it's
> > > > > > > > > > > > > missing.
> > > > > > > > > > > > 
> > > > > > > > > > > > <&clks 0> is the dummy clock. This can be used for
> > > > > > > > > > > > all input
> > > > > > > > > > > > clocks
> > > > > > > > > > > > not
> > > > > > > > > > > > defined by the SoC.
> > > > > > > > > > > 
> > > > > > > > > > > Where does this assumption come from? Is it
> > > > > > > > > > > documented
> > > > > > > > > > > anywhere?
> > > > > > > > > > 
> > > > > > > > > > This is how all i.MX clock bindings currently are. See
> > > > > > > > > > Documentation/devicetree/bindings/clock/imx*-clock.txt
> > > > > > > > > 
> > > > > > > > > OK, thanks.
> > > > > > > > > 
> > > > > > > > > I guess we need some discussion on dummy clocks vs
> > > > > > > > > skipped clocks.
> > > > > > > > > I think we want some consistency on this, don't we?
> > > > > > > > > 
> > > > > > > > > If we really need a dummy clock, then we might also want
> > > > > > > > > a generic
> > > > > > > > > way to specify it.
> > > > > > > > 
> > > > > > > > What do we actually mean by a "dummy clock"? We already
> > > > > > > > have
> > > > > > > > bindings
> > > > > > > > for "fixed-clock" and co friends describe relatively
> > > > > > > > simple
> > > > > > > > preconfigured clocks.
> > > > > > > 
> > > > > > > Some platforms have a fake clock which defines noops
> > > > > > > callbacks and
> > > > > > > basically doesn't do anything. This is analogous to the
> > > > > > > dummy
> > > > > > > regulator
> > > > > > > implementation. A central one could be registered by the
> > > > > > > clock core,
> > > > > > > as
> > > > > > > is done by the regulator core.
> > > > > > 
> > > > > > When you say some platforms, you presumably mean the platform
> > > > > > code in
> > > > > > Linux? A dummy clock sounds like a completely Linux-specific
> > > > > > abstraction rather than a description of the hardware, and I
> > > > > > don't see why we need that in the DT:
> > > > > > 
> > > > > > * If a clock is wired up and running (as presumably the dummy
> > > > > > clock is), then surely it's a fixed-clock (it's running, we
> > > > > > and we have no control over it, but we presumably know its
> > > > > > rate) and can be described as such?
> > > > > > 
> > > > > > * If no clock is wired up, then we should be able to describe
> > > > > > that. If a driver believes that a clock is required when it
> > > > > > isn't (for some level of functionality), then that driver
> > > > > > should be fixed up to support the clock as being optional.
> > > > > > 
> > > > > > Am I missing something?
> > > > > 
> > > > > I second that.
> > > > > 
> > > > > Moreover, I don't think that device tree should deal with dummy
> > > > > anything. It should be able to describe hardware that is
> > > > > available on given system, not list what hardware is not
> > > > > available.
> > > > 
> > > > I wasn't clear. The dummy clock IS a completely Linux-specific
> > > > abstraction.
> > > > 
> > > > I'm not advocating a dummy clock in DT. I am advocating
> > > > consolidation of the implementation of a clock that does nothing
> > > > into the clock core. This code could easily live in
> > > > drivers/clk/clk.c instead of having everyone open-code it.
> > > > 
> > > > As far as specifying a dummy clock in DT? I dunno. DT should
> > > > describe
> > > > real hardware so there isn't much use for a dummy clock.
> > > 
> > > Sorry, I misunderstood. Good to hear we're on the same page :)
> > > 
> > > > I'm guessing one of the reasons for such a clock are drivers do
> > > > not
> > > > honor the clk.h api and they freak out when clk_get gives them a
> > > > NULL
> > > > pointer?
> > > 
> > > I'm not sure. Sascha, could you shed some light on the matter?
> > 
> > The original reason introducing the dummy clocks in the i.MX dtbs
> > was to provide devices a clock which the driver requests but is
> > not software controllable. We often have the case where the same
> > devices are on several SoCs, but not on all of them all clocks have
> > a bit to en/disable them.
> > 
> > Anyway, to accomplish this we don't need dummy clocks. We can just
> > describe the real clocks.
> 
> You could use a dummy clk for the Linux implementation, but the downside
> is that a dummy clock has a rate of 0 always and a your clocks likely
> have non-zero rates.
> 
> It is probably better for you define a clock which only implements the
> .recalc_rate callback. If the rate of this clock changes without Linux
> having knowledge of it you can use the CLK_GET_RATE_NOCACHE flag.

I doubt that rate of a dummy clock could ever change... unless it is a 
rather smart dummy.

> > BTW with the S/PDIF core on which not all mux inputs are connected
> > to actual clocks we could also describe the unconnected inputs as
> > ground clocks with rate 0. This way we describe something which
> > is really there instead of dummy clocks ;)
> 
> Again you could use a dummy clock for this OR a fixed-rate clock with a
> rate of zero from the perspective of the Linux implementation.
> 
> Do you think it worthwhile to have a DT binding for a grounded clock?
> That is not an entirely uncommon case.

Well, how would that differ from skipping a clock from clocks list, i.e. 
not specifying it in clock-names and clocks properties?

> > Background to why it might be a good idea to connect a ground clock
> > to the unconnected input pins is that a driver has a chance to
> > successfully grab all clocks. Otherwise how does the driver
> > distinguish
> > between an unconnected and an erroneous clock?
> 
> Sorry, I don't follow this last question. Do you mean how to distinguish
> based on the value returned from clk_get?

Hmm, in theory, a driver could want to distinguish an error case (e.g. 
clock specified, but there is a problem with it) from no clock (e.g. clock 
not specified in DT, because it is not available on particular board).

Best regards,
Tomasz
