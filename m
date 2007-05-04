Return-Path: <rgetz@blackfin.uclinux.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by ozlabs.org (Postfix) with ESMTP id 7D177DDEEB
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 04:30:02 +1000 (EST)
From: Robin Getz <rgetz@blackfin.uclinux.org>
To: "Stefan Roese" <ml@stefan-roese.de>
Subject: Re: Correct location for ADC/DAC drivers
Date: Fri, 4 May 2007 14:21:50 -0400
References: <200705011435.45046.ml@stefan-roese.de>
	<20070504082434.GA22585@pengutronix.de>
	<200705041054.05650.ml@stefan-roese.de>
In-Reply-To: <200705041054.05650.ml@stefan-roese.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705041421.50830.rgetz@blackfin.uclinux.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri 4 May 2007 04:54, Stefan Roese pondered:
> On Friday 04 May 2007 10:24, Robert Schwebel wrote:
> > On Tue, May 01, 2007 at 02:35:44PM +0200, Stefan Roese wrote:
> > > I'm in the stage of integrating some ADC and DAC drivers for the AMCC
> > > 405EZ PPC and looking for the correct location to place these drivers
> > > in the Linux source tree. The drivers are basically character-drivers,
> > > so my first thought is to put them in "drivers/char/adc/foo.c" or
> > > "drivers/char/adc_foo.c". Is this a good solution?
> > >
> > > Any suggestions welcome (could be that I missed an already existing
> > > example).
> > >
> > > BTW: I am aware of the hwmon subsystem, but I don't think it fits my
> > > needs in this case.
> >
> > Could you elaborate the requirements a bit more? ADC is not ADC, because
> > slow i2c ADCs which measure a temperature every five minutes have other
> > requirements than multi-megabyte-per-second-dma-driven ADCs.
>
> The hardware (PPC405EZ) actually implements an high speed, dma capable, ADC
> controller with 10-bit resolution and up to 4MHz sample rate. The current
> driver doesn't support all these features though (dma is not supported
> right now for example). Could be that this will be added in future
> releases. It would be good though, to have the driver located at the
> "correct" place in the kernel tree right away.

We also have DAC and ADC drivers (up to 16 bits @ 64MS/s, via DMA), that would 
be nice to put in the "right" place  - I don't think that drivers/char is the 
right place, nor drivers/misc - I also don't think that /adc is a descriptive 
place for DAC or mixed signal front ends (MxFE).

What about /drivers/char/daq or just drivers/daq - drivers for 
non-PCI/USB/ISA/PCMCIA Data Acquisition Hardware, D/A and A/D converters, 
Analog Front ends, etc.

I think that is the common TLA - at least according to 
http://en.wikipedia.org/wiki/Data_acquisition

?

-Robin
