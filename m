Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7D955DDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 06:52:19 +1000 (EST)
Date: Fri, 4 May 2007 22:52:13 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: Correct location for ADC/DAC drivers
Message-ID: <20070504205213.GQ22585@pengutronix.de>
References: <200705011435.45046.ml@stefan-roese.de>
	<20070504082434.GA22585@pengutronix.de>
	<200705041054.05650.ml@stefan-roese.de>
	<200705041421.50830.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200705041421.50830.rgetz@blackfin.uclinux.org>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robin,

On Fri, May 04, 2007 at 02:21:50PM -0400, Robin Getz wrote:
> We also have DAC and ADC drivers (up to 16 bits @ 64MS/s, via DMA),
> that would be nice to put in the "right" place  - I don't think that
> drivers/char is the right place, nor drivers/misc - I also don't think
> that /adc is a descriptive place for DAC or mixed signal front ends
> (MxFE).

What userspace interface do your drivers have? I don't think that there
is anything generic available at the moment, other than COMEDI (which is
rather outdated as far as I know).
 
> What about /drivers/char/daq or just drivers/daq - drivers for
> non-PCI/USB/ISA/PCMCIA Data Acquisition Hardware, D/A and A/D
> converters, Analog Front ends, etc.

I'd like drivers/daq better, because it doesn't have anything to do with
the bus it is connected to; a chipselect bus connectable ADC may be
connected to a SoC CS-bus or to a PCI bridge and you want to use the
same driver for it.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
