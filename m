Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEC41DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:29:23 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9MESRk4562604
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 14:28:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9MESRxD3887178
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 15:28:27 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9MESR4B019972
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 15:28:27 +0100
Message-ID: <48FF3889.2030304@linux.vnet.ibm.com>
Date: Wed, 22 Oct 2008 16:28:25 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
In-Reply-To: <1224123753-20907-2-git-send-email-yanok@emcraft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>,
	pvr@emcraft.com, dzu@denx.de, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ilya,
I just tried your patch on my 440 board because it would help us in our 
environment.
Unfortunately I run into a bug on early boot (mark_bootmem).

A log can be found in this mail, this is the bug when running with 64k 
page size.
I tried this with and without your 2/2 265k patch and also with page 
size configured to 16k, the error is the same in all cases.

I used an earlier version of your patch in the past and it worked fine. 
Applying this old patch causes the same problem.
Therefore I expect that there was some other code changed that breaks 
with page size != 4k.

I did not check that in detail yet, but I would be happy for every hint 
I could get to fix this.

=> bootm
## Booting kernel from Legacy Image at 04000000 ...
   Image Name:   Linux-2.6.27-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1512203 Bytes =  1.4 MB
   Load Address: 00400000
   Entry Point:  00400458
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
CPU clock-frequency <- 0x27bc86a4 (667MHz)
CPU timebase-frequency <- 0x27bc86a4 (667MHz)
/plb: clock-frequency <- 9ef21a9 (167MHz)
/plb/opb: clock-frequency <- 4f790d4 (83MHz)
/plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600500: clock-frequency <- 42ecac (4MHz)
/plb/opb/serial@ef600600: clock-frequency <- 42ecac (4MHz)
Memory <- <0x0 0x0 0xffff000> (255MB)
ethernet0: local-mac-address <- 00:10:ec:00:e2:3e
ethernet1: local-mac-address <- 00:10:ec:80:e2:3e

zImage starting: loaded at 0x00400000 (sp: 0x0fe3c820)
Allocating 0x3c54dc bytes for kernel ...
gunzipping (0x00000000 <- 0x0040e000:0x007a2428)...done 0x380a90 bytes

Linux/PowerPC load: console=ttyS0,115200 ip=dhcp 
nfsroot=192.168.1.2:/home/paelzer/ubuntu_ppc.8.04 root=/dev/nfs rw
Finalizing device tree... flat tree at 0x40bed8
Using PowerPC 44x Platform machine description
Linux version 2.6.27-dirty (paelzer@HelionPrime) (gcc version 4.2.3) #5 
Wed Oct 22 15:15:40 CEST 2008
console [udbg0] enabled
------------[ cut here ]------------
Kernel BUG at c02be6cc [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
PowerPC 44x Platform
NIP: c02be6cc LR: c02ba4e4 CTR: 00000000
REGS: c0351eb0 TRAP: 0700   Not tainted  (2.6.27-dirty)
MSR: 00021000 <ME>  CR: 22004022  XER: 0000005f
TASK = c03204a8[0] 'swapper' THREAD: c0350000
GPR00: c02d0a1c c0351f60 c03204a8 00000fff 00001000 00000001 00000000 
00000000
GPR08: e0000000 00000000 ffffffff c02d0a14 22000024 00000000 0ffa6800 
0ffbf000
GPR16: c02ed838 bfe8f45c 00000000 00000000 0ffa7500 0fe3cb20 00000001 
c02d0a1c
GPR24: 00000000 00000001 00001000 00000fff c0390000 00000fff c039d1d0 
c02d0a08
NIP [c02be6cc] mark_bootmem+0xe0/0x124
LR [c02ba4e4] do_init_bootmem+0x134/0x168
Call Trace:
[c0351f60] [c02be6a4] mark_bootmem+0xb8/0x124 (unreliable)
[c0351f90] [c02ba4e4] do_init_bootmem+0x134/0x168
[c0351fb0] [c02b8e00] setup_arch+0x13c/0x1b8
[c0351fc0] [c02b066c] start_kernel+0x94/0x2ac
[c0351ff0] [c00001e8] skpinv+0x190/0x1cc
Instruction dump:
7f07c378 4bfffe15 7c7e1b78 4192000c 2f830000 409e0024 7f9ae000 419e0050
817f0014 83bf0004 3bebffec 4bffff68 <0fe00000> 48000000 7f63db78 7fa4eb78
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..


Ilya Yanok wrote:
> This patch adds support for page sizes bigger than 4K (16K/64K) on
> PPC 44x.
>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Vladimir Panfilov <pvr@emcraft.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/powerpc/Kconfig                   |   26 ++++++++++++++++++++------
>  arch/powerpc/include/asm/highmem.h     |    8 +++++++-
>  arch/powerpc/include/asm/mmu-44x.h     |   18 ++++++++++++++++++
>  arch/powerpc/include/asm/page.h        |   13 ++++++++-----
>  arch/powerpc/include/asm/pgtable.h     |    3 +++
>  arch/powerpc/kernel/asm-offsets.c      |    4 ++++
>  arch/powerpc/kernel/head_44x.S         |   22 +++++++++++++---------
>  arch/powerpc/kernel/misc_32.S          |   12 ++++++------
>  arch/powerpc/mm/pgtable_32.c           |    9 ++-------
>  arch/powerpc/platforms/Kconfig.cputype |    2 +-
>  10 files changed, 82 insertions(+), 35 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 587da5e..9627cfd 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -402,16 +402,30 @@ config PPC_HAS_HASH_64K
>  	depends on PPC64
>  	default n
>
> -config PPC_64K_PAGES
> -	bool "64k page size"
> -	depends on PPC64
> -	select PPC_HAS_HASH_64K
> +choice
> +	prompt "Page size"
> +	default PPC_4K_PAGES
>  	help
> -	  This option changes the kernel logical page size to 64k. On machines
> +	  The PAGE_SIZE definition. Increasing the page size may
> +	  improve the system performance in some dedicated cases like software
> +	  RAID with accelerated calculations. In PPC64 case on machines
>  	  without processor support for 64k pages, the kernel will simulate
>  	  them by loading each individual 4k page on demand transparently,
>  	  while on hardware with such support, it will be used to map
>  	  normal application pages.
> +	  If unsure, set it to 4 KB.
> +
> +config PPC_4K_PAGES
> +	bool "4k page size"
> +
> +config PPC_16K_PAGES
> +	bool "16k page size" if 44x
> +
> +config PPC_64K_PAGES
> +	bool "64k page size" if 44x || PPC64
> +	select PPC_HAS_HASH_64K if PPC64
> +
> +endchoice
>
>  config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order"
> @@ -435,7 +449,7 @@ config FORCE_MAX_ZONEORDER
>
>  config PPC_SUBPAGE_PROT
>  	bool "Support setting protections for 4k subpages"
> -	depends on PPC_64K_PAGES
> +	depends on PPC64 && PPC_64K_PAGES
>  	help
>  	  This option adds support for a system call to allow user programs
>  	  to set access permissions (read/write, readonly, or no access)
> diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
> index 5d99b64..dc1132c 100644
> --- a/arch/powerpc/include/asm/highmem.h
> +++ b/arch/powerpc/include/asm/highmem.h
> @@ -38,9 +38,15 @@ extern pte_t *pkmap_page_table;
>   * easily, subsequent pte tables have to be allocated in one physical
>   * chunk of RAM.
>   */
> +#if defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64)
> +#define PKMAP_ORDER	(27 - PAGE_SHIFT)
> +#define LAST_PKMAP	(1 << PKMAP_ORDER)
> +#define PKMAP_BASE	(FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
> +#else
>  #define LAST_PKMAP 	(1 << PTE_SHIFT)
> -#define LAST_PKMAP_MASK (LAST_PKMAP-1)
>  #define PKMAP_BASE	((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK)
> +#endif
> +#define LAST_PKMAP_MASK	(LAST_PKMAP-1)
>  #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
>  #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
>
> diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
> index a825524..2ca18e8 100644
> --- a/arch/powerpc/include/asm/mmu-44x.h
> +++ b/arch/powerpc/include/asm/mmu-44x.h
> @@ -4,6 +4,8 @@
>   * PPC440 support
>   */
>
> +#include <asm/page.h>
> +
>  #define PPC44x_MMUCR_TID	0x000000ff
>  #define PPC44x_MMUCR_STS	0x00010000
>
> @@ -73,4 +75,20 @@ typedef struct {
>  /* Size of the TLBs used for pinning in lowmem */
>  #define PPC_PIN_SIZE	(1 << 28)	/* 256M */
>
> +#if (PAGE_SHIFT == 12)
> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
> +#elif (PAGE_SHIFT == 14)
> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
> +#elif (PAGE_SHIFT == 16)
> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
> +#else
> +#error "Unsupported PAGE_SIZE"
> +#endif
> +
> +#define PPC44x_PGD_OFF_SHIFT	(32 - PMD_SHIFT + 2)
> +#define PPC44x_PGD_OFF_MASK	(PMD_SHIFT - 2)
> +#define PPC44x_PTE_ADD_SHIFT	(32 - PMD_SHIFT + PTE_SHIFT + 3)
> +#define PPC44x_PTE_ADD_MASK	(32 - 3 - PTE_SHIFT)
> +#define PPC44x_RPN_MASK		(31 - PAGE_SHIFT)
> +
>  #endif /* _ASM_POWERPC_MMU_44X_H_ */
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index e088545..537d5b1 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -15,12 +15,15 @@
>  #include <asm/types.h>
>
>  /*
> - * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
> + * On regular PPC32 page size is 4K (but we support 4K/16K/64K pages
> + * on PPC44x). For PPC64 we support either 4K or 64K software
>   * page size. When using 64K pages however, whether we are really supporting
>   * 64K pages in HW or not is irrelevant to those definitions.
>   */
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES)
>  #define PAGE_SHIFT		16
> +#elif defined(CONFIG_PPC_16K_PAGES)
> +#define PAGE_SHIFT		14
>  #else
>  #define PAGE_SHIFT		12
>  #endif
> @@ -140,7 +143,7 @@ typedef struct { pte_basic_t pte; } pte_t;
>  /* 64k pages additionally define a bigger "real PTE" type that gathers
>   * the "second half" part of the PTE for pseudo 64k pages
>   */
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
>  typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
>  #else
>  typedef struct { pte_t pte; } real_pte_t;
> @@ -180,10 +183,10 @@ typedef pte_basic_t pte_t;
>  #define pte_val(x)	(x)
>  #define __pte(x)	(x)
>
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
>  typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
>  #else
> -typedef unsigned long real_pte_t;
> +typedef pte_t real_pte_t;
>  #endif
>
>
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index dbb8ca1..0d447fb 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -39,6 +39,9 @@ extern void paging_init(void);
>
>  #include <asm-generic/pgtable.h>
>
> +#define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
> +#define PMD_T_LOG2	(__builtin_ffs(sizeof(pmd_t)) - 1)
> +#define PTE_T_LOG2	(__builtin_ffs(sizeof(pte_t)) - 1)
>
>  /*
>   * This gets called at the end of handling a page fault, when
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 92768d3..98b8bb6 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -375,6 +375,10 @@ int main(void)
>  	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
>  	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
>  #endif
> +#ifdef CONFIG_44x
> +	DEFINE(PMD_SHIFT, PMD_SHIFT);
> +	DEFINE(PTE_SHIFT, PTE_SHIFT);
> +#endif
>
>  	return 0;
>  }
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index f3a1ea9..6525124 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -391,12 +391,14 @@ interrupt_base:
>  	rlwimi	r13,r12,10,30,30
>
>  	/* Load the PTE */
> -	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
> +	/* Compute pgdir/pmd offset */
> +	rlwinm  r12, r10, PPC44x_PGD_OFF_SHIFT, PPC44x_PGD_OFF_MASK, 29
>  	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
>  	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
>  	beq	2f			/* Bail if no table */
>
> -	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
> +	/* Compute pte address */
> +	rlwimi  r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK, 28
>  	lwz	r11, 0(r12)		/* Get high word of pte entry */
>  	lwz	r12, 4(r12)		/* Get low word of pte entry */
>
> @@ -485,12 +487,14 @@ tlb_44x_patch_hwater_D:
>  	/* Make up the required permissions */
>  	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
>
> -	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
> +	/* Compute pgdir/pmd offset */
> +	rlwinm 	r12, r10, PPC44x_PGD_OFF_SHIFT, PPC44x_PGD_OFF_MASK, 29
>  	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
>  	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
>  	beq	2f			/* Bail if no table */
>
> -	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
> +	/* Compute pte address */
> +	rlwimi	r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK, 28
>  	lwz	r11, 0(r12)		/* Get high word of pte entry */
>  	lwz	r12, 4(r12)		/* Get low word of pte entry */
>
> @@ -554,15 +558,15 @@ tlb_44x_patch_hwater_I:
>   */
>  finish_tlb_load:
>  	/* Combine RPN & ERPN an write WS 0 */
> -	rlwimi	r11,r12,0,0,19
> +	rlwimi	r11,r12,0,0,PPC44x_RPN_MASK
>  	tlbwe	r11,r13,PPC44x_TLB_XLAT
>
>  	/*
>  	 * Create WS1. This is the faulting address (EPN),
>  	 * page size, and valid flag.
>  	 */
> -	li	r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
> -	rlwimi	r10,r11,0,20,31			/* Insert valid and page size*/
> +	li	r11,PPC44x_TLB_VALID | PPC44x_TLBE_SIZE
> +	rlwimi	r10,r11,0,PPC44x_PTE_ADD_MASK,31/* Insert valid and page size*/
>  	tlbwe	r10,r13,PPC44x_TLB_PAGEID	/* Write PAGEID */
>
>  	/* And WS 2 */
> @@ -634,12 +638,12 @@ _GLOBAL(set_context)
>   * goes at the beginning of the data segment, which is page-aligned.
>   */
>  	.data
> -	.align	12
> +	.align	PAGE_SHIFT
>  	.globl	sdata
>  sdata:
>  	.globl	empty_zero_page
>  empty_zero_page:
> -	.space	4096
> +	.space	PAGE_SIZE
>
>  /*
>   * To support >32-bit physical addresses, we use an 8KB pgdir.
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index 7a6dfbc..0110fcd 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -589,8 +589,8 @@ _GLOBAL(__flush_dcache_icache)
>  BEGIN_FTR_SECTION
>  	blr
>  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> -	rlwinm	r3,r3,0,0,19			/* Get page base address */
> -	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
> +	rlwinm	r3,r3,0,0,PPC44x_RPN_MASK	/* Get page base address */
> +	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
>  	mtctr	r4
>  	mr	r6,r3
>  0:	dcbst	0,r3				/* Write line to ram */
> @@ -630,8 +630,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  	rlwinm	r0,r10,0,28,26			/* clear DR */
>  	mtmsr	r0
>  	isync
> -	rlwinm	r3,r3,0,0,19			/* Get page base address */
> -	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
> +	rlwinm	r3,r3,0,0,PPC44x_RPN_MASK	/* Get page base address */
> +	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
>  	mtctr	r4
>  	mr	r6,r3
>  0:	dcbst	0,r3				/* Write line to ram */
> @@ -655,7 +655,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>   * void clear_pages(void *page, int order) ;
>   */
>  _GLOBAL(clear_pages)
> -	li	r0,4096/L1_CACHE_BYTES
> +	li	r0,PAGE_SIZE/L1_CACHE_BYTES
>  	slw	r0,r0,r4
>  	mtctr	r0
>  #ifdef CONFIG_8xx
> @@ -713,7 +713,7 @@ _GLOBAL(copy_page)
>  	dcbt	r5,r4
>  	li	r11,L1_CACHE_BYTES+4
>  #endif /* MAX_COPY_PREFETCH */
> -	li	r0,4096/L1_CACHE_BYTES - MAX_COPY_PREFETCH
> +	li	r0,PAGE_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
>  	crclr	4*cr0+eq
>  2:
>  	mtctr	r0
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 2001abd..4eed001 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -72,12 +72,7 @@ extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
>  #define p_mapped_by_tlbcam(x)	(0UL)
>  #endif /* HAVE_TLBCAM */
>
> -#ifdef CONFIG_PTE_64BIT
> -/* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
> -#define PGDIR_ORDER	1
> -#else
> -#define PGDIR_ORDER	0
> -#endif
> +#define PGDIR_ORDER	max(32 + PGD_T_LOG2 - PGDIR_SHIFT - PAGE_SHIFT, 0)
>
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> @@ -400,7 +395,7 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
>
>  static int fixmaps;
> -unsigned long FIXADDR_TOP = 0xfffff000;
> +unsigned long FIXADDR_TOP = (-PAGE_SIZE);
>  EXPORT_SYMBOL(FIXADDR_TOP);
>
>  void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 7f65127..a1386a4 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -202,7 +202,7 @@ config PPC_STD_MMU_32
>
>  config PPC_MM_SLICES
>  	bool
> -	default y if HUGETLB_PAGE || PPC_64K_PAGES
> +	default y if HUGETLB_PAGE || (PPC64 && PPC_64K_PAGES)
>  	default n
>
>  config VIRT_CPU_ACCOUNTING
>   


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
