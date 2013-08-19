Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76B8E2C012F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 20:28:38 +1000 (EST)
Message-ID: <1376908048.4081.43.camel@pizza.hi.pengutronix.de>
Subject: Re: [PATCH v7 2/2] ASoC: fsl: Add S/PDIF machine driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 19 Aug 2013 12:27:28 +0200
In-Reply-To: <20130819100143.GH3719@e106331-lin.cambridge.arm.com>
References: <cover.1376901081.git.b42378@freescale.com>
 <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
 <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
 <20130819095042.GA11402@MrMyself>
 <20130819100143.GH3719@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Nicolin Chen <b42378@freescale.com>, "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "R65777@freescale.com" <R65777@freescale.com>,
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

Am Montag, den 19.08.2013, 11:01 +0100 schrieb Mark Rutland:
> On Mon, Aug 19, 2013 at 10:50:43AM +0100, Nicolin Chen wrote:
> > Hi,
> > 
> > On Mon, Aug 19, 2013 at 10:24:58AM +0100, Mark Rutland wrote:
> > > Is this used semantically, or is it a completely arbitrary string?  In
> > > either case I don't see why the compatible string doesn't give the
> > > driver enough to have a sensible value.
> > > 
> > > I'm confused as to why we need this. The phrase "user-visible" in a
> > > device description seems very odd.
> > 
> > The string would be in the ALSA device list:
> > ALSA device list:
> >   #0: imx-spdif
> > 
> > I think it can be a sort of arbitrary as long as users know which this 
> > device exactly is when they catch the name by 'aplay -l' or 'arecord -l'
> > 
> > The phrase "user-visible" is being used in many current docs, I don't 
> > dare to change it unless a sage gives me a suggestion.
> 
> I can see that there is entrenched usage, but this really seems to be
> embedding Linux-specific implementation details into the dt. I don't see
> why the driver cannot select a sensible name, but perhaps I'm missing
> something.
> 
> Mark, is there any reason we need to handle the user-visible name of the
> device this way?
> 
> > 
> > > > +
> > > > +  - spdif-controller : The phandle of the i.MX S/PDIF controller
> > > > +
> > > > +
> > > > +Optional properties:
> > > > +
> > > > +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> > > > +
> > > > +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> > > > +
> > > > +* Note: At least one of these two properties should be set in the DT binding.
> > > 
> > > Are all four units (comlpex,controller,transmitter,receiver) really
> > > separate blocks?
> > 
> > At least they are separate drivers as I mentioned in the commit comments.
> 
> I'm not sure that the boundary of Linux drivers should necessarily
> determine the way we carve up the description of IP blocks, though
> presumably it's a pretty sensible way of carving it up or we wouldn't
> have done it.

The transmitter and receiver can be real external codec devices with
S/PDIF input or output pads connected to the i.MX S/PDIF. One example
would be the Analog Devices ADV7612 HDMI receiver, which can output
audio taken from HDMI input via S/PDIF (just as via I2S).

The dummy codec devices are just needed if the S/PDIF pads are directly
routed to externally accessible connectors.

regards
Philipp
