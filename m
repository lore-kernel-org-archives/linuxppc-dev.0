Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 688D91A0076
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 11:40:47 +1000 (EST)
In-Reply-To: <20140903122948.28708.22188.stgit@localhost.localdomain>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: fadump: fix endianess issues in firmware assisted dump handling
Message-Id: <20140925014047.3CA0B140143@ozlabs.org>
Date: Thu, 25 Sep 2014 11:40:47 +1000 (EST)
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-09 at 12:29:48 UTC, Hari Bathini wrote:
> Firmware-assisted dump (fadump) kernel code is not LE compliant. The
> below patch tries to fix this issue. Tested this patch with upstream
> kernel. Did some sanity testing for the  LE fadump vmcore generated.
> Below output shows crash tool successfully opening LE fadump vmcore.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

In general I really dislike this kind of endian conversion, ie. where we just
litter the code with endian conversions at every usage site.

But in this case it's probably OK, because we can't really do much better.

> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 742694c..7d73b2d 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -72,7 +72,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>  		return 1;
>  
>  	fw_dump.fadump_supported = 1;
> -	fw_dump.ibm_configure_kernel_dump = *token;
> +	fw_dump.ibm_configure_kernel_dump = be32_to_cpu(*token);

I'm getting a sparse warning here:

  arch/powerpc/kernel/fadump.c:75:45: warning: cast to restricted __be32

I think token should be a __be32 *.

>  	pr_debug("--------CPU State Data------------\n");
> -	pr_debug("Magic Number: %llx\n", reg_header->magic_number);
> -	pr_debug("NumCpuOffset: %x\n", reg_header->num_cpu_offset);
> +	pr_debug("Magic Number: %llx\n", be64_to_cpu(reg_header->magic_number));
> +	pr_debug("NumCpuOffset: %x\n", be32_to_cpu(reg_header->num_cpu_offset));
>  
> -	vaddr += reg_header->num_cpu_offset;
> -	num_cpus = *((u32 *)(vaddr));
> +	vaddr += be32_to_cpu(reg_header->num_cpu_offset);
> +	num_cpus = be32_to_cpu(*((u32 *)(vaddr)));

And here too:

  arch/powerpc/kernel/fadump.c:619:20: warning: cast to restricted __be32

I guess the cast is OK there because you are calculating the offset, but the
cast should be to __be32.


> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 34e6423..587887e 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -43,6 +43,7 @@
>  #include <asm/trace.h>
>  #include <asm/firmware.h>
>  #include <asm/plpar_wrappers.h>
> +#include <asm/fadump.h>
>  
>  #include "pseries.h"
>  
> @@ -249,8 +250,12 @@ static void pSeries_lpar_hptab_clear(void)
>  	}
>  
>  #ifdef __LITTLE_ENDIAN__
> -	/* Reset exceptions to big endian */
> -	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
> +	/*
> +	 * Reset exceptions to big endian
> +	 * During fadump kernel boot, we dont need to reset exception to big endian
> +	 * as we have already booted into LE kernel.
> +	 */
> +	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active()) {
>  		long rc;
>  
>  		rc = pseries_big_endian_exceptions();


It's really unfortunate that we need to inject this knowledge of fadump into
the setup code.

It sounds like we have to do it though, Mahesh said on irc that without it the
system won't boot. Please elaborate on *why* the system won't boot.

And please make the comment much clearer, ie. it's not that we don't need to
reset exceptions to big endian, it's that we *must not* reset them to big
endian.

cheers
