Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D3C6233.3090007@embeddededge.com>
Date: Mon, 22 Jul 2002 15:51:15 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Pavel Bartusek'" <pba@sysgo.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MDIO clock speed computation
References: <2702075D4DE2B043BF5EB82E9CFAD45B093B0D@mail1.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:

> However, your fix seems incomplete.
> If I have a frequency of 82,5MHz, for example,
> it yields exactly to the same result before and after your patch,
> that is an MDIO clock of 2.58MHz.

The MII clock is not derived from the core speed, but rather the
system/bus clock speed.  Up to this point, I don't believe there are
any 8xx parts that are qualified to run beyond a 50 MHz CPU/bus
speed, so the software is just fine.  If you are running something
faster than a 50 MHz bus, you may want to look into this.


>
> Since the divisor is 2 * MDCLOCK,
> I would suggest something like:
>
>   (((bd->bi_intfreq + (2 * 2500000 - 1 )) / 2500000 / 2) & 0x3F) << 1;

The proper fix would be to change this from 'bi_intfreq' to 'bi_busfreq'.

What is actually happening is you are running much slower than 2.5 MHz
because you are computing on a clock that is running much faster than
the actual supplied clock to the MII (i.e. your divisor is too large).
Also, the 2.5 MHz is a suggestion, I think all PHYs run much faster, you
will have to check the data sheet.  The Motorola manual used to indicate
this as a suggested maximum for their parts, further that it would
run faster than this and maximum was still being qualified.

The only thing that will happen if this speed is out of spec for either
side is you will have problems configuring or detecting the PHY (the exchange
of control/status messages).  It has nothing to do with data transfer.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
