Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 954FA1A0064
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 14:30:20 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar
 <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
CC: <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 "Tang Yuantian" <Yuantian.Tang@freescale.com>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v3 0/5] clk: qoriq: Move chip-specific knowledge into driver
Date: Sat, 19 Sep 2015 23:29:52 -0500
Message-ID: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing device tree bindings are error-prone and inflexible. 
Correct the mistake by moving the knowledge into the driver, which has
more flexibility in describing the quirks of each chip.  This leaves the
device tree to its proper role of identifying a programming interface
rather than describing its individual registers.

For more detail, see the commit message of patch 2.

As there are both ARM and PPC patches that depend on this patchset, I'm
requesting ACKs from clk and cpufreq in order to put this into a topic
branch that both ARM and PPC can pull.

Scott Wood (5):
  powerpc/fsl: Move fsl_guts.h out of arch/powerpc
  clk: qoriq: Move chip-specific knowledge into driver
  clk: qoriq: Add ls2080a support.
  clk: Add consumer APIs for discovering possible parent clocks
  cpufreq: qoriq: Don't look at clock implementation details

 .../devicetree/bindings/clock/qoriq-clock.txt      |   61 +-
 arch/powerpc/include/asm/fsl_guts.h                |  192 ---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |    2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-qoriq.c                            | 1316 ++++++++++++++++----
 drivers/clk/clk.c                                  |   19 +
 drivers/cpufreq/qoriq-cpufreq.c                    |  137 +-
 drivers/iommu/fsl_pamu.c                           |    2 +-
 include/linux/clk.h                                |   31 +
 include/linux/fsl/guts.h                           |  192 +++
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 19 files changed, 1441 insertions(+), 531 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/fsl_guts.h
 create mode 100644 include/linux/fsl/guts.h

-- 
2.1.4
