Return-Path: <B09055@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F69DB6F1B
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 16:47:27 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0B5l8Dm028283
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jan 2010 22:47:19 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0B5qHNZ024101
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jan 2010 23:52:18 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: fsldma: cleanup driver and fix async_tx compatibility
Date: Mon, 11 Jan 2010 11:17:04 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A6076CEE@zin33exm23.fsl.freescale.net>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu> 
From: "Dudhat Dipen-B09055" <B09055@freescale.com>
To: "Dudhat Dipen-B09055" <B09055@freescale.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>, <dan.j.williams@intel.com>
Cc: herbert@gondor.apana.org.au, Suresh Vishnu-B05022 <B05022@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>, linuxppc-dev@ozlabs.org,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Li Yang-R58472 <R58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ira,

I have tested your patches with async DMA memcpy support. Though I
haven't captured the improvement figures.
It works fine for RAID5 memcpy offload as interrupts are coming for
separate DMA channels while I have ran IOZONE onto RAID partition.

Regards,
 Dipen
=20

-----Original Message-----
From: Dudhat Dipen-B09055=20
Sent: Tuesday, January 05, 2010 11:38 AM
To: 'Ira W. Snyder'; dan.j.williams@intel.com
Cc: galak@kernel.crashing.org; herbert@gondor.apana.org.au; Tabi
Timur-B04825; linuxppc-dev@ozlabs.org; Suresh Vishnu-B05022; Gupta
Maneesh-B18878; Li Yang-R58472
Subject: RE: fsldma: cleanup driver and fix async_tx compatibility


Hi Ira,

I will test it on 85xx hardware and let you know once done.

Thanks
Dipen
=20

-----Original Message-----
From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]
Sent: Friday, January 01, 2010 11:41 AM
To: dan.j.williams@intel.com
Cc: galak@kernel.crashing.org; herbert@gondor.apana.org.au; Tabi
Timur-B04825; linuxppc-dev@ozlabs.org; Suresh Vishnu-B05022; Dudhat
Dipen-B09055; Gupta Maneesh-B18878; Li Yang-R58472
Subject: fsldma: cleanup driver and fix async_tx compatibility

This patch series cleans up the Freescale DMAEngine driver, including
verifying the locking and making sure that all code paths are correct.
There were a few places that seemed suspicious, and they have been
fixed.

I have written a quick memory->memory DMAEngine test driver, and the
performance is identical before and after my changes (<0.1% change). I
measured both setting up the DMA operation (via
device_prep_dma_interrupt() and device_prep_dma_memcpy()) and the actual
DMA transfer itself.

As an added bonus, the interrupt load is measurably reduced. My test
driver transfers 32MB as 32x 1MB chunks + 1 interrupt descriptor, using
the functions noted above. Previous to this patch series, 31 interrupts
were generated. After this patch series, only a single interrupt is
generated for the whole transaction.

Some testing on 85xx/86xx hardware would be appreciated. Also, some
testing by the users attempting to use async_tx and talitos to handle
RAID offload would be great as well.

 Documentation/powerpc/dts-bindings/fsl/dma.txt |   17 +-
 drivers/dma/fsldma.c                           | 1036
++++++++++++------------
 drivers/dma/fsldma.h                           |   35 +-
 3 files changed, 556 insertions(+), 532 deletions(-)

Thanks,
Ira
