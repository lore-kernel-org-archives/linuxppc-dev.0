Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 1EB38DDE10
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 02:01:18 +1000 (EST)
Date: Sun, 6 May 2007 18:01:04 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Correct location for ADC/DAC drivers
Message-ID: <20070506160104.GV22585@pengutronix.de>
References: <8fZXU-3EI-11@gated-at.bofh.it> <8haHG-6zd-19@gated-at.bofh.it>
	<8hd2U-1Ca-39@gated-at.bofh.it> <8heii-3GM-37@gated-at.bofh.it>
	<E1Hkfia-0000cJ-18@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <E1Hkfia-0000cJ-18@be1.lrz>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Robin Getz <rgetz@blackfin.uclinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 06, 2007 at 02:19:59PM +0200, Bodo Eggert wrote:
> Since you ask for random thoughts:
> 
> IO of data streams from or to a DAC/ADC is essentially what soundcards do.
> I'm wondering if these cards are similar enough to use alsa, and if using
> that interface would ease or hinder programming the driver.

I had a short look at ALSA and it looks like it is a little bit too
focussed towards "normal" audio. For example, if follows an asynchronous
model in the sense that an application can read/write to a buffer at any
time, taken that the ringbuffer doesn't overflow. That's not enough for
example for control applications; you need the option for real
synchronous operation there.

IMHO we need an API which offers

- kernel ring buffers (to make it sure no data gets lost)
- generic data types (streaming plain ADC values is just the simplest
  case; we also have for example streaming FPGA data containing 
  preprocessed data sets)
- optional timestamping for each sample
- zero-copy from hardware into userspace memory, with DMA support
- application notification every N samples (N >= 1)

v4l2 may also be worth a look; but in the end I suppose they are all
specialized sub-cases of what we'd need for fast DAQ.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
