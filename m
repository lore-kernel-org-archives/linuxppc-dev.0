Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0087.hostedemail.com
 [216.40.44.87])
 by lists.ozlabs.org (Postfix) with ESMTP id E5B991A0367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 06:38:17 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 309FE2129D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 20:38:16 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next 00/26] treewide: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:29 -0700
Message-Id: <cover.1402863904.git.joe@perches.com>
Cc: linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, users@rt2x00.serialmonkey.com,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 ath10k@lists.infradead.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, wcn36xx@lists.infradead.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 e1000-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Joe Perches (26):
  powerpc: Use dma_zalloc_coherent
  sh: Use dma_zalloc_coherent
  ata: Use dma_zalloc_coherent
  block: Use dma_zalloc_coherent
  crypto: Use dma_zalloc_coherent
  dma: Use dma_zalloc_coherent
  gpu: Use dma_zalloc_coherent
  infiniband: Use dma_zalloc_coherent
  mmc: Use dma_zalloc_coherent
  broadcom: Use dma_zalloc_coherent
  hisilicon: Use dma_zalloc_coherent
  intel: Use dma_zalloc_coherent
  ath: Use dma_zalloc_coherent
  rt2x00: Use dma_zalloc_coherent
  bfa: Use dma_zalloc_coherent
  bnx2fc: Use dma_zalloc_coherent
  bnx2i: Use dma_zalloc_coherent
  dpt_i2o: Use dma_zalloc_coherent
  lpfc: Use dma_zalloc_coherent
  megaraid: Use dma_zalloc_coherent
  mvsas: Use dma_zalloc_coherent
  qla2xxx: Use dma_zalloc_coherent
  qla4xxx: Use dma_zalloc_coherent
  usb: Use dma_zalloc_coherent
  fbdev: Use dma_zalloc_coherent
  sound: Use dma_zalloc_coherent

 arch/powerpc/platforms/pasemi/dma_lib.c       |  8 ++--
 arch/powerpc/sysdev/fsl_rmu.c                 |  9 ++--
 arch/sh/mm/consistent.c                       |  4 +-
 drivers/ata/sata_fsl.c                        |  5 +--
 drivers/block/nvme-core.c                     |  5 +--
 drivers/crypto/amcc/crypto4xx_core.c          |  8 ++--
 drivers/crypto/ixp4xx_crypto.c                |  8 ++--
 drivers/dma/imx-sdma.c                        |  5 +--
 drivers/dma/mxs-dma.c                         |  8 ++--
 drivers/gpu/drm/drm_pci.c                     |  6 +--
 drivers/infiniband/hw/cxgb3/cxio_hal.c        |  7 ++--
 drivers/infiniband/hw/mthca/mthca_memfree.c   |  5 +--
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      | 20 ++++-----
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c   |  6 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  8 ++--
 drivers/mmc/host/msm_sdcc.c                   |  8 ++--
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  |  6 +--
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c |  5 +--
 drivers/net/ethernet/intel/ixgb/ixgb_main.c   |  6 +--
 drivers/net/wireless/ath/ath10k/pci.c         |  8 +---
 drivers/net/wireless/ath/ath10k/wmi.c         |  8 +---
 drivers/net/wireless/ath/wcn36xx/dxe.c        |  6 +--
 drivers/net/wireless/rt2x00/rt2x00mmio.c      |  8 ++--
 drivers/scsi/bfa/bfad_bsg.c                   |  6 +--
 drivers/scsi/bnx2fc/bnx2fc_hwi.c              | 59 ++++++++++++---------------
 drivers/scsi/bnx2fc/bnx2fc_tgt.c              | 51 ++++++++++-------------
 drivers/scsi/bnx2i/bnx2i_hwi.c                | 14 +++----
 drivers/scsi/dpt_i2o.c                        | 19 ++++-----
 drivers/scsi/lpfc/lpfc_bsg.c                  |  5 +--
 drivers/scsi/lpfc/lpfc_init.c                 | 22 ++++------
 drivers/scsi/lpfc/lpfc_mbox.c                 |  6 +--
 drivers/scsi/lpfc/lpfc_sli.c                  | 14 +++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c   |  9 ++--
 drivers/scsi/mvsas/mv_init.c                  | 26 +++++-------
 drivers/scsi/qla2xxx/qla_init.c               | 10 ++---
 drivers/scsi/qla4xxx/ql4_init.c               |  5 +--
 drivers/scsi/qla4xxx/ql4_mbx.c                | 21 ++++------
 drivers/scsi/qla4xxx/ql4_nx.c                 |  5 +--
 drivers/scsi/qla4xxx/ql4_os.c                 | 12 +++---
 drivers/usb/dwc2/hcd_ddma.c                   | 20 ++++-----
 drivers/usb/host/uhci-hcd.c                   |  7 ++--
 drivers/video/fbdev/da8xx-fb.c                |  9 ++--
 sound/aoa/soundbus/i2sbus/core.c              | 12 ++----
 sound/sparc/dbri.c                            |  6 +--
 44 files changed, 197 insertions(+), 308 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
