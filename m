Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54A61DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 00:35:06 +1000 (EST)
In-Reply-To: <20070616000618.965439750@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.965439750@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9EC5456-63EF-4563-A175-ECFDE1B58912@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 7/9] disallow building powermac and tsi108 without PCI
Date: Sun, 17 Jun 2007 09:35:47 -0500
To: arnd@arndb.de
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 15, 2007, at 7:05 PM, arnd@arndb.de wrote:

> The TSI108 code and the 32 bit powermac and chrp platforms
> have dependency on PCI that is not easy or desirable to get rid
> of.
>
> The easiest fix is to always select CONFIG_PCI if one of those
> platforms is enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -18,6 +18,7 @@ config LINKSTATION
>
>  config MPC7448HPC2
>  	bool "Freescale MPC7448HPC2(Taiga)"
> +	select PCI
>  	select TSI108_BRIDGE
>  	select DEFAULT_UIMAGE
>  	select PPC_UDBG_16550
> @@ -31,6 +32,7 @@ config PPC_HOLLY
>  	select TSI108_BRIDGE
>  	select PPC_UDBG_16550
>  	select CPU_7xx
> +	select PCI
>  	help
>  	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
>  	  Board with TSI108/9 bridge (Hickory/Holly)

Any reason we just don't add the select to the config TSI108_BRIDGE  
so any future TSI108 based systems get it as well?

- k
