Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id DE6CBDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 22:07:41 +1100 (EST)
Message-ID: <49BF846E.5020101@mlbassoc.com>
Date: Tue, 17 Mar 2009 05:07:26 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: MPC5200 SPI
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to use the PSC/SPI driver on my MPC5200 board
'drivers/spi/mpc52xx_psc_spi.c' My kernel is 2.6.28, but
I don't see any changes in this area in the latest ones.

Cribbing from the Lite5200, I put this in my DTS file:
		// PSC6 => SPI
		spi@2c00 {		// PSC6
			compatible = "fsl,mpc5200-psc-spi";
			cell-index = <5>;
			reg = <0x2c00 0x100>;
			interrupts = <2 4 0>;
			interrupt-parent = <&mpc5200_pic>;
		};

I added the SPI device I'm working with (I have to write
this driver, so don't go looking for it).  This was added
within the spi@2c00 node, much like various I2C devices, etc.

			temp@spi {
				compatible = "maxim,max6629";
			};

Sadly, the SPI master driver seems 100% oblivious to this.
I found the call of_register_spi_devices (drivers/of/of_spi.c),
but it is only used by the xilinx SPI master.  Also, I didn't
find any slave examples anywhere.

Is this driver (SPI on MPC5200) supposed to work?
If so, what am I missing to get it set up?
If not, what needs to be done to get it there?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
