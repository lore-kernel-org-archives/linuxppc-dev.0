Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6094C56202
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 14:52:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F4020B80
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBpBmf5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChghZ27ylzDqbC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 01:52:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=NBpBmf5V; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChgGN6KgMzDqst
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 01:33:00 +1100 (AEDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EEC42065E;
 Thu, 26 Nov 2020 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606401178;
 bh=5dY8cbJVS6zfD7uZoLaby4Q2OOwNKKL2V1i9udJweeM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NBpBmf5VIbEXO88WpbzA6/iIU7KMKeADvAYkqkUzwv1+1V2haTEx2Ph0bDJb0KmlY
 s1ebOaFIn/gppwqJN43nLeT+6RcP0IDfD2unluy9hcIsWJUDt1xc18gs4uuGOWCHNg
 0HUeP5Xqav3l1507RgGTmw4lRaV28Zv5UHxU3gi8=
Date: Thu, 26 Nov 2020 14:32:50 +0000
From: Will Deacon <will@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/6] arm64/mm: Implement pXX_leaf_size() support
Message-ID: <20201126143249.GA18344@willie-the-truck>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.226210959@infradead.org>
 <20201126125747.GG2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126125747.GG2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, aneesh.kumar@linux.ibm.com, willy@infradead.org,
 catalin.marinas@arm.com, alexander.shishkin@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, davem@davemloft.net, dave.hansen@intel.com,
 ak@linux.intel.com, eranian@google.com, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
 kirill.shutemov@linux.intel.com, kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 26, 2020 at 01:57:47PM +0100, Peter Zijlstra wrote:
> 
> Now with pmd_cont() defined...
> 
> ---
> Subject: arm64/mm: Implement pXX_leaf_size() support
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 13 11:46:06 CET 2020
> 
> ARM64 has non-pagetable aligned large page support with PTE_CONT, when
> this bit is set the page is part of a super-page. Match the hugetlb
> code and support these super pages for PTE and PMD levels.
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
> pagetable leaf sizes.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/pgtable.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -407,6 +407,7 @@ static inline int pmd_trans_huge(pmd_t p
>  #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
>  #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
>  #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
> +#define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
>  #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
>  #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
>  #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> @@ -503,6 +504,9 @@ extern pgprot_t phys_mem_access_prot(str
>  				 PMD_TYPE_SECT)
>  #define pmd_leaf(pmd)		pmd_sect(pmd)
>  
> +#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
> +#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
> +
>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
>  static inline bool pud_sect(pud_t pud) { return false; }
>  static inline bool pud_table(pud_t pud) { return true; }

Acked-by: Will Deacon <will@kernel.org>

I'm still highly dubious about the utility of this feature in perf, since
the TLB entry size is pretty much independent of the page-table
configuration, but that's a problem for all architectures I suspect.

Will
