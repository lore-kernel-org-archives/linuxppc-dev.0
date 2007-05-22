Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9D684DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:30:09 +1000 (EST)
Date: Tue, 22 May 2007 10:34:19 -0500
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: [Patch 2/2] Kexec/Kdump support POWER6
Message-ID: <20070522153419.GA22047@lixom.net>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4652E17C.7080607@in.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller II <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, May 22, 2007 at 05:56:36PM +0530, Sachin P. Sant wrote:
> On Power machines supporting VRMA, Kexec/Kdump does not work.
> Hypervisor stores VRMA mapping used by the OS, in the hpte hash
> tables. Make sure these hpte entries are left untouched.

> diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/kernel/machine_kexec_64.c linux-2.6.22-rc2-p6/arch/powerpc/kernel/machine_kexec_64.c
> --- linux-2.6.22-rc2-vrma/arch/powerpc/kernel/machine_kexec_64.c	2007-05-21 15:14:58.000000000 +0530
> +++ linux-2.6.22-rc2-p6/arch/powerpc/kernel/machine_kexec_64.c	2007-05-21 15:19:14.000000000 +0530
> @@ -279,6 +279,9 @@ void default_machine_kexec(struct kimage
>  	kexec_stack.thread_info.task = current_thread_info()->task;
>  	kexec_stack.thread_info.flags = 0;
>  
> +	if (have_vrma)
> +		pSeries_find_hpte_vrma();
> +

This will break kexec builds on non-pseries. It's referring to platform
code that might not be built.

>  	/* Some things are best done in assembly.  Finding globals with
>  	 * a toc is easier in C, so pass in what we can.
>  	 */
> diff -Naurp linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c linux-2.6.22-rc2-p6/arch/powerpc/platforms/pseries/lpar.c
> --- linux-2.6.22-rc2-vrma/arch/powerpc/platforms/pseries/lpar.c	2007-05-21 15:14:57.000000000 +0530
> +++ linux-2.6.22-rc2-p6/arch/powerpc/platforms/pseries/lpar.c	2007-05-22 15:53:11.000000000 +0530
> @@ -369,6 +369,56 @@ static long pSeries_lpar_hpte_remove(uns
>  	return -1;
>  }
>  
> +unsigned long hpte_vrma_slots[HPTE_V_RMA_NUM];
> +unsigned int num_hpte_vrma_slots = 0;
> +
> +void pSeries_find_hpte_vrma(void)

Does this function find the vrma, or save it away? Seems like the name
is misleading.

> +{
> +	unsigned int step;
> +	unsigned long hash, slot, vaddr;
> +	unsigned long dword0, dummy1, rma_size;
> +	long lpar_rc;
> +	int i;
> +	
> +	/* Get the RMA size */
> +	rma_size = lmb.rmo_size;
> +	
> +	/* Get the VRMA page size */	
> +	step = 1 << ppc64_vrma_page_size;

Is ppc64_vrma_page_size really the size, or the shift? Above would
indicate that it's really a shift value.

> +
> +	vaddr = HPTE_V_RMA_VPN + rma_size;
> +
> +	/* Find hpte's with VRMA mappings */
> +	for (; vaddr >= HPTE_V_RMA_VPN; vaddr -= step) {
> +		hash = hpt_hash(vaddr, mmu_psize_defs[MMU_PAGE_16M].shift);

Why is 16M hardcoded here, when you're taking such great care to read
out the pagesize earlier?

> +		slot = ((hash & htab_hash_mask) * HPTES_PER_GROUP);	
> +
> +		for (i = 0; i < HPTES_PER_GROUP; i++) {
> +			lpar_rc = plpar_pte_read(0, slot, 
> +						&dword0, &dummy1);
> +			if (!lpar_rc && dword0 &&
> +			((dword0 & HPTE_V_MASK) == MAGIC_SKIP_HPTE)) {

Indentation

> +				/* store the hpte */
> +				hpte_vrma_slots[num_hpte_vrma_slots++] = slot;

Here you rely on global exported state (num_hpte_vrma_slots), increasing it without
checking for limits. What happens if this function is ever called twice? Should you
set it to 0 in the beginning of the function and check it against the size of the
hpte_vrma_slots array instead?

> +				break;
> +			}
> +			slot++;
> +		}
> +	}
> +}
> +
> +static inline int check_vrma_slot(int slot)
> +{
> +	int j;
> +
> +	for (j = 0; j < num_hpte_vrma_slots; j++)
> +		if (hpte_vrma_slots[j] == slot) 
> +			return 1;
> +
> +	return 0;
> +
> +}
> +
>  static void pSeries_lpar_hptab_clear(void)
>  {
>  	unsigned long size_bytes = 1UL << ppc64_pft_size;
> @@ -377,8 +427,12 @@ static void pSeries_lpar_hptab_clear(voi
>  	int i;
>  
>  	/* TODO: Use bulk call */
> -	for (i = 0; i < hpte_count; i++)
> +	for (i = 0; i < hpte_count; i++) {
> +		if (have_vrma && check_vrma_slot(i))
> +			/* You don't want to remove this hpte */
> +			continue;
>  		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +	}
>  }
>  
>  /*
> diff -Naurp linux-2.6.22-rc2-vrma/include/asm-powerpc/kexec.h linux-2.6.22-rc2-p6/include/asm-powerpc/kexec.h
> --- linux-2.6.22-rc2-vrma/include/asm-powerpc/kexec.h	2007-05-21 15:14:55.000000000 +0530
> +++ linux-2.6.22-rc2-p6/include/asm-powerpc/kexec.h	2007-05-21 15:19:14.000000000 +0530
> @@ -24,6 +24,8 @@
>  
>  #define KEXEC_CONTROL_CODE_SIZE 4096
>  
> +extern void pSeries_find_hpte_vrma(void);
> +

Same comment as above: This isn't a kexec function as much as a pseries function, so
it should be defined in some other header instead.

>  /* The native architecture */
>  #ifdef __powerpc64__
>  #define KEXEC_ARCH KEXEC_ARCH_PPC64
> diff -Naurp linux-2.6.22-rc2-vrma/include/asm-powerpc/mmu-hash64.h linux-2.6.22-rc2-p6/include/asm-powerpc/mmu-hash64.h
> --- linux-2.6.22-rc2-vrma/include/asm-powerpc/mmu-hash64.h	2007-05-21 15:14:55.000000000 +0530
> +++ linux-2.6.22-rc2-p6/include/asm-powerpc/mmu-hash64.h	2007-05-21 15:23:31.000000000 +0530
> @@ -94,6 +94,11 @@ extern char initial_stab[];
>  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
>  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
>  
> +#define HPTE_V_RMA_VPN         ASM_CONST(0x001FFFFFF0000000)
> +#define HPTE_V_MASK            ASM_CONST(0xc000000000000000)
> +#define MAGIC_SKIP_HPTE        ASM_CONST(0x4000000000000000)
> +#define HPTE_V_RMA_NUM         16

"MAGIC_SKIP_HPTE"? I'm sure there's a proper name for this field in the
PAPR, isn't there? Also, HPTE_V_RMA_NUM isn't a HPTE_V field, it shouldn't
have that prefix. It's not a property of the mmu in the first place.

These should maybe be local defines in the pseries lpar code instead, since it's
more of a lpar<->phyp interface than mmu programming interface.


-Olof
