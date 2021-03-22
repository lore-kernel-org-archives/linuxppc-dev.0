Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EBC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 16:50:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44C46191D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 16:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44C46191D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F40qP25t7z30FM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:50:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F40q23YTkz2xfm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 03:50:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F40pq3YHkz9txkX;
 Mon, 22 Mar 2021 17:49:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id g_KnKQSA1Ofv; Mon, 22 Mar 2021 17:49:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F40pq2JdCz9txkB;
 Mon, 22 Mar 2021 17:49:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 03E5F8B7A3;
 Mon, 22 Mar 2021 17:50:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xBNVr42Tsd28; Mon, 22 Mar 2021 17:50:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 77CE98B79C;
 Mon, 22 Mar 2021 17:50:00 +0100 (CET)
Subject: Re: [RFC PATCH 6/8] powerpc/mm/book3s64/hash: drop pre 2.06 tlbiel
 for clang
To: Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-7-dja@axtens.net>
 <1616118111.i881ydq4h2.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7f7cafb5-e6c4-5015-5285-9f9ca25e52fb@csgroup.eu>
Date: Mon, 22 Mar 2021 17:49:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616118111.i881ydq4h2.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 19/03/2021 à 03:01, Nicholas Piggin a écrit :
> Excerpts from Daniel Axtens's message of February 25, 2021 1:10 pm:
>> The llvm integrated assembler does not recognise the ISA 2.05 tlbiel
>> version. Eventually do this more smartly.
> 
> The whole thing with TLBIE and TLBIEL in this file seems a bit too
> clever. We should have PPC_TLBIE* macros for all of them.

I was expecting to drop PPC_* macros as much as possible taking into account the later binutils 
support most of them (https://github.com/linuxppc/issues/issues/350). Was not expecting to go the 
other direction.

See following series for an exemple of why we would want to get rid of PPC_* macros.

https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=231583&state=*

Christophe

> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>   arch/powerpc/mm/book3s64/hash_native.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
>> index 52e170bd95ae..c5937f69a452 100644
>> --- a/arch/powerpc/mm/book3s64/hash_native.c
>> +++ b/arch/powerpc/mm/book3s64/hash_native.c
>> @@ -267,9 +267,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>>   		va |= ssize << 8;
>>   		sllp = get_sllp_encoding(apsize);
>>   		va |= sllp << 5;
>> +#if 0
>>   		asm volatile(ASM_FTR_IFSET("tlbiel %0", "tlbiel %0,0", %1)
>>   			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
>>   			     : "memory");
>> +#endif
>> +		asm volatile("tlbiel %0"
>> +			     : : "r" (va)
>> +			     : "memory");
>>   		break;
>>   	default:
>>   		/* We need 14 to 14 + i bits of va */
>> @@ -286,9 +291,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>>   		 */
>>   		va |= (vpn & 0xfe);
>>   		va |= 1; /* L */
>> +#if 0
>>   		asm volatile(ASM_FTR_IFSET("tlbiel %0", "tlbiel %0,1", %1)
>>   			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
>>   			     : "memory");
>> +#endif
>> +		asm volatile("tlbiel %0"
>> +			     : : "r" (va)
>> +			     : "memory");
>>   		break;
>>   	}
>>   	trace_tlbie(0, 1, va, 0, 0, 0, 0);
>> -- 
>> 2.27.0
>>
>>
