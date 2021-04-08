Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E654C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 15:26:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CA261139
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CA261139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGQ8872M3z3bwp
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 01:26:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGQ7n5hmxz30FK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Apr 2021 01:25:37 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FGQ7c23dGz9txdj;
 Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zsF4pkh7DYuh; Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQ7c0v8Xz9txdh;
 Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B4BD68B7D1;
 Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qTLohSVjcwj3; Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 120BE8B7D0;
 Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
Subject: Re: [PATCH v1 2/8] powerpc/mem: Remove address argument to
 flush_coherent_icache()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
 <8cbdcfc4446154bd3323cc68827f114aa9bbc5e7.1617816138.git.christophe.leroy@csgroup.eu>
 <87k0pdb1n6.fsf@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8fdbc753-4ed6-ee3f-3317-f0ea5b95bbc9@csgroup.eu>
Date: Thu, 8 Apr 2021 17:25:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87k0pdb1n6.fsf@linux.ibm.com>
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



Le 08/04/2021 à 10:50, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> flush_coherent_icache() can use any valid address as mentionned
>> by the comment.
>>
>> Use PAGE_OFFSET as base address. This allows removing the
>> user access stuff.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/mem.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index ce6c81ce4362..19f807b87697 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -342,10 +342,9 @@ void free_initmem(void)
>>   
>>   /**
>>    * flush_coherent_icache() - if a CPU has a coherent icache, flush it
>> - * @addr: The base address to use (can be any valid address, the whole cache will be flushed)
>>    * Return true if the cache was flushed, false otherwise
>>    */
>> -static inline bool flush_coherent_icache(unsigned long addr)
>> +static inline bool flush_coherent_icache(void)
>>   {
>>   	/*
>>   	 * For a snooping icache, we still need a dummy icbi to purge all the
>> @@ -355,9 +354,7 @@ static inline bool flush_coherent_icache(unsigned long addr)
>>   	 */
>>   	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
>>   		mb(); /* sync */
>> -		allow_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
>> -		icbi((void *)addr);
>> -		prevent_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
>> +		icbi((void *)PAGE_OFFSET);
>>   		mb(); /* sync */
>>   		isync();
>>   		return true;
> 
> do we need that followup sync? Usermanual suggest sync; icbi(any address);
> isync sequence.

I don't know.

The original implementation is here: https://github.com/linuxppc/linux/commit/0ce636700

Christophe
