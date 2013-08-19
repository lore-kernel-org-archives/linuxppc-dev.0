Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFE982C0123
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 19:52:29 +1000 (EST)
Date: Mon, 19 Aug 2013 17:50:43 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 2/2] ASoC: fsl: Add S/PDIF machine driver
Message-ID: <20130819095042.GA11402@MrMyself>
References: <cover.1376901081.git.b42378@freescale.com>
 <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
 <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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

Hi,

On Mon, Aug 19, 2013 at 10:24:58AM +0100, Mark Rutland wrote:
> Is this used semantically, or is it a completely arbitrary string?  In
> either case I don't see why the compatible string doesn't give the
> driver enough to have a sensible value.
> 
> I'm confused as to why we need this. The phrase "user-visible" in a
> device description seems very odd.

The string would be in the ALSA device list:
ALSA device list:
  #0: imx-spdif

I think it can be a sort of arbitrary as long as users know which this 
device exactly is when they catch the name by 'aplay -l' or 'arecord -l'

The phrase "user-visible" is being used in many current docs, I don't 
dare to change it unless a sage gives me a suggestion.

> > +
> > +  - spdif-controller : The phandle of the i.MX S/PDIF controller
> > +
> > +
> > +Optional properties:
> > +
> > +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> > +
> > +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> > +
> > +* Note: At least one of these two properties should be set in the DT binding.
> 
> Are all four units (comlpex,controller,transmitter,receiver) really
> separate blocks?

At least they are separate drivers as I mentioned in the commit comments.

Thank you,
Nicolin
