Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 17:00:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877F9206DD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 17:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Rvx+Vllp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877F9206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zq1q4y8rzDqDK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:59:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Rvx+Vllp"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zpx43NkKzDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:55:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Zpwx27qQz9tyP5;
 Thu,  4 Apr 2019 18:55:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Rvx+Vllp; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RHEzvQwztqBp; Thu,  4 Apr 2019 18:55:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Zpwx131qz9tyP4;
 Thu,  4 Apr 2019 18:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554396945; bh=v7COA/1RLLUwkFQvnQteQnpYRPqepGhm1mFnHoinGYM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Rvx+Vllp1ljPrdejuJDm/tmbjy6F9tf1aqh316KRCKXZQIbOmYpOj1RFJjsbF+oYi
 B5doPuGSVcb1DukocuiKKDX4qYaIHgqK7YvTdmkjFif1BFQ9+Rz48dchPSFKt4w8uL
 IlQmJ/NgzegtUraLgpnGL1rRf3+GvLlAqBa5bzFw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C92A28B92A;
 Thu,  4 Apr 2019 18:55:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1o3zpKexUQAf; Thu,  4 Apr 2019 18:55:46 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3298B917;
 Thu,  4 Apr 2019 18:55:46 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org
References: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
 <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
 <1554393943.3joom3btwy.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8f28647d-8b4c-e001-a2ac-dd254d883bd5@c-s.fr>
Date: Thu, 4 Apr 2019 18:55:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554393943.3joom3btwy.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/04/2019 à 18:13, Nicholas Piggin a écrit :
> Christophe Leroy's on April 3, 2019 4:31 am:
>>
>>
>> Le 02/04/2019 à 16:34, Aneesh Kumar K.V a écrit :
>>> Currently, our mm_context_t on book3s64 include all hash specific
>>> context details like slice mask, subpage protection details. We
>>> can skip allocating those on radix. This will help us to save
>>> 8K per mm_context with radix translation.
>>>
>>> With the patch applied we have
>>>
>>> sizeof(mm_context_t)  = 136
>>> sizeof(struct hash_mm_context)  = 8288
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>> NOTE:
>>>
>>> If we want to do this, I am still trying to figure out how best we can do this
>>> without all the #ifdef and other overhead for 8xx book3e
>>>
>>>
>>>    arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>>>    arch/powerpc/include/asm/book3s/64/mmu.h      | 48 +++++++++++--------
>>>    arch/powerpc/include/asm/book3s/64/slice.h    |  6 +--
>>>    arch/powerpc/kernel/paca.c                    |  9 ++--
>>>    arch/powerpc/kernel/setup-common.c            |  7 ++-
>>>    arch/powerpc/mm/hash_utils_64.c               | 10 ++--
>>>    arch/powerpc/mm/mmu_context_book3s64.c        | 16 ++++++-
>>>    arch/powerpc/mm/slb.c                         |  2 +-
>>>    arch/powerpc/mm/slice.c                       | 48 +++++++++----------
>>>    arch/powerpc/mm/subpage-prot.c                |  8 ++--
>>>    10 files changed, 91 insertions(+), 65 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> index a28a28079edb..d801be977623 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> @@ -657,7 +657,7 @@ extern void slb_set_size(u16 size);
>>>    
>>>    /* 4 bits per slice and we have one slice per 1TB */
>>>    #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
>>> -#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
>>> +#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.hash_context->slb_addr_limit >> 41)
>>>    
>>>    #ifndef __ASSEMBLY__
>>>    
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
>>> index a809bdd77322..07e76e304a3b 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>>> @@ -114,6 +114,33 @@ struct slice_mask {
>>>    	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
>>>    };
>>>    
>>> +struct hash_mm_context {
>>> +
>>> +	u16 user_psize; /* page size index */
>>
>> Could we keep that in mm_context_t ?
> 
> Why do you want it there?

It was just to avoid so many changes and also the pointer complexity for 
just saving 2 bytes. But your suggestion below seems good.

> 
> 
>>> @@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>>>    {
>>>    #ifdef CONFIG_PPC_64K_PAGES
>>>    	if (psize == MMU_PAGE_64K)
>>> -		return &mm->context.mask_64k;
>>> +		return &mm->context.hash_context->mask_64k;
>>
>> You should take the two patches below, that would help:
>> https://patchwork.ozlabs.org/patch/1059056/
>> https://patchwork.ozlabs.org/patch/1059058/
> 
> Above patches seem good I think. What I think Aneesh should have is
> is a macro or inline that gives a pointer to the hash_mm_context from
> an mm_context pointer.

Good idea. But please call it something else, as it has nothing to do 
with hash outside of book3s64 (ie the 8xx is a nohash32).

Christophe

> 
> Architectures which always want it should just put the hash struct
> in their mm_context struct and that avoids the pointer overhead
> completely.
> 
> Thanks,
> Nick
> 
