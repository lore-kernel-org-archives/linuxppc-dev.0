Return-Path: <jgpobox@gmail.com>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
 [209.85.216.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC6952C0126
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2013 10:57:29 +1100 (EST)
Received: by mail-qa0-f41.google.com with SMTP id bs12so2359609qab.0
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Apr 2013 16:57:26 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <515CC1E5.7030704@pobox.com>
Date: Wed, 03 Apr 2013 19:57:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [PATCH] fsl/sata: create a sysfs entry for rx water mark
References: <1362381623-10856-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1362381623-10856-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/2013 02:20 AM, Qiang Liu wrote:
> Support config RX WATER MARK via sysfs when running at run-time;
> A wrokaround for fix the exception happened to some WD HDD, found on
> WD3000HLFS-01G6U1, WD3000HLFS-01G6U0, some SSD disks. The read performance
> is also regression (about 30%) when use default value.
>
> According to the latest documents, 0x10 is the default value of RX WATER MARK,
> but exception/performance issue happened to some disks mentioned above.
>
> The exception log as below when testing read performance with IOZone:
> ata1.00: exception Emask 0x0 SAct 0x7 SErr 0x800000 action 0x6 frozen
> ata1: SError: { LinkSeq }
> ata1.00: failed command: READ FPDMA QUEUED
> ata1.00: cmd 60/00:00:ff:2c:14/01:00:02:00:00/40 tag 0 ncq 131072 in
> res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: failed command: READ FPDMA QUEUED
> ata1.00: cmd 60/00:08:ff:2d:14/01:00:02:00:00/40 tag 1 ncq 131072 in
> res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: failed command: WRITE FPDMA QUEUED
> ata1.00: cmd 61/10:10:af:08:6e/00:00:12:00:00/40 tag 2 ncq 8192 out
> res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: hard resetting link
> ata1: Hardreset failed, not off-lined 0
> ata1: Signature Update detected @ 504 msecs
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1.00: device reported invalid CHS sector 0
> ata1.00: device reported invalid CHS sector 0
> ata1.00: device reported invalid CHS sector 0
> ata1: EH complete
>
> The exception/performance can be resolved when RX WATER MARK value is 0x16.
>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>   drivers/ata/sata_fsl.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 55 insertions(+), 0 deletions(-)

applied, though it seems advisable to simply set 0x16 than all this mess
