Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDF411A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 10:56:34 +1100 (AEDT)
Message-ID: <1428018982.22867.310.camel@freescale.com>
Subject: Re: [PATCH] powerpc/config: add SCSI configs for
 corenet64_smp_defconfig
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
Date: Thu, 2 Apr 2015 18:56:22 -0500
In-Reply-To: <1427796008-40028-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1427796008-40028-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 18:00 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Otherwise there wil be no SCSI device nodes.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  arch/powerpc/configs/corenet64_smp_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
> index 04737aa..77a8151 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -75,6 +75,13 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=131072
>  CONFIG_EEPROM_LEGACY=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_CHR_DEV_ST=y
> +CONFIG_BLK_DEV_SR=y
> +CONFIG_CHR_DEV_SG=y

Ben already sent a patch enabling these (except ST -- do we really need
that?) in both corenet32 and corenet64.

> +CONFIG_SCSI_MULTI_LUN=y

This option was removed by c309b35171dd

> +CONFIG_SCSI_LOGGING=y
> +CONFIG_SCSI_SPI_ATTRS=y

If you want these enabled, do it in a separate patch with an explanation
of why we should enable them by default, and do it for other
85xx/corenet configs as well.

-Scott
