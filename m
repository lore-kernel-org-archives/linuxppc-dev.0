Return-Path: <to-fleischer@t-online.de>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by ozlabs.org (Postfix) with ESMTP id 2DEEA1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Nov 2009 03:43:18 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: spi_mpc8xxx.c: chip select polarity problem
Date: Mon, 16 Nov 2009 17:42:46 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200911161742.46663.to-fleischer@t-online.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I have 3 devices connected to the SPI bus of the MPC8313. For the Chip Select 
(CS) signals 3 GPIOs of the controller are used. But the driver uses the 
inverse polarity of the CS either during the initialization or at the transfer 
- depending on the setup of the flattened device tree.

Here is what I discovered:
The driver uses a polarity flag for each CS signal (the alow_flags array). 
These flags are set according to the 'gpios' property of the SPI node of the 
flattened device tree.
Is it correct that alow_flags[x] = 1 means CSx is active low?

During the initialization the driver sets the CS to the value of 
alow_flags[x]. I.e. CSx is High if alow_flags[x] = 1 and otherwise Low.

The flags are used in the function mpc8xxx_spi_cs_control() to take care about 
the polarity when setting the appropriate GPIO pin. But the function 
mpc8xxx_spi_chipselect() that calls the mpc8xxx_spi_cs_control() takes also 
care about the polarity of the CS (bool pol = spi->mode & SPI_CS_HIGH).

Lets assume alow_flags[x] = 1 and the property 'spi-cs-high' is not set for 
the SPI device. During initialization the driver sets the chip select signal 
'x' to High (see of_mpc8xxx_spi_get_chipselects()). This is OK if the chip 
select is active low, because this disables the device on start-up. But during 
the transfer the chip select signal is High and after the transfer is 
completed the signal is set to Low. This is not the intended behavior for an 
active low chip select.

I also tried to set alow_flags[x] = 0 for active low. In this case the 
transfer works, but the initial value for the CS is wrong (Low instead of 
High).

The problem seems to be that the polarity is taken into account twice (as 
described above).
So what would be the better solution: removing the usage of the alow_flags in 
mpc8xxx_spi_cs_control() or the variable 'pol' in mpc8xxx_spi_chipselect()?

Best Regards
Torsten Fleischer
