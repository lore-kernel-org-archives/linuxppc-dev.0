Return-Path: <SRS0=OS5J=KH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6D5C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 14:44:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9148613BD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 14:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9148613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgHcC26W7z30Bq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 00:44:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgHbq0HHrz2xv1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 00:43:48 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FgHbh5mDJz9sdw;
 Wed, 12 May 2021 16:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XhpERfMAMcjt; Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FgHbh4nsRz9sdc;
 Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 83D6C8B7F4;
 Wed, 12 May 2021 16:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KNm8b5FGVtrW; Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 10B2E8B7F3;
 Wed, 12 May 2021 16:43:44 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
 <20210511105154.GJ10366@gate.crashing.org>
 <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu>
 <20210512143105.GW10366@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2623fe98-7a73-f7a2-bcba-2d668d00ffd0@csgroup.eu>
Date: Wed, 12 May 2021 16:43:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512143105.GW10366@gate.crashing.org>
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



Le 12/05/2021 à 16:31, Segher Boessenkool a écrit :
> On Wed, May 12, 2021 at 02:56:56PM +0200, Christophe Leroy wrote:
>> Le 11/05/2021 à 12:51, Segher Boessenkool a écrit :
>>> Something seems to have decided this asm is more expensive than it is.
>>> That isn't always avoidable -- the compiler cannot look inside asms --
>>> but it seems it could be improved here.
>>>
>>> Do you have (or can make) a self-contained testcase?
>>
>> I have not tried, and I fear it might be difficult, because on a kernel
>> build with dozens of calls to csum_add(), only ip6_tunnel.o exhibits such
>> an issue.
> 
> Yeah.  Sometimes you can force some of the decisions, but that usually
> requires knowing too many GCC internals :-/
> 
>>>> And there is even one completely unused instance of csum_add().
>>>
>>> That is strange, that should never happen.
>>
>> It seems that several .o include unused versions of csum_add. After the
>> final link, one remains (in addition to the used one) in vmlinux.
> 
> But it is a static function, so it should not end up in any object file
> where it isn't used.

Well .... did I dream ?

Now I only find one extra .o with unused csum_add() : That's net/ipv6/exthdrs.o
It matches the one found in vmlinux.

Are you interested in -fdump-tree-einline-all for that one as well ?

Christophe
