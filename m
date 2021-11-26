Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11CC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Nov 2021 13:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J0wvH0P2hz3cGl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Nov 2021 00:43:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J0wtp0JfZz2xB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Nov 2021 00:43:27 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4J0wth2H7kz9sSM;
 Fri, 26 Nov 2021 14:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vK7OUS3ldOV2; Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4J0wth1NLYz9sQv;
 Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EE3A8B77D;
 Fri, 26 Nov 2021 14:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GsDpKo4Y4dVs; Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from [192.168.204.6] (unknown [192.168.204.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 216EE8B763;
 Fri, 26 Nov 2021 14:43:23 +0100 (CET)
Message-ID: <6b1e51a8-2f4d-2024-df90-a35c926d7a30@csgroup.eu>
Date: Fri, 26 Nov 2021 14:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] powerpc: mm: radix_tlb: rearrange the if-else block
Content-Language: fr-FR
To: Anders Roxell <anders.roxell@linaro.org>, benh@kernel.crashing.org,
 paulus@samba.org
References: <20211125154406.470082-1-anders.roxell@linaro.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211125154406.470082-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/11/2021 à 16:44, Anders Roxell a écrit :
> Clang warns:
> 
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
>                                  __tlbiel_va_range(hstart, hend, pid,
>                                                    ^~~~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
>                  unsigned long hstart, hend;
>                                      ^
>                                       = 0
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
>                                  __tlbiel_va_range(hstart, hend, pid,
>                                                            ^~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
>                  unsigned long hstart, hend;
>                                            ^
>                                             = 0
> 2 errors generated.
> 
> Rework the if-else to pull the 'IS_ENABLE(CONFIG_TRANSPARENT_HUGEPAGE)'
> check one level up, this will silent the warnings. That will also
> simplify the 'else' path. Clang is getting confused with these warnings,
> but the warnings is a false-positive.

But you are duplicating a significant part of the code by doing that, 
and duplicated code generaly leads to bugs.

And we already have redundant stuff between FLUSH_TYPE_LOCAL leg and 
cputlb_use_tlbie() leg.

Can't you fix CLANG instead :) ?

Or just add an else to the IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) that 
sets hstart and hend to 0 ?

Or just put hstart and hend calculation outside the IS_ENABLED() ? After 
all GCC should drop the calculation when not used.


> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   arch/powerpc/mm/book3s64/radix_tlb.c | 31 +++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 7724af19ed7e..e494a45ce1b4 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -1170,16 +1170,14 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
>   				_tlbiel_pid_multicast(mm, pid, RIC_FLUSH_ALL);
>   			}
>   		}
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>   		bool hflush = false;
>   		unsigned long hstart, hend;
>   
> -		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
> -			hend = end & PMD_MASK;
> -			if (hstart < hend)
> -				hflush = true;
> -		}
> +		hstart = (start + PMD_SIZE - 1) & PMD_MASK;
> +		hend = end & PMD_MASK;
> +		if (hstart < hend)
> +			hflush = true;
>   
>   		if (type == FLUSH_TYPE_LOCAL) {
>   			asm volatile("ptesync": : :"memory");
> @@ -1207,6 +1205,25 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
>   				_tlbiel_va_range_multicast(mm,
>   					hstart, hend, pid, PMD_SIZE, MMU_PAGE_2M, flush_pwc);
>   		}
> +	} else {
> +
> +		if (type == FLUSH_TYPE_LOCAL) {
> +			asm volatile("ptesync" : : : "memory");
> +			if (flush_pwc)
> +				/* For PWC, only one flush is needed */
> +				__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
> +			__tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
> +			ppc_after_tlbiel_barrier();
> +		} else if (cputlb_use_tlbie()) {
> +			asm volatile("ptesync" : : : "memory");
> +			if (flush_pwc)
> +				__tlbie_pid(pid, RIC_FLUSH_PWC);
> +			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
> +			asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> +		} else {
> +			_tlbiel_va_range_multicast(mm,
> +					start, end, pid, page_size, mmu_virtual_psize, flush_pwc);
> +		}
>   	}
>   out:
>   	preempt_enable();
> 
