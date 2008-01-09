Return-Path: <Simon.Richter@hogyros.de>
Message-ID: <478501A2.60506@hogyros.de>
Date: Wed, 09 Jan 2008 18:17:22 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: Generic MMC-over-SPI binding?
References: <47838708.5050008@hogyros.de> <200801081827.13940.arnd@arndb.de>
In-Reply-To: <200801081827.13940.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Arnd Bergmann wrote:

> The important part where this connects to the mmc-spi driver is that
> you need to set spi_board_info->modalias to "mmc-spi", if the
> device node can be identified as an mmc card.

Doing that now, using the code you provided as a base. The SPI child 
device gets registered, but it appears something is still missing as no 
messages I could attribute to mmc-spi appear. My suspicion would be that 
it doesn't like the monolithic kernel for some reason (the mmc-spi 
driver registers itself as a driver called "mmc_spi", not sure if the 
modalias handling will catch that; still investigating there).

> Then you call that function after registering the master, from
> mpc52xx_psc_spi_of_probe.

I've changed mpc52xx_psc_spi_do_probe to have an additional argument for 
the OF device node of the SPI master; ARCH=ppc can call this with NULL 
as long as it still exists.

    Simon
