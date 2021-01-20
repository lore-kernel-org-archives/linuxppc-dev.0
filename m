Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA262C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 06:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20492313A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 06:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20492313A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLG2x0HPHzDqtt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 17:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLFzw41FbzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 17:31:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DLFzh1gjnz9v0KG;
 Wed, 20 Jan 2021 07:31:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qL9e-0ptTvus; Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DLFzh0Jf6z9v0KF;
 Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E93E88B7DF;
 Wed, 20 Jan 2021 07:31:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bh3Vqo3ktCbr; Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C92398B75F;
 Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Subject: Re: [PATCH] powerpc/47x: Disable 256k page size
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <2fed79b1154c872194f98bac4422c23918325e61.1611039590.git.christophe.leroy@csgroup.eu>
 <87h7ncqhz1.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <19acabee-3a6d-d2d0-db7a-b637bd162069@csgroup.eu>
Date: Wed, 20 Jan 2021 07:31:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87h7ncqhz1.fsf@mpe.ellerman.id.au>
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



Le 20/01/2021 à 06:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> PPC47x_TLBE_SIZE isn't defined for 256k pages, so
>> this size of page shall not be selected for 47x.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: e7f75ad01d59 ("powerpc/47x: Base ppc476 support")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 107bb4319e0e..a685e42d3993 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -772,7 +772,7 @@ config PPC_64K_PAGES
>>   
>>   config PPC_256K_PAGES
>>   	bool "256k page size"
>> -	depends on 44x && !STDBINUTILS
>> +	depends on 44x && !STDBINUTILS && !PPC_47x
> 
> Do we still need this STDBINUTILS thing?
> 
> It's pretty gross, and I notice we have zero defconfigs which disable
> it, meaning it's only randconfig builds that will ever test 256K pages.
> 
> Can we just drop it and say if you enable 256K pages you need to know
> what you're doing?

I guess we can, yes. I'll send a patch for that.

Christophe

> 
