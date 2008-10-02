Return-Path: <buytenh@wantstofly.org>
Received: from xi.wantstofly.org (xi.wantstofly.org [83.160.184.112])
	by ozlabs.org (Postfix) with ESMTP id 915A1DDFFC
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 20:15:11 +1000 (EST)
Date: Thu, 2 Oct 2008 12:15:08 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Vitaly Bordug <vbordug@ru.mvista.com>,
	Michael Chan <mchan@broadcom.com>, Olof Johansson <olof@lixom.net>,
	Kumar Gala <galak@kernel.crashing.org>, Eugene Konev <ejka@imfi.kspu.ru>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Kim Phillips <kim.phillips@freescale.com>,
	Laurent Pinchart <laurentp@cse-semaphore.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Li Yang <leoli@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Bryan Wu <cooloney@kernel.org>
Subject: [PATCH,CFT] dynamic struct mii_bus allocation
Message-ID: <20081002101508.GA31074@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi *,

You're listed as maintainer of one of the network drivers in the tree
that use phylib.  Available at the URL below is a change to the phylib
API (dynamic allocation of struct mii_bus, which is needed for hooking
up mdio buses into the device tree) that needs corresponding mdio bus
driver changes.  I've patched all mdio bus drivers I could find, and
tried not to break anything, but it's possible I might have
inadvertently broken something, so I'd like you to test these changes
and let me know if they work for you or not:

	git://git.marvell.com/phylib.git master

As a side-effect of the last patch, you should end up with a list of
mdio buses in your system in /sys/class/mdio_bus.


thanks,
Lennert


The following changes since commit e69c4e0f1210450841e40716894ba6a877b31d52:
  Vlad Yasevich (1):
        sctp: correctly save sctp_adaptation from parameter.

are available in the git repository at:

  git://git.marvell.com/phylib.git master

Lennert Buytenhek (5):
      phylib: phy_mii_ioctl() fixes
      phylib: add mdiobus_{read,write}
      phylib: rename mii_bus::dev to mii_bus::parent
      phylib: move to dynamic allocation of struct mii_bus
      phylib: give mdio buses a device tree presence

 arch/powerpc/platforms/82xx/ep8248e.c     |    2 +-
 arch/powerpc/platforms/pasemi/gpio_mdio.c |    6 +-
 drivers/net/au1000_eth.c                  |   43 ++++++---
 drivers/net/au1000_eth.h                  |    2 +-
 drivers/net/bfin_mac.c                    |   31 ++++---
 drivers/net/bfin_mac.h                    |    2 +-
 drivers/net/cpmac.c                       |   51 ++++++----
 drivers/net/fec_mpc52xx_phy.c             |    8 +-
 drivers/net/fs_enet/mii-bitbang.c         |    9 +-
 drivers/net/fs_enet/mii-fec.c             |    8 +-
 drivers/net/gianfar_mii.c                 |    9 +-
 drivers/net/macb.c                        |   49 ++++++----
 drivers/net/macb.h                        |    2 +-
 drivers/net/mv643xx_eth.c                 |   32 ++++---
 drivers/net/phy/fixed.c                   |   29 ++++--
 drivers/net/phy/mdio-bitbang.c            |    4 +-
 drivers/net/phy/mdio-ofgpio.c             |   11 +-
 drivers/net/phy/mdio_bus.c                |  144 ++++++++++++++++++++++++++++-
 drivers/net/phy/phy.c                     |   54 +----------
 drivers/net/sb1250-mac.c                  |   36 +++++---
 drivers/net/sh_eth.c                      |    4 +-
 drivers/net/tc35815.c                     |   45 ++++++----
 drivers/net/tg3.c                         |   66 +++++++-------
 drivers/net/tg3.h                         |    2 +-
 drivers/net/ucc_geth_mii.c                |    9 +-
 include/linux/phy.h                       |   54 ++++++++++--
 26 files changed, 456 insertions(+), 256 deletions(-)
