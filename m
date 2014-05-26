Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32D5C1A0590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:25:42 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 26 May 2014 21:25:40 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 828DF3578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:25:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4QB3vSg45285628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:03:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4QBPSU7024049
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:25:29 +1000
Message-ID: <5383249A.6060407@in.ibm.com>
Date: Mon, 26 May 2014 16:55:14 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@gmail.com>
Subject: Re: [RFT PATCH -next ] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
References: <536A16A6.5040709@hitachi.com>
 <20140507115551.22259.70581.stgit@ltc230.yrl.intra.hitachi.co.jp>
In-Reply-To: <20140507115551.22259.70581.stgit@ltc230.yrl.intra.hitachi.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2014 05:25 PM, Masami Hiramatsu wrote:
> On ia64 and ppc64, the function pointer does not point the
> entry address of the function, but the address of function
> discriptor (which contains the entry address and misc
> data.) Since the kprobes passes the function pointer stored
> by NOKPROBE_SYMBOL() to kallsyms_lookup_size_offset() for
> initalizing its blacklist, it fails and reports many errors
> as below.
> 
>   Failed to find blacklist 0001013168300000
>   Failed to find blacklist 0001013000f0a000
>   Failed to find blacklist 000101315f70a000
>   Failed to find blacklist 000101324c80a000
>   Failed to find blacklist 0001013063f0a000
>   Failed to find blacklist 000101327800a000
>   Failed to find blacklist 0001013277f0a000
>   Failed to find blacklist 000101315a70a000
>   Failed to find blacklist 0001013277e0a000
>   Failed to find blacklist 000101305a20a000
>   Failed to find blacklist 0001013277d0a000
>   Failed to find blacklist 00010130bdc0a000
>   Failed to find blacklist 00010130dc20a000
>   Failed to find blacklist 000101309a00a000
>   Failed to find blacklist 0001013277c0a000
>   Failed to find blacklist 0001013277b0a000
>   Failed to find blacklist 0001013277a0a000
>   Failed to find blacklist 000101327790a000
>   Failed to find blacklist 000101303140a000
>   Failed to find blacklist 0001013a3280a000
> 
> To fix this bug, this introduces function_entry() macro to
> retrieve the entry address from the given function pointer,
> and uses it in NOKPROBE_SYMBOL().
> 
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Reported-by: Tony Luck <tony.luck@gmail.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Kevin Hao <haokexin@gmail.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/ia64/include/asm/types.h    |    2 ++
>  arch/powerpc/include/asm/types.h |   11 +++++++++++
>  include/linux/kprobes.h          |    3 ++-
>  include/linux/types.h            |    4 ++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/types.h b/arch/ia64/include/asm/types.h
> index 4c351b1..6ab7b6c 100644
> --- a/arch/ia64/include/asm/types.h
> +++ b/arch/ia64/include/asm/types.h
> @@ -27,5 +27,7 @@ struct fnptr {
>  	unsigned long gp;
>  };
>  
> +#define constant_function_entry(fn) (((struct fnptr *)(fn))->ip)
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_IA64_TYPES_H */
> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
> index bfb6ded..fd297b8 100644
> --- a/arch/powerpc/include/asm/types.h
> +++ b/arch/powerpc/include/asm/types.h
> @@ -25,6 +25,17 @@ typedef struct {
>  	unsigned long env;
>  } func_descr_t;
>  
> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
> +/*
> + * On PPC64 ABIv1 the function pointer actually points to the
> + * function's descriptor. The first entry in the descriptor is the
> + * address of the function text.
> + */
> +#define constant_function_entry(fn)	(((func_descr_t *)(fn))->entry)
> +#else
> +#define constant_function_entry(fn)	((unsigned long)(fn))
> +#endif
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_TYPES_H */
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e059507..637eafe 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -40,6 +40,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
>  #include <linux/ftrace.h>
> +#include <linux/types.h>
>  
>  #ifdef CONFIG_KPROBES
>  #include <asm/kprobes.h>
> @@ -485,7 +486,7 @@ static inline int enable_jprobe(struct jprobe *jp)
>  #define __NOKPROBE_SYMBOL(fname)			\
>  static unsigned long __used				\
>  	__attribute__((section("_kprobe_blacklist")))	\
> -	_kbl_addr_##fname = (unsigned long)fname;
> +	_kbl_addr_##fname = constant_function_entry(fname);
>  #define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)


Throws up build errors for me :

  CC      kernel/notifier.o
kernel/notifier.c:105:1: error: initializer element is not constant
 NOKPROBE_SYMBOL(notifier_call_chain);
 ^
kernel/notifier.c:188:1: error: initializer element is not constant
 NOKPROBE_SYMBOL(__atomic_notifier_call_chain);
 ^
kernel/notifier.c:196:1: error: initializer element is not constant
 NOKPROBE_SYMBOL(atomic_notifier_call_chain);
 ^
kernel/notifier.c:546:1: error: initializer element is not constant
 NOKPROBE_SYMBOL(notify_die);
 ^
make[1]: *** [kernel/notifier.o] Error 1
make: *** [kernel] Error 2

Thanks
Suzuki
