Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DB612C0494
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 04:44:56 +1000 (EST)
Message-ID: <1379011486.2536.46.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/85xx: introduce cornet_generic machine
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 12 Sep 2013 13:44:46 -0500
In-Reply-To: <1378969993-14991-2-git-send-email-haokexin@gmail.com>
References: <1378969993-14991-1-git-send-email-haokexin@gmail.com>
 <1378969993-14991-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-12 at 15:13 +0800, Kevin Hao wrote:
> In the current kernel, the board files for p2041rdb, p3041ds, p4080ds,
> p5020ds, p5040ds, t4240qds and b4qds are almost the same except the
> machine name. So this introduces a cornet_generic machine to support
> all these boards to avoid the code duplication.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> This patch is based on http://patchwork.ozlabs.org/patch/274390/
> 
>  arch/powerpc/platforms/85xx/Kconfig      | 10 ++++
>  arch/powerpc/platforms/85xx/Makefile     |  8 +--
>  arch/powerpc/platforms/85xx/b4_qds.c     | 97 --------------------------------
>  arch/powerpc/platforms/85xx/corenet_ds.c | 86 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/p2041_rdb.c  | 87 ----------------------------
>  arch/powerpc/platforms/85xx/p3041_ds.c   | 89 -----------------------------
>  arch/powerpc/platforms/85xx/p4080_ds.c   | 87 ----------------------------
>  arch/powerpc/platforms/85xx/p5020_ds.c   | 93 ------------------------------
>  arch/powerpc/platforms/85xx/p5040_ds.c   | 84 ---------------------------
>  arch/powerpc/platforms/85xx/t4240_qds.c  | 93 ------------------------------
>  10 files changed, 97 insertions(+), 637 deletions(-)
>  delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
>  delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
>  delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
>  delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
>  delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
>  delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
>  delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

Why not merge patch 2/2 with this?

Did you use -M -C with git format-patch?

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index de2eb93..3bee943 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -228,6 +228,7 @@ config P2041_RDB
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P2041 RDB board
>  
> @@ -241,6 +242,7 @@ config P3041_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P3041 DS board
>  
> @@ -254,6 +256,7 @@ config P4080_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P4080 DS board
>  
> @@ -278,6 +281,7 @@ config P5020_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P5020 DS board
>  
> @@ -292,6 +296,7 @@ config P5040_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P5040 DS board
>  
> @@ -323,6 +328,7 @@ config T4240_QDS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the T4240 QDS board
>  
> @@ -337,6 +343,7 @@ config B4_QDS
>  	select ARCH_REQUIRE_GPIOLIB
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the B4 QDS board
>  	  The B4 application development system B4 QDS is a complete
> @@ -348,3 +355,6 @@ endif # FSL_SOC_BOOKE
>  
>  config TQM85xx
>  	bool
> +
> +config CORENET_GENERIC
> +	bool

Why do we need separate kconfig symbols for each board, if they all
select the same code?

> +define_machine(corenet_generic) {
> +	.name			= "CORENET GENERIC",

No allcaps please.

-Scott
