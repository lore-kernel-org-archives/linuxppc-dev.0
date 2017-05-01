Return-Path: <roy.pledge@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0044.outbound.protection.outlook.com [104.47.41.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGyJK1ZhlzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 07:30:24 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, <roy.pledge@nxp.com>
Subject: [PATCH v3 00/11] soc/fsl/qbman: Enable QBMan on ARM Platforms
Date: Mon, 1 May 2017 17:30:02 -0400
Message-ID: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
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
QBMan functionality.

Changes since v2:
Fixed some misspellings
Added 'no-map' constraint to device tree bindings
Described ordering contraint on regions in the device tree
Removed confusing comment regarding non-shareable mappings
Added warning if old reserved-memory technique is used on ARM

Changes since v1:
Reworked private memory allocations to use shared-dma-pool on ARM platforms

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
  soc/fsl/qbman: Rework ioremap() calls for ARM/PPC

Valentin Rothberg (1):
  soc/fsl/qbman: Fix ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 ++--
 drivers/soc/fsl/qbman/Kconfig                      |   2 +-
 drivers/soc/fsl/qbman/bman.c                       |  24 +++-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  35 +++++-
 drivers/soc/fsl/qbman/bman_portal.c                |  12 +-
 drivers/soc/fsl/qbman/bman_priv.h                  |   3 +
 drivers/soc/fsl/qbman/dpaa_sys.h                   |   8 +-
 drivers/soc/fsl/qbman/qman.c                       |  46 ++++++-
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 140 ++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c                |  12 +-
 drivers/soc/fsl/qbman/qman_priv.h                  |   5 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 13 files changed, 262 insertions(+), 65 deletions(-)

--
2.7.4
