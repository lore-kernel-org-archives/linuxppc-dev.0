Message-ID: <3D3D6FB6.6030804@embeddededge.com>
Date: Tue, 23 Jul 2002 11:01:10 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pavel Bartusek <pba@sysgo.de>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MDIO clock speed computation
References: <2702075D4DE2B043BF5EB82E9CFAD45B093B0D@mail1.mediatrix.com> <3D3C6233.3090007@embeddededge.com> <3D3D2E49.8000309@sysgo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Bartusek wrote:

> I thing that system clock and bus clock can be different (in terminology
> of the MPC855T user manual)
>
> MPC855T manual, section Clocks and Power Control:
> "
> GCLK1C/GCLK2C - Basic clocks supplied to the core, the data and
> instruction caches, and MMUs.
> GCLK1_50/GCLK2_50 - Optionally divided versions of GCLK1/GCLK2, which
> are used to clock the GPCM and UPM in the memory controller and to
> provide the CLKOUT output for the external bus.

Notice in all of the descriptions there is no definition of "system clock."
I carefully read all of the 8xx manuals, and there are a few references
to "system clocks", especially around power management and frequency
control.  There are a couple of references to peripheral clocks being
derived from a "system clock", which from the context appears to be the
same as the core clock, not the CLKOUT that would be supplied to the rest
of the "system."

It appears the MII clock must be derived from the core clock speed, so
my code change suggestion the other day was wrong. :-)



>>>   (((bd->bi_intfreq + (2 * 2500000 - 1 )) / 2500000 / 2) & 0x3F) << 1;
>>
>>
> OK. It is more correct.

try this (since the problem is the divisor register truncation):

(((((bd->bi_intfreq + 500000) / 2500000) + 1) / 2 ) & 0x3F ) << 1;

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
