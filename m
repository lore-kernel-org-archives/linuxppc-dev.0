Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D3C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D7F20672
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D7F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FmcR5QVdzDqnv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 19:12:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FmYp721xzDqsW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:09:50 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43FmYh2T2bz9v0fr;
 Thu, 13 Dec 2018 09:09:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fAPraMlzkj8R; Thu, 13 Dec 2018 09:09:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43FmYh1w79z9v0fk;
 Thu, 13 Dec 2018 09:09:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 200BA8B862;
 Thu, 13 Dec 2018 09:09:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Jui947cLBaEW; Thu, 13 Dec 2018 09:09:45 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A3FDF8B754;
 Thu, 13 Dec 2018 09:09:44 +0100 (CET)
Subject: Re: [PATCH] powerpc/8xx: hide itlbie and dtlbie symbols
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <8a48b395c3468f8020ea56af679530854b090e4c.1543404405.git.christophe.leroy@c-s.fr>
 <87ftv2x5d8.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3da93325-bb9a-1a09-68b3-43923b7fea5a@c-s.fr>
Date: Thu, 13 Dec 2018 09:09:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87ftv2x5d8.fsf@concordia.ellerman.id.au>
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



Le 12/12/2018 à 14:05, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> When disassembling InstructionTLBError we get the following messy code:
>>
>> c000138c:       7d 84 63 78     mr      r4,r12
>> c0001390:       75 25 58 00     andis.  r5,r9,22528
>> c0001394:       75 2a 40 00     andis.  r10,r9,16384
>> c0001398:       41 a2 00 08     beq     c00013a0 <itlbie>
>> c000139c:       7c 00 22 64     tlbie   r4,r0
>>
>> c00013a0 <itlbie>:
>> c00013a0:       39 40 04 01     li      r10,1025
>> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
>> c00013a8:       39 40 10 32     li      r10,4146
>> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
>>
>> For a cleaner code dump, this patch replaces itlbie and dtlbie
>> symbols by numeric symbols.
>>
>> c000138c:       7d 84 63 78     mr      r4,r12
>> c0001390:       75 25 58 00     andis.  r5,r9,22528
>> c0001394:       75 2a 40 00     andis.  r10,r9,16384
>> c0001398:       41 a2 00 08     beq     c00013a0 <InstructionTLBError+0xa0>
>> c000139c:       7c 00 22 64     tlbie   r4,r0
>> c00013a0:       39 40 04 01     li      r10,1025
>> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
>> c00013a8:       39 40 10 32     li      r10,4146
>> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/head_8xx.S | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
>> index 3b67b9533c82..8c848acfe249 100644
>> --- a/arch/powerpc/kernel/head_8xx.S
>> +++ b/arch/powerpc/kernel/head_8xx.S
>> @@ -552,11 +552,10 @@ InstructionTLBError:
>>   	mr	r4,r12
>>   	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
>>   	andis.	r10,r9,SRR1_ISI_NOPT@h
>> -	beq+	1f
>> +	beq+	1301f
>>   	tlbie	r4
>> -itlbie:
>>   	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
>> -1:	EXC_XFER_LITE(0x400, handle_page_fault)
>> +1301:	EXC_XFER_LITE(0x400, handle_page_fault)
> 
> You could use a local symbol, something like:

Thanks for the tip, I sent v2

Christophe

> 
> 	beq+	1f
>   	tlbie	r4
> .Litlbie:
>   	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
> 1:	EXC_XFER_LITE(0x400, handle_page_fault)
> 
> 
> cheers
> 
