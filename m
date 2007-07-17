Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD703DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 06:56:30 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6HLJXuh299578
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 07:19:33 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HL01Ro059814
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 07:00:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HKuSmA019322
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 06:56:28 +1000
Subject: Re: [PATCH] iommu virtual merge no longer experimental
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070717160935.GE5771@austin.ibm.com>
References: <20070717160935.GE5771@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 06:56:26 +1000
Message-Id: <1184705786.25235.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Tim Schimke <tschimke@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-17 at 11:09 -0500, Linas Vepstas wrote:
> Per conversations with BenH, iommu virtual merging should no longer
> be considered to be an "experimental" feature. In particular, 
> CONFIG_VMERGE has been set to "y" in te defconfigs for quite a while.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ----
>  arch/powerpc/Kconfig |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.22-git2/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.22-git2.orig/arch/powerpc/Kconfig	2007-07-08 18:32:17.000000000 -0500
> +++ linux-2.6.22-git2/arch/powerpc/Kconfig	2007-07-17 11:08:18.000000000 -0500
> @@ -430,16 +430,17 @@ config MATH_EMULATION
>  	  instructions to run.
>  
>  config IOMMU_VMERGE
> -	bool "Enable IOMMU virtual merging (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && PPC64
> -	default n
> +	bool "Enable IOMMU virtual merging"
> +	depends on PPC64
> +	default y
>  	help
>  	  Cause IO segments sent to a device for DMA to be merged virtually
>  	  by the IOMMU when they happen to have been allocated contiguously.
>  	  This doesn't add pressure to the IOMMU allocator. However, some
>  	  drivers don't support getting large merged segments coming back
> -	  from *_map_sg(). Say Y if you know the drivers you are using are
> -	  properly handling this case.
> +	  from *_map_sg().
> +
> +	  Most drivers don't have this problem; it is safe to say Y here.
>  
>  config HOTPLUG_CPU
>  	bool "Support for enabling/disabling CPUs"
