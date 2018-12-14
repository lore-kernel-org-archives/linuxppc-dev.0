Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AED3C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1F32146E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1F32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GRrZ3trLzDrHl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 21:39:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GRpL0zxKzDrFl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 21:38:02 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43GRpF4STsz9v0tP;
 Fri, 14 Dec 2018 11:37:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 66xo2yDZCMVl; Fri, 14 Dec 2018 11:37:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43GRpF3TgPz9v0t1;
 Fri, 14 Dec 2018 11:37:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EE778B8B0;
 Fri, 14 Dec 2018 11:37:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ReCGMNRBk1YG; Fri, 14 Dec 2018 11:37:58 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C0228B8AF;
 Fri, 14 Dec 2018 11:37:58 +0100 (CET)
Subject: Re: [PATCH] powerpc/prom: fix early DEBUG messages
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <531e7e818b5c4867148412c7902a9cbeee5745ee.1544709040.git.christophe.leroy@c-s.fr>
 <87pnu4vd94.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0cde4fdd-9d16-732f-ebf8-b06127929e63@c-s.fr>
Date: Fri, 14 Dec 2018 11:37:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87pnu4vd94.fsf@concordia.ellerman.id.au>
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



Le 14/12/2018 à 07:22, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index fe758cedb93f..d8e56e03c9c6 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -749,7 +749,11 @@ void __init early_init_devtree(void *params)
>>   	memblock_allow_resize();
>>   	memblock_dump_all();
>>   
>> +#ifdef CONFIG_PHYS_64BIT
>>   	DBG("Phys. mem: %llx\n", memblock_phys_mem_size());
>> +#else
>> +	DBG("Phys. mem: %x\n", memblock_phys_mem_size());
>> +#endif
> 
> Can we just do:
> 
>    	DBG("Phys. mem: %llx\n", (unsigned long long)memblock_phys_mem_size());
> 
> ?
> 

Yes that's obviously better, especially as we don't fix the length of 
the displayed value.
Christophe
