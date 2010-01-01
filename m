Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E103CB6EE9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 17:10:47 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: fsldma: cleanup driver and fix async_tx compatibility
Date: Thu, 31 Dec 2009 22:10:38 -0800
Message-Id: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	Maneesh.Gupta@freescale.com, R58472@freescale.com
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

 Documentation/powerpc/dts-bindings/fsl/dma.txt |   17 +-
 drivers/dma/fsldma.c                           | 1036 ++++++++++++------------
 drivers/dma/fsldma.h                           |   35 +-
 3 files changed, 556 insertions(+), 532 deletions(-)

Thanks,
Ira
