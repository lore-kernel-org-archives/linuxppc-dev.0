Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id D7C2AB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 19:07:30 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit physical
	addr
Message-Id: <20100708-mitltonm-msm-reply@mdm.bga.com>
In-Reply-To: <1278535881-6463-1-git-send-email-msm@freescale.com>
References: <1278535881-6463-1-git-send-email-msm@freescale.com>
Date: Thu, 08 Jul 2010 04:07:23 -0500
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 07 Jul 2010 around 10:51:20 -0000 Matthew McClintock wrote:
> 
> Fix sizes of variables so correct values are exported via /proc.
> Cast variable in comparison to avoid compiler error.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> 
>  
> -	csize = min(csize, PAGE_SIZE);
> +	csize = min(csize, (size_t)PAGE_SIZE);

no use min_t

>  
> -	if (pfn < max_pfn) {
> +	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
>  		vaddr = __va(pfn << PAGE_SHIFT);
>  		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
>  	} else {
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index bb3d893..ec7f054 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -145,6 +145,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
>  
>  /* Values we need to export to the second kernel via the device tree. */
>  static unsigned long kernel_end;
> +static unsigned long crashk_start;
>  static unsigned long crashk_size;
>  
>  static struct property kernel_end_prop = {
> @@ -156,7 +157,7 @@ static struct property kernel_end_prop = {
>  static struct property crashk_base_prop = {
>  	.name = "linux,crashkernel-base",
>  	.length = sizeof(unsigned long),
> -	.value = &crashk_res.start,
> +	.value = &crashk_start,
>  };
>  

This is wrong, its truncating the start and size.

Change the variables to be physaddr_t and the length to be sizeof(physaddr_t).

Since these properites only contain one variable, the number of cells
can be inferred from the property size like we do for reading the initrd-size.

Technically they should be an array of be32 but we can make that a comment.

By the way, why does 32 bit care about the running kernel's size? aka
linux,kernel-end?  64 bit book 3S needs it because we use mmu hooks
to copy the pages to their destination, but I thought ppc32 was using
a relocatable copy routine.  Are we missing the code to create
temp ref tlbs on the fly for book 3E?

>  static struct property crashk_size_prop = {
> @@ -180,6 +181,7 @@ static void __init export_crashk_values(struct device_node *node)
>  		prom_remove_property(node, prop);
>  
>  	if (crashk_res.start != 0) {
> +		crashk_start = crashk_res.start;
>  		prom_add_property(node, &crashk_base_prop);
>  		crashk_size = crashk_res.end - crashk_res.start + 1;
>  		prom_add_property(node, &crashk_size_prop);

I guess we use the reuse of the resources varables, but such is
common code vs userspace.

milton
