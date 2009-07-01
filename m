Return-Path: <sshtylyov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 70060B70F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 18:26:01 +1000 (EST)
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2CFBDDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 18:26:00 +1000 (EST)
Message-ID: <4A4B1D8F.9090609@ru.mvista.com>
Date: Wed, 01 Jul 2009 12:25:51 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ashish kalra <ashish.kalra@freescale.com>
Subject: Re: [PATCH][v2] sata_fsl: Add asynchronous notification support
References: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
In-Reply-To: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

ashish kalra wrote:

> Enable device hot-plug support on Port multiplier fan-out ports
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
[...]
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 94eaa43..5751145 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
>
>      SATA_FSL_HOST_FLAGS    = (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -                ATA_FLAG_PMP | ATA_FLAG_NCQ),
> +                 ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

   Why are you breaking the alignment? There's alos trailing whitespace 
here...

> @@ -132,7 +132,7 @@ enum {
>      INT_ON_SINGL_DEVICE_ERR = (1 << 1),
>      INT_ON_CMD_COMPLETE = 1,
>
> -    INT_ON_ERROR = INT_ON_FATAL_ERR |
> +    INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |

   Trailing whitespace.

> @@ -154,6 +154,7 @@ enum {
>
>      DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
>          IE_ON_SIGNATURE_UPDATE |
> +        IE_ON_SNOTIFY_UPDATE |

   Again.

>          IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
>
>      EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
> @@ -1003,6 +1004,11 @@ static void sata_fsl_error_intr(struct ata_port 
> *ap)
>          freeze = 1;
>      }
>
> +    /* Handle SDB FIS receive & notify update */
> +    if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +        sata_async_notification(ap);
> +    }

   And again -- on every line.

MBR, Sergei
