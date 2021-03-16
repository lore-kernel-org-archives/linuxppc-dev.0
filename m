Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61598C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:10:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744D565127
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D565127
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0Ltz0nccz3bs5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 05:10:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0Ltb3xDYz2xgK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 05:10:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F0LtQ5qpxz9v0hq;
 Tue, 16 Mar 2021 19:10:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id b9cIQnu_A5rj; Tue, 16 Mar 2021 19:10:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F0LtQ3h1Nz9v0hm;
 Tue, 16 Mar 2021 19:10:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FFD98B7EE;
 Tue, 16 Mar 2021 19:10:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pg33Skpor4nr; Tue, 16 Mar 2021 19:10:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B55658B7E1;
 Tue, 16 Mar 2021 19:10:23 +0100 (CET)
Subject: Re: [PATCH] net: ethernet: fs-enet: remove casting dma_alloc_coherent
To: David Laight <David.Laight@ACULAB.COM>, Xu Wang <vulab@iscas.ac.cn>,
 "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20201211085212.85457-1-vulab@iscas.ac.cn>
 <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
 <6fc4b62ee7754d78b8f7b9c2275bc47e@AcuMS.aculab.com>
 <4a1c2852-781f-e125-afcb-69387660b6af@csgroup.eu>
 <3f31140339c94652b1e7116e91cfd9c8@AcuMS.aculab.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7f322df3-80b6-dfd0-caf2-afc2ca3950b1@csgroup.eu>
Date: Tue, 16 Mar 2021 19:10:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3f31140339c94652b1e7116e91cfd9c8@AcuMS.aculab.com>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/12/2020 à 17:55, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 11 December 2020 16:43
>>
>> Le 11/12/2020 à 17:07, David Laight a écrit :
>>> From: Christophe Leroy
>>>> Sent: 11 December 2020 15:22
>>>>
>>>> Le 11/12/2020 à 09:52, Xu Wang a écrit :
>>>>> Remove casting the values returned by dma_alloc_coherent.
>>>>
>>>> Can you explain more in the commit log ?
>>>>
>>>> As far as I can see, dma_alloc_coherent() doesn't return __iomem, and ring_base member is __iomem
>>>
>>> Which is probably wrong - that is the kernel address of kernel memory.
>>> So it shouldn't have the __iomem marker.
>>
>> That's where the buffer descriptors are, the driver accesses to the content of the buffer
>> descriptors using the IO accessors in_be16()/out_be16(). Is it not correct ?
> 
> I've just been looking at the crap in there.
> My understanding is that IO accessors are for IO devices (eg addresses
> from io_remap() etc).
> 
> Buffers allocated by dma_alloc_coherent() are normal kernel memory
> and don't need any accessors.
> Now you might need some barriers - mostly because an ethernet chip
> can typically read a ring entry without being prodded.
> IIRC there is a barrier in writel() to ensure the dma master will
> 'see' all memory writes done before the IO write that kicks it into
> doing some processing.

As far as I can see, writel() is using __iomem memory, see 
https://elixir.bootlin.com/linux/v5.12-rc2/source/include/asm-generic/io.h#L221

> 
> The fact that the driver contains so many __iomem casts (eg in
> tx_restart) is an indication that something is badly awry.
> __iomem exists to check you are using the correct type of pointer.
> Any __iomem casts are dubious.

I agree, but what else can we do to guarantee proper access to that memory ?

Christophe
