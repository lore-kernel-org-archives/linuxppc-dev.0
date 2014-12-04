Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4E31A0CB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 07:16:17 +1100 (AEDT)
Message-ID: <1417724162.334.5.camel@freescale.com>
Subject: Re: [RFC PATCH v2 1/1] powerpc/85xx: Add support for
 Emerson/Artesyn MVME2500.
From: Scott Wood <scottwood@freescale.com>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Thu, 4 Dec 2014 14:16:02 -0600
In-Reply-To: <1417685009-1640-1-git-send-email-alessio.bogani@elettra.eu>
References: <1417685009-1640-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-04 at 10:23 +0100, Alessio Igor Bogani wrote:
> +/include/ "fsl/pq3-mpic-message-B.dtsi"

The MPIC message include should be done in the SoC file -- it's not
board-specific.

For some reason I don't see this dtsi being included by anything
currently.

> @@ -80,33 +82,21 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
> -CONFIG_MTD_OF_PARTS=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
> -CONFIG_MTD_BLKDEVS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_FTL=y
>  CONFIG_MTD_CFI=y
> -CONFIG_MTD_GEN_PROBE=y
> -CONFIG_MTD_MAP_BANK_WIDTH_1=y
> -CONFIG_MTD_MAP_BANK_WIDTH_2=y
> -CONFIG_MTD_MAP_BANK_WIDTH_4=y
> -CONFIG_MTD_CFI_I1=y
> -CONFIG_MTD_CFI_I2=y

Are these removals due to make savedefconfig?  Please have a separate
patch that just runs make savedefconfig first, so that we can see what
actual changes are being made.

Otherwise, looks good.

-Scott
