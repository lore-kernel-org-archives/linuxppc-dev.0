Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B52EFDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:09:38 +1100 (EST)
Date: Fri, 5 Dec 2008 23:09:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 0/7] OpenFirmware support for the spi_mpc83xx driver
Message-ID: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

The patch series are used to support SPI via the OF SPI subsystem
(driver/of/of_spi.c). Now the driver is able to manage its own
chip selects, and doesn't need any auxiliary support from the
board files or fsl_soc constructors.

The series also contains PowerPC portions of the MMC SPI support.

Since the series touches spi and powerpc trees, I think it would
be most convenient to pass it via one of these trees. The patches
doesn't touch any SPI functionality, only some probe routines, so
I believe powerpc.git is the best candidate...

The other reason for powerpc tree is that the patches depends on
other patches as found in paulus/powerpc.git + of_gpio_count()
as found here:
http://ozlabs.org/pipermail/linuxppc-dev/2008-December/065917.html

David, if you're OK with the patches, may I ask you to sign off on
the ones that touch drivers/spi so that we could pass it via Kumar's
powerpc.git?

The queue:

[1/7] powerpc: Implement get_brgfreq() and get_baudrate() stubs
[2/7] spi_mpc83xx: Fix sparse warnings
[3/7] spi_mpc83xx: Rework chip selects handling
[4/7] spi_mpc83xx: Add OF platform driver bindings
[5/7] powerpc/fsl_soc: Isolate legacy fsl_spi support to mpc832x_rdb boards
[6/7] powerpc: Add mmc-spi-slot bindings
[7/7] powerpc/83xx: Add mmc-spi support via the device tree for MPC8323E-RDB

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
