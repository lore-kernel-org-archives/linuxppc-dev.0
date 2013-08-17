Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x231.google.com (mail-bk0-x231.google.com
 [IPv6:2a00:1450:4008:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BF7A2C0233
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 22:26:51 +1000 (EST)
Received: by mail-bk0-f49.google.com with SMTP id r7so910756bkg.36
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 05:26:44 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 14:26:40 +0200
Message-ID: <137675716.iLf1T1CVZo@flatron>
In-Reply-To: <20130816085632.GO26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130816080124.GE1846@MrMyself> <20130816085632.GO26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com,
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

On Friday 16 of August 2013 10:56:32 Sascha Hauer wrote:
> On Fri, Aug 16, 2013 at 04:01:25PM +0800, Nicolin Chen wrote:
> > Hi Sascha,
> > 
> >    Thank you for the detailed comments.
> > 
> > On Fri, Aug 16, 2013 at 09:08:18AM +0200, Sascha Hauer wrote:
> > > Which of them the driver should use is configuration and thus
> > > normally
> > > should *not* be described in the devicetree. However, there may be
> > > no
> > > good way for the driver to know which clock to use in which case.
> > > There
> > > may be additional board requirements which are unknown to the
> > > driver. So in this case it might be valid to put the information
> > > which clock to use into the devicetree. But be aware that from the
> > > moment you put this information into the devicetree the driver is
> > > no longer free to chose the best clock, even if in future we find a
> > > good way to automatically guess the best clock. Do you have some
> > > insights in which case I would use which input clock? Is this only
> > > about which clock has the best suitable input frequency or is this
> > > also about synchronization of the audio signal with some other
> > > unit?
> > 
> > I understand. What I'm thinking now is to let the driver find the best
> > clock source for tx clock and a correspond divisor like this:
> > 
> > "tx<0-8>"	Optional	Tx clock source for spdif playback.
> > 
> > 				If absent, will use core clock.
> > 				The index from 0 to 8 is identical
> > 				to the clock source list described
> > 				in TxClk_Source bit of register STC.
> > 				Multiple clock source are allowed
> > 				for this tx clock source. The driver
> > 				will select one source from them for
> > 				each supported sample rate according
> > 				to the clock rates of these provided
> > 				clock sources.
> 
> You mean tx<0-7>.
> 
> Also I would make this option required. Use a dummy clock for mux inputs
> that are grounded for a specific SoC.

Why do you need a dummy clock?

The driver can simply try to grab all the possible clocks and discard 
those that failed, so you can just keep those grounded clocks unspecified.

Best regards,
Tomasz
