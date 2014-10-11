Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id EA28D1A05B0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:48 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 0/6] dmaengine: remove FSLDMA_EXTERNAL_START
Date: Sat, 11 Oct 2014 21:16:42 +0530
Message-Id: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSLDMA_EXTERNAL_START is one of the custom methods in device_control. Since
we are planning to deprecate device_control, we should move this to an API.

This serries adds the fsl_dma_external_start() API for users and also
converts the users.

I would like this to be merged thru dmanegine tree due to new dependency.

Vinod Koul (6):
  dmaengine: add dmaengine_prep_dma_sg() helper
  dmaengine: freescale: add and export fsl_dma_external_start()
  carma-fpga: use dmaengine_xxx() API
  carma-fpga: move to fsl_dma_external_start()
  dmaengine: freescale: remove FSLDMA_EXTERNAL_START control method
  dmaengine: remove FSLDMA_EXTERNAL_START

 drivers/dma/fsldma.c                    |   25 +++++++++++++++----------
 drivers/misc/carma/carma-fpga-program.c |   12 ++++++------
 include/linux/dmaengine.h               |   13 ++++++++++---
 include/linux/fsldma.h                  |   13 +++++++++++++
 4 files changed, 44 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/fsldma.h
