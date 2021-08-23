Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA09C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 17:06:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58965611AF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 17:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58965611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gtdth1xMrz2yp0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 03:06:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtdtC1brsz2xb6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 03:05:52 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gtdt53jKnz9sTr;
 Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbdMG_FqIlnR; Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gtdt52kzjz9sTg;
 Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 268CE8B7AD;
 Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2xoQtNv-6Qji; Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BABDA8B7BA;
 Mon, 23 Aug 2021 19:05:48 +0200 (CEST)
Subject: Re: [PATCH] powerpc/booke: Avoid link stack corruption in several
 places
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <d7435e616336fd5f07bb19ec61e97d71e5c53568.1629705153.git.christophe.leroy@csgroup.eu>
 <20210823155837.GX1583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
Date: Mon, 23 Aug 2021 19:05:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823155837.GX1583@gate.crashing.org>
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



Le 23/08/2021 à 17:58, Segher Boessenkool a écrit :
> On Mon, Aug 23, 2021 at 07:53:01AM +0000, Christophe Leroy wrote:
>>   /* Be careful, this will clobber the lr register. */
>>   #define LOAD_REG_ADDR_PIC(reg, name)		\
>> -	bl	0f;				\
>> +	bcl	20,31,0f			\
>>   0:	mflr	reg;				\
>>   	addis	reg,reg,(name - 0b)@ha;		\
>>   	addi	reg,reg,(name - 0b)@l;
> 
> The code ended each line with a semicolon before, for absolutely no
> reason that I can see, but still.  Fixing that would be nice, but only
> doing it on one line isn't good.

Sure, forgetting the semicolon broke the build. That's because the backslash removes the newline.

The cleanest way I found to fix that quite of stuff is by using GAS macro, as I did for 
LOAD_REG_IMMEDIATE() some time ago.

> 
> Btw.  Both the 7450 and the modern cores implementing this really need
> this to be $+4, so it is a lot clearer to write that instead of 1f or
> a named label.

I like that, removing unneeded labels will make it smoother and clearer. I'll do it.

Christophe
