Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79FD61A0246
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 08:18:24 +1100 (AEDT)
Subject: Re: [RFT PATCH] powerpc: convert amigaone_defconfig to use libata
 PATA drivers
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
 <1454514630-29269-12-git-send-email-b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: Gerhard Pircher <gerhard_pircher@gmx.net>
Message-ID: <56B26E7F.70307@gmx.net>
Date: Wed, 3 Feb 2016 22:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <1454514630-29269-12-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 2016-02-03 um 16:50 schrieb Bartlomiej Zolnierkiewicz:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts amigaone_defconfig to use libata PATA
> drivers.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Build tested only.
> If you have affected hardware please test.  Thank you.
> 
>  arch/powerpc/configs/amigaone_defconfig | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
> index 84f1b41..55a4929 100644
> --- a/arch/powerpc/configs/amigaone_defconfig
> +++ b/arch/powerpc/configs/amigaone_defconfig
> @@ -46,12 +46,6 @@ CONFIG_PARPORT_PC_FIFO=y
>  CONFIG_BLK_DEV_FD=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -# CONFIG_IDEPCI_PCIBUS_ORDER is not set
> -CONFIG_BLK_DEV_GENERIC=y
> -CONFIG_BLK_DEV_SIIMAGE=y
> -CONFIG_BLK_DEV_VIA82CXXX=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_CHR_DEV_ST=y
> @@ -62,6 +56,10 @@ CONFIG_SCSI_CONSTANTS=y
>  CONFIG_SCSI_SYM53C8XX_2=y
>  CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
>  # CONFIG_SCSI_SYM53C8XX_MMIO is not set
> +CONFIG_ATA=y
> +CONFIG_PATA_SIL680=y
> +CONFIG_PATA_VIA=y
> +CONFIG_ATA_GENERIC=y
>  CONFIG_NETDEVICES=y
>  CONFIG_VORTEX=y
>  CONFIG_8139CP=y
> 
Thanks for cleaning up the defconfig file!

libata drivers work fine on the amigaone platform (tested on all three
first-gen AmigaOne machines). BTW: could it be that CONFIG_ATA_SFF=y
and CONFIG_ATA_BMDMA=y are missing in the patch?

br,
Gerhard
