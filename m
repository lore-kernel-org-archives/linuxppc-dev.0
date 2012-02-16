Return-Path: <B29397@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CE29B6FCF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 12:12:48 +1100 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Mehresh Ramneek-B31383 <B31383@freescale.com>, "stern@rowland.harvard.edu"
 <stern@rowland.harvard.edu>, "agust@denx.de" <agust@denx.de>
Subject: RE: [RFC] usb: Fix build error due to dma_mask is not at
 pdev_archdata at ARM
Date: Thu, 16 Feb 2012 01:12:36 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649804880F@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1329210695-14492-1-git-send-email-peter.chen@freescale.com>
 <75A6930FC6B2FE479E2BC468C9240CE0026C19@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <75A6930FC6B2FE479E2BC468C9240CE0026C19@039-SN1MPN1-002.039d.mgd.msft.net>
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

=20
> When build i.mx platform with imx_v6_v7_defconfig, and after adding USB
> Gadget support, it has below build error:
>=20
> CC      drivers/usb/host/fsl-mph-dr-of.o
> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata'
> has no member named 'dma_mask'
>=20
> It has discussed at: http://www.spinics.net/lists/linux-usb/msg57302.html
>=20
> For PowerPC, there is dma_mask at struct pdev_archdata, but there is no
> dma_mask at struct pdev_archdata for ARM. The pdev_archdata is related to
> specific platform, it should NOT be accessed by cross platform drivers,
> like USB.
>=20
> The code for pdev_archdata should be useless, as for PowerPC, it has
> already gotten the value for pdev->dev.dma_mask at function
> arch_setup_pdev_archdata of arch/powerpc/kernel/setup-common.c.
>=20
> Anyone who has PowerPC hardware with USB host enabled, and uses this code
> can help me a test? Thank you
>=20
> [Ramneek]: Hi Peter, the code is working for Host stack on PowerPC.
=20
Thanks, Ramneek. I will post PATCH and add:
Tested-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
