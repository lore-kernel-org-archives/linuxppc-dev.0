Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1797B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 19:44:39 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix hypervisor TLB batching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091012074734.GB4808@kryten>
References: <20091012074734.GB4808@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Oct 2009 19:44:33 +1100
Message-Id: <1255337073.2192.113.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-12 at 18:47 +1100, Anton Blanchard wrote:
> Profiling of a page fault scalability microbenchmark shows flush_hash_range
> is not calling the batch hpte invalidate hcall (H_BULK_REMOVE).
>
> It turns out we have a duplicate firmware feature for hcall-bulk and the
> current setup code stops after finding the first match. This meant we never
> batch and always do individual invalidates.
> 
> The patch below removes the duplicate and shifts FW_FEATURE_CMO to close
> the gap. With the patch applied the single threaded page fault rate improves
> from 217169 to 238755 per second on a POWER5 test box, a 10% improvement.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---

Good catch !

Ben.

> Index: linux.trees.git/arch/powerpc/include/asm/firmware.h
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/include/asm/firmware.h	2009-10-12 18:11:56.000000000 +1100
> +++ linux.trees.git/arch/powerpc/include/asm/firmware.h	2009-10-12 18:21:20.000000000 +1100
> @@ -37,7 +37,7 @@
>  #define FW_FEATURE_VIO		ASM_CONST(0x0000000000004000)
>  #define FW_FEATURE_RDMA		ASM_CONST(0x0000000000008000)
>  #define FW_FEATURE_LLAN		ASM_CONST(0x0000000000010000)
> -#define FW_FEATURE_BULK		ASM_CONST(0x0000000000020000)
> +#define FW_FEATURE_BULK_REMOVE	ASM_CONST(0x0000000000020000)
>  #define FW_FEATURE_XDABR	ASM_CONST(0x0000000000040000)
>  #define FW_FEATURE_MULTITCE	ASM_CONST(0x0000000000080000)
>  #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
> @@ -45,8 +45,7 @@
>  #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
>  #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
>  #define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
> -#define FW_FEATURE_BULK_REMOVE	ASM_CONST(0x0000000002000000)
> -#define FW_FEATURE_CMO		ASM_CONST(0x0000000004000000)
> +#define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -58,8 +57,9 @@ enum {
>  		FW_FEATURE_PERF | FW_FEATURE_DUMP | FW_FEATURE_INTERRUPT |
>  		FW_FEATURE_MIGRATE | FW_FEATURE_PERFMON | FW_FEATURE_CRQ |
>  		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
> -		FW_FEATURE_BULK | FW_FEATURE_XDABR | FW_FEATURE_MULTITCE |
> -		FW_FEATURE_SPLPAR | FW_FEATURE_LPAR | FW_FEATURE_CMO,
> +		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
> +		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
> +		FW_FEATURE_CMO,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
>  	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
> Index: linux.trees.git/arch/powerpc/platforms/pseries/firmware.c
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/platforms/pseries/firmware.c	2009-10-12 18:08:37.000000000 +1100
> +++ linux.trees.git/arch/powerpc/platforms/pseries/firmware.c	2009-10-12 18:12:54.000000000 +1100
> @@ -51,11 +51,10 @@ firmware_features_table[FIRMWARE_MAX_FEA
>  	{FW_FEATURE_VIO,		"hcall-vio"},
>  	{FW_FEATURE_RDMA,		"hcall-rdma"},
>  	{FW_FEATURE_LLAN,		"hcall-lLAN"},
> -	{FW_FEATURE_BULK,		"hcall-bulk"},
> +	{FW_FEATURE_BULK_REMOVE,	"hcall-bulk"},
>  	{FW_FEATURE_XDABR,		"hcall-xdabr"},
>  	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
>  	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
> -	{FW_FEATURE_BULK_REMOVE,	"hcall-bulk"},
>  };
>  
>  /* Build up the firmware features bitmask using the contents of
