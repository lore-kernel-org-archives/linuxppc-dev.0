Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KQfV3032zDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 01:56:17 +1000 (AEST)
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
 <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
Message-ID: <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
Date: Tue, 25 Sep 2018 17:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Snowpatch reports failure on pmac32_defconfig, as follows:

arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88: 
undefined reference to `__stack_chk_fail_local'
arch/powerpc/platforms/powermac/bootx_init.o: In function 
`bootx_add_display_props':
/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:211: 
undefined reference to `__stack_chk_fail_local'
arch/powerpc/platforms/powermac/bootx_init.o: In function 
`bootx_scan_dt_build_struct':
/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:350: 
undefined reference to `__stack_chk_fail_local'
arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_init':
/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:598: 
undefined reference to `__stack_chk_fail_local'
ld: .tmp_vmlinux1: hidden symbol `__stack_chk_fail_local' isn't defined
ld: final link failed: Bad value
Makefile:1040: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

I don't have this issue with GCC 8.1, bootx_init.o has references to 
__stack_chk_fail, not to __stack_chk_fail_local

Looking online, it may be due to an old build and a lack of 'make 
clean', could it be the case here ?

Otherwise, can you retry the build to see if it's happen again ?

Christophe

Le 24/09/2018 à 17:15, Christophe Leroy a écrit :
> On PPC64, as register r13 points to the paca_struct at all time,
> this patch adds a copy of the canary there, which is copied at
> task_switch.
> That new canary is then used by using the following GCC options:
> -mstack-protector-guard=tls
> -mstack-protector-guard-reg=r13
> -mstack-protector-guard-offset=offsetof(struct paca_struct, canary))
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/Kconfig                      | 2 +-
>   arch/powerpc/Makefile                     | 8 ++++++++
>   arch/powerpc/include/asm/paca.h           | 3 +++
>   arch/powerpc/include/asm/stackprotector.h | 3 +++
>   arch/powerpc/kernel/asm-offsets.c         | 3 +++
>   arch/powerpc/kernel/entry_64.S            | 4 ++++
>   6 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3bcb05929931..602eea723624 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -180,7 +180,7 @@ config PPC
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_CBPF_JIT			if !PPC64
> -	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls) && PPC32
> +	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls)
>   	select HAVE_CONTEXT_TRACKING		if PPC64
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DEBUG_STACKOVERFLOW
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 45b8eb4d8fe7..81552c7b46eb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -113,7 +113,11 @@ KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>   endif
>   
>   cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
> +ifdef CONFIG_PPC64
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r13
> +else
>   cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
> +endif
>   
>   LDFLAGS_vmlinux-y := -Bstatic
>   LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> @@ -411,8 +415,12 @@ ifdef CONFIG_STACKPROTECTOR
>   prepare: stack_protector_prepare
>   
>   stack_protector_prepare: prepare0
> +ifdef CONFIG_PPC64
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
> +else
>   	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
>   endif
> +endif
>   
>   # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
>   # to stdout and these checks are run even on install targets.
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 6d6b3706232c..98d883e58945 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -246,6 +246,9 @@ struct paca_struct {
>   	struct slb_entry *mce_faulty_slbs;
>   	u16 slb_save_cache_ptr;
>   #endif /* CONFIG_PPC_BOOK3S_64 */
> +#ifdef CONFIG_STACKPROTECTOR
> +	unsigned long canary;
> +#endif
>   } ____cacheline_aligned;
>   
>   extern struct paca_struct **paca_ptrs;
> diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
> index 263e2aab1862..e81991955c0d 100644
> --- a/arch/powerpc/include/asm/stackprotector.h
> +++ b/arch/powerpc/include/asm/stackprotector.h
> @@ -29,6 +29,9 @@ static __always_inline void boot_init_stack_canary(void)
>   	canary ^= LINUX_VERSION_CODE;
>   
>   	current->stack_canary = canary;
> +#ifdef CONFIG_PPC64
> +	get_paca()->canary = canary;
> +#endif
>   }
>   
>   #endif	/* _ASM_STACKPROTECTOR_H */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index a992f7a53cf3..773dee55b3f6 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -81,6 +81,9 @@ int main(void)
>   	OFFSET(MM, task_struct, mm);
>   #ifdef CONFIG_STACKPROTECTOR
>   	OFFSET(TASK_CANARY, task_struct, stack_canary);
> +#ifdef CONFIG_PPC64
> +	OFFSET(PACA_CANARY, paca_struct, canary);
> +#endif
>   #endif
>   	OFFSET(MMCONTEXTID, mm_struct, context.id);
>   #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 77a888bfcb53..573fa879d785 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -624,6 +624,10 @@ _GLOBAL(_switch)
>   
>   	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
>   	std	r6,PACACURRENT(r13)	/* Set new 'current' */
> +#if defined(CONFIG_STACKPROTECTOR)
> +	ld	r6, TASK_CANARY(r6)
> +	std	r6, PACA_CANARY(r13)
> +#endif
>   
>   	ld	r8,KSP(r4)	/* new stack pointer */
>   #ifdef CONFIG_PPC_BOOK3S_64
> 
