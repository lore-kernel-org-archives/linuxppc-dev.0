Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C62F91A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 01:20:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 Mar 2015 00:20:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 97FBE2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 01:20:22 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2IEKDTD39059678
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 01:20:22 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2IEJmWH022791
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 01:19:48 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/3] powerpc/dma: Remove ZONE_DMA completely
In-Reply-To: <1424421344.27448.43.camel@kernel.crashing.org>
References: <1424421344.27448.43.camel@kernel.crashing.org>
Date: Wed, 18 Mar 2015 19:49:28 +0530
Message-ID: <87zj7amlqn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> We don't initialize it, we don't use it, remove it.
>
> We can bring it back if we ever wish to have support for devices
> who have smaller than 32-bit DMA limitations but I don't think
> we care much anymore.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/Kconfig      |    2 +-
>  arch/powerpc/kernel/dma.c |   10 +---------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 22b0940..4efbfba 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -712,7 +712,7 @@ config ISA
>  
>  config ZONE_DMA
>  	bool
> -	default y
> +	default n
>  
>  config NEED_DMA_MAP_STATE
>  	def_bool (PPC64 || NOT_COHERENT_CACHE)
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index e24e0ae..6306d4e 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -63,16 +63,8 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  		return NULL;
>  	}
>  
> -	switch (zone) {
> -	case ZONE_DMA:
> -		flag |= GFP_DMA;
> -		break;
> -#ifdef CONFIG_ZONE_DMA32
> -	case ZONE_DMA32:
> +	if (zone == ZONE_DMA32)
>  		flag |= GFP_DMA32;
> -		break;
> -#endif
> -	};
>  

Why not do it also for DMA32 as below. We call limit_zone_pfn() only for few
platforms. They can select ZONE_DMA32. Everywhere else ZONE_DMA32 is
same as ZONE_NORMAL ? So instead of having confusing output for
show_mem(), we now have


Node 0 Normal: 6*64kB (UM) 566*128kB (UEM) 367*256kB (UM) 185*512kB (UM)59*1024kB (UEM) 11*2048kB (UM) 4*4096kB (UM) 3*8192kB (UEM) 4016*16384kB

Node 1 Normal: 42*64kB (UEM) 14*128kB (UEM) 10*256kB (UM) 2*512kB (UM) 6*1024kB (UM) 7*2048kB (UEM) 5*4096kB (UM) 2*8192kB (U) 3644*16384kB (MR) =

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 38fe9c5409be..3a448cdaa22f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -290,7 +290,7 @@ config PPC_EMULATE_SSTEP
 
 config ZONE_DMA32
 	bool
-	default y if PPC64
+	default n
 
 source "init/Kconfig"
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 03511968a9c6..253222ddb308 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -71,6 +71,11 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	}
 
 	switch (zone) {
+#ifdef CONFIG_ZONE_DMA
+	case ZONE_DMA:
+		flag |= GFP_DMA;
+		break;
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	case ZONE_DMA32:
 		flag |= GFP_DMA32;
