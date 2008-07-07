Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 75B88DDF0E
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 23:23:27 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so356016rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 06:23:24 -0700 (PDT)
Message-ID: <9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
Date: Mon, 7 Jul 2008 09:23:24 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, timur@freescale.com
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
In-Reply-To: <20080707105905.GA19240@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
	<20080707105905.GA19240@rakim.wolfsonmicro.main>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:
>
>  > The driver is assuming a capture stream exists. My codec is output only.
>
>
> While the driver declares a capture stream the core doesn't require that
>  both capture and playback be available - it will cope with a capture
>  only or a playback only DAI (this is fairly common due to DAC only and
>  ADC only parts).  Unless there's some other issue specific to this
>  driver?

Yes, it GPFs allocating a a DMA buffer on the null capture stream pointer.

>
>  > I'm using external clocking, but the driver should support using the
>  > mpc5200 for clocking. That's a little complicated since you have to
>  > compute the divisors. For example the Phytec pcm030 board has a
>  > 33.3333Mhz xtal and runs at 400Mhz.
>
>
> This is desirable, though it shouldn't be an obstacle for merging if the
>  driver only supports running in slave mode.
>
>
>  > In order to reduce options, can the psc-i2s driver always try to use
>  > mpc5200 clocking, then let the codec or fabric driver override it?
>
>
> The clocking should always be under the control of the machine driver
>  with the codec and platform drivers exporting the required dividers and
>  PLLs/FLLs.  Neither the platform driver nor the codec driver are really
>  in a position to know how a given board is wired up and what
>  interdependencies or external requirements there are.
>


-- 
Jon Smirl
jonsmirl@gmail.com
