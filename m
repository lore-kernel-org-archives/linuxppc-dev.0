Message-ID: <3D3D93B1.1090304@embeddededge.com>
Date: Tue, 23 Jul 2002 13:34:41 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: Pavel Bartusek <pba@sysgo.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MDIO clock speed computation
References: <2702075D4DE2B043BF5EB82E9CFAD45B093B11@mail1.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:


> With a frequency of 46.5MHz, you get a MII clock of 2.58MHz.

OK....We'll use something else, then.

> Why adding 500000 (0.5MHz) to the internal clock in this computation?
> We usually do that to round up (or down) to the nearest integer.

I did it to round up so the frequencies I knew about at the time would
generate the proper results.  I have to admit, I never expected to
see someone run something like 46.5 MHz.  I guess when we made the
change to represent the frequency in Hz instead of MHz, the arithmetic
fell apart.  In the past, we couldn't represent 46.5 MHz, it would
have been 47 MHz, so the rounding would have produced a correct result.

> But we do NOT want to round down, or the divisor (MII_SPEED) will be too
> low.

I'm not rounding down, there are two cases where it is rounded up, but
I guess that still isn't enough.


> We want to round up to the nearest integer when divided by 2*2.5MHz.

Will this work for all cases? :

((((bd->bi_intfreq + 4999999) / 2500000) / 2 ) & 0x3F ) << 1;



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
