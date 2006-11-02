Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA32A67D76
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:36:11 +1100 (EST)
Subject: Re: [patch 15/16] powerpc: clean up usage of boot_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125630.211637000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125630.211637000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:36:05 +1100
Message-Id: <1162506965.10630.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 13:56 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (powerpc-pmac-move-boot_dev-to-pmac.diff)
> dev_t boot_dev is declared in arch/powerpc/kernel/setup_32.c
> and in arch/powerpc/kernel/setup_64.c but not used in these files.
> It is only used in arch/powerpc/platforms/powermac/setup.c, so make
> it static in this file
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: arch/powerpc/kernel/setup_32.c
> ===================================================================
> --- a/arch/powerpc/kernel/setup_32.c.orig
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -63,10 +63,6 @@ unsigned int DMA_MODE_WRITE;
>  
>  int have_of = 1;
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> -dev_t boot_dev;
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> -
>  #ifdef CONFIG_VGA_CONSOLE
>  unsigned long vgacon_remap_base;
>  #endif
> Index: arch/powerpc/kernel/setup_64.c
> ===================================================================
> --- a/arch/powerpc/kernel/setup_64.c.orig
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -71,7 +71,6 @@
>  
>  int have_of = 1;
>  int boot_cpuid = 0;
> -dev_t boot_dev;
>  u64 ppc64_pft_size;
>  
>  /* Pick defaults since we might want to patch instructions
> Index: arch/powerpc/platforms/powermac/setup.c
> ===================================================================
> --- a/arch/powerpc/platforms/powermac/setup.c.orig
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -361,7 +361,7 @@ char *bootdevice;
>  void *boot_host;
>  int boot_target;
>  int boot_part;
> -extern dev_t boot_dev;
> +static dev_t boot_dev;
>  
>  #ifdef CONFIG_SCSI
>  void __init note_scsi_host(struct device_node *node, void *host)
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
