Return-Path: <B09055@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0772AB7C7E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 18:50:11 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o127o8vA012658
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 00:50:08 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o127v9kK017139
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 01:57:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: fsldma: cleanup driver and fix async_tx compatibility
Date: Tue, 2 Feb 2010 13:20:05 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A6105CC5@zin33exm23.fsl.freescale.net>
In-Reply-To: <20100111162900.GA10110@ovro.caltech.edu>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<0949C49693EF1A47A54B0F0113CDB4A6076CEE@zin33exm23.fsl.freescale.net>
	<20100111162900.GA10110@ovro.caltech.edu>
From: "Dudhat Dipen-B09055" <B09055@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: herbert@gondor.apana.org.au, Suresh Vishnu-B05022 <B05022@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
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

=20
Hi Ira,

Do these patches accepted to open source kernel??

- Dipen

-----Original Message-----
From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]=20
Sent: Monday, January 11, 2010 9:59 PM
To: Dudhat Dipen-B09055
Cc: dan.j.williams@intel.com; galak@kernel.crashing.org;
herbert@gondor.apana.org.au; Tabi Timur-B04825; linuxppc-dev@ozlabs.org;
Suresh Vishnu-B05022; Gupta Maneesh-B18878; Li Yang-R58472
Subject: Re: fsldma: cleanup driver and fix async_tx compatibility

On Mon, Jan 11, 2010 at 11:17:04AM +0530, Dudhat Dipen-B09055 wrote:
>=20
> Hi Ira,
>=20
> I have tested your patches with async DMA memcpy support. Though I=20
> haven't captured the improvement figures.
> It works fine for RAID5 memcpy offload as interrupts are coming for=20
> separate DMA channels while I have ran IOZONE onto RAID partition.
>=20

Excellent, thanks for running these tests. I'm glad to hear that the
RAID offload is working now.

You shouldn't notice any difference in performance. On a 32MB memcpy
operation, broken into 32x 1MB memcpy(), 1x interrupt(), I noticed less
than 0.1% difference (approx 100,000 ns / 0.1ms). This is probably at or
near the limits of my measurement accuracy.

Ira


> Regards,
>  Dipen
> =20
>=20
> -----Original Message-----
> From: Dudhat Dipen-B09055
> Sent: Tuesday, January 05, 2010 11:38 AM
> To: 'Ira W. Snyder'; dan.j.williams@intel.com
> Cc: galak@kernel.crashing.org; herbert@gondor.apana.org.au; Tabi=20
> Timur-B04825; linuxppc-dev@ozlabs.org; Suresh Vishnu-B05022; Gupta=20
> Maneesh-B18878; Li Yang-R58472
> Subject: RE: fsldma: cleanup driver and fix async_tx compatibility
>=20
>=20
> Hi Ira,
>=20
> I will test it on 85xx hardware and let you know once done.
>=20
> Thanks
> Dipen
> =20
>=20
> -----Original Message-----
> From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]
> Sent: Friday, January 01, 2010 11:41 AM
> To: dan.j.williams@intel.com
> Cc: galak@kernel.crashing.org; herbert@gondor.apana.org.au; Tabi=20
> Timur-B04825; linuxppc-dev@ozlabs.org; Suresh Vishnu-B05022; Dudhat=20
> Dipen-B09055; Gupta Maneesh-B18878; Li Yang-R58472
> Subject: fsldma: cleanup driver and fix async_tx compatibility
>=20
> This patch series cleans up the Freescale DMAEngine driver, including=20
> verifying the locking and making sure that all code paths are correct.
> There were a few places that seemed suspicious, and they have been=20
> fixed.
>=20
> I have written a quick memory->memory DMAEngine test driver, and the=20
> performance is identical before and after my changes (<0.1% change). I

> measured both setting up the DMA operation (via
> device_prep_dma_interrupt() and device_prep_dma_memcpy()) and the=20
> actual DMA transfer itself.
>=20
> As an added bonus, the interrupt load is measurably reduced. My test=20
> driver transfers 32MB as 32x 1MB chunks + 1 interrupt descriptor,=20
> using the functions noted above. Previous to this patch series, 31=20
> interrupts were generated. After this patch series, only a single=20
> interrupt is generated for the whole transaction.
>=20
> Some testing on 85xx/86xx hardware would be appreciated. Also, some=20
> testing by the users attempting to use async_tx and talitos to handle=20
> RAID offload would be great as well.
>=20
>  Documentation/powerpc/dts-bindings/fsl/dma.txt |   17 +-
>  drivers/dma/fsldma.c                           | 1036
> ++++++++++++------------
>  drivers/dma/fsldma.h                           |   35 +-
>  3 files changed, 556 insertions(+), 532 deletions(-)
>=20
> Thanks,
> Ira
>=20
