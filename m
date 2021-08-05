Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1959BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:27:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57B560238
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A57B560238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgNYk0lwMz309F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 19:27:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgNYM27vwz2ym7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 19:27:17 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GgNYG4hVXz9sWd;
 Thu,  5 Aug 2021 11:27:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLOPeGASC_u0; Thu,  5 Aug 2021 11:27:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GgNYG3dHvz9sWL;
 Thu,  5 Aug 2021 11:27:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 459488B7C1;
 Thu,  5 Aug 2021 11:27:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id of4fuNahxMWp; Thu,  5 Aug 2021 11:27:14 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98C118B7BD;
 Thu,  5 Aug 2021 11:27:13 +0200 (CEST)
Subject: Re: [PATCH v5 5/8] powerpc/64s: Introduce temporary mm for Radix MMU
To: "Christopher M. Riedl" <cmr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20210713053113.4632-1-cmr@linux.ibm.com>
 <20210713053113.4632-6-cmr@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c8b2291e-57f9-6d9a-583e-4ec65b2c9bcb@csgroup.eu>
Date: Thu, 5 Aug 2021 11:27:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713053113.4632-6-cmr@linux.ibm.com>
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
Cc: keescook@chromium.org, peterz@infradead.org, x86@kernel.org,
 npiggin@gmail.com, linux-hardening@vger.kernel.org, tglx@linutronix.de,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/07/2021 à 07:31, Christopher M. Riedl a écrit :
> x86 supports the notion of a temporary mm which restricts access to
> temporary PTEs to a single CPU. A temporary mm is useful for situations
> where a CPU needs to perform sensitive operations (such as patching a
> STRICT_KERNEL_RWX kernel) requiring temporary mappings without exposing
> said mappings to other CPUs. Another benefit is that other CPU TLBs do
> not need to be flushed when the temporary mm is torn down.
> 
> Mappings in the temporary mm can be set in the userspace portion of the
> address-space.
> 
> Interrupts must be disabled while the temporary mm is in use. HW
> breakpoints, which may have been set by userspace as watchpoints on
> addresses now within the temporary mm, are saved and disabled when
> loading the temporary mm. The HW breakpoints are restored when unloading
> the temporary mm. All HW breakpoints are indiscriminately disabled while
> the temporary mm is in use.

Can you explain more about that breakpoint stuff ? Why is it a special case here at all ? Isn't it 
the same when you switch from one user task to another one ? x86 commit doesn't say anythink about 
breakpoints.

> 
> Based on x86 implementation:
> 
> commit cefa929c034e
> ("x86/mm: Introduce temporary mm structs")
> 
> Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
> 
> ---
> 
> v5:  * Drop support for using a temporary mm on Book3s64 Hash MMU.
> 
> v4:  * Pass the prev mm instead of NULL to switch_mm_irqs_off() when
>         using/unusing the temp mm as suggested by Jann Horn to keep
>         the context.active counter in-sync on mm/nohash.
>       * Disable SLB preload in the temporary mm when initializing the
>         temp_mm struct.
>       * Include asm/debug.h header to fix build issue with
>         ppc44x_defconfig.
> ---
>   arch/powerpc/include/asm/debug.h |  1 +
>   arch/powerpc/kernel/process.c    |  5 +++
>   arch/powerpc/lib/code-patching.c | 56 ++++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
> index 86a14736c76c3..dfd82635ea8b3 100644
> --- a/arch/powerpc/include/asm/debug.h
> +++ b/arch/powerpc/include/asm/debug.h
> @@ -46,6 +46,7 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
>   #endif
>   
>   void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk);
> +void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk);
>   bool ppc_breakpoint_available(void);
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>   extern void do_send_trap(struct pt_regs *regs, unsigned long address,
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 185beb2905801..a0776200772e8 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -865,6 +865,11 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
>   	return 0;
>   }
>   
> +void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk)
> +{
> +	memcpy(brk, this_cpu_ptr(&current_brk[nr]), sizeof(*brk));
> +}
> +
>   void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk)
>   {
>   	memcpy(this_cpu_ptr(&current_brk[nr]), brk, sizeof(*brk));
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 54b6157d44e95..3122d8e4cc013 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -17,6 +17,9 @@
>   #include <asm/code-patching.h>
>   #include <asm/setup.h>
>   #include <asm/inst.h>
> +#include <asm/mmu_context.h>
> +#include <asm/debug.h>
> +#include <asm/tlb.h>
>   
>   static int __patch_instruction(u32 *exec_addr, struct ppc_inst instr, u32 *patch_addr)
>   {
> @@ -45,6 +48,59 @@ int raw_patch_instruction(u32 *addr, struct ppc_inst instr)
>   }
>   
>   #ifdef CONFIG_STRICT_KERNEL_RWX
> +
> +struct temp_mm {
> +	struct mm_struct *temp;
> +	struct mm_struct *prev;
> +	struct arch_hw_breakpoint brk[HBP_NUM_MAX];
> +};
> +
> +static inline void init_temp_mm(struct temp_mm *temp_mm, struct mm_struct *mm)
> +{
> +	/* We currently only support temporary mm on the Book3s64 Radix MMU */
> +	WARN_ON(!radix_enabled());
> +
> +	temp_mm->temp = mm;
> +	temp_mm->prev = NULL;
> +	memset(&temp_mm->brk, 0, sizeof(temp_mm->brk));
> +}
> +
> +static inline void use_temporary_mm(struct temp_mm *temp_mm)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	temp_mm->prev = current->active_mm;
> +	switch_mm_irqs_off(temp_mm->prev, temp_mm->temp, current);
> +
> +	WARN_ON(!mm_is_thread_local(temp_mm->temp));
> +
> +	if (ppc_breakpoint_available()) {
> +		struct arch_hw_breakpoint null_brk = {0};
> +		int i = 0;
> +
> +		for (; i < nr_wp_slots(); ++i) {
> +			__get_breakpoint(i, &temp_mm->brk[i]);
> +			if (temp_mm->brk[i].type != 0)
> +				__set_breakpoint(i, &null_brk);
> +		}
> +	}
> +}
> +
> +static inline void unuse_temporary_mm(struct temp_mm *temp_mm)

not sure about the naming.

Maybe start_using_temp_mm() and stop_using_temp_mm() would be more explicit.


> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	switch_mm_irqs_off(temp_mm->temp, temp_mm->prev, current);
> +
> +	if (ppc_breakpoint_available()) {
> +		int i = 0;
> +
> +		for (; i < nr_wp_slots(); ++i)
> +			if (temp_mm->brk[i].type != 0)
> +				__set_breakpoint(i, &temp_mm->brk[i]);
> +	}
> +}
> +
>   static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
>   
>   #if IS_BUILTIN(CONFIG_LKDTM)
> 

You'll probably get a bisecting hasard with those unused 'static inline' functions in a .c file 
because that patch alone probably fails build.
