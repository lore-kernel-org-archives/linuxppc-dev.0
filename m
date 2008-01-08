Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Generic MMC-over-SPI binding?
Date: Tue, 8 Jan 2008 18:27:13 +0100
References: <47838708.5050008@hogyros.de>
In-Reply-To: <47838708.5050008@hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801081827.13940.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, Simon Richter wrote:
> in an embedded system similar to the lite5200 board, there is an MMC 
> card socket connected to one of the PSCs. Ideally, I'd like to express 
> this fact via the device tree and have the kernel bind the mmc-spi 
> driver to the SPI interface, but I cannot find any place where to insert 
> this code that I feel comfortable with.
> ...
> Any ideas?
> 

One way you could do it would be to have an spi_board_info in the
way that mpc832x_spi_init does it, but that would not make use of the
device tree.

What would probably be a better way is to call spi_new_device()
from the mpc52xx_psc_spi driver, with an spi_board_info you generate
on the fly for each child of the spi controller.

The important part where this connects to the mmc-spi driver is that
you need to set spi_board_info->modalias to "mmc-spi", if the
device node can be identified as an mmc card.
We'd have to define a list of valid identifications of SPI devices
in the device tree, and teach the SPI drivers how they relate to
linux device drivers like mmc-spi.

Since that part of the code would be used by all device tree based
SPI master drivers, it should be in a separate module, which can
consist of a single exported function, like (paraphrased):

void spi_of_scan_master(struct spi_master *master)
{
	struct device_node *child;
	of_dev_for_each_child(master->dev->node, child) {
		struct spi_board_info *info;
		info = kzalloc(sizeof (*info), GFP_KERNEL);
		if (of_device_is_compatible(child, "spi,mmc"))
			strcpy(info->modalias, "mmc-spi");
		else if (of_device_is_compatible(child, "spi,foo"))
			strcpy(info->modalias, "foo");
		else
			strcpy(info->modalias, "");

		info->irq = irq_of_parse_and_map(child);
		
		spi_new_device(master, child);
	}
}

Then you call that function after registering the master, from
mpc52xx_psc_spi_of_probe.

	Arnd <><
