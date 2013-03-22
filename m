Return-Path: <florian@openwrt.org>
From: Florian Fainelli <florian@openwrt.org>
To: davem@davemloft.net
Subject: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
Date: Fri, 22 Mar 2013 14:39:24 +0100
Message-Id: <1363959568-16976-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1363284515-9865-1-git-send-email-florian@openwrt.org>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
instead of rolling its own implementation. As a result, all users of this
mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
The mvmdio driver is also updated to support an interrupt line which reports
SMI error/completion, and to allow traditionnal platform device registration
instead of just device tree.

David, I think it makes sense for you to merge all of this, since we do
not want the architecture files to be desynchronized from the mv643xx_eth to
avoid runtime breakage. The potential for merge conflicts should be very small.

Florian Fainelli (4):
  net: mvmdio: allow platform device style registration
  net: mvmdio: rename base register cookie from smireg to regs
  net: mvmdio: enhance driver to support SMI error/done interrupts
  mv643xx_eth: convert to use the Marvell Orion MDIO driver

 .../devicetree/bindings/net/marvell-orion-mdio.txt |    3 +
 arch/arm/plat-orion/common.c                       |   54 +++---
 arch/powerpc/platforms/chrp/pegasos_eth.c          |   20 ++
 arch/powerpc/sysdev/mv64x60_dev.c                  |   16 +-
 drivers/net/ethernet/marvell/Kconfig               |    5 +-
 drivers/net/ethernet/marvell/Makefile              |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  195 ++------------------
 drivers/net/ethernet/marvell/mvmdio.c              |  130 ++++++++++---
 include/linux/mv643xx_eth.h                        |    1 -
 9 files changed, 187 insertions(+), 239 deletions(-)

-- 
1.7.10.4
