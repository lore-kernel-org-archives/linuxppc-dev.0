Return-Path: <shannon.nelson@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id A19C6DDEF8
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 02:10:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Date: Fri, 7 Sep 2007 09:00:17 -0700
Message-ID: <BAE9DCEF64577A439B3A37F36F9B691C02FF08A1@orsmsx418.amr.corp.intel.com>
In-Reply-To: <11891624582950-git-send-email-wei.zhang@freescale.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
From: "Nelson, Shannon" <shannon.nelson@intel.com>
To: "Zhang Wei" <wei.zhang@freescale.com>,
	<paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Zhang Wei [mailto:wei.zhang@freescale.com]=20
>Sent: Friday, September 07, 2007 3:54 AM
>To: paulus@samba.org; Nelson, Shannon
>Cc: linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
>galak@kernel.crashing.org; Zhang Wei; Ebony Zhu
>Subject: [PATCH 5/5] Add DMA engine driver for Freescale=20
>MPC85xx processors.
>
>The driver implements DMA engine API for Freescale MPC85xx DMA
>controller, which could be used for MEM<-->MEM, IO_ADDR<-->MEM
>and IO_ADDR<-->IO_ADDR data transfer.
>The driver supports the Basic mode of Freescale MPC85xx DMA controller.
>The MPC85xx processors supported include MPC8540/60, MPC8555, MPC8548,
>MPC8641 and so on.
>The support for MPC83xx(MPC8349, MPC8360) is experimental.
>
>Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
>---
> drivers/dma/Kconfig  |    8 +
> drivers/dma/Makefile |    1 +
> drivers/dma/fsldma.c |  995=20
>++++++++++++++++++++++++++++++++++++++++++++++++++
> drivers/dma/fsldma.h |  188 ++++++++++
> 4 files changed, 1192 insertions(+), 0 deletions(-)
> create mode 100644 drivers/dma/fsldma.c
> create mode 100644 drivers/dma/fsldma.h
>
>diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>index 8f670da..a99e925 100644
>--- a/drivers/dma/Kconfig
>+++ b/drivers/dma/Kconfig
>@@ -40,4 +40,12 @@ config INTEL_IOP_ADMA
>         ---help---
>           Enable support for the Intel(R) IOP Series RAID engines.
>=20
>+config FSL_DMA
>+	bool "Freescale MPC85xx/MPC83xx DMA support"
>+	depends on DMA_ENGINE && PPC
>+	---help---
>+	  Enable support for the Freescale DMA engine. Now, it support
>+	  MPC8560/40, MPC8555, MPC8548 and MPC8641 processors.
>+	  The MPC8349, MPC8360 support is experimental.
>+
> endmenu

If this is experimental, perhaps you should mark the depends line as
such
	depends on on DMA_ENGINE && PPC && EXPERIMENTAL

[...]

>+static int fsl_dma_self_test(struct fsl_dma_chan *fsl_chan)
>+{
>+	struct dma_chan *chan;
>+	int err =3D 0;
>+	dma_addr_t addr;
>+	dma_cookie_t cookie;
>+	u8 *src, *dest;
>+	int i;
>+	size_t test_size;
>+	struct dma_async_tx_descriptor *tx1, *tx2, *tx3;
>+	struct fsl_dma_device *fdev;
>+
>+	BUG_ON(!fsl_chan);
>+
>+	fdev =3D fsl_chan->device;
>+	test_size =3D 4096;
>+
>+	src =3D kmalloc(test_size * 2, GFP_KERNEL);
>+	if (!src) {
>+		dev_err(fdev->dev,
>+				"selftest: Can not alloc memory=20
>for test!\n");
>+		err =3D -ENOMEM;
>+		goto out;
>+	}
>+
>+	dest =3D src + test_size;
>+
>+	for (i =3D 0; i < test_size; i++)
>+		src[i] =3D (u8) i;
>+
>+	chan =3D &fsl_chan->common;
>+
>+	if (fsl_dma_alloc_chan_resources(chan) < 1) {
>+		dev_err(fdev->dev,
>+				"selftest: Can not alloc=20
>resources for DMA\n");
>+		err =3D -ENODEV;
>+		goto out;
>+	}
>+
>+	/* TX 1 */
>+	tx1 =3D fsl_dma_prep_memcpy(chan, test_size / 2, 0);
>+	async_tx_ack(tx1);
>+	addr =3D dma_map_single(chan->device->dev, src, test_size / 2,
>+							DMA_TO_DEVICE);
>+	fsl_dma_set_src(addr, tx1, 0);
>+	addr =3D dma_map_single(chan->device->dev, dest, test_size / 2,
>+						=09
>DMA_FROM_DEVICE);
>+	fsl_dma_set_dest(addr, tx1, 0);
>+
>+	cookie =3D fsl_dma_tx_submit(tx1);
>+	fsl_dma_memcpy_issue_pending(chan);
>+
>+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
>+			!=3D DMA_SUCCESS);

Is this guaranteed to finish?  If there's something wrong and the DMA
never completes, you've now hung this thread.  This is why the ioat_dma
engine does an msleep() and then checks once for completion.  You might
think about this...

>+
>+	/* Test free and re-alloc channel resources */
>+	fsl_dma_free_chan_resources(chan);
>+
>+	if (fsl_dma_alloc_chan_resources(chan) < 1) {
>+		dev_err(fdev->dev,
>+				"selftest: Can not alloc=20
>resources for DMA\n");
>+		err =3D -ENODEV;
>+		goto out;
>+	}
>+
>+	/* Continue to test
>+	 * TX 2
>+	 */
>+	tx2 =3D fsl_dma_prep_memcpy(chan, test_size / 4, 0);
>+	async_tx_ack(tx2);
>+	addr =3D dma_map_single(chan->device->dev, src + test_size / 2,
>+					test_size / 4, DMA_TO_DEVICE);
>+	fsl_dma_set_src(addr, tx2, 0);
>+	addr =3D dma_map_single(chan->device->dev, dest + test_size / 2,
>+					test_size / 4, DMA_FROM_DEVICE);
>+	fsl_dma_set_dest(addr, tx2, 0);
>+
>+	/* TX 3 */
>+	tx3 =3D fsl_dma_prep_memcpy(chan, test_size / 4, 0);
>+	async_tx_ack(tx3);
>+	addr =3D dma_map_single(chan->device->dev, src +=20
>test_size * 3 / 4,
>+					test_size / 4, DMA_TO_DEVICE);
>+	fsl_dma_set_src(addr, tx3, 0);
>+	addr =3D dma_map_single(chan->device->dev, dest +=20
>test_size * 3 / 4,
>+					test_size / 4, DMA_FROM_DEVICE);
>+	fsl_dma_set_dest(addr, tx3, 0);
>+
>+	/* Test exchanging the prepared tx sort */
>+	cookie =3D fsl_dma_tx_submit(tx3);
>+	cookie =3D fsl_dma_tx_submit(tx2);
>+
>+	fsl_dma_memcpy_issue_pending(chan);
>+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
>+			!=3D DMA_SUCCESS);

Again, is it possible to hang your thread here?

[...]

sln
--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mr. Shannon Nelson                 LAN Access Division, Intel Corp.
Shannon.Nelson@intel.com                I don't speak for Intel
(503) 712-7659                    Parents can't afford to be squeamish.
