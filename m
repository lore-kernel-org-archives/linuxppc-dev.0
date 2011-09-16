Return-Path: <michele.de_candia@alcatel-lucent.com>
Subject: espi enable/disable issue
From: Michele Jr De Candia <michele.de_candia@alcatel-lucent.com>
To: <Linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Sep 2011 12:28:34 +0200
Message-ID: <1316168914.2033.190.camel@nbdecandia>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
we're using your driver for espi controller on P1015 freescale micro.

We're testing an issue trying to do multiple operation into a single
chip select "window".

We've noted that the driver disables and enables the ESPI_SPMODE[EN] bit
in order to change the "ESPI_SPMODE x" register; probably it does it
because, such as for ESPI_SPMODE register, its bits can't change when
ESPI_SPMODE[EN] is enabled (although  the datasheet doesn't say nothing
about the mandatory disable operation for changing "ESPI_SPMODE x"
regs). 

The enable/disable operation issues a clock spike on SPI_CLK signal.

We need to do multiple SPI read/write into a single chip-select window
without changing SPIMODE and using an external chip select gpio.

Unfortunately, the clock spike generated from the enable/disable
operation its' destructive for our data.

We've tryed to remove the "enable/disable" operation into the
fsl_espi_setup_transfer() function but just the first operation went
fine; the next operation reply all as "FF". 

Seems that we can't do multiple operations into a single chip select
window without changing mode. Is it true? Is it possible to avoid this
issue (probably into the irq management)?

We're not using the last version of the driver but we've looked already
to the new driver uploaded into 3.0.4 kernel and the "Enable/Disable"
operation is still there.

Thank you in advance,
Michele De Candia
Angelo Spada
