Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B39567D7C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:34:21 +1100 (EST)
Subject: Re: [patch 13/16] powerpc: make prom_init.o dependent on PPC_OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125629.335003000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125629.335003000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:34:13 +1100
Message-Id: <1162506853.10630.55.camel@localhost.localdomain>
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
> (powerpc-kernel-makefile-move-prom_init.c-to-PPC_OF.diff)
> prom_init.o is used for OF machines, so make compilation dependent
> on that and not on PPC_MULTIPLATFORM
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Note that CONFIG_PPC_OF is always set in arch/powerpc since that
includes support for the flat device-tree... We might want to keep a
separate option for prom_init.c, though I'm not too big about it right
now. Maybe CONFIG_PPC_BOOT_FROM_OF :) That would allow custom kernel to
be shrunk down if they don't need to support platforms that are known
not to have a real OF (iSeries for example).


> Index: arch/powerpc/kernel/Makefile
> ===================================================================
> --- a/arch/powerpc/kernel/Makefile.orig
> +++ b/arch/powerpc/kernel/Makefile
> @@ -21,7 +21,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o binfm
>  obj-$(CONFIG_PPC64)		+= vdso64/
>  obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
>  obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
> -obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o
> +obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o prom_init.o
>  procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
>  obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
>  rtaspci-$(CONFIG_PPC64)		:= rtas_pci.o
> @@ -53,7 +53,6 @@ obj-y				+= time.o prom.o traps.o setup-
>  				   udbg.o misc.o io.o
>  obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
>  obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
> -obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
>  obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
>  obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
>  obj-$(CONFIG_SMP)		+= smp.o
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
