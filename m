Return-Path: <B42378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DE262C0153
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:18:31 +1000 (EST)
Date: Fri, 16 Aug 2013 18:16:18 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816101617.GB4694@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <20130816070818.GM26614@pengutronix.de>
 <20130816080124.GE1846@MrMyself>
 <20130816085632.GO26614@pengutronix.de>
 <20130816095357.GA4694@MrMyself>
 <20130816101151.GQ26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130816101151.GQ26614@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 Tomasz Figa <tomasz.figa@gmail.com>, rob.herring@calxeda.com, timur@tabi.org,
 broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 16, 2013 at 12:11:51PM +0200, Sascha Hauer wrote:
> > Some clocks are not from CCM and we haven't defined in imx6q-clk.txt,
> > so in most cases we can't provide a phandle for them, eg: spdif_ext.
> > I think it's a bit hard to force it to be 'required'. An 'optional'
> > looks more flexible to me and a default one is ensured even if it's
> > missing.
> 
> <&clks 0> is the dummy clock. This can be used for all input clocks not
> defined by the SoC.

That's feasible, thank you.

> spdif_ext would be a fixed clock on boards which provide it, but wiring
> this up would be the job of the board maintainer.

Understood.

> Look, it's really simple. Define the binding in a way that describes the
> hardware. Then use some sensible default in the driver for which clock
> to use. This doesn't have to cover all possible usecases, it only has
> to work. This is all that is necessary to get this driver mainline and
> will make most users happy. Then, later, someone might come along who
> needs more fine grained control over the clocks, but this guy is then
> able to justify *why* more control is needed.
> 
> This is not about getting a full featured driver into mainline. Get
> a basic driver into mainline and improve it later. You'll make it
> easier for us all.

Thank you for explain all these to the despicable me.
I'll try to make myself more comfortable with rules here.

Best regards,
Nicolin Chen
