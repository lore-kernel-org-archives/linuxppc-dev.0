Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgKSJ0z17zDq68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 08:01:36 +1000 (AEST)
Message-ID: <1459980089.32510.78.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: Mingkai.Hu@nxp.com
Date: Wed, 06 Apr 2016 17:01:29 -0500
In-Reply-To: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/config: Disable the 4KiB erase granularity of
 SPI flash
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-06 at 18:14 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Disable the subsector (4KiB) erase granularity to speed up the erase
> operation.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/powerpc/configs/85xx-hw.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx
> -hw.config
> index 528ff0e..a0f4e70 100644
> --- a/arch/powerpc/configs/85xx-hw.config
> +++ b/arch/powerpc/configs/85xx-hw.config
> @@ -77,6 +77,7 @@ CONFIG_MTD_PHYSMAP_OF=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PLATRAM=y
>  CONFIG_MTD_SPI_NOR=y
> +# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
>  CONFIG_NETDEVICES=y
>  CONFIG_NVRAM=y
>  CONFIG_PATA_ALI=y

Is there a reason specific to 85xx to have a different default than every
other platform except lpc18xx?  The description of MTD_SPI_NOR_USE_4K_SECTORS
acknowledges that erase speed is a tradeoff.  Why is that concern more
compelling on 85xx than elsewhere?

-Scott
