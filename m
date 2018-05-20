Return-Path: <nipun.gupta@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40072.outbound.protection.outlook.com [40.107.4.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pjwR6w3WzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:50:28 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
 robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 leoyang.li@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Date: Sun, 20 May 2018 19:19:44 +0530
Message-Id: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
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

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

The patch series is based on top of dma-mapping tree (for-next branch):
http://git.infradead.org/users/hch/dma-mapping.git

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
  - Updates the fsl-mc device node with iommu/dma related changes (patch 7)

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

Changes in v3:
  - move of_map_rid in drivers/of/address.c

Changes in v4:
  - move of_map_rid in drivers/of/base.c

Changes in v5:
  - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
  - add changelog text in patch 3/7 and patch 5/7
  - typo fix

Nipun Gupta (7):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: support dma configure for devices on fsl-mc bus
  bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  21 +++++
 drivers/iommu/of_iommu.c                           |  25 ++++-
 drivers/of/base.c                                  | 102 +++++++++++++++++++++
 drivers/of/irq.c                                   |   5 +-
 drivers/pci/of.c                                   | 101 --------------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of.h                                 |  11 +++
 include/linux/of_pci.h                             |  10 --
 13 files changed, 231 insertions(+), 122 deletions(-)

-- 
1.9.1
