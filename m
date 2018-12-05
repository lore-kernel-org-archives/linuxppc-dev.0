Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61105C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:57:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1982081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1982081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438mgC6MLgzDqng
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438mLb6mNdzDqlr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 15:42:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 438mLX1PRbz9v08l;
 Wed,  5 Dec 2018 05:42:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id YXa3vaUCdKE7; Wed,  5 Dec 2018 05:42:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 438mLX08HYz9v08k;
 Wed,  5 Dec 2018 05:42:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B68E58B829;
 Wed,  5 Dec 2018 05:42:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LNHFL8eh-QhB; Wed,  5 Dec 2018 05:42:44 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 063558B755;
 Wed,  5 Dec 2018 05:42:43 +0100 (CET)
Subject: Re: [PATCH V3 2/5] mm: update ptep_modify_prot_commit to take old pte
 value as arg
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
References: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
 <20181205030931.12037-3-aneesh.kumar@linux.ibm.com>
 <f446afd3-a77d-cc5a-1ac8-3992090bcd7d@c-s.fr>
 <48f13462-1695-a759-9df8-1ef60fd88196@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3c1395e0-8a06-e407-80ba-2d634a9e01e9@c-s.fr>
Date: Wed, 5 Dec 2018 05:42:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <48f13462-1695-a759-9df8-1ef60fd88196@linux.ibm.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/12/2018 à 05:06, Aneesh Kumar K.V a écrit :
> On 12/5/18 9:32 AM, Christophe LEROY wrote:
>>
>>
>> Le 05/12/2018 à 04:09, Aneesh Kumar K.V a écrit :
>>> Architectures like ppc64 requires to do a conditional tlb flush based 
>>> on the old
>>> and new value of pte. Enable that by passing old pte value as the arg.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>   arch/s390/include/asm/pgtable.h | 3 ++-
>>>   arch/s390/mm/pgtable.c          | 2 +-
>>>   arch/x86/include/asm/paravirt.h | 2 +-
>>>   fs/proc/task_mmu.c              | 8 +++++---
>>>   include/asm-generic/pgtable.h   | 2 +-
>>>   mm/memory.c                     | 8 ++++----
>>>   mm/mprotect.c                   | 6 +++---
>>>   7 files changed, 17 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/pgtable.h 
>>> b/arch/s390/include/asm/pgtable.h
>>> index 5d730199e37b..76dc344edb8c 100644
>>> --- a/arch/s390/include/asm/pgtable.h
>>> +++ b/arch/s390/include/asm/pgtable.h
>>> @@ -1070,7 +1070,8 @@ static inline pte_t ptep_get_and_clear(struct 
>>> mm_struct *mm,
>>>   #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>>>   pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned 
>>> long, pte_t *);
>>> -void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long, 
>>> pte_t *, pte_t);
>>> +void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
>>> +                 pte_t *, pte_t, pte_t);
>>>   #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>>   static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
>>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>>> index 29c0a21cd34a..b283b92722cc 100644
>>> --- a/arch/s390/mm/pgtable.c
>>> +++ b/arch/s390/mm/pgtable.c
>>> @@ -322,7 +322,7 @@ pte_t ptep_modify_prot_start(struct 
>>> vm_area_struct *vma, unsigned long addr,
>>>   EXPORT_SYMBOL(ptep_modify_prot_start);
>>>   void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned 
>>> long addr,
>>> -                 pte_t *ptep, pte_t pte)
>>> +                 pte_t *ptep, pte_t old_pte, pte_t pte)
>>>   {
>>>       pgste_t pgste;
>>>       struct mm_struct *mm = vma->vm_mm;
>>> diff --git a/arch/x86/include/asm/paravirt.h 
>>> b/arch/x86/include/asm/paravirt.h
>>> index 1154f154025d..0d75a4f60500 100644
>>> --- a/arch/x86/include/asm/paravirt.h
>>> +++ b/arch/x86/include/asm/paravirt.h
>>> @@ -429,7 +429,7 @@ static inline pte_t ptep_modify_prot_start(struct 
>>> vm_area_struct *vma, unsigned
>>>   }
>>>   static inline void ptep_modify_prot_commit(struct vm_area_struct 
>>> *vma, unsigned long addr,
>>> -                       pte_t *ptep, pte_t pte)
>>> +                       pte_t *ptep, pte_t old_pte, pte_t pte)
>>>   {
>>>       struct mm_struct *mm = vma->vm_mm;
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 9952d7185170..8d62891d38a8 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -940,10 +940,12 @@ static inline void clear_soft_dirty(struct 
>>> vm_area_struct *vma,
>>>       pte_t ptent = *pte;
>>>       if (pte_present(ptent)) {
>>> -        ptent = ptep_modify_prot_start(vma, addr, pte);
>>> -        ptent = pte_wrprotect(ptent);
>>> +        pte_t old_pte;
>>> +
>>> +        old_pte = ptep_modify_prot_start(vma, addr, pte);
>>> +        ptent = pte_wrprotect(old_pte);
>>
>> This change doesn't seem to fit with the commit description. Why write 
>> protecting in addition to clearing dirty ?
>>
>>
> 
> The hunk above use a new variable old_pte. There is no functional change 
> in that hunk.
> 

Oops, sorry, I misread the patch, don't know why.

Christophe
