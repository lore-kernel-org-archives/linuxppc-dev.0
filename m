Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 733CDB6FBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 05:21:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Tue, 7 Jun 2011 21:16:21 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106070908.16301.arnd@arndb.de> <4DEE567E.7080102@tilera.com>
In-Reply-To: <4DEE567E.7080102@tilera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106072116.21469.arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, greg@kroah.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 07 June 2011 18:49:02 Chris Metcalf wrote:
> > You can probably argue that the tile drivers do fit in here as long as
> > they are specific to the hypervisor and not to some SOC specific hardware.
> 
> Can you clarify that?   I think you're contrasting something like an ARM
> core that was licensed and put in a SoC by some random vendor, and you
> could have an endless stream of drivers for that case.  The Tilera core
> isn't being licensed; it's sold more like an Intel chip with a fixed set of
> interfaces available only from Tilera.  The particular interface in
> question here is SPI, and the core itself knows how to boot the chip over
> SPI by finding an SPI ROM and reading the boot stream out of it directly
> after power-up.
> 
> So does that match with your model of "drivers/platform/tile"?  Maybe we
> have a winner!  :-)

I'm not really against drivers/platform/tile for this, the only potential
problem that I see with this is that having more stuff in drivers/platform
might lead to having even more other stuff in there that should really
go into another place.

Obviously, if the device is a raw SPI host, the driver should actually go
into drivers/spi/spi_tile.c rather than drivers/platform/tile/spi.c.

For the spi flash driver that goes through the hypervisor abstraction,
I think drivers/virt/tile would be better than driver/platform/tile,
but we should really have a new "abstract flash character driver" subsystem
for that.

	Arnd
