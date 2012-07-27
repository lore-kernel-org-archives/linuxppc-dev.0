Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC74C2C038E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:16:02 +1000 (EST)
From: <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <vinod.koul@intel.com>,
 <dan.j.williams@intel.com>, <herbert@gondor.hengli.com.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 0/7] Raid: enable talitos xor offload for improving
 performance
Date: Fri, 27 Jul 2012 17:15:31 +0800
Message-ID: <1343380531-11953-1-git-send-email-qiang.liu@freescale.com>
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

Hi,

The following 7 patches enabling fsl-dma and talitos offload raid
operations for improving raid performance and balancing CPU load.

Write performance will be improved by 25-30% tested by iozone.
Write performance is improved about 2% after using spin_lock_bh replace
spin_lock_irqsave.
CPU load will be reduced by 8%.

Changes in V4:
	- fix an error in talitos when dest addr is same with src addr, dest
	should be freed only one time if src is same with dest addr;
	- correct coding style in fsl-dma according to Ira's comments;
	- fix a race condition in fsl-dma fsl_tx_status(), remove the interface
	which is used to free descriptors in queue ld_completed, this interface
	has been included in fsldma_cleanup_descriptor(), in v3, there is one
	place missed spin_lock protect;
	- split the original patch 3/4 up to 2 patches 3/7 and 4/7 according to
	Li Yang's comments.
	- fix a warning of unitialized cookie;
	- add memory copy self test in fsl-dma;
	- add more detail description about use spin_lock_bh() to instead of
	spin_lock_irqsave() according to Timur's comments;

Changes in v3:
	- change release process of fsl-dma descriptor for resolve the
	potential race condition
	- add test result when use spin_lock_bh replace spin_lock_irqsave
	- modify the benchmark results according to the latest patch

Changes in v2:
	- rebase onto cryptodev tree
	- split the patch 3/4 up to 3 independent patches
	- remove the patch 4/4, the fix is not for cryptodev tree


Qiang Liu (4):
      Talitos: Support for async_tx XOR offload
      fsl-dma: remove attribute DMA_INTERRUPT of dmaengine
      fsl-dma: change release process of dma descriptor for supporting async_tx
      fsl-dma: use spin_lock_bh to instead of spin_lock_irqsave

Qiang Liu (7):
      Talitos: Support for async_tx XOR offload
      fsl-dma: remove attribute DMA_INTERRUPT of dmaengine
      fsl-dma: change release process of dma descriptor for supporting async_tx
      fsl-dma: move the function ahead of its invoke function
      fsl-dma: use spin_lock_bh to instead of spin_lock_irqsave
      fsl-dma: fix a warning of unitialized cookie
      fsl-dma: add memcpy self test interface

 drivers/crypto/Kconfig   |    9 +
 drivers/crypto/talitos.c |  413 ++++++++++++++++++++++++++++++++++
 drivers/crypto/talitos.h |   53 +++++
 drivers/dma/fsldma.c     |  550 +++++++++++++++++++++++++++++-----------------
 drivers/dma/fsldma.h     |    1 +
 5 files changed, 822 insertions(+), 204 deletions(-)
