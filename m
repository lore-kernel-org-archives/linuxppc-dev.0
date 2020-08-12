Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7928C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 07:48:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68546205CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 07:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68546205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRMJf4GcczDqYt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 17:48:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BRMGn1mCQzDqVc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 17:46:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08DAD6E;
 Wed, 12 Aug 2020 00:46:51 -0700 (PDT)
Received: from [10.163.66.87] (unknown [10.163.66.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280943F22E;
 Wed, 12 Aug 2020 00:46:49 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 01/16] powerpc/mm: Add DEBUG_VM WARN for pmd_clear
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20200812063358.369514-1-aneesh.kumar@linux.ibm.com>
Message-ID: <8b951ede-d779-d18f-b2b8-d09f94af6822@arm.com>
Date: Wed, 12 Aug 2020 13:16:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200812063358.369514-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 08/12/2020 12:03 PM, Aneesh Kumar K.V wrote:
> With the hash page table, the kernel should not use pmd_clear for clearing
> huge pte entries. Add a DEBUG_VM WARN to catch the wrong usage.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

This particular change is very much powerpc specific. Hence please drop it from
the series which otherwise changes the page table test. Also, this series which
is not a RFC, still lacks a proper cover letter with diff stats, tree/tag on
which this applies, summary about the proposal etc. All those information will
be helpful in reviewing this series better. For now, assuming that this applies
cleanly on current master branch. But again, please do include a cover letter
in the next version.

> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 6de56c3b33c4..079211968987 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -868,6 +868,13 @@ static inline bool pte_ci(pte_t pte)
>  
>  static inline void pmd_clear(pmd_t *pmdp)
>  {
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && !radix_enabled()) {
> +		/*
> +		 * Don't use this if we can possibly have a hash page table
> +		 * entry mapping this.
> +		 */
> +		WARN_ON((pmd_val(*pmdp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));
> +	}
>  	*pmdp = __pmd(0);
>  }
>  
> @@ -916,6 +923,13 @@ static inline int pmd_bad(pmd_t pmd)
>  
>  static inline void pud_clear(pud_t *pudp)
>  {
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && !radix_enabled()) {
> +		/*
> +		 * Don't use this if we can possibly have a hash page table
> +		 * entry mapping this.
> +		 */
> +		WARN_ON((pud_val(*pudp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));
> +	}
>  	*pudp = __pud(0);
>  }
>  
> 
