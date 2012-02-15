Return-Path: <B31383@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF4341007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 19:47:27 +1100 (EST)
From: Mehresh Ramneek-B31383 <B31383@freescale.com>
To: Chen Peter-B29397 <B29397@freescale.com>, "stern@rowland.harvard.edu"
 <stern@rowland.harvard.edu>, "agust@denx.de" <agust@denx.de>
Subject: RE: [RFC] usb: Fix build error due to dma_mask is not at
 pdev_archdata at ARM
Date: Wed, 15 Feb 2012 08:47:17 +0000
Message-ID: <75A6930FC6B2FE479E2BC468C9240CE0026C19@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329210695-14492-1-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1329210695-14492-1-git-send-email-peter.chen@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Chen Peter-B29397=20
Sent: Tuesday, February 14, 2012 2:42 PM
To: stern@rowland.harvard.edu; agust@denx.de
Cc: kernel@pengutronix.de; linuxppc-dev@lists.ozlabs.org; Mehresh Ramneek-B=
31383; Estevam Fabio-R49496; linux-usb@vger.kernel.org
Subject: [RFC] usb: Fix build error due to dma_mask is not at pdev_archdata=
 at ARM

When build i.mx platform with imx_v6_v7_defconfig, and after adding USB Gad=
get support, it has below build error:

CC      drivers/usb/host/fsl-mph-dr-of.o
drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata'
has no member named 'dma_mask'

It has discussed at: http://www.spinics.net/lists/linux-usb/msg57302.html

For PowerPC, there is dma_mask at struct pdev_archdata, but there is no dma=
_mask at struct pdev_archdata for ARM. The pdev_archdata is related to spec=
ific platform, it should NOT be accessed by cross platform drivers, like US=
B.

The code for pdev_archdata should be useless, as for PowerPC, it has alread=
y gotten the value for pdev->dev.dma_mask at function arch_setup_pdev_archd=
ata of arch/powerpc/kernel/setup-common.c.

Anyone who has PowerPC hardware with USB host enabled, and uses this code c=
an help me a test? Thank you

[Ramneek]: Hi Peter, the code is working for Host stack on PowerPC.
=20
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/host/fsl-mph-dr-of.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index 7916e56..ab333ac 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -94,7 +94,6 @@ struct platform_device * __devinit fsl_usb2_device_regist=
er(
 	pdev->dev.parent =3D &ofdev->dev;
=20
 	pdev->dev.coherent_dma_mask =3D ofdev->dev.coherent_dma_mask;
-	pdev->dev.dma_mask =3D &pdev->archdata.dma_mask;
 	*pdev->dev.dma_mask =3D *ofdev->dev.dma_mask;
=20
 	retval =3D platform_device_add_data(pdev, pdata, sizeof(*pdata));
--
1.7.0.4
