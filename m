Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ABFC433E3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 09:15:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9556E2078B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 09:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9556E2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRPDS30vSzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BRPBB143pzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 19:13:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1202BD6E;
 Wed, 12 Aug 2020 02:13:01 -0700 (PDT)
Received: from [10.163.66.87] (unknown [10.163.66.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42F4E3F22E;
 Wed, 12 Aug 2020 02:12:58 -0700 (PDT)
Subject: Re: [PATCH 03/16] debug_vm_pgtable/set_pte: Don't use set_pte_at to
 update an existing pte entry
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20200812063358.369514-1-aneesh.kumar@linux.ibm.com>
 <20200812063358.369514-3-aneesh.kumar@linux.ibm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <94ed519a-2cf2-af50-82be-2a559dee7d86@arm.com>
Date: Wed, 12 Aug 2020 14:42:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200812063358.369514-3-aneesh.kumar@linux.ibm.com>
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
> set_pte_at() should not be used to set a pte entry at locations that
> already holds a valid pte entry. Architectures like ppc64 don't do TLB
> invalidate in set_pte_at() and hence expect it to be used to set locations
> that are not a valid PTE.

Even though set_pte_at() is not really a arch page table helper and
very much arch specific, I just wonder why this deviation on ppc64
as compared to other platforms. Detecting such semantics variation
across platforms is an objective of this test.

As small nit.

Please follow the existing subject format for all patches in here.
It will improve readability and also help understand these changes
better, later on.

mm/debug_vm_pgtable: <Specify changes to an individual test>

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 4c32063a8acf..02a7c20aa4a2 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -81,8 +81,6 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  	pte = ptep_get(ptep);
>  	WARN_ON(pte_write(pte));
>  
> -	pte = pfn_pte(pfn, prot);
> -	set_pte_at(mm, vaddr, ptep, pte);
>  	ptep_get_and_clear(mm, vaddr, ptep);
>  	pte = ptep_get(ptep);
>  	WARN_ON(!pte_none(pte));

This makes sense. But could you please fold this code stanza with
the previous one in order to imply that 'ptep' did have some valid
entry before being cleared and checked against pte_none().

> @@ -97,12 +95,14 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  	pte = ptep_get(ptep);
>  	WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
>  
> -	pte = pfn_pte(pfn, prot);
> -	set_pte_at(mm, vaddr, ptep, pte);
>  	ptep_get_and_clear_full(mm, vaddr, ptep, 1);
>  	pte = ptep_get(ptep);
>  	WARN_ON(!pte_none(pte));

Same, please fold back.

>  
> +	/*
> +	 * We should clear pte before we do set_pte_at
> +	 */
> +	pte = ptep_get_and_clear(mm, vaddr, ptep);
>  	pte = pte_mkyoung(pte);
>  	set_pte_at(mm, vaddr, ptep, pte);
>  	ptep_test_and_clear_young(vma, vaddr, ptep);
>

The comment above should also explain details that are mentioned
in the commit message i.e how platforms such as ppc64 expects a
clear pte entry for set_pte_at() to work.
