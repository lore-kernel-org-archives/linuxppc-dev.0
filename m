Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BA81B6F77
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 21:10:22 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6CB9rm8012498
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 16:39:53 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6CB9rDP3334264
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 16:39:53 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6CB9qsh014608
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 21:09:53 +1000
Message-ID: <4E1C2B80.1090908@in.ibm.com>
Date: Tue, 12 Jul 2011 16:39:52 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Michal Simek <monstr@monstr.eu>
Subject: Re: [RFC PATCH 7/7] powerpc: Support RELOCATABLE kernel for PPC44x
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
	<1308233668-24166-4-git-send-email-monstr@monstr.eu>
	<1308233668-24166-5-git-send-email-monstr@monstr.eu>
	<1308233668-24166-6-git-send-email-monstr@monstr.eu>
	<1308233668-24166-7-git-send-email-monstr@monstr.eu>
	<1308233668-24166-8-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-8-git-send-email-monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tmarri@apm.com, linuxppc-dev@ozlabs.org, john.williams@petalogix.com,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/11 19:44, Michal Simek wrote:
> Changes:
> - Find out address where kernel runs
> - Create the first 256MB TLB from online detected address
>
> Limitations:
> - Kernel must be aligned to 256MB
>
> Backport:
> - Changes in page.h are backported from newer kernel version
>
> mmu_mapin_ram function has to reflect offset in memory start.
> memstart_addr and kernstart_addr are setup directly from asm
> code to ensure that only ppc44x is affected.
>
> Signed-off-by: Michal Simek<monstr@monstr.eu>
> ---
>   arch/powerpc/Kconfig            |    3 ++-
>   arch/powerpc/include/asm/page.h |    7 ++++++-
>   arch/powerpc/kernel/head_44x.S  |   28 ++++++++++++++++++++++++++++
>   arch/powerpc/mm/44x_mmu.c       |    6 +++++-
>   4 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 45c9683..34c521e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -796,7 +796,8 @@ config LOWMEM_CAM_NUM
>
>   config RELOCATABLE
>   	bool "Build a relocatable kernel (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL&&  ADVANCED_OPTIONS&&  FLATMEM&&  FSL_BOOKE
> +	depends on EXPERIMENTAL&&  ADVANCED_OPTIONS&&  FLATMEM
> +	depends on FSL_BOOKE || (44x&&  !SMP)
>   	help
>   	  This builds a kernel image that is capable of running at the
>   	  location the kernel is loaded at (some alignment restrictions may
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 4940662..e813cc2 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -108,8 +108,13 @@ extern phys_addr_t kernstart_addr;
>   #define pfn_to_kaddr(pfn)	__va((pfn)<<  PAGE_SHIFT)
>   #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr)>>  PAGE_SHIFT)
>
> -#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET - MEMORY_START))
> +#ifdef CONFIG_BOOKE
> +#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + KERNELBASE))
> +#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
> +#else
> +#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + PAGE_OFFSET - MEMORY_START))
>   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + MEMORY_START)
> +#endif
>
>   /*
>    * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index d80ce05..6a63d32 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -59,6 +59,17 @@ _ENTRY(_start);
>   	 * of abatron_pteptrs
>   	 */
>   	nop
> +
> +#ifdef CONFIG_RELOCATABLE
> +	bl	jump                            /* Find our address */
> +	nop
> +jump:	mflr	r25                              /* Make it accessible */
> +	/* just for and */
> +	lis     r26, 0xfffffff0@h
> +	ori     r26, r26, 0xfffffff0@l
> +	and.	r21, r25, r26
> +#endif

Hmm. So we are assuming we are running from a 1:1 mapping at the entry.
It is much more safe to read our tlb entry and use the RPN instead.


> +#ifdef CONFIG_RELOCATABLE
> +	/* load physical address where kernel runs */
> +	mr	r4,r21
> +#else
>   	/* Kernel is at PHYSICAL_START */
>   	lis	r4,PHYSICAL_START@h
>   	ori	r4,r4,PHYSICAL_START@l
> +#endif
>
>   	/* Load the kernel PID = 0 */
>   	li	r0,0
> @@ -258,6 +274,18 @@ skpinv:	addi	r4,r4,1				/* Increment */
>   	mr	r5,r29
>   	mr	r6,r28
>   	mr	r7,r27
> +
> +#ifdef CONFIG_RELOCATABLE
> +	/* save kernel and memory start */
> +	lis	r25,kernstart_addr@h
> +	ori	r25,r25,kernstart_addr@l
> +	stw	r21,4(r25)

1) You have to use ERPN value in the higher word of kernel_start_addr.
2) You have to account for the (KERNEL_BASE - PAGE_OFFSET) shift for kernel_start_addr.

> +
> +	lis	r25,memstart_addr@h
> +	ori	r25,r25,memstart_addr@l
> +	stw	r21,4(r25)

> +#endif
> +

Suzuki
