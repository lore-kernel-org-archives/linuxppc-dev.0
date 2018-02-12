Return-Path: <boris.brezillon@bootlin.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgJ756hwCzF0qB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 08:03:38 +1100 (AEDT)
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org
Cc: Joern Engel <joern@lazybastard.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Edward Cree <ecree@solarflare.com>, Bert Kenward <bkenward@solarflare.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/5] mtd: Simplify erase handling
Date: Mon, 12 Feb 2018 22:03:06 +0100
Message-Id: <20180212210311.23244-1-boris.brezillon@bootlin.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This series aims at simplifying erase handling both in MTD drivers and
MTD users code.

Historically, the erase operation has been designed to be asynchronous,
which, in theory, is a good thing since erasing a block usually takes
longer that reading/writing to a flash. In practice, all drivers are
implementing ->_erase() in a synchronous manner. Moreover, both drivers
and users are inconsistently updating/checking the erase_info fields.

In order to simplify things, let's assume ->_erase() is and will always
be synchronous. This also make error code checking more consistent and
allows us to get rid of a few hundred lines of code.

Regards,

Boris

Boris Brezillon (5):
  mtd: Initialize ->fail_addr early in mtd_erase()
  mtd: Get rid of unused fields in struct erase_info
  mtd: Stop assuming mtd_erase() is asynchronous
  mtd: Unconditionally update ->fail_addr and ->addr in part_erase()
  mtd: Stop updating erase_info->state and calling mtd_erase_callback()

 drivers/mtd/chips/cfi_cmdset_0001.c      | 16 +-----
 drivers/mtd/chips/cfi_cmdset_0002.c      | 26 ++-------
 drivers/mtd/chips/cfi_cmdset_0020.c      |  3 --
 drivers/mtd/chips/map_ram.c              |  2 -
 drivers/mtd/devices/bcm47xxsflash.c      | 12 +----
 drivers/mtd/devices/block2mtd.c          |  7 +--
 drivers/mtd/devices/docg3.c              | 16 +-----
 drivers/mtd/devices/lart.c               |  4 --
 drivers/mtd/devices/mtd_dataflash.c      |  4 --
 drivers/mtd/devices/mtdram.c             |  2 -
 drivers/mtd/devices/phram.c              |  2 -
 drivers/mtd/devices/pmc551.c             |  2 -
 drivers/mtd/devices/powernv_flash.c      | 11 +---
 drivers/mtd/devices/slram.c              |  2 -
 drivers/mtd/devices/spear_smi.c          |  3 --
 drivers/mtd/devices/sst25l.c             |  3 --
 drivers/mtd/devices/st_spi_fsm.c         |  4 --
 drivers/mtd/ftl.c                        | 52 +++---------------
 drivers/mtd/inftlmount.c                 |  8 ++-
 drivers/mtd/lpddr/lpddr2_nvm.c           | 10 +---
 drivers/mtd/lpddr/lpddr_cmds.c           |  2 -
 drivers/mtd/mtdblock.c                   | 21 --------
 drivers/mtd/mtdchar.c                    | 34 +-----------
 drivers/mtd/mtdconcat.c                  | 48 +----------------
 drivers/mtd/mtdcore.c                    | 17 +++---
 drivers/mtd/mtdoops.c                    | 20 -------
 drivers/mtd/mtdpart.c                    | 23 ++------
 drivers/mtd/mtdswap.c                    | 34 ------------
 drivers/mtd/nand/nand_base.c             | 16 ++----
 drivers/mtd/nand/nand_bbt.c              |  1 -
 drivers/mtd/nftlmount.c                  |  5 +-
 drivers/mtd/onenand/onenand_base.c       | 17 ------
 drivers/mtd/rfd_ftl.c                    | 93 ++++++++++----------------------
 drivers/mtd/sm_ftl.c                     | 19 -------
 drivers/mtd/sm_ftl.h                     |  4 --
 drivers/mtd/spi-nor/spi-nor.c            |  3 --
 drivers/mtd/tests/mtd_test.c             |  5 --
 drivers/mtd/tests/speedtest.c            |  7 ---
 drivers/mtd/ubi/gluebi.c                 |  3 --
 drivers/mtd/ubi/io.c                     | 36 -------------
 drivers/net/ethernet/sfc/falcon/mtd.c    | 11 +---
 drivers/net/ethernet/sfc/mtd.c           | 11 +---
 drivers/staging/goldfish/goldfish_nand.c |  3 --
 fs/jffs2/erase.c                         | 37 ++-----------
 include/linux/mtd/mtd.h                  | 19 +------
 45 files changed, 79 insertions(+), 599 deletions(-)

-- 
2.14.1
