Return-Path: <shawn.guo@linaro.org>
From: Shawn Guo <shawn.guo@linaro.org>
To: linux-mmc@vger.kernel.org
Subject: [PATCH v4 0/4] Consolidate sdhci pltfm & OF drivers and get them self
	registered
Date: Fri, 27 May 2011 23:48:11 +0800
Message-Id: <1306511295-2433-1-git-send-email-shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes since v3:
 * Update Kconfig and Makefile to fix module build failure

Changes since v2:
 * Drop imx mpc esdhc consolidation
 * Fix checkpatch errors
 * Add sdhci-of-core.c copyright into sdhci-pltfm.c

Changes since v1:
 * Rebase on cjb's mmc-next tree
 * Introduce helper function pair sdhci_pltfm_register and
   sdhci_pltfm_unregister
 * Eliminate variable 'scratch' in .remove hook to make the code
   look simple
 * Return ERR_PTR in sdhci_pltfm_init and use IS_ERR/PTR_ERR to check
   return value in .probe hooks
 * Correct MODULE_AUTHOR statement
 * Split esdhc conlidation patch to ease reviewing

Shawn Guo (4):
      mmc: sdhci: make sdhci-pltfm device drivers self registered
      mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
      mmc: sdhci: make sdhci-of device drivers self registered
      mmc: sdhci: merge two sdhci-pltfm.h into one

 drivers/mmc/host/Kconfig           |   42 ++----
 drivers/mmc/host/Makefile          |   23 ++--
 drivers/mmc/host/sdhci-cns3xxx.c   |   43 ++++++-
 drivers/mmc/host/sdhci-dove.c      |   42 ++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  114 +++++++++++-----
 drivers/mmc/host/sdhci-of-core.c   |  250 ---------------------------------
 drivers/mmc/host/sdhci-of-esdhc.c  |   85 +++++++++---
 drivers/mmc/host/sdhci-of-hlwd.c   |   66 ++++++++--
 drivers/mmc/host/sdhci-of.h        |   42 ------
 drivers/mmc/host/sdhci-pltfm.c     |  266 ++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-pltfm.h     |   39 +++++-
 drivers/mmc/host/sdhci-tegra.c     |  116 +++++++++++-----
 include/linux/mmc/sdhci-pltfm.h    |   35 -----
 13 files changed, 574 insertions(+), 589 deletions(-)
