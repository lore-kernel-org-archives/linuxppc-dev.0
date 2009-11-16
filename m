Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 42F4BB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Nov 2009 04:10:39 +1100 (EST)
Date: Mon, 16 Nov 2009 20:10:37 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Torsten Fleischer <to-fleischer@t-online.de>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091116171037.GA26163@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200911161742.46663.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 05:42:46PM +0100, Torsten Fleischer wrote:
> Hi all,
> 
> I have 3 devices connected to the SPI bus of the MPC8313. For the Chip Select 
> (CS) signals 3 GPIOs of the controller are used. But the driver uses the 
> inverse polarity of the CS either during the initialization or at the transfer 
> - depending on the setup of the flattened device tree.
> 
> Here is what I discovered:
> The driver uses a polarity flag for each CS signal (the alow_flags array). 
> These flags are set according to the 'gpios' property of the SPI node of the 
> flattened device tree.
> Is it correct that alow_flags[x] = 1 means CSx is active low?

Either way should work. Though, now I tend to I think that
'spi-cs-high' is actually already encoded in the compatible
name. E.g. for device X we always know that the device assumes
CS to be active low, so it has no spi-cs-high.

How chip selects are wired to a device is another matter.

> During the initialization the driver sets the CS to the value of 
> alow_flags[x]. I.e. CSx is High if alow_flags[x] = 1 and otherwise Low.
> 
> The flags are used in the function mpc8xxx_spi_cs_control() to take care about 
> the polarity when setting the appropriate GPIO pin. But the function 
> mpc8xxx_spi_chipselect() that calls the mpc8xxx_spi_cs_control() takes also 
> care about the polarity of the CS (bool pol = spi->mode & SPI_CS_HIGH).
> 
> Lets assume alow_flags[x] = 1 and the property 'spi-cs-high' is not set for 
> the SPI device. During initialization the driver sets the chip select signal 
> 'x' to High (see of_mpc8xxx_spi_get_chipselects()). This is OK if the chip 
> select is active low, because this disables the device on start-up. But during 
> the transfer the chip select signal is High and after the transfer is 
> completed the signal is set to Low. This is not the intended behavior for an 
> active low chip select.
> 
> I also tried to set alow_flags[x] = 0 for active low. In this case the 
> transfer works, but the initial value for the CS is wrong (Low instead of 
> High).

So it might be better to fix up initial value in the platform code?

> The problem seems to be that the polarity is taken into account twice (as 
> described above).

Yep. So, today I'd suggest to not use spe-cs-high, even though
I was OK with it before.

> So what would be the better solution: removing the usage of the alow_flags in 
> mpc8xxx_spi_cs_control() or the variable 'pol' in mpc8xxx_spi_chipselect()?

Neither. 'pol' is still needed. Don't mix device wiring and the
chip select type. Driver may play active-low/high games with
a device, some drivers pass or clear SPI_CS_HIGH flags by themselves
(e.g. mmc_spi.c), so device-tree don't have to have spi-cs-high
flag specified.

But the wire from a GPIO controller to a SPI device can be inverted,
so you'll have to account that too!

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
