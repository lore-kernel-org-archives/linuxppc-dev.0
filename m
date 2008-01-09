Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Generic MMC-over-SPI binding?
Date: Wed, 9 Jan 2008 22:55:31 +0100
References: <47838708.5050008@hogyros.de> <200801081827.13940.arnd@arndb.de>
	<478501A2.60506@hogyros.de>
In-Reply-To: <478501A2.60506@hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801092255.32056.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 January 2008, Simon Richter wrote:
> > The important part where this connects to the mmc-spi driver is that
> > you need to set spi_board_info->modalias to "mmc-spi", if the
> > device node can be identified as an mmc card.
> 
> Doing that now, using the code you provided as a base. The SPI child 
> device gets registered, but it appears something is still missing as no 
> messages I could attribute to mmc-spi appear. My suspicion would be that 
> it doesn't like the monolithic kernel for some reason (the mmc-spi 
> driver registers itself as a driver called "mmc_spi", not sure if the 
> modalias handling will catch that; still investigating there).

Right, the modalias needs to be the same as the driver name, not the
module name, so you should change it to mmc_spi as well.
For loading the module it would not make a difference because - and _
are treated the same by the module loader, but the device only
gets associated with the driver when it matches exactly.

> > Then you call that function after registering the master, from
> > mpc52xx_psc_spi_of_probe.
> 
> I've changed mpc52xx_psc_spi_do_probe to have an additional argument for 
> the OF device node of the SPI master; ARCH=ppc can call this with NULL 
> as long as it still exists.

Ok. keeping the code itself in the mpc52xx_psc_spi driver is fine as long
as it's relatively small. Other of_platform_drivers for SPI will just
have to it the same way.

	Arnd <><
