Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0075.outbound.protection.outlook.com [104.47.1.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XVWN2MchzF24K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 20:27:56 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com
Cc: hch@lst.de, gregkh@linuxfoundation.org, joro@8bytes.org,
 robh+dt@kernel.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 0/6 v3] Support for fsl-mc bus and its devices in SMMU
Date: Fri, 27 Apr 2018 15:57:00 +0530
Message-Id: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
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

This patch series is dependent on patset:
https://patchwork.kernel.org/patch/10317337/

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5)
  - Updates the fsl-mc device node with iommu/dma related changes (patch6)

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

Changes in v3:
  - move of_map_rid in drivers/of/address.c

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  21 +++++
 drivers/iommu/of_iommu.c                           |  26 +++++-
 drivers/of/address.c                               | 102 +++++++++++++++++++++
 drivers/of/irq.c                                   |   7 +-
 drivers/pci/of.c                                   | 101 --------------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of_address.h                         |  11 +++
 include/linux/of_pci.h                             |  10 --
 13 files changed, 234 insertions(+), 122 deletions(-)

-- 
1.9.1
