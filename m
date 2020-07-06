Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C00C433E2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18532073E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QEJG+g9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18532073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0cRk3bgCzDqlm
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 17:20:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0cNm3ckHzDqkT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 17:18:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=QEJG+g9L; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B0cNm0dZpz9sRK;
 Mon,  6 Jul 2020 17:18:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594019896;
 bh=eiAbPU0mNPUx23t/0dWGH/vovUwBclv8sl+0XraFO70=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QEJG+g9Ltp0Ex9k882ct+bDXog3lBkKEQTVH17eGCOn3VSLG47pRq57TyOD99ZsQ9
 p/ycC4RGxyKW3WYEX0SoyhlB1nzNCN2/plboL4KRWcYkYb+8QekB26IZEFCbcQn/Vd
 P42iug19+brZ+81OmKj014j66sQAfWQfxzXwZMA1diqCRNGlpcSgQMfEe7oPyWz0tc
 JpZj6sd7SyWIoA8lJ7LqsPJcRH8MQTbnu7KooxtpNvDZwG7w8HHiNnEH0vNccGxHua
 ilmZDIjypIvFWBTrnkNf+/ZZlUoa5tGWGyeYmB39xjnAoJlJ4xQh+3CZ/SecgIaA8b
 XsW05xffLRexg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 15/26] powerpc/book3s64/pkeys: Use execute_pkey_disable
 static key
In-Reply-To: <20200619135850.47155-16-aneesh.kumar@linux.ibm.com>
References: <20200619135850.47155-1-aneesh.kumar@linux.ibm.com>
 <20200619135850.47155-16-aneesh.kumar@linux.ibm.com>
Date: Mon, 06 Jul 2020 17:20:31 +1000
Message-ID: <87mu4d5cu8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxram@us.ibm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> Use execute_pkey_disabled static key to check for execute key support instead
> of pkey_disabled.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h | 10 +---------
>  arch/powerpc/mm/book3s64/pkeys.c |  5 ++++-
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 47c81d41ea9a..09fbaa409ac4 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -126,15 +126,7 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>   * Try to dedicate one of the protection keys to be used as an
>   * execute-only protection key.
>   */
> -extern int __execute_only_pkey(struct mm_struct *mm);
> -static inline int execute_only_pkey(struct mm_struct *mm)
> -{
> -	if (static_branch_likely(&pkey_disabled))
> -		return -1;
> -
> -	return __execute_only_pkey(mm);
> -}
> -
> +extern int execute_only_pkey(struct mm_struct *mm);
>  extern int __arch_override_mprotect_pkey(struct vm_area_struct *vma,
>  					 int prot, int pkey);
>  static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
> index bbba9c601e14..fed4f159011b 100644
> --- a/arch/powerpc/mm/book3s64/pkeys.c
> +++ b/arch/powerpc/mm/book3s64/pkeys.c
> @@ -345,8 +345,11 @@ void thread_pkey_regs_init(struct thread_struct *thread)
>  	write_uamor(default_uamor);
>  }
>  
> -int __execute_only_pkey(struct mm_struct *mm)
> +int execute_only_pkey(struct mm_struct *mm)
>  {
> +	if (static_branch_likely(&execute_pkey_disabled))
> +		return -1;
> +
>  	return mm->context.execute_only_pkey;
>  }

That adds the overhead of a function call, but then uses a static_key to
avoid an easy to predict branch, which seems like a bad tradeoff. And
it's not a performance critical path AFAICS.

Anyway this seems unnecessary:

pkey_early_init_devtree()
{
	...
	if (unlikely(max_pkey <= execute_only_key)) {
		/*
		 * Insufficient number of keys to support
		 * execute only key. Mark it unavailable.
		 */
		execute_only_key = -1;

void pkey_mm_init(struct mm_struct *mm)
{
	...
	mm->context.execute_only_pkey = execute_only_key;
}


ie. Can't it just be:

static inline int execute_only_pkey(struct mm_struct *mm)
{
	return mm->context.execute_only_pkey;
}

cheers
