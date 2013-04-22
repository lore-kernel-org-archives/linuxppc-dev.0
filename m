Return-Path: <robherring2@gmail.com>
From: Rob Herring <robherring2@gmail.com>
To: linux-kernel@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 0/5] of_platform_driver and OF_DEVICE removal
Date: Sun, 21 Apr 2013 21:13:13 -0500
Message-Id: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
Cc: Roland Dreier <roland@kernel.org>, Sean Hefty <sean.hefty@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-usb@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-rdma@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
 Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@linaro.org>, Paul Mackerras <paulus@samba.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <rob.herring@calxeda.com>

This series is a relatively straight-forward removal of the last remaining
user of of_platform_driver (ibmebus) and removal of CONFIG_OF_DEVICE which
is always enabled when CONFIG_OF is enabled.

Compile tested on powerpc and sparc.

Rob

Rob Herring (5):
  ibmebus: convert of_platform_driver to platform_driver
  driver core: move to_platform_driver to platform_device.h
  of: remove of_platform_driver
  usb: chipidea: depend on CONFIG_OF instead of CONFIG_OF_DEVICE
  of: remove CONFIG_OF_DEVICE

 arch/powerpc/include/asm/ibmebus.h        |    4 ++--
 arch/powerpc/kernel/ibmebus.c             |   22 ++++++++++-----------
 drivers/base/platform.c                   |    3 ---
 drivers/infiniband/hw/ehca/ehca_main.c    |    5 ++---
 drivers/net/ethernet/ibm/ehea/ehea_main.c |    8 +++-----
 drivers/of/Kconfig                        |    3 ---
 drivers/of/Makefile                       |    3 +--
 drivers/usb/chipidea/Makefile             |    2 +-
 include/linux/of_device.h                 |    6 +++---
 include/linux/of_platform.h               |   30 +----------------------------
 include/linux/platform_device.h           |    3 +++
 11 files changed, 26 insertions(+), 63 deletions(-)

-- 
1.7.10.4
