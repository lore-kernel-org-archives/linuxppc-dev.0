Subject: Re: [PATCH][RFC]Updated MPC I2C driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: mcclintock@freescale.com,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Matthew McClintock <mcclintock@motorola.com>
In-Reply-To: <40E49100.2060501@246tNt.com>
References: <1088705955.28598.168.camel@localhost>
	 <1088693987.7555.60.camel@matthew-laptop>
	 <1088717127.28598.197.camel@localhost>  <40E49100.2060501@246tNt.com>
Content-Type: text/plain
Message-Id: <1088759103.936.24.camel@localhost>
Mime-Version: 1.0
Date: Fri, 02 Jul 2004 10:05:03 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-01 at 23:32, Sylvain Munaut wrote:

>  - The FDR computation is completly different. Here is the code I
> attached the code I used in my I2C driver. Basically, it takes as
> argument the desired I2C clock rate ( was a module parameter ) and the
> internal bus frequency and then compute the FDR.

The 5200 seems to have a different FDR implementation. I could include
your calculation code if you can tell me where the value of ipb_freq
should come from.

I don't currently do a calculation on the 107, but pick a slow value for
safety. I'd need more platform specific knowledge to do the calculation,
as the 107/824x scale from the SDRAM clock, and the 85xx scales from the
CCB clock.

>  - During the scan, the first bus is scanned without devices and the
> error when debug is active is I2C_MAL. From the moment the eeprom is
> detected, the error code become I2C_NORXACK for the address wihout
> device. Included dmesg

Are you sure that it changes from MAL to NORXACK after seeing a device?
It looks to me that it returns MAL only on the bus without devices,
probably due to lack of pull-up resistors.

>  - The interrupt bit. BTW, on what event should the interrupt be fired ?
> (I did my test without any interrupts )

To use my driver, just set IE1 and IE2. The other flags are for a
different approach using DMA to load the TX and RX registers. That would
give a lower CPU overhead, but would also require a separate driver.

In fact, the reset value of this register is correct. The easiest fix
may be for platform code to ensure that the register has the correct
value, in case boot firmware changed it.

> Another remark : The register setup are done at every _start. Couldn't
> they be done once for all during init ( just after the probe, call a
> init_hardware functions ).

Yes, the frequency settings could be done once on startup. I might try
that.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
