Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B8C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 12:08:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58002084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 12:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58002084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D20C4hpJzDqcf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:08:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D1xQ4367zDqtR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 23:05:46 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43D1xJ5LHpz9v10x;
 Mon, 10 Dec 2018 13:05:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rvi7tACNazWE; Mon, 10 Dec 2018 13:05:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43D1xJ4lYmz9v10w;
 Mon, 10 Dec 2018 13:05:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 34FDB8B7A9;
 Mon, 10 Dec 2018 13:05:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id r7yc4roY29Tx; Mon, 10 Dec 2018 13:05:41 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F1AC48B74C;
 Mon, 10 Dec 2018 13:05:40 +0100 (CET)
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kim Phillips <kim.phillips@arm.com>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
 <f570563c-1cc7-fecf-2ed2-58164047ec9d@c-s.fr>
 <878t12ks3f.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9182f885-5773-d42e-20eb-26923a34e011@c-s.fr>
Date: Mon, 10 Dec 2018 13:05:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <878t12ks3f.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 07/12/2018 à 03:07, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 05/12/2018 à 04:26, Michael Ellerman a écrit :
>>> Hi Dan,
>>>
>>> Thanks for the patch.
>>>
>>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>>>> The ipic_info[] array only has 95 elements so I have made the bounds
>>>> check smaller to prevent a read overflow.  It was Smatch that found
>>>> this issue:
>>>>
>>>>       arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
>>>>       error: buffer overflow 'ipic_info' 95 <= 127
>>>>
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> ---
>>>> I wasn't able to find any callers of this code.  Maybe we removed the
>>>> last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
>>>> host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
>>>> should just remove it.  I'm not really comfortable doing that myself,
>>>> because I don't know the code well enough and can't build test
>>>> it properly.
>>>
>>> Hah wow, last usage removed in 2006!
>>>
>>> I don't see any mention of it since then, so I'll remove it. If it
>>> breaks something we can put it back.
>>>
>>> Can smatch help us find things like this that are defined non-static but
>>> never used?
>>>
>>
>> I think we have to do that carrefully. Some of those functions might be
>> used by out-of-tree boards.
> 
> We don't keep unused code around for out-of-tree boards.
> 
> Either the out-of-tree code should be merged upstream, or you can
> maintain whatever extra functions you need as part of your out-of-tree
> code base.
> 
>> I'm thinking especially at ipic_get_mcp_status() and
>> ipic_set_mcp_status(). They are used in my 832x boards's machine check
>> handler to know when a machine check is a timeout from the 832x watchdog.
> 
> Thanks for pointing them out, I'll send a patch to remove them :)

Lol :)

If you are doing the housework, you can remove 
ipic_set_highest_priority() ipic_enable_mcp() and ipic_disable_mcp()


> 
> But seriously, why is your machine check code not in-tree, is there some
> reason you can't merge it?

Maybe because you haven't merged it yet allthough I sent it more than 
three minutes ago. :)

Seriously, that was just left over with other priorities, and also 
because I'm not too happy about it because what I would really like is 
that it kills the userland app if any but don't crash the system when it 
is in interrupt or in idle.

But due to b96672dd840f ("powerpc: Machine check interrupt is a 
non-maskable interrupt"), die_will_crash() doesn't work anymore. So for 
the time being, the patch I sent is not killing anybody, just doing an 
Oops for notification (note that die_will_crash() is used in the Opal 
machine check handler, so it probably doesn't work anymore there either).

Christophe
