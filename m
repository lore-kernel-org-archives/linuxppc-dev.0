Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRkx0MKkzDqgY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:52 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 00/23] ata: sata_dwc_460ex: make it working again
Date: Thu, 21 Apr 2016 21:15:21 +0300
Message-Id: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last approach in the commit 8b3444852a2b ("sata_dwc_460ex: move to generic
DMA driver") to switch to generic DMA engine API wasn't tested on bare metal.
Besides that we expecting new board support coming with the same SATA IP but
with different DMA.

This series is targetting the following things:
- a few bug fixes to the original driver
- a part to fix the DMA engine usage and in particularly dw_dmac driver
- move driver to use generic PHY and "dmas" property which leads to update in DTS

The driver has been tested myself on Sam460ex and WD MyBookLive (apollo3g)
boards. In any case I ask Christian, Måns, and Julian to independently test and
provide Tested-by tag or error report.

Series depends on previously published but not yet fully applied series [1].

[1] http://www.spinics.net/lists/kernel/msg2239735.html

Andy Shevchenko (11):
  ata: sata_dwc_460ex: set dma_boundary to 0x1fff
  ata: sata_dwc_460ex: burst size must be in items not bytes
  ata: sata_dwc_460ex: DMA is always a flow controller
  ata: sata_dwc_460ex: select only core part of DMA driver
  ata: sata_dwc_460ex: don't call ata_sff_qc_issue() on DMA commands
  ata: sata_dwc_460ex: correct HOSTDEV{P}_FROM_*() macros
  ata: sata_dwc_460ex: supply physical address of FIFO to DMA
  ata: sata_dwc_460ex: switch to new dmaengine_terminate_* API
  ata: sata_dwc_460ex: use devm_ioremap
  ata: sata_dwc_460ex: make debug messages neat
  powerpc/4xx: Device tree update for the 460ex DWC SATA

Christian Lamparter (1):
  ata: sata_dwc_460ex: fix crash on offline links without an attached
    drive

Mans Rullgard (11):
  ata: sata_dwc_460ex: remove incorrect locking
  ata: sata_dwc_460ex: skip dma setup for non-dma commands
  ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
  ata: sata_dwc_460ex: add phy support
  ata: sata_dwc_460ex: get rid of global data
  ata: sata_dwc_460ex: remove empty libata callback
  ata: sata_dwc_460ex: get rid of some pointless casts
  ata: sata_dwc_460ex: get rid of incorrect cast
  ata: sata_dwc_460ex: add __iomem to register base pointer
  ata: sata_dwc_460ex: use readl/writel_relaxed()
  ata: sata_dwc_460ex: tidy up sata_dwc_clear_dmacr()

 arch/powerpc/boot/dts/canyonlands.dts |  15 +-
 drivers/ata/Kconfig                   |  12 +-
 drivers/ata/sata_dwc_460ex.c          | 554 +++++++++++++++++-----------------
 3 files changed, 307 insertions(+), 274 deletions(-)

-- 
2.8.0.rc3
