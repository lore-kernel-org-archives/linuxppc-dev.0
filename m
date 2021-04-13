Return-Path: <SRS0=AS1h=JK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6B7C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 16:37:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E8160720
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E8160720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FKWTp32ZFz3bVR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 02:37:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FKWTR0BWfz2yhK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2021 02:36:42 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FKWTL3l94z9v4hC;
 Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DydKvha3r-0P; Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWTL1dSsz9v4h8;
 Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B63518B7AA;
 Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id l6EiQIyyQ9dS; Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5627A8B75F;
 Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
Subject: Re: [PATCH v1 2/2] powerpc/atomics: Use immediate operand when
 possible
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <9f50b5fadeb090553e5c2fae025052d04d52f3c7.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412220821.GN26583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <063ca819-1276-8deb-0d9b-ea6ec33f9a98@csgroup.eu>
Date: Tue, 13 Apr 2021 18:36:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412220821.GN26583@gate.crashing.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/04/2021 à 00:08, Segher Boessenkool a écrit :
> Hi!
> 
> On Thu, Apr 08, 2021 at 03:33:45PM +0000, Christophe Leroy wrote:
>> +#define ATOMIC_OP(op, asm_op, dot, sign)				\
>>   static __inline__ void atomic_##op(int a, atomic_t *v)			\
>>   {									\
>>   	int t;								\
>>   									\
>>   	__asm__ __volatile__(						\
>>   "1:	lwarx	%0,0,%3		# atomic_" #op "\n"			\
>> -	#asm_op " %0,%2,%0\n"						\
>> +	#asm_op "%I2" dot " %0,%0,%2\n"					\
>>   "	stwcx.	%0,0,%3 \n"						\
>>   "	bne-	1b\n"							\
>> -	: "=&r" (t), "+m" (v->counter)					\
>> -	: "r" (a), "r" (&v->counter)					\
>> +	: "=&b" (t), "+m" (v->counter)					\
>> +	: "r"#sign (a), "r" (&v->counter)				\
>>   	: "cc");							\
>>   }									\
> 
> You need "b" (instead of "r") only for "addi".  You can use "addic"
> instead, which clobbers XER[CA], but *all* inline asm does, so that is
> not a downside here (it is also not slower on any CPU that matters).
> 
>> @@ -238,14 +238,14 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>>   "1:	lwarx	%0,0,%1		# atomic_fetch_add_unless\n\
>>   	cmpw	0,%0,%3 \n\
>>   	beq	2f \n\
>> -	add	%0,%2,%0 \n"
>> +	add%I2	%0,%0,%2 \n"
>>   "	stwcx.	%0,0,%1 \n\
>>   	bne-	1b \n"
>>   	PPC_ATOMIC_EXIT_BARRIER
>> -"	subf	%0,%2,%0 \n\
>> +"	sub%I2	%0,%0,%2 \n\
>>   2:"
>> -	: "=&r" (t)
>> -	: "r" (&v->counter), "r" (a), "r" (u)
>> +	: "=&b" (t)
>> +	: "r" (&v->counter), "rI" (a), "r" (u)
>>   	: "cc", "memory");
> 
> Same here.

Yes, I thought about addic, I didn't find an early solution because I forgot the matching 'addc'.

Now with the couple addc/addic it works well.

Thanks

> 
> Nice patches!
> 
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> 

Christophe
