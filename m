Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B061C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 09:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE735206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 09:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sbuhtCS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE735206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HsqW5kwLzDqCx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 20:14:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Hsnj0TfHzDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 20:12:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="sbuhtCS+"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Hsnh6Lqmz8wWS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 20:12:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Hsnh5z15z9s3q; Mon, 11 Mar 2019 20:12:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="sbuhtCS+"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Hsng6mC7z9s3l
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Mar 2019 20:12:39 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44HsnX3kT2z9vRZh;
 Mon, 11 Mar 2019 10:12:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=sbuhtCS+; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7_qExAl9TkAX; Mon, 11 Mar 2019 10:12:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44HsnX2W6Gz9vRZY;
 Mon, 11 Mar 2019 10:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552295552; bh=kpkEA4Z4d2maZgoUYx0t+PlWCMrf8If5pmm5E6yzSJI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=sbuhtCS+4Wg+SDMw/sehHiITn0Jam408NEQdEPLLTvxHY66w0LtVTPAjFyznpQYPt
 SFA+0JKwUXqGur65tJjszIBMemxjca20wujT08bzoIaaq5ZeR9Jkyr8o7cFvyEFlmc
 aiPxX9VWVCXFeXZ5Osm9lcJppK5/UM+gKR3dW6Sg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F14FF8B820;
 Mon, 11 Mar 2019 10:12:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sFFunSg3AodB; Mon, 11 Mar 2019 10:12:36 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B95E68B7FE;
 Mon, 11 Mar 2019 10:12:36 +0100 (CET)
Subject: Re: [PATCH v5 05/10] powerpc: Add a framework for Kernel Userspace
 Access Protection
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-5-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0ad18520-7cd0-b31c-9a7c-3cbc2e2a679a@c-s.fr>
Date: Mon, 11 Mar 2019 10:12:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190308011619.22402-5-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/03/2019 à 02:16, Michael Ellerman a écrit :
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> This patch implements a framework for Kernel Userspace Access
> Protection.
> 
> Then subarches will have the possibility to provide their own
> implementation by providing setup_kuap() and
> allow/prevent_user_access().
> 
> Some platforms will need to know the area accessed and whether it is
> accessed from read, write or both. Therefore source, destination and
> size and handed over to the two functions.
> 
> mpe: Rename to allow/prevent rather than unlock/lock, and add
> read/write wrappers. Drop the 32-bit code for now until we have an
> implementation for it. Add kuap to pt_regs for 64-bit as well as
> 32-bit. Don't split strings, use pr_crit_ratelimited().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v5: Futex ops need read/write so use allow_user_acccess() there.
>      Use #ifdef CONFIG_PPC64 in kup.h to fix build errors.
>      Allow subarch to override allow_read/write_from/to_user().
> 
> v4: mpe: Rename to allow/prevent rather than unlock/lock, and add
>      read/write wrappers. Drop the 32-bit code for now until we have an
>      implementation for it. Add kuap to pt_regs for 64-bit as well as
>      32-bit. Don't split strings, use pr_crit_ratelimited().

We know have on top of v5 an implementation for 32-bit 8xx and book3s/32 
that works (tested on 8xx, 83xx and QEMU MAC99).

Christophe

> 
>   .../admin-guide/kernel-parameters.txt         |  2 +-
>   arch/powerpc/include/asm/futex.h              |  4 ++
>   arch/powerpc/include/asm/kup.h                | 24 ++++++++++++
>   arch/powerpc/include/asm/ptrace.h             | 11 +++++-
>   arch/powerpc/include/asm/uaccess.h            | 38 +++++++++++++++----
>   arch/powerpc/kernel/asm-offsets.c             |  4 ++
>   arch/powerpc/lib/checksum_wrappers.c          |  4 ++
>   arch/powerpc/mm/fault.c                       | 19 ++++++++--
>   arch/powerpc/mm/init-common.c                 | 10 +++++
>   arch/powerpc/platforms/Kconfig.cputype        | 12 ++++++
>   10 files changed, 113 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f81d79de4de0..16883f2a05fd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2809,7 +2809,7 @@
>   			noexec=on: enable non-executable mappings (default)
>   			noexec=off: disable non-executable mappings
>   
> -	nosmap		[X86]
> +	nosmap		[X86,PPC]
>   			Disable SMAP (Supervisor Mode Access Prevention)
>   			even if it is supported by processor.
>   
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
> index 88b38b37c21b..3a6aa57b9d90 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -35,6 +35,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>   {
>   	int oldval = 0, ret;
>   
> +	allow_write_to_user(uaddr, sizeof(*uaddr));
>   	pagefault_disable();
>   
>   	switch (op) {
> @@ -62,6 +63,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>   	if (!ret)
>   		*oval = oldval;
>   
> +	prevent_write_to_user(uaddr, sizeof(*uaddr));
>   	return ret;
>   }
>   
> @@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>   	if (!access_ok(uaddr, sizeof(u32)))
>   		return -EFAULT;
>   
> +	allow_write_to_user(uaddr, sizeof(*uaddr));
>           __asm__ __volatile__ (
>           PPC_ATOMIC_ENTRY_BARRIER
>   "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
> @@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>           : "cc", "memory");
>   
>   	*uval = prev;
> +	prevent_write_to_user(uaddr, sizeof(*uaddr));
>           return ret;
>   }
>   
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
> index a2a959cb4e36..4410625f4364 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -4,6 +4,8 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +#include <asm/pgtable.h>
> +
>   void setup_kup(void);
>   
>   #ifdef CONFIG_PPC_KUEP
> @@ -12,6 +14,28 @@ void setup_kuep(bool disabled);
>   static inline void setup_kuep(bool disabled) { }
>   #endif /* CONFIG_PPC_KUEP */
>   
> +#ifdef CONFIG_PPC_KUAP
> +void setup_kuap(bool disabled);
> +#else
> +static inline void setup_kuap(bool disabled) { }
> +static inline void allow_user_access(void __user *to, const void __user *from,
> +				     unsigned long size) { }
> +static inline void prevent_user_access(void __user *to, const void __user *from,
> +				       unsigned long size) { }
> +static inline void allow_read_from_user(const void __user *from, unsigned long size) {}
> +static inline void allow_write_to_user(void __user *to, unsigned long size) {}
> +#endif /* CONFIG_PPC_KUAP */
> +
> +static inline void prevent_read_from_user(const void __user *from, unsigned long size)
> +{
> +	prevent_user_access(NULL, from, size);
> +}
> +
> +static inline void prevent_write_to_user(void __user *to, unsigned long size)
> +{
> +	prevent_user_access(to, NULL, size);
> +}
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   #endif /* _ASM_POWERPC_KUP_H_ */
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 64271e562fed..6f047730e642 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -52,10 +52,17 @@ struct pt_regs
>   		};
>   	};
>   
> +	union {
> +		struct {
>   #ifdef CONFIG_PPC64
> -	unsigned long ppr;
> -	unsigned long __pad;	/* Maintain 16 byte interrupt stack alignment */
> +			unsigned long ppr;
> +#endif
> +#ifdef CONFIG_PPC_KUAP
> +			unsigned long kuap;
>   #endif
> +		};
> +		unsigned long __pad[2];	/* Maintain 16 byte interrupt stack alignment */
> +	};
>   };
>   #endif
>   
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e3a731793ea2..fb7651a5488b 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -6,6 +6,7 @@
>   #include <asm/processor.h>
>   #include <asm/page.h>
>   #include <asm/extable.h>
> +#include <asm/kup.h>
>   
>   /*
>    * The fs value determines whether argument validity checking should be
> @@ -141,6 +142,7 @@ extern long __put_user_bad(void);
>   #define __put_user_size(x, ptr, size, retval)			\
>   do {								\
>   	retval = 0;						\
> +	allow_write_to_user(ptr, size);				\
>   	switch (size) {						\
>   	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
>   	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
> @@ -148,6 +150,7 @@ do {								\
>   	  case 8: __put_user_asm2(x, ptr, retval); break;	\
>   	  default: __put_user_bad();				\
>   	}							\
> +	prevent_write_to_user(ptr, size);			\
>   } while (0)
>   
>   #define __put_user_nocheck(x, ptr, size)			\
> @@ -240,6 +243,7 @@ do {								\
>   	__chk_user_ptr(ptr);					\
>   	if (size > sizeof(x))					\
>   		(x) = __get_user_bad();				\
> +	allow_read_from_user(ptr, size);			\
>   	switch (size) {						\
>   	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
>   	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
> @@ -247,6 +251,7 @@ do {								\
>   	case 8: __get_user_asm2(x, ptr, retval);  break;	\
>   	default: (x) = __get_user_bad();			\
>   	}							\
> +	prevent_read_from_user(ptr, size);			\
>   } while (0)
>   
>   /*
> @@ -306,15 +311,21 @@ extern unsigned long __copy_tofrom_user(void __user *to,
>   static inline unsigned long
>   raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
>   {
> -	return __copy_tofrom_user(to, from, n);
> +	unsigned long ret;
> +
> +	allow_user_access(to, from, n);
> +	ret = __copy_tofrom_user(to, from, n);
> +	prevent_user_access(to, from, n);
> +	return ret;
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
> @@ -339,14 +350,18 @@ static inline unsigned long raw_copy_from_user(void *to,
>   	}
>   
>   	barrier_nospec();
> -	return __copy_tofrom_user((__force void __user *)to, from, n);
> +	allow_read_from_user(from, n);
> +	ret = __copy_tofrom_user((__force void __user *)to, from, n);
> +	prevent_read_from_user(from, n);
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
> @@ -366,17 +381,24 @@ static inline unsigned long raw_copy_to_user(void __user *to,
>   			return 0;
>   	}
>   
> -	return __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	allow_write_to_user(to, n);
> +	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	prevent_write_to_user(to, n);
> +	return ret;
>   }
>   
>   extern unsigned long __clear_user(void __user *addr, unsigned long size);
>   
>   static inline unsigned long clear_user(void __user *addr, unsigned long size)
>   {
> +	unsigned long ret = size;
>   	might_fault();
> -	if (likely(access_ok(addr, size)))
> -		return __clear_user(addr, size);
> -	return size;
> +	if (likely(access_ok(addr, size))) {
> +		allow_write_to_user(addr, size);
> +		ret = __clear_user(addr, size);
> +		prevent_write_to_user(addr, size);
> +	}
> +	return ret;
>   }
>   
>   extern long strncpy_from_user(char *dst, const char __user *src, long count);
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 86a61e5f8285..66202e02fee2 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -332,6 +332,10 @@ int main(void)
>   	STACK_PT_REGS_OFFSET(_PPR, ppr);
>   #endif /* CONFIG_PPC64 */
>   
> +#ifdef CONFIG_PPC_KUAP
> +	STACK_PT_REGS_OFFSET(STACK_REGS_KUAP, kuap);
> +#endif
> +
>   #if defined(CONFIG_PPC32)
>   #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>   	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
> diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
> index 890d4ddd91d6..bb9307ce2440 100644
> --- a/arch/powerpc/lib/checksum_wrappers.c
> +++ b/arch/powerpc/lib/checksum_wrappers.c
> @@ -29,6 +29,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>   	unsigned int csum;
>   
>   	might_sleep();
> +	allow_read_from_user(src, len);
>   
>   	*err_ptr = 0;
>   
> @@ -60,6 +61,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
>   	}
>   
>   out:
> +	prevent_read_from_user(src, len);
>   	return (__force __wsum)csum;
>   }
>   EXPORT_SYMBOL(csum_and_copy_from_user);
> @@ -70,6 +72,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>   	unsigned int csum;
>   
>   	might_sleep();
> +	allow_write_to_user(dst, len);
>   
>   	*err_ptr = 0;
>   
> @@ -97,6 +100,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
>   	}
>   
>   out:
> +	prevent_write_to_user(dst, len);
>   	return (__force __wsum)csum;
>   }
>   EXPORT_SYMBOL(csum_and_copy_to_user);
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 3384354abc1d..463d1e9d026e 100644
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
> @@ -234,7 +236,15 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
>   				    address,
>   				    from_kuid(&init_user_ns, current_uid()));
>   	}
> -	return is_exec || (address >= TASK_SIZE);
> +
> +	if (!is_exec && address < TASK_SIZE && (error_code & DSISR_PROTFAULT) &&
> +	    !search_exception_tables(regs->nip)) {
> +		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - exploit attempt? (uid: %d)\n",
> +				    address,
> +				    from_kuid(&init_user_ns, current_uid()));
> +	}
> +
> +	return is_exec || (address >= TASK_SIZE) || !search_exception_tables(regs->nip);
>   }
>   
>   static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
> @@ -454,9 +464,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
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
> index 83f95a5565d6..ecaedfff9992 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -27,6 +27,7 @@
>   #include <asm/kup.h>
>   
>   static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
> +static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
>   
>   static int __init parse_nosmep(char *p)
>   {
> @@ -36,9 +37,18 @@ static int __init parse_nosmep(char *p)
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
>   void __init setup_kup(void)
>   {
>   	setup_kuep(disable_kuep);
> +	setup_kuap(disable_kuap);
>   }
>   
>   #define CTOR(shift) static void ctor_##shift(void *addr) \
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 7d30bbbaa3c1..457fc3a5ed93 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -357,6 +357,18 @@ config PPC_KUEP
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
