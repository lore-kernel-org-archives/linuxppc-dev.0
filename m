Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C6AC5B70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 08:58:00 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFCv3 0/4] dma: add support for scatterlist to scatterlist copy
Date: Mon, 27 Sep 2010 15:57:53 -0700
Message-Id: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
Cc: Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for scatterlist to scatterlist copies to the
generic DMAEngine API. Both the fsldma and ste_dma40 drivers currently
implement a similar API using different, non-generic methods. This series
converts both of them to the new, standardized API.

By doing this as part of the core DMAEngine API, the individual drivers
have control over how to chain their descriptors together. This is
different to the previous implementation, which called
device_prep_dma_memcpy() multiple times.

Neither implementation has been tested on real hardware. I attempted a
conversion of the ste_dma40 driver which should do the right thing, but the
authors should check and make sure.

Ira W. Snyder (4):
  dma: add support for scatterlist to scatterlist copy
  fsldma: implement support for scatterlist to scatterlist copy
  fsldma: remove DMA_SLAVE support
  ste_dma40: implement support for scatterlist to scatterlist copy

 arch/powerpc/include/asm/fsldma.h |  115 ++------------
 drivers/dma/dmaengine.c           |    2 +
 drivers/dma/fsldma.c              |  321 +++++++++++++++++--------------------
 drivers/dma/ste_dma40.c           |   17 ++
 include/linux/dmaengine.h         |    6 +
 5 files changed, 185 insertions(+), 276 deletions(-)
