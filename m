Return-Path: <hongbo.zhang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C553140090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:20:31 +1000 (EST)
Message-ID: <5346462B.1080902@freescale.com>
Date: Thu, 10 Apr 2014 15:20:11 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v3 0/8] DMA: Freescale: driver cleanups and enhancements
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
 <1397113805-24171-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1397113805-24171-2-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, leo.li@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, forgot the cover letter, plus it here.


From: Hongbo Zhang <hongbo.zhang@freescale.com>
Date: Thu, 10 Apr 2014 15:16:31 +0800
Subject: [PATCH v3 0/8] DMA: Freescale: driver cleanups and enhancements

Hi Vinod Koul,
Please have a look at the v3 patch set.

v2 -> v3 change:
Only add "chan->pm_state = RUNNING" for patch[8/8].

v1 -> v2 change:
The only one change is introducing a new patch[1/7] to remove the 
unnecessary
macro FSL_DMA_LD_DEBUG, thus the total patches number is 8 now (was 7)

Hongbo Zhang (8):
   DMA: Freescale: remove the unnecessary FSL_DMA_LD_DEBUG
   DMA: Freescale: unify register access methods
   DMA: Freescale: remove attribute DMA_INTERRUPT of dmaengine
   DMA: Freescale: add fsl_dma_free_descriptor() to reduce code
     duplication
   DMA: Freescale: move functions to avoid forward declarations
   DMA: Freescale: change descriptor release process for supporting
     async_tx
   DMA: Freescale: use spin_lock_bh instead of spin_lock_irqsave
   DMA: Freescale: add suspend resume functions for DMA driver

  drivers/dma/fsldma.c |  591 
++++++++++++++++++++++++++++++++------------------
  drivers/dma/fsldma.h |   33 ++-
  2 files changed, 409 insertions(+), 215 deletions(-)
