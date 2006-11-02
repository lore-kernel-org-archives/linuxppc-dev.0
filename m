Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3902D67C8C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:31:49 +1100 (EST)
Subject: Re: [patch 10/16] powerpc: make hash_native_64.o a 64bit-only object
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125628.027744000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125628.027744000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:31:44 +1100
Message-Id: <1162506704.10630.50.camel@localhost.localdomain>
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
> (powerpc-mm-makefile-hash_native_64-make-obj64.diff)
> Make hash_native_64.o dependent on 64bit, not on MULTIPLATFORM
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

If we ever want it, we might have specific Kconfig options for the
various low level MMU interfaces and have the platform select them, but
for now, that's fine.

> Index: arch/powerpc/mm/Makefile
> ===================================================================
> --- a/arch/powerpc/mm/Makefile.orig
> +++ b/arch/powerpc/mm/Makefile
> @@ -8,7 +8,7 @@ endif
>  
>  obj-y				:= fault.o mem.o lmb.o
>  obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o
> -hash-$(CONFIG_PPC_MULTIPLATFORM) := hash_native_64.o
> +hash-$(CONFIG_PPC64)		:= hash_native_64.o
>  obj-$(CONFIG_PPC64)		+= init_64.o pgtable_64.o mmu_context_64.o \
>  				   hash_utils_64.o hash_low_64.o tlb_64.o \
>  				   slb_low.o slb.o stab.o mmap.o imalloc.o \
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
