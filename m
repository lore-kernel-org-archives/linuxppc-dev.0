Return-Path: <linuxppc-dev+bounces-18471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1D41093170
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:09:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcSGS3RbJz2xm5;
	Fri, 20 Mar 2026 14:09:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773976176;
	cv=none; b=HJ9ZPHfIMh/anQ0K9V37hSFRbzxeMVqLtB60uLP+Sc9Wxl4zOcTtw4Ndkot8a4R8Nmgth++6WmjXm0mpbfYwFFvu4sDZSzVhO93Le0upM1+2zXZ0sldYgp961ZkixH6SM2YciGRap42BbA6i9a1QvzBQW+ckOhbDT7OH/y4+t66eMCqsbGxxpARblUE0MFDizNcmL/V95yzxiv4iwQqKUSEbTwGo9YkdQRHIFHzZ0AF/kW0uEyDz2q5xZu/9pvDWQcuomT46pSYO7EhgE/DVsBo1lauIaVfLaHLz3egssTZbyCcoFrBUqWWGocpcqo1StD+zwzdLOUnWwK9SVFgebA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773976176; c=relaxed/relaxed;
	bh=VWrUuwn6/3D2jBpHTBrix7nCaDc+sDPWfC/Ra1XXa8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m69ZlaPHi0xjQ0vZaKdM0rrukUcvNTOilg07MFBnAQD1tztBRb4zQbIBlI6gJ23hi+krF6G4l1ETBQNmTrDKyXohruRI2u0umaenj95tnzBToX6rkNP2s1rDsIhniP4OI60aP5gYwrIzQPYxu4vXmWhkufjYTSs+DlkT+xGuZ2bmCuFf4w3j0AowVa5FW7Vd7qmA7Wo2JliBx/q/PYSSzVaD/9sahyDUcuXRuRfX1vvsSBrqka2hbq9gSBStJhqOulVqJ42DejLURTOudNX1aTNIwDvJT+6JgQXFl+VTDeOFjOlEgWqavI38w27rzQ5CWrnfLMUGydeszUpBWnp8Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j7VGs8Kj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j7VGs8Kj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcSGR0LsYz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:09:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976170; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VWrUuwn6/3D2jBpHTBrix7nCaDc+sDPWfC/Ra1XXa8Q=;
	b=j7VGs8KjVuuuzQ1cQvvGaD/P/rZRDoIb2hSGGkSaYazWS9aMVrPy3EM/GFinsa3FmB7EW832UoPIAb/fL86fZER3F0IzAPD1PgXdbnNkseuF4Rbd+3Rol4vmur4hB+4+FPxap/HdH3kkREaQoCnvwpj4j0jLo6ern/fcRlfe6os=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K9Y71_1773976168;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K9Y71_1773976168 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:09:29 +0800
Message-ID: <a745d7ad-5d6b-4bef-b102-09139f56556c@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:09:28 +0800
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
Subject: Re: [PATCH 4/6] mm: change to return bool for
 pmdp_clear_flush_young()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <eb513ed809685f78e0abdeb7f7b6ebdec0fcca18.1773890510.git.baolin.wang@linux.alibaba.com>
 <60e7cc1b-1459-44d8-8088-30b7ba3e9b44@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <60e7cc1b-1459-44d8-8088-30b7ba3e9b44@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/26 7:33 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:03AM +0800, Baolin Wang wrote:
>> The pmdp_clear_flush_young() is used to clear the young flag and flush the
>> TLB, returning whether the young flag was set for this PMD entry. Change
>> the return type to bool to make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Some nits, but otherwise LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
>> ---
>>   arch/s390/include/asm/pgtable.h |  4 ++--
>>   arch/x86/include/asm/pgtable.h  |  4 ++--
>>   arch/x86/mm/pgtable.c           |  6 +++---
>>   include/linux/pgtable.h         | 10 +++++-----
>>   mm/pgtable-generic.c            |  7 ++++---
>>   5 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 1f5efb7be71d..90bba85ca4b8 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1693,8 +1693,8 @@ static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>>   }
>>
>>   #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>> -static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -					 unsigned long addr, pmd_t *pmdp)
>> +static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +					  unsigned long addr, pmd_t *pmdp)
> 
> Same indentation comment as with other patches, 2 tabs you know the drill :)
> applies to all such in this patch.
> 
>>   {
>>   	VM_BUG_ON(addr & ~HPAGE_MASK);
>>   	return pmdp_test_and_clear_young(vma, addr, pmdp);
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index bd02ee730a23..f9439449c9bd 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1301,8 +1301,8 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>>   				     unsigned long addr, pud_t *pudp);
>>
>>   #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -				  unsigned long address, pmd_t *pmdp);
>> +extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +				   unsigned long address, pmd_t *pmdp);
> 
> Drop the extern please!

Ack.

>>   #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 10a5e0b2be36..8c336edf0e65 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -503,10 +503,10 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>>   }
>>
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -			   unsigned long address, pmd_t *pmdp)
>> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +			    unsigned long address, pmd_t *pmdp)
>>   {
>> -	int young;
>> +	bool young;
>>
>>   	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index e53220b0a9a3..8b8838f19af3 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -536,18 +536,18 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>>
>>   #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -				  unsigned long address, pmd_t *pmdp);
>> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +		unsigned long address, pmd_t *pmdp);
> 
> Ahh! Here you drop the extern :) AND use 2 tabs :)) thanks!

Right. Because this is the mm subsystem, and I know the maintainers' 
preferences:)

