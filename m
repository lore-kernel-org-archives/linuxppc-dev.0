Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 99DB3B7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 22:27:29 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D20DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 22:27:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n61CQoAo020641
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 05:27:04 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n61CQmWL023399
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 07:26:49 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][v2] sata_fsl: Add asynchronous notification support
Date: Wed, 1 Jul 2009 17:56:45 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B24FB60@zin33exm20.fsl.freescale.net>
In-Reply-To: <4A4B1D8F.9090609@ru.mvista.com>
References: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
	<4A4B1D8F.9090609@ru.mvista.com>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Sergei,

It looks like that the email client has added these whitespaces and
alignment mess-up,
as the original patch file has none of these issues.=20

I will try using another email client and re-post the patch.

Thanks,
Ashish

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]=20
Sent: Wednesday, July 01, 2009 1:56 PM
To: Kalra Ashish-B00888
Cc: linux-ide@vger.kernel.org; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][v2] sata_fsl: Add asynchronous notification support

Hello.

ashish kalra wrote:

> Enable device hot-plug support on Port multiplier fan-out ports
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
[...]
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index=20
> 94eaa43..5751145 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
>
>      SATA_FSL_HOST_FLAGS    =3D (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -                ATA_FLAG_PMP | ATA_FLAG_NCQ),
> +                 ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

   Why are you breaking the alignment? There's alos trailing whitespace
here...

> @@ -132,7 +132,7 @@ enum {
>      INT_ON_SINGL_DEVICE_ERR =3D (1 << 1),
>      INT_ON_CMD_COMPLETE =3D 1,
>
> -    INT_ON_ERROR =3D INT_ON_FATAL_ERR |
> +    INT_ON_ERROR =3D INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |

   Trailing whitespace.

> @@ -154,6 +154,7 @@ enum {
>
>      DEFAULT_PORT_IRQ_ENABLE_MASK =3D IE_ON_FATAL_ERR | =
IE_ON_PHYRDY_CHG
|
>          IE_ON_SIGNATURE_UPDATE |
> +        IE_ON_SNOTIFY_UPDATE |

   Again.

>          IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
>
>      EXT_INDIRECT_SEG_PRD_FLAG =3D (1 << 31), @@ -1003,6 +1004,11 @@=20
> static void sata_fsl_error_intr(struct ata_port
> *ap)
>          freeze =3D 1;
>      }
>
> +    /* Handle SDB FIS receive & notify update */
> +    if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +        sata_async_notification(ap);
> +    }

   And again -- on every line.

MBR, Sergei
