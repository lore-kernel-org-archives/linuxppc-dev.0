Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971EC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:55:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183776113D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183776113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8KxT4PDDz3bsB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 18:55:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8Kx555Psz2xff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 18:55:33 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G8Kwx2mznzB7XH;
 Tue, 22 Jun 2021 10:55:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 844ZopNgNrr2; Tue, 22 Jun 2021 10:55:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G8Kwx1sYvz9xTT;
 Tue, 22 Jun 2021 10:55:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C0B88B7B2;
 Tue, 22 Jun 2021 10:55:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zxPk7IgQjEdV; Tue, 22 Jun 2021 10:55:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2A9B8B7B1;
 Tue, 22 Jun 2021 10:55:28 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/64s/interrupt: Check and fix srr_valid
 without crashing
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20210622060416.548187-1-npiggin@gmail.com>
 <20210622060416.548187-3-npiggin@gmail.com>
 <21088c39-77fb-97d5-6fe9-76ae4ef4b439@csgroup.eu>
 <1624351871.ezysew4q8c.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2d9d6e9e-0ce0-3556-86c8-adf88596c59c@csgroup.eu>
Date: Tue, 22 Jun 2021 10:55:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624351871.ezysew4q8c.astroid@bobo.none>
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



Le 22/06/2021 à 10:54, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of June 22, 2021 4:47 pm:
>>
>>
>> Le 22/06/2021 à 08:04, Nicholas Piggin a écrit :
>>> The PPC_RFI_SRR_DEBUG check added by patch "powerpc/64s: avoid reloading
>>> (H)SRR registers if they are still valid" has a few deficiencies. It
>>> does not fix the actual problem, it's not enabled by default, and it
>>> causes a program check interrupt which can cause more difficulties.
>>>
>>> However there are a lot of paths which may clobber SRRs or change return
>>> regs, and difficult to have a high confidence that all paths are covered
>>> without wider testing.
>>>
>>> Add a relatively low overhead always-enabled check that catches most
>>> such cases, reports once, and fixes it so the kernel can continue.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    arch/powerpc/kernel/interrupt.c | 58 +++++++++++++++++++++++++++++++++
>>>    1 file changed, 58 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
>>> index 05fa3ae56e25..5920a3e8d1d5 100644
>>> --- a/arch/powerpc/kernel/interrupt.c
>>> +++ b/arch/powerpc/kernel/interrupt.c
>>> @@ -231,6 +231,56 @@ static notrace void booke_load_dbcr0(void)
>>>    #endif
>>>    }
>>>    
>>> +#include <linux/sched/debug.h> /* for show_regs */
>>> +static void check_return_regs_valid(struct pt_regs *regs)
>>> +{
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +	static bool warned = false;
>>> +
>>> +	if (regs->trap == 0x980 || regs->trap == 0xe00 || regs->trap == 0xe20 ||
>>> +	    regs->trap == 0xe40 || regs->trap == 0xe60 || regs->trap == 0xe80 ||
>>> +	    regs->trap == 0xea0 || regs->trap == 0xf80 || regs->trap == 0x1200 ||
>>> +	    regs->trap == 0x1500 || regs->trap == 0x1600 || regs->trap == 0x1800) {
>>
>> Can you use names defined in asm/interrupt.h instead of raw values ?
>> Some are already there, others can be added.
> 
> Good idea. Could go into a helper too actually.
> 
> I wanted to clean up the KVM definitions and unify them with interrupt.h
> defs but that's a bit of churn. Can I get to that in the next merge or
> so?
> 


Sure

Christophe
