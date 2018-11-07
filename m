Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF1C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773532081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773532081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qtGT28rjzF3Bx
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 04:10:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qtD80srZzDr4F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 04:08:39 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qtD22HTjz9tvrk;
 Wed,  7 Nov 2018 18:08:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id n2rcrPGrglSK; Wed,  7 Nov 2018 18:08:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qtD21j7xz9tvrX;
 Wed,  7 Nov 2018 18:08:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 732F48B819;
 Wed,  7 Nov 2018 18:08:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id g4w5_CEfZkIq; Wed,  7 Nov 2018 18:08:36 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 280258B814;
 Wed,  7 Nov 2018 18:08:36 +0100 (CET)
Subject: Re: [RFC PATCH v1 5/6] powerpc/mm: Add a framework for Kernel
 Userspace Access Protection
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 ruscur@russell.cc
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
 <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
Message-ID: <f42d745c-96aa-154d-7deb-988884a02e8b@c-s.fr>
Date: Wed, 7 Nov 2018 18:08:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/11/2018 à 17:56, Christophe Leroy a écrit :
> This patch implements a framework for Kernel Userspace Access Protection.
> 
> Then subarches will have to possibility to provide their own implementation
> by providing setup_kuap(), and lock/unlock_user_rd/wr_access
> 
> We separate read and write accesses because some subarches like
> book3s32 might only support write access protection.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Note that many parts of this patch comes from Russel's serie. Thanks.

> ---
>   Documentation/admin-guide/kernel-parameters.txt |  2 +-
>   arch/powerpc/include/asm/futex.h                |  4 +++
>   arch/powerpc/include/asm/mmu.h                  |  6 ++++
>   arch/powerpc/include/asm/uaccess.h              | 44 ++++++++++++++++++++-----
>   arch/powerpc/lib/checksum_wrappers.c            |  4 +++
>   arch/powerpc/mm/fault.c                         | 17 +++++++---
>   arch/powerpc/mm/init-common.c                   | 10 ++++++
>   arch/powerpc/platforms/Kconfig.cputype          | 12 +++++++
>   8 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1103549363bb..0d059b141ff8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2792,7 +2792,7 @@
>   			noexec=on: enable non-executable mappings (default)
>   			noexec=off: disable non-executable mappings
>   
> -	nosmap		[X86]
> +	nosmap		[X86,PPC]
>   			Disable SMAP (Supervisor Mode Access Prevention)
>   			even if it is supported by processor.
>   
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
> index 94542776a62d..bd58be09f1e8 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -35,6 +35,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>   {
>   	int oldval = 0, ret;
>   
> +	unlock_user_wr_access();
>   	pagefault_disable();
>   
>   	switch (op) {
> @@ -62,6 +63,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>   	if (!ret)
>   		*oval = oldval;
>   
> +	lock_user_wr_access();
>   	return ret;
>   }
>   
> @@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>   	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
>   		return -EFAULT;
>   
> +	unlock_user_wr_access();
>           __asm__ __volatile__ (
>           PPC_ATOMIC_ENTRY_BARRIER
>   "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
> @@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>           : "cc", "memory");
>   
>   	*uval = prev;
> +	lock_user_wr_access();
>           return ret;
>   }
>   
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index cf92f2a813a8..5631a906af55 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -276,6 +276,12 @@ void setup_kuep(bool disabled);
>   static inline void setup_kuep(bool disabled) { }
>   #endif
>   
> +#ifdef CONFIG_PPC_KUAP
> +void setup_kuap(bool disabled);
> +#else
> +static inline void setup_kuap(bool disabled) { }
> +#endif
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   /* The kernel use the constants below to index in the page sizes array.
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 15bea9a0f260..2f3625cbfcee 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -6,6 +6,7 @@
>   #include <asm/processor.h>
>   #include <asm/page.h>
>   #include <asm/extable.h>
> +#include <asm/pgtable.h>
>   
>   /*
>    * The fs value determines whether argument validity checking should be
> @@ -62,6 +63,13 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
>   
>   #endif
>   
> +#ifndef CONFIG_PPC_KUAP
> +static inline void unlock_user_rd_access(void) { }
> +static inline void lock_user_rd_access(void) { }
> +static inline void unlock_user_wr_access(void) { }
> +static inline void lock_user_wr_access(void) { }
> +#endif
> +
>   #define access_ok(type, addr, size)		\
>   	(__chk_user_ptr(addr),			\
>   	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
> @@ -141,6 +149,7 @@ extern long __put_user_bad(void);
>   #define __put_user_size(x, ptr, size, retval)			\
>   do {								\
>   	retval = 0;						\
> +	unlock_user_wr_access();					\
>   	switch (size) {						\
>   	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
>   	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
> @@ -148,6 +157,7 @@ do {								\
>   	  case 8: __put_user_asm2(x, ptr, retval); break;	\
>   	  default: __put_user_bad();				\
>   	}							\
> +	lock_user_wr_access();					\
>   } while (0)
>   
>   #define __put_user_nocheck(x, ptr, size)			\
> @@ -240,6 +250,7 @@ do {								\
>   	__chk_user_ptr(ptr);					\
>   	if (size > sizeof(x))					\
>   		(x) = __get_user_bad();				\
> +	unlock_user_rd_access();					\
>   	switch (size) {						\
>   	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
>   	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
> @@ -247,6 +258,7 @@ do {								\
>   	case 8: __get_user_asm2(x, ptr, retval);  break;	\
>   	default: (x) = __get_user_bad();			\
>   	}							\
> +	lock_user_rd_access();					\
>   } while (0)
>   
>   /*
> @@ -306,15 +318,20 @@ extern unsigned long __copy_tofrom_user(void __user *to,
>   static inline unsigned long
>   raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
>   {
> -	return __copy_tofrom_user(to, from, n);
> +	unsigned long ret;
> +	unlock_user_wr_access();					\
> +	ret = __copy_tofrom_user(to, from, n);			\
> +	lock_user_wr_access();					\
> +	return ret;						\
>   }
>   #endif /* __powerpc64__ */
>   
>   static inline unsigned long raw_copy_from_user(void *to,
>   		const void __user *from, unsigned long n)
>   {
> +	unsigned long ret;
>   	if (__builtin_constant_p(n) && (n <= 8)) {
> -		unsigned long ret = 1;
> +		ret = 1;
>   
>   		switch (n) {
>   		case 1:
> @@ -339,14 +356,18 @@ static inline unsigned long raw_copy_from_user(void *to,
>   	}
>   
>   	barrier_nospec();
> -	return __copy_tofrom_user((__force void __user *)to, from, n);
> +	unlock_user_rd_access();
> +	ret = __copy_tofrom_user((__force void __user *)to, from, n);
> +	lock_user_rd_access();
> +	return ret;
>   }
>   
>   static inline unsigned long raw_copy_to_user(void __user *to,
>   		const void *from, unsigned long n)
>   {
> +	unsigned long ret;
>   	if (__builtin_constant_p(n) && (n <= 8)) {
> -		unsigned long ret = 1;
> +		ret = 1;
>   
>   		switch (n) {
>   		case 1:
> @@ -366,17 +387,24 @@ static inline unsigned long raw_copy_to_user(void __user *to,
>   			return 0;
>   	}
>   
> -	return __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	unlock_user_wr_access();
> +	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	lock_user_wr_access();
> +	return ret;
>   }
>   
>   extern unsigned long __clear_user(void __user *addr, unsigned long size);
>   
>   static inline unsigned long clear_user(void __user *addr, unsigned long size)
>   {
> +	unsigned long ret = size;
>   	might_fault();
> -	if (likely(access_ok(VERIFY_WRITE, addr, size)))
> -		return __clear_user(addr, size);
> -	return size;
> +	if (likely(access_ok(VERIFY_WRITE, addr, size))) {
> +		unlock_user_wr_access();
> +		ret = __clear_user(addr, size);
> +		lock_user_wr_access();
> +	}
> +	return ret;
>   }
>   
>   extern long strncpy_from_user(char *dst, const char __user *src, long count);
> diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
> index a0cb63fb76a1..7dca421ecb53 100644
> --- a/arch/powerpc/lib/checksum_wrappers.c
> +++ b/arch/powerpc/lib/checksum_wrappers.c
> @@ -28,6 +28,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>   {
>   	unsigned int csum;
>   
> +	unlock_user_rd_access();
>   	might_sleep();
>   
>   	*err_ptr = 0;
> @@ -60,6 +61,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>   	}
>   
>   out:
> +	lock_user_rd_access();
>   	return (__force __wsum)csum;
>   }
>   EXPORT_SYMBOL(csum_and_copy_from_user);
> @@ -69,6 +71,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>   {
>   	unsigned int csum;
>   
> +	unlock_user_wr_access();
>   	might_sleep();
>   
>   	*err_ptr = 0;
> @@ -97,6 +100,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>   	}
>   
>   out:
> +	lock_user_wr_access();
>   	return (__force __wsum)csum;
>   }
>   EXPORT_SYMBOL(csum_and_copy_to_user);
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index e57bd46cf25b..7cea9d7fc5e8 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -223,9 +223,11 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr,
>   }
>   
>   /* Is this a bad kernel fault ? */
> -static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
> +static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>   			     unsigned long address)
>   {
> +	int is_exec = TRAP(regs) == 0x400;
> +
>   	/* NX faults set DSISR_PROTFAULT on the 8xx, DSISR_NOEXEC_OR_G on others */
>   	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
>   				      DSISR_PROTFAULT))) {
> @@ -236,7 +238,13 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
>   				   address, from_kuid(&init_user_ns,
>   						      current_uid()));
>   	}
> -	return is_exec || (address >= TASK_SIZE);
> +	if (!is_exec && address < TASK_SIZE && (error_code & DSISR_PROTFAULT) &&
> +	    !search_exception_tables(regs->nip))
> +		printk_ratelimited(KERN_CRIT "Kernel attempted to access user"
> +				   " page (%lx) - exploit attempt? (uid: %d)\n",
> +				   address, from_kuid(&init_user_ns,
> +						      current_uid()));
> +	return is_exec || (address >= TASK_SIZE) || !search_exception_tables(regs->nip);
>   }
>   
>   static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
> @@ -442,9 +450,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   
>   	/*
>   	 * The kernel should never take an execute fault nor should it
> -	 * take a page fault to a kernel address.
> +	 * take a page fault to a kernel address or a page fault to a user
> +	 * address outside of dedicated places
>   	 */
> -	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
> +	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address)))
>   		return SIGSEGV;
>   
>   	/*
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index 89c8bd58509e..1e12f936844e 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -26,6 +26,7 @@
>   #include <asm/pgtable.h>
>   
>   static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
> +static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
>   
>   static int __init parse_nosmep(char *p)
>   {
> @@ -35,9 +36,18 @@ static int __init parse_nosmep(char *p)
>   }
>   early_param("nosmep", parse_nosmep);
>   
> +static int __init parse_nosmap(char *p)
> +{
> +	disable_kuap = true;
> +	pr_warn("Disabling Kernel Userspace Access Protection\n");
> +	return 0;
> +}
> +early_param("nosmap", parse_nosmap);
> +
>   void setup_kup(void)
>   {
>   	setup_kuep(disable_kuep);
> +	setup_kuap(disable_kuap);
>   }
>   
>   static void pgd_ctor(void *addr)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index bbcae320324c..d1757cedf60b 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -364,6 +364,18 @@ config PPC_KUEP
>   
>   	  If you're unsure, say Y.
>   
> +config PPC_HAVE_KUAP
> +	bool
> +
> +config PPC_KUAP
> +	bool "Kernel Userspace Access Protection"
> +	depends on PPC_HAVE_KUAP
> +	default y
> +	help
> +	  Enable support for Kernel Userspace Access Protection (KUAP)
> +
> +	  If you're unsure, say Y.
> +
>   config ARCH_ENABLE_HUGEPAGE_MIGRATION
>   	def_bool y
>   	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
> 
