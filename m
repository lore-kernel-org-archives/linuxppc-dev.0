Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA22C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 13:20:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D87F20656
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 13:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D87F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRVgc23CWzDqb9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 23:20:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BRTwZ25mYzDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 22:46:37 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4FD31B;
 Wed, 12 Aug 2020 05:46:35 -0700 (PDT)
Received: from [10.163.66.87] (unknown [10.163.66.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5973F70D;
 Wed, 12 Aug 2020 05:46:33 -0700 (PDT)
Subject: Re: [PATCH 08/16] debug_vm_pgtable/set_pmd: Don't use set_pmd_at to
 update an existing pmd entry
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20200812063358.369514-1-aneesh.kumar@linux.ibm.com>
 <20200812063358.369514-8-aneesh.kumar@linux.ibm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b6d72a0a-3ded-016a-67fe-fe704818a0d5@arm.com>
Date: Wed, 12 Aug 2020 18:16:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200812063358.369514-8-aneesh.kumar@linux.ibm.com>
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
> set_pmd_at() should not be used to set a pte entry at locations that
> already holds a valid pte entry. Architectures like ppc64 don't do TLB
> invalidate in set_pmd_at() and hence expect it to be used to set locations
> that are not a valid PTE.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index cd609a212dd4..60bf876081b8 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -164,8 +164,6 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(pmd_write(pmd));
>  
> -	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> -	set_pmd_at(mm, vaddr, pmdp, pmd);
>  	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(!pmd_none(pmd));
> @@ -180,12 +178,11 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
>  
> -	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> -	set_pmd_at(mm, vaddr, pmdp, pmd);
>  	pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(!pmd_none(pmd));
>  
> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>  	pmd = pmd_mkyoung(pmd);
>  	set_pmd_at(mm, vaddr, pmdp, pmd);
>  	pmdp_test_and_clear_young(vma, vaddr, pmdp);
> 

Very similar to [PATCH 3/16] wrt set_pte_at(), please fold it.
