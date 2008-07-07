Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFF2EDDE10
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 21:06:30 +1000 (EST)
Date: Mon, 7 Jul 2008 11:59:06 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080707105905.GA19240@rakim.wolfsonmicro.main>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:

> The driver is assuming a capture stream exists. My codec is output only.

While the driver declares a capture stream the core doesn't require that
both capture and playback be available - it will cope with a capture
only or a playback only DAI (this is fairly common due to DAC only and
ADC only parts).  Unless there's some other issue specific to this
driver?

> I'm using external clocking, but the driver should support using the
> mpc5200 for clocking. That's a little complicated since you have to
> compute the divisors. For example the Phytec pcm030 board has a
> 33.3333Mhz xtal and runs at 400Mhz.

This is desirable, though it shouldn't be an obstacle for merging if the
driver only supports running in slave mode.

> In order to reduce options, can the psc-i2s driver always try to use
> mpc5200 clocking, then let the codec or fabric driver override it?

The clocking should always be under the control of the machine driver
with the codec and platform drivers exporting the required dividers and
PLLs/FLLs.  Neither the platform driver nor the codec driver are really
in a position to know how a given board is wired up and what
interdependencies or external requirements there are.
