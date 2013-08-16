Return-Path: <B42378@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 669132C0238
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 18:03:59 +1000 (EST)
Date: Fri, 16 Aug 2013 16:01:25 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816080124.GE1846@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <20130816070818.GM26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130816070818.GM26614@pengutronix.de>
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

Hi Sascha,

   Thank you for the detailed comments.

On Fri, Aug 16, 2013 at 09:08:18AM +0200, Sascha Hauer wrote:
> Which of them the driver should use is configuration and thus normally
> should *not* be described in the devicetree. However, there may be no
> good way for the driver to know which clock to use in which case. There
> may be additional board requirements which are unknown to the driver. So
> in this case it might be valid to put the information which clock to use
> into the devicetree. But be aware that from the moment you put this
> information into the devicetree the driver is no longer free to chose
> the best clock, even if in future we find a good way to automatically
> guess the best clock. Do you have some insights in which case I would
> use which input clock? Is this only about which clock has the best
> suitable input frequency or is this also about synchronization of the
> audio signal with some other unit?

I understand. What I'm thinking now is to let the driver find the best
clock source for tx clock and a correspond divisor like this:

"tx<0-8>"	Optional	Tx clock source for spdif playback.
				If absent, will use core clock.
				The index from 0 to 8 is identical
				to the clock source list described
				in TxClk_Source bit of register STC.
				Multiple clock source are allowed
				for this tx clock source. The driver
				will select one source from them for
				each supported sample rate according
				to the clock rates of these provided
				clock sources.

Please review this idea.


And likewise for rx:

"rx<0-16>"	Optional	Rx clock source for spdif record.
				If absent, will use core clock.
				The index from 0 to 16 is identical
				to the clock source list described
				in ClkSrc_Sel bit of register SRPC.
				If the index provided contains an
				"if (DPLL Locked)" condition in its
				source, the correspond clock phandle
				should be the one in "else" path.
				Only one rx clock source should be
				defined here.

> Likewise with the rx-clksrc-lock property. what are the reasons to
> enable/disable this property? Is this an option you want to change
> during runtime? Is it an option you always want to use when it's
> available?
> 
> If you don't know the answer then it might be a good option to just let
> the driver pick a sane default. If someone feels the need to change the
> default he probably comes up with a good reason why this is necessary.
> And then we can discuss again whether we want to have the option in the
> devicetree or some sysfs entry or whatever else.

The answer is, SPDIF controller actually doesn't care about which rx
clock source being chosen or even whether it has the "if (DPLL Locked)"
condition or not. It can measure its input clock sample rate by measuring
the signal source, from a spdif transmitter via coaxial cable or optical
line. However, the rxclk will be sent to other IP, ASRC on i.MX6Q for
example. Quoting from the i.MX6Q reference manual that "Both the Rx clock
and Tx clock are sent to the ASRC".

Therefore, if 'rx-clksrc-lock' is present, that means ASRC will get a
clock source indirectly from coaxial cable that contains the sample rate
information. So it can know what input sample rate is and do his own
procedure accordingly.

Thank you,
Nicolin Chen
