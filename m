Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD33AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 06:29:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23DA60F56
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 06:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B23DA60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gfhf66jxvz3cX6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Aug 2021 16:29:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gfhdj5DB6z30CZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Aug 2021 16:28:39 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gfhdb3xn1z9sWH;
 Wed,  4 Aug 2021 08:28:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NdM5a1txM0b; Wed,  4 Aug 2021 08:28:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gfhdb2y2zz9sWG;
 Wed,  4 Aug 2021 08:28:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 461CB8B79A;
 Wed,  4 Aug 2021 08:28:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4YJr5MCJhASt; Wed,  4 Aug 2021 08:28:35 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E778D8B764;
 Wed,  4 Aug 2021 08:28:34 +0200 (CEST)
Subject: Re: Debian SID kernel doesn't boot on PowerBook 3400c
To: Finn Thain <fthain@linux-m68k.org>
References: <60841a75-ed7c-8789-15db-272bf43055f5.ref@yahoo.com>
 <60841a75-ed7c-8789-15db-272bf43055f5@yahoo.com>
 <20210731175842.Horde.UunWM8rZMP0dRCaeWUo-og1@messagerie.c-s.fr>
 <cd7c931c-a578-a2ff-0632-7767a0e90bb9@yahoo.com>
 <fbd08736-9738-35cf-3b47-b5c9c455c552@csgroup.eu>
 <b84bb7ff-2dfb-0ae6-6eee-dd3c40661982@yahoo.com>
 <fac98e72-14a1-802e-8343-9bed9a6eaedc@csgroup.eu>
 <c535cc2b-3f45-2415-1e81-32ea24b4ec@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b8ae2ca4-56e8-e39a-27a0-f0ee2fea1511@csgroup.eu>
Date: Wed, 4 Aug 2021 08:28:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c535cc2b-3f45-2415-1e81-32ea24b4ec@linux-m68k.org>
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
Cc: Debian PowerPC <debian-powerpc@lists.debian.org>,
 linuxppc-dev@lists.ozlabs.org, Stan Johnson <userm57@yahoo.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/08/2021 à 02:34, Finn Thain a écrit :
> 
> On Tue, 3 Aug 2021, Christophe Leroy wrote:
> 
>>
>> Looks like the memory errors are linked to KUAP (Kernel Userspace Access
>> Protection). Based on the places the problems happen, I don't think
>> there are any invalid access, so there must be something wrong in the
>> KUAP logic, probably linked to some interrupts happenning in kernel mode
>> while the KUAP window is opened. And because is not selected by default
>> on book3s/32 until 5.14, probably nobody ever tested it in a real
>> environment before you.
>>
>> I think the issue may be linked to commit
>> https://github.com/linuxppc/linux/commit/c16728835 which happened
>> between 5.12 and 5.13.
> 
> The messages, "Kernel attempted to write user page (c6207c) - exploit
> attempt? (uid: 0)", appear in the console logs generated by v5.13. Those
> logs come from the Powerbook G3 discussion in the other thread. Could that
> be the same bug?
> 

Yes, most likely.

So you confirm this appears with 5.13 and not 5.12 ?

Can you check if they happen at commit c16728835
Can you check if they DO NOT happen at preceding commit c16728835~

Could you test without CONFIG_PPC_KUAP
Could you test with CONFIG_PPC_KUAP and CONFIG_PPC_KUAP_DEBUG

Thanks
Christophe
