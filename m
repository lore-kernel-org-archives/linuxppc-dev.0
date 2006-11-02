Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31CBB67D97
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:36:36 +1100 (EST)
Subject: Re: [patch 16/16] powerpc: make nvram_64.o a 64bit-only object
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125630.648324000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125630.648324000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:36:31 +1100
Message-Id: <1162506991.10630.61.camel@localhost.localdomain>
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
> (powerpc-make-nvram_64.c-a-64bit-object.diff)
> Make nvram_64.o dependent on 64bit, not on MULTIPLATFORM
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: arch/powerpc/kernel/Makefile
> ===================================================================
> --- a/arch/powerpc/kernel/Makefile.orig
> +++ b/arch/powerpc/kernel/Makefile
> @@ -17,7 +17,7 @@ obj-y				+= vdso32/
>  obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
>  				   paca.o cpu_setup_ppc970.o \
> -				   firmware.o sysfs.o
> +				   firmware.o sysfs.o nvram_64.o
>  obj-$(CONFIG_PPC64)		+= vdso64/
>  obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
>  obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
> @@ -32,7 +32,6 @@ obj-$(CONFIG_LPARCFG)		+= lparcfg.o
>  obj-$(CONFIG_IBMVIO)		+= vio.o
>  obj-$(CONFIG_IBMEBUS)           += ibmebus.o
>  obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
> -obj64-$(CONFIG_PPC_MULTIPLATFORM) += nvram_64.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
>  obj-$(CONFIG_TAU)		+= tau_6xx.o
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
