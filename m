Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D47972C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 07:41:50 +1000 (EST)
Received: by mail-pb0-f43.google.com with SMTP id md4so1149218pbc.16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 14:41:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130823140128.GI31036@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130822210035.GB31036@pengutronix.de> <20130822224331.8231.75743@quantum>
 <34430785.ApIqfgatMc@flatron> <20130823063421.GF31036@pengutronix.de>
 <20130823125815.GG25856@e106331-lin.cambridge.arm.com>
 <20130823140128.GI31036@pengutronix.de>
Message-ID: <20130823214144.8231.2039@quantum>
Subject: Re: [alsa-devel] [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Fri, 23 Aug 2013 14:41:44 -0700
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
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

Quoting Sascha Hauer (2013-08-23 07:01:28)
> On Fri, Aug 23, 2013 at 01:58:15PM +0100, Mark Rutland wrote:
> > On Fri, Aug 23, 2013 at 07:34:21AM +0100, Sascha Hauer wrote:
> > > On Fri, Aug 23, 2013 at 12:49:19AM +0200, Tomasz Figa wrote:
> > > > On Thursday 22 of August 2013 15:43:31 Mike Turquette wrote:
> > > > > Quoting Sascha Hauer (2013-08-22 14:00:35)
> > > > > =

> > > > > > On Thu, Aug 22, 2013 at 01:09:31PM +0100, Mark Rutland wrote:
> > > > > > > On Thu, Aug 22, 2013 at 08:19:10AM +0100, Mike Turquette wrot=
e:
> > > > > > > > Quoting Tomasz Figa (2013-08-21 14:34:55)
> > > > > > > > =

> > > > > > > > > On Wednesday 21 of August 2013 09:50:15 Mark Rutland wrot=
e:
> > > > > > > > > > On Tue, Aug 20, 2013 at 01:06:25AM +0100, Mike Turquett=
e =

> > > > wrote:
> > > > > > > > > > > Quoting Mark Rutland (2013-08-19 02:35:43)
> > > > > > > > > > > =

> > > > > > > > > > > > On Sat, Aug 17, 2013 at 04:17:18PM +0100, Tomasz Fi=
ga =

> > > > wrote:
> > > > > > > > > > > > > On Saturday 17 of August 2013 16:53:16 Sascha Hau=
er =

> > > > wrote:
> > > > > > > > > > > > > > On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomas=
z Figa =

> > > > wrote:
> > > > > > > > > > > > > > > > > > Also I would make this option required.=
 Use a
> > > > > > > > > > > > > > > > > > dummy
> > > > > > > > > > > > > > > > > > clock for
> > > > > > > > > > > > > > > > > > mux
> > > > > > > > > > > > > > > > > > inputs that are grounded for a specific=
 SoC.
> > > > > > > > > > > > > > > > > =

> > > > > > > > > > > > > > > > > Some clocks are not from CCM and we haven=
't
> > > > > > > > > > > > > > > > > defined in
> > > > > > > > > > > > > > > > > imx6q-clk.txt,
> > > > > > > > > > > > > > > > > so in most cases we can't provide a phand=
le for
> > > > > > > > > > > > > > > > > them, eg:
> > > > > > > > > > > > > > > > > spdif_ext.
> > > > > > > > > > > > > > > > > I think it's a bit hard to force it to be
> > > > > > > > > > > > > > > > > 'required'. An
> > > > > > > > > > > > > > > > > 'optional'
> > > > > > > > > > > > > > > > > looks more flexible to me and a default o=
ne is
> > > > > > > > > > > > > > > > > ensured
> > > > > > > > > > > > > > > > > even if
> > > > > > > > > > > > > > > > > it's
> > > > > > > > > > > > > > > > > missing.
> > > > > > > > > > > > > > > > =

> > > > > > > > > > > > > > > > <&clks 0> is the dummy clock. This can be u=
sed for
> > > > > > > > > > > > > > > > all input
> > > > > > > > > > > > > > > > clocks
> > > > > > > > > > > > > > > > not
> > > > > > > > > > > > > > > > defined by the SoC.
> > > > > > > > > > > > > > > =

> > > > > > > > > > > > > > > Where does this assumption come from? Is it
> > > > > > > > > > > > > > > documented
> > > > > > > > > > > > > > > anywhere?
> > > > > > > > > > > > > > =

> > > > > > > > > > > > > > This is how all i.MX clock bindings currently a=
re. See
> > > > > > > > > > > > > > Documentation/devicetree/bindings/clock/imx*-cl=
ock.txt
> > > > > > > > > > > > > =

> > > > > > > > > > > > > OK, thanks.
> > > > > > > > > > > > > =

> > > > > > > > > > > > > I guess we need some discussion on dummy clocks vs
> > > > > > > > > > > > > skipped clocks.
> > > > > > > > > > > > > I think we want some consistency on this, don't w=
e?
> > > > > > > > > > > > > =

> > > > > > > > > > > > > If we really need a dummy clock, then we might al=
so want
> > > > > > > > > > > > > a generic
> > > > > > > > > > > > > way to specify it.
> > > > > > > > > > > > =

> > > > > > > > > > > > What do we actually mean by a "dummy clock"? We alr=
eady
> > > > > > > > > > > > have
> > > > > > > > > > > > bindings
> > > > > > > > > > > > for "fixed-clock" and co friends describe relatively
> > > > > > > > > > > > simple
> > > > > > > > > > > > preconfigured clocks.
> > > > > > > > > > > =

> > > > > > > > > > > Some platforms have a fake clock which defines noops
> > > > > > > > > > > callbacks and
> > > > > > > > > > > basically doesn't do anything. This is analogous to t=
he
> > > > > > > > > > > dummy
> > > > > > > > > > > regulator
> > > > > > > > > > > implementation. A central one could be registered by =
the
> > > > > > > > > > > clock core,
> > > > > > > > > > > as
> > > > > > > > > > > is done by the regulator core.
> > > > > > > > > > =

> > > > > > > > > > When you say some platforms, you presumably mean the pl=
atform
> > > > > > > > > > code in
> > > > > > > > > > Linux? A dummy clock sounds like a completely Linux-spe=
cific
> > > > > > > > > > abstraction rather than a description of the hardware, =
and I
> > > > > > > > > > don't see why we need that in the DT:
> > > > > > > > > > =

> > > > > > > > > > * If a clock is wired up and running (as presumably the=
 dummy
> > > > > > > > > > clock is), then surely it's a fixed-clock (it's running=
, we
> > > > > > > > > > and we have no control over it, but we presumably know =
its
> > > > > > > > > > rate) and can be described as such?
> > > > > > > > > > =

> > > > > > > > > > * If no clock is wired up, then we should be able to de=
scribe
> > > > > > > > > > that. If a driver believes that a clock is required whe=
n it
> > > > > > > > > > isn't (for some level of functionality), then that driv=
er
> > > > > > > > > > should be fixed up to support the clock as being option=
al.
> > > > > > > > > > =

> > > > > > > > > > Am I missing something?
> > > > > > > > > =

> > > > > > > > > I second that.
> > > > > > > > > =

> > > > > > > > > Moreover, I don't think that device tree should deal with=
 dummy
> > > > > > > > > anything. It should be able to describe hardware that is
> > > > > > > > > available on given system, not list what hardware is not
> > > > > > > > > available.
> > > > > > > > =

> > > > > > > > I wasn't clear. The dummy clock IS a completely Linux-speci=
fic
> > > > > > > > abstraction.
> > > > > > > > =

> > > > > > > > I'm not advocating a dummy clock in DT. I am advocating
> > > > > > > > consolidation of the implementation of a clock that does no=
thing
> > > > > > > > into the clock core. This code could easily live in
> > > > > > > > drivers/clk/clk.c instead of having everyone open-code it.
> > > > > > > > =

> > > > > > > > As far as specifying a dummy clock in DT? I dunno. DT should
> > > > > > > > describe
> > > > > > > > real hardware so there isn't much use for a dummy clock.
> > > > > > > =

> > > > > > > Sorry, I misunderstood. Good to hear we're on the same page :)
> > > > > > > =

> > > > > > > > I'm guessing one of the reasons for such a clock are driver=
s do
> > > > > > > > not
> > > > > > > > honor the clk.h api and they freak out when clk_get gives t=
hem a
> > > > > > > > NULL
> > > > > > > > pointer?
> > > > > > > =

> > > > > > > I'm not sure. Sascha, could you shed some light on the matter?
> > > > > > =

> > > > > > The original reason introducing the dummy clocks in the i.MX dt=
bs
> > > > > > was to provide devices a clock which the driver requests but is
> > > > > > not software controllable. We often have the case where the same
> > > > > > devices are on several SoCs, but not on all of them all clocks =
have
> > > > > > a bit to en/disable them.
> > > > > > =

> > > > > > Anyway, to accomplish this we don't need dummy clocks. We can j=
ust
> > > > > > describe the real clocks.
> > > > > =

> > > > > You could use a dummy clk for the Linux implementation, but the d=
ownside
> > > > > is that a dummy clock has a rate of 0 always and a your clocks li=
kely
> > > > > have non-zero rates.
> > > > > =

> > > > > It is probably better for you define a clock which only implement=
s the
> > > > > .recalc_rate callback. If the rate of this clock changes without =
Linux
> > > > > having knowledge of it you can use the CLK_GET_RATE_NOCACHE flag.
> > > > =

> > > > I doubt that rate of a dummy clock could ever change... unless it i=
s a =

> > > > rather smart dummy.
> > > > =

> > > > > > BTW with the S/PDIF core on which not all mux inputs are connec=
ted
> > > > > > to actual clocks we could also describe the unconnected inputs =
as
> > > > > > ground clocks with rate 0. This way we describe something which
> > > > > > is really there instead of dummy clocks ;)
> > > > > =

> > > > > Again you could use a dummy clock for this OR a fixed-rate clock =
with a
> > > > > rate of zero from the perspective of the Linux implementation.
> > > > > =

> > > > > Do you think it worthwhile to have a DT binding for a grounded cl=
ock?
> > > > > That is not an entirely uncommon case.
> > > > =

> > > > Well, how would that differ from skipping a clock from clocks list,=
 i.e. =

> > > > not specifying it in clock-names and clocks properties?
> > > =

> > > The difference is that you can successfully grab it in your driver.
> > =

> > That's a driver-specific issue. The driver knows best which clocks it
> > can live without (if it's poking only a subset of the hardware, it may
> > not need some just yet, but could for extended functionality in future
> > when support is extended), and could assign a dummy to those clocks it
> > knows it doesn't need that aren't described. That doesn't need to be in
> > the dt, and shouldn't be, because it's OS and driver specific.
> > =

> > > =

> > > > =

> > > > > > Background to why it might be a good idea to connect a ground c=
lock
> > > > > > to the unconnected input pins is that a driver has a chance to
> > > > > > successfully grab all clocks. Otherwise how does the driver
> > > > > > distinguish
> > > > > > between an unconnected and an erroneous clock?
> > > > > =

> > > > > Sorry, I don't follow this last question. Do you mean how to dist=
inguish
> > > > > based on the value returned from clk_get?
> > > > =

> > > > Hmm, in theory, a driver could want to distinguish an error case (e=
.g. =

> > > > clock specified, but there is a problem with it) from no clock (e.g=
. clock =

> > > > not specified in DT, because it is not available on particular boar=
d).
> > > =

> > > Yes, that's what I meant. To illustrate the problem for this driver:
> > > =

> > >     for (i =3D 0; i < STC_TXCLK_SRC_MAX; i++) {
> > >             sprintf(tmp, "rxtx%d", i);
> > >             clk =3D devm_clk_get(&pdev->dev, tmp);
> > >             if (IS_ERR(clk)) {
> > =

> >               [...]
> > =

> >                       /*
> >                        * ERR_PTR(-ENOENT) returned when clock not
> >                        * present in the dt (i.e. not wired up). We can
> >                        * live without this clock, so assign a dummy
> >                        * (NULL) to simplify the rest of the code. If
> >                        * the clock is present but something else went
> >                        * wrong, we'll get a different ERR_PTR value
> >                        * and actually fail.
> >                        */
> >                       if (clk =3D=3D ERR_PTR(-ENOENT)
> >                               clk =3D NULL;
> > =

> > >             }
> > >     }
> > > =

> > > This could be solved by always specifying all input clocks in the
> > > devicetree.
> > =

> > As far as I can see, the above is sufficient, and leaves the knowledge
> > of skippable clocks in the driver, where I believe it should be.
> =

> You miss my point. Once a clock is specified in the devicetree it is no
> longer optional. The driver currently can't find out whether a clock
> hasn't been specified (and it's ok that it's not there) or a clock has
> been specified, but some error prevents actually grabbing the clock (in
> which case the driver should bail out)

Seems like the regulator framework is solving this with the new
regulator_get_optional() call. This leaves the
optional-versus-not-optional logic up to the driver.

Regards,
Mike

> =

> Sascha
> =

> =

> -- =

> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
