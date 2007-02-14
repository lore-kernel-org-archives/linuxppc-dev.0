Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41BE5DDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:21:52 +1100 (EST)
Subject: Re: [PATCH] celleb: fix scc_uhc.c dependency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702140659.l1E6xLgj008828@toshiba.co.jp>
References: <200702140659.l1E6xLgj008828@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:21:46 +1100
Message-Id: <1171488106.20192.167.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 15:59 +0900, Ishizaki Kou wrote:
> scc_uhc.c depends on CONFIG_PCI, not CONFIG_USB. Because CONFIG_PCI
> is always "y" on Celleb platform, we move scc_uhc.o to obj-y.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
> diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.12
> --- linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.1.1.1	Thu Feb  8 11:38:20 2007
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile	Fri Feb  9 18:42:06 2007
> @@ -1,9 +1,8 @@
>  obj-y				+= interrupt.o iommu.o setup.o \
>  				   htab.o beat.o pci.o \
> -				   scc_epci.o hvCall.o
> +				   scc_epci.o scc_uhc.o hvCall.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
> -obj-$(CONFIG_USB)		+= scc_uhc.o
>  obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
>  obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
