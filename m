Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49B5572F.4010007@am.sony.com>
Date: Mon, 9 Mar 2009 10:51:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ps3/block: Replace mtd/ps3vram by block/ps3vram
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<1236209255.6696.75.camel@pasglop>
	<20090305065423.GK11787@kernel.dk>
	<alpine.LRH.2.00.0903061349010.16809@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0903061349010.16809@vixen.sonytel.be>
Content-Type: text/plain; charset="ISO-8859-15"
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org, Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>,
	David Woodhouse <dwmw2@infradead.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 03/06/2009 04:54 AM, Geert Uytterhoeven wrote:
> Convert the PS3 Video RAM Storage Driver from an MTD driver to a plain block
> device driver.
> 
> The ps3vram driver exposes unused video RAM on the PS3 as a block device
> suitable for storage or swap.  Fast data transfer is achieved using a local
> cache in system RAM and DMA transfers via the GPU.
> 
> The new driver is ca. 50% faster for reading, and ca. 10% for writing.
> 
>  arch/powerpc/platforms/ps3/Kconfig |    7 +
>  drivers/block/Makefile             |    1 +
>  drivers/block/ps3vram.c            |  865 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/devices/Kconfig        |    7 -
>  drivers/mtd/devices/Makefile       |    1 -
>  drivers/mtd/devices/ps3vram.c      |  768 --------------------------------
>  6 files changed, 873 insertions(+), 776 deletions(-)
>  create mode 100644 drivers/block/ps3vram.c
>  delete mode 100644 drivers/mtd/devices/ps3vram.c

Looks good, certainly an improvement.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
