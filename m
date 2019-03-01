Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:27:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70B420857
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70B420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449ZbT2v1ZzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:27:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449ZXP0WDJzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 14:24:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 449ZXN0wlkz9sCJ;
 Fri,  1 Mar 2019 14:24:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: fix "sz" set but not used
In-Reply-To: <20190228023505.80092-1-cai@lca.pw>
References: <20190228023505.80092-1-cai@lca.pw>
Date: Fri, 01 Mar 2019 14:24:16 +1100
Message-ID: <87ef7rjmzj.fsf@concordia.ellerman.id.au>
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qian Cai <cai@lca.pw> writes:
> arch/powerpc/mm/hugetlbpage-hash64.c: In function '__hash_page_huge':
> arch/powerpc/mm/hugetlbpage-hash64.c:29:28: warning: variable 'sz' set
> but not used [-Wunused-but-set-variable]

It's always nice to know *why* it's not used.

It's unlikely, but not impossible, that it's a bug that the variable is
not used.

To find out why:

  $ git log --oneline -S sz arch/powerpc/mm/hugetlbpage-hash64.c
  0895ecda7942 powerpc/mm: Bring hugepage PTE accessor functions back into sync with normal accessors
  883a3e523672 powerpc/mm: Split hash MMU specific hugepage code into a new file

Then we look at those, and see the the first one did:

@@ -89,8 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
        if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
                /* No CPU has hugepages but lacks no execute, so we
                 * don't need to worry about that case */
-               rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
-                                                      trap, sz);
+               rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);


And if you read the commit log it's pretty clear the change was
deliberate and so sz should indeed be removed.

I've applied this as-is, no need to send a v2.

cheers

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 2e6a8f9345d3..f6b09edc5e6e 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -26,7 +26,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	real_pte_t rpte;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
> -	unsigned long rflags, pa, sz;
> +	unsigned long rflags, pa;
>  	long slot, offset;
>  
>  	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
> @@ -73,7 +73,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		offset = PTRS_PER_PMD;
>  	rpte = __real_pte(__pte(old_pte), ptep, offset);
>  
> -	sz = ((1UL) << shift);
>  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>  		/* No CPU has hugepages but lacks no execute, so we
>  		 * don't need to worry about that case */
> -- 
> 2.17.2 (Apple Git-113)
