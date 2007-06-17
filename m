Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2273DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 00:41:30 +1000 (EST)
In-Reply-To: <20070616000618.183462070@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.183462070@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3BBD8247-77A4-420C-8D4D-577E1B47D5F0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/9] move 82xx/83xx/86xx Kconfig options to platform
	selection
Date: Sun, 17 Jun 2007 09:42:10 -0500
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

> The cores used in the MPC82xx/83xx/86xx embedded controllers are  
> very similar
> to those in the 32 bit general-purpose processors, so it makes  
> sense to
> treat them as the same CPU family.
>
> Choosing between the embedded platforms and the multiplatform code is
> now done in the platform menu, but functionally everything stays the
> same.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Index: linux-2.6/arch/powerpc/platforms/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/Kconfig
> @@ -2,7 +2,7 @@ menu "Platform support"
>
>  choice
>  	prompt "Machine type"
> -	depends on PPC64 || CLASSIC32
> +	depends on PPC64 || 6xx
>  	default PPC_MULTIPLATFORM
>
>  config PPC_MULTIPLATFORM
> @@ -16,8 +16,31 @@ config EMBEDDED6xx
>  	bool "Embedded 6xx/7xx/7xxx-based board"
>  	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
>
> +config PPC_82xx
> +	bool "Freescale 82xx"
> +	depends on 6xx
> +
> +config PPC_83xx
> +	bool "Freescale 83xx"
> +	depends on 6xx
> +	select FSL_SOC
> +	select 83xx
> +	select WANT_DEVICE_TREE
> +
> +config PPC_86xx
> +	bool "Freescale 86xx"
> +	depends on 6xx
> +	select FSL_SOC
> +	select FSL_PCIE
> +	select ALTIVEC
> +	help
> +	  The Freescale E600 SoCs have 74xx cores.
>  endchoice

is it feasible to have 83xx/86xx go 'multiplatform' but not 82xx?   
There are more annoyances about CPM2 support that are not clean such  
that you couldn't build support for different 82xx systems into the  
same kernel.  Today we only support one 82xx system in ARCH=powerpc,  
but I'd rather we not move it until we clean up those issues.  (the  
same is true of 85xx).

- k
