Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BE292C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 22:08:04 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix sram_offset parameter type
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342693696-29734-1-git-send-email-claudiu.manoil@freescale.com>
Date: Thu, 19 Jul 2012 07:07:56 -0500
Message-Id: <37C94886-3DA3-4389-8A67-F13035D2CEA6@kernel.crashing.org>
References: <1342693696-29734-1-git-send-email-claudiu.manoil@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2012, at 5:28 AM, Claudiu Manoil wrote:

> The sram_offset parameter represents a physical address
> and should be of type phys_addr_t. As part of this fix,
> the extraction of sram_params is being cleaned-up and
> fixed.
> This patch fixes now the case when the offset value of
> 0xfff00000 was being rejected by the driver (returning
> -EINVAL), although this is a valid offset value.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 =
++++++++++------------------
> 2 files changed, 16 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h =
b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
> index 60c9c0b..a4ce9b8 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
> @@ -1,5 +1,5 @@
> /*
> - * Copyright 2009-2010 Freescale Semiconductor, Inc
> + * Copyright 2009-2010 2012 Freescale Semiconductor, Inc

we normally do 2009-2010, 2012

>  *
>  * QorIQ based Cache Controller Memory Mapped Registers
>  *
> @@ -91,7 +91,7 @@ struct mpc85xx_l2ctlr {
>=20
> struct sram_parameters {
> 	unsigned int sram_size;
> -	uint64_t sram_offset;
> +	phys_addr_t sram_offset;
> };
>=20
>=20

- k
