Date: Tue, 21 May 2002 08:59:24 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>,
	andrew may <acmay@acmay.homeip.net>
Subject: Re: 405 I2C
Message-ID: <20020521085924.F9190@ecam.san.rr.com>
References: <1021995053.7265.22.camel@swb11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1021995053.7265.22.camel@swb11>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 05:30:53PM +0200, Kenneth Johansson wrote:
> How would you feel about merging the i2c-adap-ibm_ocp.c
> andi2c-algo-ibm_ocp.c into one file. This way it's possible to build the
> i2c drivers as a module.

I think it would be nice to have them seperate. I think we can latter
have i2-adap-ibm use i2c-algo-bit to controll the I2C bus through the
Direct Control Reg or use the GPIO pins as another I2C bus. I think the
interupt handling should move into "algo" though.

> Also I have a problem when accessing a device that is not present. The
> bus ends up in busy state an no other action can be taken. I solved the
> problem for me here by simply removing the test in iix_xfer but a proper
> solution has to be discussed. I have not tried Andrew's new iic_xfer is
> it going to be merged ??

Does the scan bus work for you? It should go through and read from all
possible locations and report if a device is there. It works with my
iic_xfer but I don't rember if I tried the old one. It should have the
same effect as "accessing a device that is not present".

Which test in iix_xffer that?

I have been stuck doing a lot of other stuff the past couple of weeks
and the lint'ing of the source files really made the last merge pretty
bad. So my motivation to look into this stuff has been very low.

I was trying to use the lm75 driver and have been running into
problems. The driver does reads of the static registers on the
chip then does a set of reads to "aliased" (1,9,17,...)addresses
of the same registers and does a compare. With my iic_xfer things
start to fail and by forcing the driver to come up it reads a bad
temp(79 I think) and the config is stuck at 0x20. With the old
iic_xfer the bus locks up in an unkown state.

I have been using the GPIO pins to trigger things to look at I2C
clock and data and it seems that the lm75 is doing a NACK for the
chip reg of 0x09. So I am not sure why this appears to different
than the other lm75's out there.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
