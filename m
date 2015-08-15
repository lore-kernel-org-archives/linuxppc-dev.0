Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CFC61A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 16:42:02 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 0/5] clk: qoriq: Move chip-specific knowledge into driver
Date: Sat, 15 Aug 2015 01:41:17 -0500
Message-ID: <1439620882-20449-1-git-send-email-scottwood@freescale.com>
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
Correct the mistake by moving the knowledge into the driver, which
has more flexibility in describing the quirks of each chip.  This leaves
the device tree to its proper role of identifying a programming interface
rather than describing its individual registers.

For more detail, see the commit message of patch 3.

Scott Wood (5):
  cpufreq: qoriq: Don't look at clock implementation details
  powerpc/fsl: Move fsl_guts.h out of arch/powerpc
  clk: qoriq: Move chip-specific knowledge into driver
  cpufreq: qoriq: Remove frequency masking and minimum
  powerpc/fsl: Use new clockgen binding

 .../devicetree/bindings/clock/qoriq-clock.txt      |   61 +-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |    4 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   15 -
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   18 -
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   18 -
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   70 --
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   16 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |    4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   18 -
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |   50 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |   33 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   16 -
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |    4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   44 -
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |   22 -
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |    8 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   61 -
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |   24 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |    2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
 drivers/clk/clk-qoriq.c                            | 1260 ++++++++++++++++----
 drivers/cpufreq/qoriq-cpufreq.c                    |  139 +--
 drivers/iommu/fsl_pamu.c                           |    2 +-
 .../asm/fsl_guts.h => include/linux/fsl/guts.h     |    6 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 37 files changed, 1176 insertions(+), 777 deletions(-)
 rename arch/powerpc/include/asm/fsl_guts.h => include/linux/fsl/guts.h (98%)

-- 
2.1.4
