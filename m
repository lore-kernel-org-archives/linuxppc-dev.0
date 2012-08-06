Return-Path: <B32616@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18BC02C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 20:36:36 +1000 (EST)
From: <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <vinod.koul@intel.com>,
 <dan.j.williams@intel.com>, <herbert@gondor.hengli.com.au>, <arnd@arndb.de>,
 <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <dan.j.williams@gmail.com>
Subject: [PATCH v6 0/8] Raid: enable talitos xor offload for improving
 performance
Date: Mon, 6 Aug 2012 18:10:15 +0800
Message-ID: <1344247815-1104-1-git-send-email-qiang.liu@freescale.com>
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

Hi all,

The following 8 patches enabling fsl-dma and talitos offload raid
operations for improving raid performance and balancing CPU load.

These patches include talitos, fsl-dma and carma module (caram uses
some features of fsl-dma).

Write performance will be improved by 25-30% tested by iozone.
Write performance is improved about 2% after using spin_lock_bh replace
spin_lock_irqsave.
CPU load will be reduced by 8%.

Changes in v6:
	- swap the order of original patch 3/6 and 4/6;
	- merge Ira's patch to reduce the size of original patch;
	- merge Ira's patch of carma in 8/8;
	- update documents and descriptions according to Ira's advice;

Changes in v5:
	- add detail description in patch 3/6 about the process of completed
	descriptor, the process is in align with fsl-dma Reference Manual,
	illustrate the potential risk and how to reproduce it;
	- drop the patch 7/7 in v4 according to Timur's comments;

Changes in v4:
	- fix an error in talitos when dest addr is same with src addr, dest
	should be freed only one time if src is same with dest addr;
	- correct coding style in fsl-dma according to Ira's comments;
	- fix a race condition in fsl-dma fsl_tx_status(), remove the interface
	which is used to free descriptors in queue ld_completed, this interface
	has been included in fsldma_cleanup_descriptor(), in v3, there is one
	place missed spin_lock protect;
	- split the original patch 3/4 up to 2 patches 3/7 and 4/7 according to
	Li Yang's comments;
	- fix a warning of unitialized cookie;
	- add memory copy self test in fsl-dma;
	- add more detail description about use spin_lock_bh() to instead of
	spin_lock_irqsave() according to Timur's comments.

Changes in v3:
	- change release process of fsl-dma descriptor for resolve the
	potential race condition;
	- add test result when use spin_lock_bh replace spin_lock_irqsave;
	- modify the benchmark results according to the latest patch.

Changes in v2:
	- rebase onto cryptodev tree;
	- split the patch 3/4 up to 3 independent patches;
	- remove the patch 4/4, the fix is not for cryptodev tree;

Qiang Liu (8):
      Talitos: Support for async_tx XOR offload
      fsl-dma: remove attribute DMA_INTERRUPT of dmaengine
      fsl-dma: add fsl_dma_free_descriptor() to reduce code duplication
      fsl-dma: move functions to avoid forward declarations
      fsl-dma: change release process of dma descriptor for supporting async_tx
      fsl-dma: use spin_lock_bh to instead of spin_lock_irqsave
      fsl-dma: fix a warning of unitialized cookie
      carma: remove unnecessary DMA_INTERRUPT capability

 drivers/crypto/Kconfig                  |    9 +
 drivers/crypto/talitos.c                |  413 ++++++++++++++++++++++++++
 drivers/crypto/talitos.h                |   53 ++++
 drivers/dma/fsldma.c                    |  487 +++++++++++++++++--------------
 drivers/dma/fsldma.h                    |   17 +-
 drivers/misc/carma/carma-fpga-program.c |    1 -
 drivers/misc/carma/carma-fpga.c         |    2 +-
 7 files changed, 760 insertions(+), 222 deletions(-)
