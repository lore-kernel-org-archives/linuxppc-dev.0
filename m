Return-Path: <linuxppc-dev+bounces-17706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1463EB7EAC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 09:04:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQmtw3ksFz3c9l;
	Wed, 04 Mar 2026 20:04:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772615048;
	cv=none; b=f/BBwfflDCoMUArSD7kLCq0oKzgODQ9MSt1FiEjdzzrVV8ndo3YqGHEd0Lxr+YwZsSmyh0AdXZQo3jMYlKYkqvpUftpY+9D07QIy7xSfP+qL7z+NyQz+4P+5b9MgphYwBERdCYIa5f8L/5Exyk0dh+E7eeuRWo/FF/dbrx5OaSA8tL/7Ej1xrQLJMep7Uhjj9JNUUOXBxizdm2mjPAHvSemvoNkEZFdfXbiRuHnUS2iIrEJ85gVM8u12V5AShr2yyiaU4p2jqL7a04mwdko0uon3yS/Es4QL1rQN6UP63iaY1YtlwSDUgZ7lbPdyMGXdMMhkc2pFFKJY8FPp+tNY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772615048; c=relaxed/relaxed;
	bh=sOQlj6naO92JugN1Y9eyq9OsCaSmpPv2KoT7HaBPRQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGDUqv+c6fJ1HicpJhIUB+C+nu0/k7smlqBky66PwNIdxAG/M+7JfDAiVxmOf7dRETcqxDE2FuLlFO9g2dqpFyARa19DNQng0YM8n1ISyKjBZAImwR05mEsmIgEPb1nuIed5mq67v+eY1ON05/6K9mOyWxrzh2DaBdG8cLY871M2VybSAU/K0ASeencNi+wo1MduNsIigd9iX/RrdyXFl0PXjn+/WOkAX33rtuQK94hti4CJgdJmcEJcJuZPYqXI/vitGVC9Asfx1nMS/7TbNu37DRmNmFei+Zu3bfPlo7OFfkETpTKMy3HZRkGFpB6IZdlz5U+6M7GcH/DR7T9wVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LO5cFKB3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LO5cFKB3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQmtv5Vrtz3c9M
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 20:04:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3387C40B99;
	Wed,  4 Mar 2026 09:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F464C19423;
	Wed,  4 Mar 2026 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772615046;
	bh=duYFPXRSVqTWjpnCYbxKCrWGKHrn4IMlEvOkeRB4SBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LO5cFKB3INrXPIS9/Zzl0WPAjo/Xz417AVxD+S6wAoYl8T2a9o4qmbHKzaF3yafXU
	 qPupfGUV3z8mC/GJE5HSVUjlpZr/zfH/n8eG1iWtPbkj5xC4dE5vQqHN3pRq/NJY5p
	 UNgtygr9jbQ5jthBp+wJPEHAwxOUPwCoo/6O6de4EnKslc+KW8thlzk44/3Q0fr+x0
	 +9ttAdacuqh4wTMayA0UCQME/k/uUScbhIcelDUYRXOWs8gX4QALILX4bsw7L6V6dg
	 tz9Jci+tOojITSRXWYmLBR01xP02JIAi0LHkPMAQtNNFCWjlsFZPmK6FeP0QEpjE8P
	 NgjYWXUy5RhYQ==
Message-ID: <88b77e80-8b6c-44de-b74f-ad589d49b6cd@kernel.org>
Date: Wed, 4 Mar 2026 10:04:02 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 07/10] powerpc: book3s64: Rename tlbie_va_lpid to
 tlbie_va_pid_lpid
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1772013273.git.ritesh.list@gmail.com>
 <465a2aac31f00d395be0d551574de37786ace094.1772013273.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <465a2aac31f00d395be0d551574de37786ace094.1772013273.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/02/2026 à 12:04, Ritesh Harjani (IBM) a écrit :
> It only make sense to rename these functions, so it's better reflect what
> they are supposed to do. For e.g. __tlbie_va_pid_lpid name better reflect
> that it is invalidating tlbie using VA, PID and LPID.
> 
> No functional change in this patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/mm/book3s64/radix_tlb.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 339bd276840b..1adf20798ca6 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -1411,7 +1411,7 @@ static __always_inline void __tlbie_pid_lpid(unsigned long pid,
>   	trace_tlbie(0, 0, rb, rs, ric, prs, r);
>   }
>   
> -static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
> +static __always_inline void __tlbie_va_pid_lpid(unsigned long va, unsigned long pid,
>   					    unsigned long lpid,
>   					    unsigned long ap, unsigned long ric)
>   {
> @@ -1443,7 +1443,7 @@ static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
>   
>   	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
>   		asm volatile("ptesync" : : : "memory");
> -		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
> +		__tlbie_va_pid_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
>   				RIC_FLUSH_TLB);
>   	}
>   }
> @@ -1474,7 +1474,7 @@ static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
>   	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
>   }
>   
> -static inline void fixup_tlbie_va_range_lpid(unsigned long va,
> +static inline void fixup_tlbie_va_range_pid_lpid(unsigned long va,
>   					     unsigned long pid,
>   					     unsigned long lpid,
>   					     unsigned long ap)
> @@ -1486,11 +1486,11 @@ static inline void fixup_tlbie_va_range_lpid(unsigned long va,
>   
>   	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
>   		asm volatile("ptesync" : : : "memory");
> -		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
> +		__tlbie_va_pid_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
>   	}
>   }
>   
> -static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
> +static inline void __tlbie_va_range_pid_lpid(unsigned long start, unsigned long end,
>   					 unsigned long pid, unsigned long lpid,
>   					 unsigned long page_size,
>   					 unsigned long psize)
> @@ -1499,12 +1499,12 @@ static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
>   	unsigned long ap = mmu_get_ap(psize);
>   
>   	for (addr = start; addr < end; addr += page_size)
> -		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
> +		__tlbie_va_pid_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
>   
> -	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
> +	fixup_tlbie_va_range_pid_lpid(addr - page_size, pid, lpid, ap);
>   }
>   
> -static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
> +static inline void _tlbie_va_range_pid_lpid(unsigned long start, unsigned long end,
>   					unsigned long pid, unsigned long lpid,
>   					unsigned long page_size,
>   					unsigned long psize, bool also_pwc)
> @@ -1512,7 +1512,7 @@ static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
>   	asm volatile("ptesync" : : : "memory");
>   	if (also_pwc)
>   		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
> -	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
> +	__tlbie_va_range_pid_lpid(start, end, pid, lpid, page_size, psize);
>   	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
>   }
>   
> @@ -1563,7 +1563,7 @@ void do_h_rpt_invalidate_prt(unsigned long pid, unsigned long lpid,
>   			_tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
>   			return;
>   		}
> -		_tlbie_va_range_lpid(start, end, pid, lpid,
> +		_tlbie_va_range_pid_lpid(start, end, pid, lpid,
>   				     (1UL << def->shift), psize, false);
>   	}
>   }


