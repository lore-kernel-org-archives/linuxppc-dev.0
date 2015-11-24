Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0102.outbound.protection.outlook.com [157.56.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4F491A1D66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:15:55 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <edubezval@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <scottwood@freescale.com>,
 <hongtao.jia@freescale.com>
Subject: [PATCH V4 0/5] TMU support for QorIQ platform
Date: Tue, 24 Nov 2015 14:52:43 +0800
Message-ID: <1448347968-37766-1-git-send-email-hongtao.jia@freescale.com>
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

This patchset add thermal management support to QorIQ platform including:
- T1040/T1042.
- T1023/T1024.
- LS1021A.

The thermal driver is updated to V4 based on Linux v4.4-rc2.

CPU Cooling device registration is done by another patch which will send
to both thermal and cpufreq maintainers.

The patchset is reviewed by Scott Wood <scottwood@freescale.com>.

Jia Hongtao (5):
  dt-bindings: Add QorIQ TMU thermal bindings
  thermal: qoriq: Add thermal management support
  powerpc/mpc85xx: Add TMU device tree support for T1040/T1042
  powerpc/mpc85xx: Add TMU device tree support for T1023/T1024
  arm/ls1021a: Add TMU device tree support for LS1021A

 .../devicetree/bindings/thermal/qoriq-thermal.txt  |  63 +++++
 arch/arm/boot/dts/ls1021a.dtsi                     |  84 ++++++-
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  86 +++++++
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/t1040d4rdb.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/t1040qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  94 ++++++++
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/t1042qds.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts          |   2 +-
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   4 +
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qoriq_thermal.c                    | 262 +++++++++++++++++++++
 21 files changed, 616 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
 create mode 100644 drivers/thermal/qoriq_thermal.c

-- 
2.1.0.27.g96db324
