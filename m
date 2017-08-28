Return-Path: <srs0=02yx=76=linux.vnet.ibm.com=gpiccoli@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgsjf0FMhzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 23:16:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xgsjd6BvGz8snT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 23:16:37 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xgsjc63nDz9sNr
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 23:16:36 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7SDFloR090514
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 09:16:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cmjwem6um-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 09:16:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 07:16:34 -0600
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 "dougmill@us.ibm.com" <dougmill@us.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:16:29 -0300
MIME-Version: 1.0
In-Reply-To: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/28/2017 02:56 AM, Michael Ellerman wrote:
> Some Power9 boxes will have this adapter installed, so add it to the
> defconfig so we can boot on those machines without an initrd.

Michael, not sure if this affects Petitboot (I know it has its own
default config files), but in the past we had some issues with this
driver and it's nice to have the possibility to blacklist it.

What is the rationale for this change? I mean, how being able to boot
without initrd is interesting here? Sorry if it's silly question!

Thanks,


Guilherme


P.S. If this config was *unset* and you're setting, I'd be glad to see
it as module!

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/configs/powernv_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index f89d9b1799b6..dde87c623b74 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -113,6 +113,7 @@ CONFIG_SCSI_CXGB3_ISCSI=m
>  CONFIG_SCSI_CXGB4_ISCSI=m
>  CONFIG_SCSI_BNX2_ISCSI=m
>  CONFIG_BE2ISCSI=m
> +CONFIG_SCSI_AACRAID=y
>  CONFIG_SCSI_MPT2SAS=m
>  CONFIG_SCSI_SYM53C8XX_2=m
>  CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> 
