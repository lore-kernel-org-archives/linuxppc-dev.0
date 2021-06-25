Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849A2C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 04:57:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF83D61419
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 04:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF83D61419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GB4Vs2cl9z3bvV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 14:57:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GB4VS5yK4z2xZJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 14:57:02 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GB4VK1WGnzBC7l;
 Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2g-zeAQYg2tJ; Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GB4VK0Z0yzBC7h;
 Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EB1638B7F4;
 Fri, 25 Jun 2021 06:56:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WESD5kl9hnOU; Fri, 25 Jun 2021 06:56:55 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E8C58B7F0;
 Fri, 25 Jun 2021 06:56:51 +0200 (CEST)
Subject: Re: [PATCH v2 1/4] mm: pagewalk: Fix walk for hugepage tables
To: Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
 <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
 <874kdm1rim.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <217a6b38-a6ac-84d5-e3dc-257331431bb2@csgroup.eu>
Date: Fri, 25 Jun 2021 06:56:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874kdm1rim.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
 Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/06/2021 à 06:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Hi Michael,
>>
>> Le 19/04/2021 à 12:47, Christophe Leroy a écrit :
>>> Pagewalk ignores hugepd entries and walk down the tables
>>> as if it was traditionnal entries, leading to crazy result.
>>>
>>> Add walk_hugepd_range() and use it to walk hugepage tables.
>>
>> I see you took patch 2 and 3 of the series.
> 
> Yeah I decided those were bug fixes so could be taken separately.
> 
>> Do you expect Andrew to take patch 1 via mm tree, and then you'll take
>> patch 4 once mm tree is merged ?
> 
> I didn't feel I could take patch 1 via the powerpc tree without risking
> conflicts.
> 
> Andrew could take patch 1 and 4 via mm, though he might not want to pick
> them up this late.

Patch 4 needs patches 2 and 3 and doesn't apply without them so it is not that easy.

Maybe Andrew you can take patch 1 now and then Michael you can take patch 4 at anytime during 5.15 
preparation without any conflict risk ?

> 
> I guess step one would be to repost 1 and 4 as a new series. Either they
> can go via mm, or for 5.15 I could probably take them both as long as I
> pick them up early enough.
> 

I'll first repost patch 1 as standalone and see what happens.

Christophe
