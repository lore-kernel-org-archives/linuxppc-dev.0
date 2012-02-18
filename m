Return-Path: <hzpeterchen@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3ED6DB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 21:22:48 +1100 (EST)
Received: by eaan11 with SMTP id n11so1462477eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 02:22:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329356512-31527-1-git-send-email-peter.chen@freescale.com>
References: <1329356512-31527-1-git-send-email-peter.chen@freescale.com>
Date: Sat, 18 Feb 2012 18:22:41 +0800
Message-ID: <CAL411-rL8N4i-sRnnWL5wKZTk9Ac=Go41SEHpcNepN38+MZi9w@mail.gmail.com>
Subject: Re: [PATCH] usb: Fix build error due to dma_mask is not at
 pdev_archdata at ARM
From: Peter Chen <hzpeterchen@gmail.com>
To: Peter Chen <peter.chen@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: fabio.estevam@freescale.com, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, ramneek.mehresh@freescale.com, agust@denx.de,
 linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 9:41 AM, Peter Chen <peter.chen@freescale.com> wrot=
e:
> When build i.mx platform with imx_v6_v7_defconfig, and after adding
> USB Gadget support, it has below build error:
>
> CC =A0 =A0 =A0drivers/usb/host/fsl-mph-dr-of.o
> drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
> drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata'
> has no member named 'dma_mask'
>
> It has discussed at: http://www.spinics.net/lists/linux-usb/msg57302.html
>
> For PowerPC, there is dma_mask at struct pdev_archdata, but there is
> no dma_mask at struct pdev_archdata for ARM. The pdev_archdata is
> related to specific platform, it should NOT be accessed by
> cross platform drivers, like USB.
>
> The code for pdev_archdata should be useless, as for PowerPC,
> it has already gotten the value for pdev->dev.dma_mask at function
> arch_setup_pdev_archdata of arch/powerpc/kernel/setup-common.c.
>
> Tested-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> =A0drivers/usb/host/fsl-mph-dr-of.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-=
dr-of.c
> index 7916e56..ab333ac 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -94,7 +94,6 @@ struct platform_device * __devinit fsl_usb2_device_regi=
ster(
> =A0 =A0 =A0 =A0pdev->dev.parent =3D &ofdev->dev;
>
> =A0 =A0 =A0 =A0pdev->dev.coherent_dma_mask =3D ofdev->dev.coherent_dma_ma=
sk;
> - =A0 =A0 =A0 pdev->dev.dma_mask =3D &pdev->archdata.dma_mask;
> =A0 =A0 =A0 =A0*pdev->dev.dma_mask =3D *ofdev->dev.dma_mask;
>
> =A0 =A0 =A0 =A0retval =3D platform_device_add_data(pdev, pdata, sizeof(*p=
data));
Hi Leo, can your guys give me an ACK for it?  Then, Alan can apply it.
Ramneek has already tested it, and confirmed it did not break host
function at his platform.

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
BR,
Peter Chen
