Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25AC43444
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:43:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491AE206C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rsm/lq6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491AE206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpLs2Q76zDqcV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:43:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="rsm/lq6Z"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fp9J3HJlzDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:35:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fp9967Bhz9vBKb;
 Wed, 16 Jan 2019 14:34:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=rsm/lq6Z; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NFNnFJHY8mP1; Wed, 16 Jan 2019 14:34:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fp9954cNz9vBKS;
 Wed, 16 Jan 2019 14:34:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547645693; bh=RssY5jBIYO3kjcknWLVYqdukiqwxw9EeRFRnZmASpOA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rsm/lq6ZA5olwEoJxQDt/ToWNMnrfN3ak5QhIEMc+ZCQ9kLo6gCn+REjusF843lYl
 yPJCPCBAQPzY1FMBteBZerzxLA8EwbSAYW/FR0Qr9nA9CjRT2V3RQrAk5VmuitjaX8
 ZYNr9pRJb5Q+KgxhL16Lv4V5s1++nkx92VQRUtTA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 15B578B847;
 Wed, 16 Jan 2019 14:34:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 01cTsM86UASg; Wed, 16 Jan 2019 14:34:55 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 651688B830;
 Wed, 16 Jan 2019 14:34:54 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <20190116003535.GE22334@latitude>
 <f434aafc-7e5f-dfa2-4cfa-03119c27463a@c-s.fr>
 <20190116131637.GF22334@latitude>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5051e5cb-89ea-b857-1288-1ac6bfe67872@c-s.fr>
Date: Wed, 16 Jan 2019 14:34:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116131637.GF22334@latitude>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/01/2019 à 14:16, Jonathan Neuschäfer a écrit :
> On Wed, Jan 16, 2019 at 07:55:29AM +0100, Christophe Leroy wrote:
>> Le 16/01/2019 à 01:35, Jonathan Neuschäfer a écrit :
>>> Thinning the kernel down a bit actually makes it boot again. Ooops...!
>>> Maybe enabling CONFIG_STRICT_KERNEL_RWX has made it just large enough to
>>> fail the hash table allocation, but there may have been other factors
>>> involved (I'm not sure exactly).  Sorry for the confusion!
>>
>> Ok, that must be the reason. Thanks for testing.
>>
>> What about the following modification which maps a second 256Mb BAT, does it
>> helps ?
>>
>>
>>
>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
>> index c2f564690778..ea574596de37 100644
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -1160,6 +1160,14 @@ initial_bats:
>>   	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
>>   	mtspr	SPRN_IBAT0L,r8
>>   	mtspr	SPRN_IBAT0U,r11
>> +#ifdef CONFIG_WII
>> +	addis	r11,r11,0x10000000@h
>> +	addis	r8,r8,0x10000000@h
>> +	mtspr	SPRN_DBAT2L,r8
>> +	mtspr	SPRN_DBAT2U,r11
>> +	mtspr	SPRN_IBAT2L,r8
>> +	mtspr	SPRN_IBAT2U,r11
>> +#endif
>>   	isync
>>   	blr
>>
>> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
>> index 3f4193201ee7..a334fd5210a8 100644
>> --- a/arch/powerpc/mm/ppc_mmu_32.c
>> +++ b/arch/powerpc/mm/ppc_mmu_32.c
>> @@ -259,6 +259,8 @@ void setup_initial_memory_limit(phys_addr_t
>> first_memblock_base,
>>   	/* 601 can only access 16MB at the moment */
>>   	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
>>   		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000));
>> +	else if (IS_ENABLED(CONFIG_WII))
>> +		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x20000000));
>>   	else /* Anything else has 256M mapped */
>>   		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
>>   }
> 
> I haven't tested it, but this patch won't be enough, because we're only
> looking at the first memblock, and the additional memory in the Wii
> (MEM2) is the second memblock.
> 

Yes right.


Would the following work instead ?

memblock_set_current_limit(0x20000000);


Christophe
