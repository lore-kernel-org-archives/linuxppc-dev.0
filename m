Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id AAE01DDEFF
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 08:46:56 +1000 (EST)
Date: 24 Jun 2007 15:46:52 -0700
Message-ID: <20070624224652.2950.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: yur@emcraft.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
In-Reply-To: <200706241552.31483.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <200706241552.31483.yur@emcraft.com> you write:
>  This patch fixes the issue of erroneously involving the 
> arch/powerpc/sysdev/mv64x60*.c files into the compilation 
> process for ppc- (not powerpc-) based platforms (e.g., 
> P3M750).
> 
>  Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> 
> --
> 
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index c3ce0bd..25eaa14 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -17,7 +17,9 @@ obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>  mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o

Shouldn't the above line also be placed inside the of following ifeq ?

> +ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
> +endif
>  
>  # contains only the suspend handler for time
>  obj-$(CONFIG_PM)		+= timer.o

Thanks,

-Dale
