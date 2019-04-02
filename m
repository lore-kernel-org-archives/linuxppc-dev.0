Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E096C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:38:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D517B2084B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="V3BXhgEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517B2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YdJr4lnQzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:38:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="V3BXhgEI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YdHD1jrdzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:37:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44YdH82t2Tz9v06N;
 Tue,  2 Apr 2019 20:37:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=V3BXhgEI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id a3O802W1TmIJ; Tue,  2 Apr 2019 20:37:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44YdH81V4hz9v06M;
 Tue,  2 Apr 2019 20:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554230244; bh=UqSCuolhi9NFsyzu8L/f8xSE5kUzvZ7ddFYRRS9N+EY=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=V3BXhgEIl3XSIavWoA9KbzXzA+1lAMKarFRbzCgbFsfM6Heaj2DRHj4X22HEMkCV5
 zyqrxM1rKMHHmNCRhHogtIKGiyT8//OYTG/zoMGeeAUmV9dlUHHV6n8mc1JJ36WK85
 jqz5zq88vtzYDVviKWg+pxFTOzQ/DpeFEJVdVO60=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 402778B8D2;
 Tue,  2 Apr 2019 20:37:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0rsyb_JvQktg; Tue,  2 Apr 2019 20:37:24 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6130F8B8CD;
 Tue,  2 Apr 2019 20:37:23 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
 <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
Message-ID: <47e42023-8e0e-ece8-8a9d-a991dc7338c8@c-s.fr>
Date: Tue, 2 Apr 2019 20:37:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
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



Le 02/04/2019 à 20:31, Christophe Leroy a écrit :
> 
> 
> Le 02/04/2019 à 16:34, Aneesh Kumar K.V a écrit :
>> Currently, our mm_context_t on book3s64 include all hash specific
>> context details like slice mask, subpage protection details. We
>> can skip allocating those on radix. This will help us to save
>> 8K per mm_context with radix translation.
>>
>> With the patch applied we have
>>
>> sizeof(mm_context_t)  = 136
>> sizeof(struct hash_mm_context)  = 8288
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> NOTE:
>>
>> If we want to do this, I am still trying to figure out how best we can 
>> do this
>> without all the #ifdef and other overhead for 8xx book3e
>>
>>
>>   arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>>   arch/powerpc/include/asm/book3s/64/mmu.h      | 48 +++++++++++--------
>>   arch/powerpc/include/asm/book3s/64/slice.h    |  6 +--
>>   arch/powerpc/kernel/paca.c                    |  9 ++--
>>   arch/powerpc/kernel/setup-common.c            |  7 ++-
>>   arch/powerpc/mm/hash_utils_64.c               | 10 ++--
>>   arch/powerpc/mm/mmu_context_book3s64.c        | 16 ++++++-
>>   arch/powerpc/mm/slb.c                         |  2 +-
>>   arch/powerpc/mm/slice.c                       | 48 +++++++++----------
>>   arch/powerpc/mm/subpage-prot.c                |  8 ++--
>>   10 files changed, 91 insertions(+), 65 deletions(-)
>>

[...]

>> @@ -253,7 +253,7 @@ static void slice_convert(struct mm_struct *mm,
>>        */
>>       spin_lock_irqsave(&slice_convert_lock, flags);
>> -    lpsizes = mm->context.low_slices_psize;
>> +    lpsizes = mm->context.hash_context->low_slices_psize;
> 
> A help to get ->low_slices_psize would help,
> something like:
> 
> In nohash/32/mmu-8xx:
> 
> unsigned char *slice_low_slices_psize(context_t *ctx)
> {
>      return mm->context.low_slices_psize;

Of course here I meant:

unsigned char *slice_low_slices_psize(mm_context_t *ctx)
{
	return ctx->low_slices_psize;
}

> }
> 
> And in book3s/64/mmu.h:
> 
> unsigned char *slice_low_slices_psize(context_t *ctx)
> {
>      return mm->context.hash_context->low_slices_psize;

and

unsigned char *slice_low_slices_psize(mm_context_t *ctx)
{
	return ctx->hash_context->low_slices_psize;
}

Christophe
