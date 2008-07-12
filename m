Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 52A54DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 03:36:19 +1000 (EST)
Date: Sat, 12 Jul 2008 18:36:10 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Message-ID: <20080712173609.GA6523@sirena.org.uk>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080712060018.GB23213@secretlab.ca>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 12:00:18AM -0600, Grant Likely wrote:
> On Wed, Jul 02, 2008 at 11:48:33AM +0100, Liam Girdwood wrote:

> > PLL/FLL/clock config is usually done in a separate function
> > (codec_set_pll(), callable by machine driver) so that we can change
> > clocks depending on the available machine clocks and srate. 

...

> > Codec domain (i.e Bias power) PM stuff should be done in
> > codec_dapm_event(). This allows us to power the codec on when we do
> > things like sidetone (with no active playback or capture stream).

> Ugh, I'm going to have to leave these two for now.  I don't understand
> enough about the ASoC structure yet to understand what it should look
> like.  I'll probably need help, but I don't think I can get it sorted
> out before the merge window.

> Do these two comments need to be addressed before the driver is merged?

It wouldn't be the only driver not to implement PLL configuration in
this way so that's probably be OK for an initial merge.  What's expected
for PLL configuration is that you implement the DAI set_pll() operation
in the codec driver, allowing machine drivers to configure the PLL when
they wish.

The power configuration should be fixed, though.  Normally drivers
either fully implement DAPM (including set_bias_level()) or power
everything in the codec up when the driver is loaded.  At the minute
what the driver is doing appears to be powering the codec up in both
_hw_params() and _probe() but never powering anything down - if that is
the case then probably all you need to do is remove the extra power up
from hw_params(), giving you the simple option.

> Hmmm, I haven't been able to find this; either in the code or on a live
> running system.  Where is the common reg dump implemented.

/sys/bus/platform/devices/soc-audio/codec_reg
