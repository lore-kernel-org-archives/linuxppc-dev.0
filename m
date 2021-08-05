Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B141C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:35:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F4660230
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99F4660230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgNkD26lKz3cZt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 19:35:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgNjh3Wk2z3d76
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 19:34:29 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GgNjZ5kr3z9sWG;
 Thu,  5 Aug 2021 11:34:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLFCP15Z8Qrl; Thu,  5 Aug 2021 11:34:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GgNjZ4hSBz9sWW;
 Thu,  5 Aug 2021 11:34:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 851A48B7BD;
 Thu,  5 Aug 2021 11:34:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id liNPilBVWVym; Thu,  5 Aug 2021 11:34:26 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D96588B7C2;
 Thu,  5 Aug 2021 11:34:25 +0200 (CEST)
Subject: Re: [PATCH v5 6/8] powerpc: Rework and improve STRICT_KERNEL_RWX
 patching
To: "Christopher M. Riedl" <cmr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20210713053113.4632-1-cmr@linux.ibm.com>
 <20210713053113.4632-7-cmr@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9c53e997-3609-20f8-74c0-7776c867ce6c@csgroup.eu>
Date: Thu, 5 Aug 2021 11:34:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713053113.4632-7-cmr@linux.ibm.com>
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
> Rework code-patching with STRICT_KERNEL_RWX to prepare for the next
> patch which uses a temporary mm for patching under the Book3s64 Radix
> MMU. Make improvements by adding a WARN_ON when the patchsite doesn't
> match after patching and return the error from __patch_instruction()
> properly.
> 
> Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
> 
> ---
> 
> v5:  * New to series.
> ---
>   arch/powerpc/lib/code-patching.c | 51 +++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 3122d8e4cc013..9f2eba9b70ee4 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -102,11 +102,12 @@ static inline void unuse_temporary_mm(struct temp_mm *temp_mm)
>   }
>   
>   static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
> +static DEFINE_PER_CPU(unsigned long, cpu_patching_addr);
>   
>   #if IS_BUILTIN(CONFIG_LKDTM)
>   unsigned long read_cpu_patching_addr(unsigned int cpu)
>   {
> -	return (unsigned long)(per_cpu(text_poke_area, cpu))->addr;
> +	return per_cpu(cpu_patching_addr, cpu);
>   }
>   #endif
>   
> @@ -121,6 +122,7 @@ static int text_area_cpu_up(unsigned int cpu)
>   		return -1;
>   	}
>   	this_cpu_write(text_poke_area, area);
> +	this_cpu_write(cpu_patching_addr, (unsigned long)area->addr);
>   
>   	return 0;
>   }
> @@ -146,7 +148,7 @@ void __init poking_init(void)
>   /*
>    * This can be called for kernel text or a module.
>    */
> -static int map_patch_area(void *addr, unsigned long text_poke_addr)
> +static int map_patch_area(void *addr)
>   {
>   	unsigned long pfn;
>   	int err;
> @@ -156,17 +158,20 @@ static int map_patch_area(void *addr, unsigned long text_poke_addr)
>   	else
>   		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
>   
> -	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
> +	err = map_kernel_page(__this_cpu_read(cpu_patching_addr),
> +			      (pfn << PAGE_SHIFT), PAGE_KERNEL);
>   
> -	pr_devel("Mapped addr %lx with pfn %lx:%d\n", text_poke_addr, pfn, err);
> +	pr_devel("Mapped addr %lx with pfn %lx:%d\n",
> +		 __this_cpu_read(cpu_patching_addr), pfn, err);
>   	if (err)
>   		return -1;
>   
>   	return 0;
>   }
>   
> -static inline int unmap_patch_area(unsigned long addr)
> +static inline int unmap_patch_area(void)
>   {
> +	unsigned long addr = __this_cpu_read(cpu_patching_addr);
>   	pte_t *ptep;
>   	pmd_t *pmdp;
>   	pud_t *pudp;
> @@ -175,23 +180,23 @@ static inline int unmap_patch_area(unsigned long addr)
>   
>   	pgdp = pgd_offset_k(addr);
>   	if (unlikely(!pgdp))
> -		return -EINVAL;
> +		goto out_err;
>   
>   	p4dp = p4d_offset(pgdp, addr);
>   	if (unlikely(!p4dp))
> -		return -EINVAL;
> +		goto out_err;
>   
>   	pudp = pud_offset(p4dp, addr);
>   	if (unlikely(!pudp))
> -		return -EINVAL;
> +		goto out_err;
>   
>   	pmdp = pmd_offset(pudp, addr);
>   	if (unlikely(!pmdp))
> -		return -EINVAL;
> +		goto out_err;
>   
>   	ptep = pte_offset_kernel(pmdp, addr);
>   	if (unlikely(!ptep))
> -		return -EINVAL;
> +		goto out_err;
>   
>   	pr_devel("clearing mm %p, pte %p, addr %lx\n", &init_mm, ptep, addr);
>   
> @@ -202,15 +207,17 @@ static inline int unmap_patch_area(unsigned long addr)
>   	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>   
>   	return 0;
> +
> +out_err:
> +	pr_warn("failed to unmap %lx\n", addr);
> +	return -EINVAL;

Can you keep that in the caller of unmap_patch_area() instead of all those goto stuff ?

>   }
>   
>   static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
>   {
> -	int err;
> +	int err, rc = 0;
>   	u32 *patch_addr = NULL;
>   	unsigned long flags;
> -	unsigned long text_poke_addr;
> -	unsigned long kaddr = (unsigned long)addr;
>   
>   	/*
>   	 * During early early boot patch_instruction is called
> @@ -222,24 +229,20 @@ static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
>   
>   	local_irq_save(flags);
>   
> -	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
> -	if (map_patch_area(addr, text_poke_addr)) {
> -		err = -1;
> +	err = map_patch_area(addr);
> +	if (err)
>   		goto out;
> -	}
> -
> -	patch_addr = (u32 *)(text_poke_addr + (kaddr & ~PAGE_MASK));
>   
> -	__patch_instruction(addr, instr, patch_addr);
> +	patch_addr = (u32 *)(__this_cpu_read(cpu_patching_addr) | offset_in_page(addr));
> +	rc = __patch_instruction(addr, instr, patch_addr);
>   
> -	err = unmap_patch_area(text_poke_addr);
> -	if (err)
> -		pr_warn("failed to unmap %lx\n", text_poke_addr);
> +	err = unmap_patch_area();
>   
>   out:
>   	local_irq_restore(flags);
> +	WARN_ON(!ppc_inst_equal(ppc_inst_read(addr), instr));

Why adding that WARN_ON(), what could make that happen that is worth a WARN_ON() ?

Patching is quite a critical fast path, I'm not sure we want to afford too many checks during 
patching, we want it quick at first.

>   
> -	return err;
> +	return rc ? rc : err;
>   }
>   #else /* !CONFIG_STRICT_KERNEL_RWX */
>   
> 
