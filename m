Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88015C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 08:55:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20CD604D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 08:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E20CD604D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzLcQ27b9z30Pd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 18:55:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzLbt2kJnz2yfn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 18:54:47 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GzLbm5bJSz9sTZ;
 Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7g6dDEZLufQh; Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GzLbm4cx0z9sTX;
 Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8243C8B7DE;
 Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ETEfsJj37GqN; Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 14BA48B7DD;
 Tue, 31 Aug 2021 10:54:44 +0200 (CEST)
Subject: Re: [PATCH] powerpc/64: Avoid link stack corruption in kexec_wait()
To: Daniel Axtens <dja@axtens.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <3ffe7775f3fcda8e5fca6a7bc7db0b8251153c67.1629705147.git.christophe.leroy@csgroup.eu>
 <87ilzm6str.fsf@dja-thinkpad.axtens.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9f43118b-ef81-9a80-0e0b-5e74433e0b8c@csgroup.eu>
Date: Tue, 31 Aug 2021 10:54:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ilzm6str.fsf@dja-thinkpad.axtens.net>
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



Le 31/08/2021 à 08:17, Daniel Axtens a écrit :
> Hi Christophe,
> 
>> Use bcl 20,31,+4 instead of bl in order to preserve link stack.
>>
>> See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
>> in __get_datapage()") for details.
> 
>  From my understanding of that commit message, the change helps to keep
> the link stack correctly balanced which is helpful for performance,
> rather than for correctness. If I understand correctly, kexec_wait is
> not in a hot path - rather it is where CPUs spin while waiting for
> kexec. Is there any benefit in using the more complicated opcode in this
> situation?

AFAICS the main benefit is to keep things consistent over the kernel and not have to wonder "is it a 
hot path or not ? If it is I use bcl 20,31, if it is not I use bl". The best way to keep things in 
order is to always use the right instruction.

> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/kernel/misc_64.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
>> index 4b761a18a74d..613509907166 100644
>> --- a/arch/powerpc/kernel/misc_64.S
>> +++ b/arch/powerpc/kernel/misc_64.S
>> @@ -255,7 +255,7 @@ _GLOBAL(scom970_write)
>>    * Physical (hardware) cpu id should be in r3.
>>    */
>>   _GLOBAL(kexec_wait)
>> -	bl	1f
>> +	bcl	20,31,1f
>>   1:	mflr	r5
> 
> Would it be better to create a macro of some sort to wrap this unusual
> special form so that the meaning is more clear?

Not sure, I think people working with assembly will easily recognise that form whereas an obscure 
macro is always puzzling.

I like macros when they allow you to not repeat again and again the same sequence of several 
instructions, but here it is a single quite simple instruction which is not worth a macro in my mind.

Christophe
