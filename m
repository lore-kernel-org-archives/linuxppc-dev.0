Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0064.outbound.protection.outlook.com [104.47.37.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwyYV4rw5zDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:39:56 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Roy Pledge
 <roy.pledge@nxp.com>
Subject: [v5 00/12] soc/fsl/qbman: Enable QBMan on ARM Platforms
Date: Mon, 18 Sep 2017 16:39:35 -0400
Message-ID: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
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

Changes since v4:
- Introduce a common function for QBMan private memory initialization
- Fix sparse warnings making sure that __iomem and __be32 are respected
- Control different memremap() attributes using a #define

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
  soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM

Roy Pledge (5):
  soc/fsl/qbman: Add common routine for QBMan private allocations
  soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
  soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
  dt-bindings: soc/fsl: Update reserved memory binding for QBMan
  soc/fsl/qbman: Rework portal mapping calls for ARM/PPC

Valentin Rothberg (1):
  soc/fsl/qbman: Fix ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +--
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++--
 drivers/soc/fsl/qbman/Kconfig                      |  2 +-
 drivers/soc/fsl/qbman/Makefile                     |  2 +-
 drivers/soc/fsl/qbman/bman.c                       | 42 ++++++++--
 drivers/soc/fsl/qbman/bman_ccsr.c                  | 15 ++++
 drivers/soc/fsl/qbman/bman_portal.c                | 23 +++---
 drivers/soc/fsl/qbman/bman_priv.h                  |  8 +-
 drivers/soc/fsl/qbman/dpaa_sys.c                   | 78 ++++++++++++++++++
 drivers/soc/fsl/qbman/dpaa_sys.h                   | 25 ++++--
 drivers/soc/fsl/qbman/qman.c                       | 77 +++++++++++++-----
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 95 +++++++++++++++-------
 drivers/soc/fsl/qbman/qman_portal.c                | 23 +++---
 drivers/soc/fsl/qbman/qman_priv.h                  | 11 +--
 drivers/soc/fsl/qbman/qman_test.h                  |  2 -
 15 files changed, 318 insertions(+), 123 deletions(-)
 create mode 100644 drivers/soc/fsl/qbman/dpaa_sys.c

--
2.7.4
