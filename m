Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A6B5FB6F1A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:08 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 0/8 v2] fsldma: cleanup driver and fix async_tx compatibility
Date: Wed,  6 Jan 2010 15:33:58 -0800
Message-Id: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
Cc: R58472@freescale.com, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Dipen.Dudhat@freescale.com,
	Maneesh.Gupta@freescale.com, herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series cleans up the Freescale DMAEngine driver, including
verifying the locking and making sure that all code paths are correct.
There were a few places that seemed suspicious, and they have been fixed.

I have written a quick memory->memory DMAEngine test driver, and the
performance is identical before and after my changes (<0.1% change). I
measured both setting up the DMA operation (via device_prep_dma_interrupt()
and device_prep_dma_memcpy()) and the actual DMA transfer itself.

As an added bonus, the interrupt load is measurably reduced. My test driver
transfers 32MB as 32x 1MB chunks + 1 interrupt descriptor, using the
functions noted above. Previous to this patch series, 31 interrupts were
generated. After this patch series, only a single interrupt is generated
for the whole transaction.

Some testing on 85xx/86xx hardware would be appreciated. Also, some testing
by the users attempting to use async_tx and talitos to handle RAID offload
would be great as well.

 Documentation/powerpc/dts-bindings/fsl/dma.txt |    8 +
 drivers/dma/fsldma.c                           | 1174 +++++++++++++-----------
 drivers/dma/fsldma.h                           |   35 +-
 3 files changed, 675 insertions(+), 542 deletions(-)

v1 -> v2:
- addresses comments from Scott Wood
  - prefer per-controller interrupt if available
  - rename "fchan" to "chan"
  - leave the documentation alone (mostly)

Thanks,
Ira
