Message-ID: <3C39C144.7090202@embeddededge.com>
Date: Mon, 07 Jan 2002 10:39:48 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
Cc: "'dmalek@jlc.net'" <dmalek@jlc.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: CS4218 sound driver
References: <69AB2E42243FD511920200805FE64EAD0E367D@zbr01exm01.spo.br.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Borracini Evandro-R45188 wrote:


> You wrote the cs4218_tdm sound driver, right?

Yes.

> I would like to use your cs4218 driver on my MPC823 board but I don't know how to connect an audio codec to the TDM.


There are many, many ways to configure codecs to match a hardware and software
interface.  Not all (and I don't think any Motorola :-) codecs lend themselves
to an efficient hardware connection to the TDM along with useful software features.

The CS4218 codec (and others in this family) work well with the TDM interface and
provide the features we want for professinal audio. First of all, you need to choose a
codec that will source a very accurate clock, or provide some external hardware to
do so.  The MPC8xx can't source a clock that is useful for standard sampling frequencies.
The driver is a trivial implementation of TDM data transfer to/from the codec, and is
also specific to the Embedded Planet HIOX card because all codec control is performed
through GPIO pins and the SPI.  About 95% of this driver is taken from the PowerMac
dmasound driver, since they are logically very similar.

> Do you  know ( or does anyone in linuxppc list know) were I can find the hardware schematic  for the cs4218_tdm driver?

It's actually pretty simple.  Get a CS4218 data sheet and look at the signals.  The
clock is obvious, the frame pulse, tx/rx are connected to the TDM.  In a default
mode, this is all you need to make it work.  We then connected the mode pins to a
GPIO register to select the sampling frequency, and the SPI is connected to the CS4218
control interface to provide gain/level control.  I didn't use the 8xx SPI controller
because the overhead was too high.  I just software-clocked the bits on the pins.

Have fun.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
