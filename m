Return-Path: <rgetz@blackfin.uclinux.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by ozlabs.org (Postfix) with ESMTP id 3CDB5DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 08:13:49 +1000 (EST)
From: Robin Getz <rgetz@blackfin.uclinux.org>
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: Correct location for ADC/DAC drivers
Date: Fri, 4 May 2007 18:16:01 -0400
References: <200705011435.45046.ml@stefan-roese.de>
	<200705041421.50830.rgetz@blackfin.uclinux.org>
	<20070504205213.GQ22585@pengutronix.de>
In-Reply-To: <20070504205213.GQ22585@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705041816.01572.rgetz@blackfin.uclinux.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri 4 May 2007 16:52, Robert Schwebel pondered:
> Robin,
>
> On Fri, May 04, 2007 at 02:21:50PM -0400, Robin Getz wrote:
> > We also have DAC and ADC drivers (up to 16 bits @ 64MS/s, via DMA),
> > that would be nice to put in the "right" place  - I don't think that
> > drivers/char is the right place, nor drivers/misc - I also don't think
> > that /adc is a descriptive place for DAC or mixed signal front ends
> > (MxFE).
>
> What userspace interface do your drivers have?

Right now, it is a little rudimentary char interface, it needs a little care 
to be a bit more general purpose, but it suited needs of what the people who 
were using it.

http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/?view=markup&path=/trunk/drivers/char/ad9960.c

> I don't think that there 
> is anything generic available at the moment, other than COMEDI (which is
> rather outdated as far as I know).

I would be interested in having a detailed discussion/random thoughts on 
this - what is the best way to expose these types of devices?

I never actually used COMEDI, to understand the pro/cons of what it did.

> > What about /drivers/char/daq or just drivers/daq - drivers for
> > non-PCI/USB/ISA/PCMCIA Data Acquisition Hardware, D/A and A/D
> > converters, Analog Front ends, etc.
>
> I'd like drivers/daq better, because it doesn't have anything to do with
> the bus it is connected to; a chipselect bus connectable ADC may be
> connected to a SoC CS-bus or to a PCI bridge and you want to use the
> same driver for it.

That makes sense - I have seen more and more parts with selectable interfaces 
(I2C or SPI), and you should be able to use the same base driver, independent 
of the bus - so drivers/daq would suite me fine. 

-Robin
