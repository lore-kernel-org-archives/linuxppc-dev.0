Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DCCC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 06:02:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E4D218A5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 06:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ik55Wz8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E4D218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Px5R2MG0zDqD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 17:02:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Ik55Wz8u"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Px300kGJzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 17:00:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Px2s3S2VzB09ZN;
 Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Ik55Wz8u; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id wswbAT7RI93K; Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Px2s2JGMzB09ZM;
 Thu, 21 Mar 2019 07:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553148005; bh=Iw6NoawQM0GrtLmPpbr42oycLqMZGHJByjvdQTVvx8k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ik55Wz8uVogNzpAewAr4LAyO7zslcDWA8fZoqloH+6Ajl0q30XMPWaervWp6PK/uk
 Yssm34mYuAayxU3iTtRSdhpMrov7CQZMCxvswDyfI1ZYkuSmmWUnsHAuLTZPeoYolx
 HXlVJ+tRkOEYTjds6uqLV2gqs9ROmlL2DdZw25Fk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B5708B7CC;
 Thu, 21 Mar 2019 07:00:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xRVnTIWARwtR; Thu, 21 Mar 2019 07:00:06 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 771D68B74C;
 Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Subject: Re: [PATCH] powerpc/highmem: change BUG_ON() to WARN_ON()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr>
 <87va0c23s8.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
Date: Thu, 21 Mar 2019 07:00:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87va0c23s8.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/03/2019 à 06:29, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
>> CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
>> not vital and can be replaced by a a WARN_ON
>>
>> At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/highmem.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
>> index 82a0e37557a5..b68c9f20fbdf 100644
>> --- a/arch/powerpc/mm/highmem.c
>> +++ b/arch/powerpc/mm/highmem.c
>> @@ -56,7 +54,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>>   void __kunmap_atomic(void *kvaddr)
>>   {
>>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
>> -	int type __maybe_unused;
>> +	int type;
> 
> Why don't we move type into the block below.

Yes you're right, when Mathieu introduced the __maybe_unused, I was 
wrongly thinging that kmap_atomic_idx() was doing something important 
that had to be done also when DEBUG was not selected, but indeed it does 
nothing else than returning the type.

I'll send a new patch.

Christophe

> 
> eg:
> 
>> @@ -66,12 +64,11 @@ void __kunmap_atomic(void *kvaddr)
>>   
> -  	type = kmap_atomic_idx();
>>   
>> -#ifdef CONFIG_DEBUG_HIGHMEM
>> -	{
>> +	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
>    		int type = kmap_atomic_idx();
>>   		unsigned int idx;
>>   
>>   		idx = type + KM_TYPE_NR * smp_processor_id();
>> -		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
>> +		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
> 
> 
> cheers
> 
