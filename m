Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF1DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 08:32:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF67214AF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 08:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="CpoTNpFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF67214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JSrS6fcSzDqJH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 19:32:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="CpoTNpFb"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JSpY52Z0zDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 19:30:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44JSpM0SCQz9v15c;
 Tue, 12 Mar 2019 09:30:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=CpoTNpFb; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FLy-hoINyza0; Tue, 12 Mar 2019 09:30:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44JSpL6Bk8z9v15b;
 Tue, 12 Mar 2019 09:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552379418; bh=1myz5J8ZVLszeIL92W/atiC/QXM6CN8DPieqkg4zSng=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=CpoTNpFblZmkjqesat0Xy6EZ//r82bnYoh5WXl7dL+i3odVvAbxxF2q9jkdNaCCm5
 viNr08e+npSXCC5oiiiMyM9zMgk/pRqN6nGf0ojHGsuwUWui2osr2LCoseYG7Dx4Rz
 m0nS+m22OaXkvxQhU2K7Niy8U3fecpt8T8OazsKk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C439F8B881;
 Tue, 12 Mar 2019 09:30:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6S7V69fL3TR3; Tue, 12 Mar 2019 09:30:14 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4609E8B896;
 Tue, 12 Mar 2019 09:30:14 +0100 (CET)
Subject: Re: [RFCv2 PATCH 4/4] powerpc: KASAN for 64bit Book3E
To: Daniel Axtens <dja@axtens.net>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
References: <20190312012348.4854-1-dja@axtens.net>
 <20190312012348.4854-5-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7a65ee5d-06d2-eed1-1039-428a5437018a@c-s.fr>
Date: Tue, 12 Mar 2019 08:30:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190312012348.4854-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Build failure with pmac32_defconfig.

   CC      arch/powerpc/kernel/asm-offsets.s
In file included from ./arch/powerpc/include/asm/book3s/32/pgtable.h:149:0,
                  from ./arch/powerpc/include/asm/book3s/pgtable.h:8,
                  from ./arch/powerpc/include/asm/pgtable.h:18,
                  from ./arch/powerpc/include/asm/kasan.h:18,
                  from ./include/linux/kasan.h:14,
                  from ./include/linux/slab.h:129,
                  from ./include/linux/crypto.h:24,
                  from ./include/crypto/hash.h:16,
                  from ./include/linux/uio.h:14,
                  from ./include/linux/socket.h:8,
                  from ./include/linux/compat.h:15,
                  from arch/powerpc/kernel/asm-offsets.c:18:
./include/asm-generic/fixmap.h: In function ‘fix_to_virt’:
./arch/powerpc/include/asm/fixmap.h:27:22: error: ‘KASAN_SHADOW_START’ 
undeclared (first use in this function)
  #define FIXADDR_TOP (KASAN_SHADOW_START - PAGE_SIZE)
                       ^
./include/asm-generic/fixmap.h:21:27: note: in expansion of macro 
‘FIXADDR_TOP’
  #define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
                            ^
./include/asm-generic/fixmap.h:33:9: note: in expansion of macro 
‘__fix_to_virt’
   return __fix_to_virt(idx);
          ^
./arch/powerpc/include/asm/fixmap.h:27:22: note: each undeclared 
identifier is reported only once for each function it appears in
  #define FIXADDR_TOP (KASAN_SHADOW_START - PAGE_SIZE)
                       ^
./include/asm-generic/fixmap.h:21:27: note: in expansion of macro 
‘FIXADDR_TOP’
  #define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
                            ^
./include/asm-generic/fixmap.h:33:9: note: in expansion of macro 
‘__fix_to_virt’
   return __fix_to_virt(idx);
          ^
In file included from ./include/linux/bug.h:5:0,
                  from ./include/linux/thread_info.h:12,
                  from ./include/asm-generic/preempt.h:5,
                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
                  from ./include/linux/preempt.h:78,
                  from ./include/linux/spinlock.h:51,
                  from ./include/linux/seqlock.h:36,
                  from ./include/linux/time.h:6,
                  from ./include/linux/compat.h:10,
                  from arch/powerpc/kernel/asm-offsets.c:18:
./include/asm-generic/fixmap.h: In function ‘virt_to_fix’:
./arch/powerpc/include/asm/fixmap.h:27:22: error: ‘KASAN_SHADOW_START’ 
undeclared (first use in this function)
  #define FIXADDR_TOP (KASAN_SHADOW_START - PAGE_SIZE)
                       ^
./arch/powerpc/include/asm/bug.h:76:27: note: in definition of macro 
‘BUG_ON’
   if (__builtin_constant_p(x)) {    \
                            ^
./include/asm-generic/fixmap.h:38:18: note: in expansion of macro 
‘FIXADDR_TOP’
   BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
                   ^
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Christophe

On 03/12/2019 01:23 AM, Daniel Axtens wrote:
> Wire up KASAN. Only outline instrumentation is supported.
> 
> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> To do this we require that vmemmap be disabled. (This is the default
> in the kernel config that QorIQ provides for the machine in their
> SDK anyway - they use flat memory.)
> 
> Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
> ioremap areas (also in 0x800...) are all mapped to the zero page. As
> with the Book3S hash series, this requires overriding the memory <->
> shadow mapping.
> 
> Also, as with both previous 64-bit series, early instrumentation is not
> supported.  It would allow us to drop the check_return_arch_not_ready()
> hook in the KASAN core, but it's tricky to get it set up early enough:
> we need it setup before the first call to instrumented code like printk().
> Perhaps in the future.
> 
> Only KASAN_MINIMAL works.
> 
> Tested on e6500. KVM, kexec and xmon have not been tested.
> 
> The test_kasan module fires warnings as expected, except for the
> following tests:
> 
>   - Expected/by design:
> kasan test: memcg_accounted_kmem_cache allocate memcg accounted object
> 
>   - Due to only supporting KASAN_MINIMAL:
> kasan test: kasan_stack_oob out-of-bounds on stack
> kasan test: kasan_global_oob out-of-bounds global variable
> kasan test: kasan_alloca_oob_left out-of-bounds to left on alloca
> kasan test: kasan_alloca_oob_right out-of-bounds to right on alloca
> kasan test: use_after_scope_test use-after-scope on int
> kasan test: use_after_scope_test use-after-scope on array
> 
> Thanks to those who have done the heavy lifting over the past several years:
>   - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
>   - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
>   - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> While useful if you have a book3e device, this is mostly intended
> as a warm-up exercise for reviving Aneesh's series for book3s hash.
> In particular, changes to the kasan core are going to be required
> for hash and radix as well.
> ---
>   arch/powerpc/Kconfig                         |  1 +
>   arch/powerpc/Kconfig.debug                   |  2 +-
>   arch/powerpc/include/asm/kasan.h             | 73 +++++++++++++++++++-
>   arch/powerpc/mm/Makefile                     |  2 +
>   arch/powerpc/mm/kasan/Makefile               |  1 +
>   arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 53 ++++++++++++++
>   6 files changed, 129 insertions(+), 3 deletions(-)
>   create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8d6108c83299..01540873a79f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -173,6 +173,7 @@ config PPC
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_KASAN			if PPC32
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 61febbbdd02b..fc1f5fa7554e 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -369,5 +369,5 @@ config PPC_FAST_ENDIAN_SWITCH
>   
>   config KASAN_SHADOW_OFFSET
>   	hex
> -	depends on KASAN
> +	depends on KASAN && PPC32
>   	default 0xe0000000
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index e4adc6bc1e8f..661a5700869b 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -15,14 +15,16 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <asm/page.h>
> +#include <asm/pgtable.h>
>   
>   #define KASAN_SHADOW_SCALE_SHIFT	3
>   
> -#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
> -
>   #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
>   				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
>   
> +#ifdef CONFIG_PPC32
> +#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
> +
>   #define KASAN_SHADOW_END	0UL
>   
>   #define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
> @@ -30,6 +32,73 @@
>   #ifdef CONFIG_KASAN
>   void kasan_early_init(void);
>   void kasan_mmu_init(void);
> +#endif
> +#endif /* CONFIG_PPC32 */
> +
> +#ifdef CONFIG_PPC_BOOK3E_64
> +
> +/* we don't put this in Kconfig as we only support KASAN_MINIMAL, and
> + * that will be disabled if the symbol is availabe in Kconfig */
> +#define KASAN_SHADOW_OFFSET ASM_CONST(0x6800040000000000)
> +
> +#define KASAN_SHADOW_SIZE	(KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +
> +extern struct static_key_false powerpc_kasan_enabled_key;
> +static inline bool kasan_arch_is_ready_book3e(void) {
> +	if (static_branch_likely(&powerpc_kasan_enabled_key))
> +				return true;
> +	return false;
> +}
> +#define kasan_arch_is_ready kasan_arch_is_ready_book3e
> +
> +extern unsigned char kasan_zero_page[PAGE_SIZE];
> +static inline void *kasan_mem_to_shadow_book3e(const void *addr)
> +{
> +	if ((unsigned long)addr >= KERN_VIRT_START &&
> +		(unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
> +		return (void *)kasan_zero_page;
> +	}
> +
> +	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> +		+ KASAN_SHADOW_OFFSET;
> +}
> +#define kasan_mem_to_shadow kasan_mem_to_shadow_book3e
> +
> +static inline void *kasan_shadow_to_mem_book3e(const void *shadow_addr)
> +{
> +	/*
> +	 * We map the entire non-linear virtual mapping onto the zero page so if
> +	 * we are asked to map the zero page back just pick the beginning of that
> +	 * area.
> +	 */
> +	if (shadow_addr >= (void *)kasan_zero_page &&
> +		shadow_addr < (void *)(kasan_zero_page + PAGE_SIZE)) {
> +		return (void *)KERN_VIRT_START;
> +	}
> +
> +	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
> +		<< KASAN_SHADOW_SCALE_SHIFT);
> +}
> +#define kasan_shadow_to_mem kasan_shadow_to_mem_book3e
> +
> +static inline bool kasan_addr_has_shadow_book3e(const void *addr)
> +{
> +	/*
> +	 * We want to specifically assert that the addresses in the 0x8000...
> +	 * region have a shadow, otherwise they are considered by the kasan
> +	 * core to be wild pointers
> +	 */
> +	if ((unsigned long)addr >= KERN_VIRT_START &&
> +		(unsigned long)addr < (KERN_VIRT_START + KERN_VIRT_SIZE)) {
> +		return true;
> +	}
> +	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> +}
> +#define kasan_addr_has_shadow kasan_addr_has_shadow_book3e
> +
> +#endif /* CONFIG_PPC_BOOK3E_64 */
> +
> +#ifdef CONFIG_KASAN
>   void kasan_init(void);
>   #else
>   static inline void kasan_init(void) { }
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 80382a2d169b..fc49231f807c 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -8,9 +8,11 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>   CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>   
>   KASAN_SANITIZE_ppc_mmu_32.o := n
> +KASAN_SANITIZE_fsl_booke_mmu.o := n
>   
>   ifdef CONFIG_KASAN
>   CFLAGS_ppc_mmu_32.o  		+= -DDISABLE_BRANCH_PROFILING
> +CFLAGS_fsl_booke_mmu.o		+= -DDISABLE_BRANCH_PROFILING
>   endif
>   
>   obj-y				:= fault.o mem.o pgtable.o mmap.o \
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> index 6577897673dd..f8f164ad8ade 100644
> --- a/arch/powerpc/mm/kasan/Makefile
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -3,3 +3,4 @@
>   KASAN_SANITIZE := n
>   
>   obj-$(CONFIG_PPC32)           += kasan_init_32.o
> +obj-$(CONFIG_PPC_BOOK3E_64)   += kasan_init_book3e_64.o
> diff --git a/arch/powerpc/mm/kasan/kasan_init_book3e_64.c b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> new file mode 100644
> index 000000000000..93b9afcf1020
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> +EXPORT_SYMBOL(powerpc_kasan_enabled_key);
> +unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
> +
> +static void __init kasan_init_region(struct memblock_region *reg)
> +{
> +	void *start = __va(reg->base);
> +	void *end = __va(reg->base + reg->size);
> +	unsigned long k_start, k_end, k_cur;
> +
> +	if (start >= end)
> +		return;
> +
> +	k_start = (unsigned long)kasan_mem_to_shadow(start);
> +	k_end = (unsigned long)kasan_mem_to_shadow(end);
> +
> +	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
> +		void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		map_kernel_page(k_cur, __pa(va), PAGE_KERNEL);
> +	}
> +	flush_tlb_kernel_range(k_start, k_end);
> +}
> +
> +void __init kasan_init(void)
> +{
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg)
> +		kasan_init_region(reg);
> +
> +	/* map the zero page RO */
> +	map_kernel_page((unsigned long)kasan_zero_page,
> +					__pa(kasan_zero_page), PAGE_KERNEL_RO);
> +
> +	kasan_init_tags();
> +
> +	/* Turn on checking */
> +	static_branch_inc(&powerpc_kasan_enabled_key);
> +
> +	/* Enable error messages */
> +	init_task.kasan_depth = 0;
> +	pr_info("KASAN init done (64-bit Book3E)\n");
> +}
> 
