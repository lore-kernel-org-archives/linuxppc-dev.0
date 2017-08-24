Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0062.outbound.protection.outlook.com [104.47.36.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdbhr4PG0zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 06:38:03 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Roy Pledge
 <roy.pledge@nxp.com>
Subject: [v4 00/11] soc/fsl/qbman: Enable QBMan on ARM Platforms
Date: Thu, 24 Aug 2017 16:37:44 -0400
Message-ID: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

This patch series enables DPAA1 QBMan devices for ARM and
ARM64 architectures. This allows the LS1043A and LS1046A to use
QBMan functionality which allows access to ethernet and cyptographic
devices for example.

Changes since v3:
- Use memremap() instead of ioremap() for non iomem QBMan portal regions
- Ensured the __iomem attribute is respected when accessing iomem mapped regions
- Removed calls to flush/invalidate/prefetch for ARM/ARM64 since mapping is done as write combine

Changes since v2:
- Fixed some misspellings
- Added 'no-map' constraint to device tree bindings
- Described ordering contraint on regions in the device tree
- Removed confusing comment regarding non-shareable mappings
- Added warning if old reserved-memory technique is used on ARM

Changes since v1:
- Reworked private memory allocations to use shared-dma-pool on ARM platforms


Claudiu Manoil (2):
  soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
  soc/fsl/qbman: Add missing headers on ARM

Madalin Bucur (4):
  soc/fsl/qbman: Drop set/clear_bits usage
  soc/fsl/qbman: add QMAN_REV32
  soc/fsl/qbman: different register offsets on ARM
  fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM

Roy Pledge (4):
  soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
  soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
  dt-bindings: soc/fsl: Update reserved memory binding for QBMan
  soc/fsl/qbman: Rework portal mapping calls for ARM/PPC

Valentin Rothberg (1):
  soc/fsl/qbman: Fix ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 ++--
 drivers/soc/fsl/qbman/Kconfig                      |   2 +-
 drivers/soc/fsl/qbman/bman.c                       |  30 ++++-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  35 +++++-
 drivers/soc/fsl/qbman/bman_portal.c                |  36 ++++--
 drivers/soc/fsl/qbman/bman_priv.h                  |  11 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |  14 +--
 drivers/soc/fsl/qbman/qman.c                       |  52 ++++++--
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 140 ++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c                |  36 ++++--
 drivers/soc/fsl/qbman/qman_priv.h                  |  13 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 13 files changed, 305 insertions(+), 104 deletions(-)

--
2.7.4
