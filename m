Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C518C4320A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:53:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E81E60EE0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E81E60EE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwQp66d8Sz3058
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 00:53:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GwQng05YMz2xh1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 00:53:07 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GwQnW0gGZz9sTr;
 Thu, 26 Aug 2021 16:53:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9XwOq-zzMJJ3; Thu, 26 Aug 2021 16:53:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GwQnV6NFyz9sTj;
 Thu, 26 Aug 2021 16:53:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 723E78B8D1;
 Thu, 26 Aug 2021 16:53:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cWljRHwm5qtx; Thu, 26 Aug 2021 16:53:02 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A3948B8B4;
 Thu, 26 Aug 2021 16:53:02 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to
 WARN_ON/__WARN_FLAGS() with asm goto
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
 <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
 <YSa1O4fcX1nNKqN/@Ryzen-9-3900X.localdomain>
 <87h7fcc2m4.fsf@mpe.ellerman.id.au>
 <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
 <87sfyw9sel.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5b0984eb-b933-7ea5-462d-283d0fe09424@csgroup.eu>
Date: Thu, 26 Aug 2021 16:53:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87sfyw9sel.fsf@mpe.ellerman.id.au>
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
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/08/2021 à 16:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 26/08/2021 à 05:21, Michael Ellerman a écrit :
>>> Nathan Chancellor <nathan@kernel.org> writes:
>>>> On Tue, Apr 13, 2021 at 04:38:10PM +0000, Christophe Leroy wrote:
>>>>> Using asm goto in __WARN_FLAGS() and WARN_ON() allows more
>>>>> flexibility to GCC.
>>> ...
>>>>
>>>> This patch as commit 1e688dd2a3d6 ("powerpc/bug: Provide better
>>>> flexibility to WARN_ON/__WARN_FLAGS() with asm goto") cause a WARN_ON in
>>>> klist_add_tail to trigger over and over on boot when compiling with
>>>> clang:
>>
>> ...
>>
>>>
>>> This patch seems to fix it. Not sure if that's just papering over it though.
>>>
>>> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
>>> index 1ee0f22313ee..75fcb4370d96 100644
>>> --- a/arch/powerpc/include/asm/bug.h
>>> +++ b/arch/powerpc/include/asm/bug.h
>>> @@ -119,7 +119,7 @@ __label_warn_on:						\
>>>    								\
>>>    			WARN_ENTRY(PPC_TLNEI " %4, 0",		\
>>>    				   BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
>>> -				   __label_warn_on, "r" (x));	\
>>> +				   __label_warn_on, "r" (!!(x))); \
>>>    			break;					\
>>>    __label_warn_on:						\
>>>    			__ret_warn_on = true;			\
>>
>> But for a simple WARN_ON() call:
>>
>> void test(unsigned long b)
>> {
>> 	WARN_ON(b);
>> }
>>
>> Without your change with GCC you get:
>>
>> 00000000000012d0 <.test>:
>>       12d0:	0b 03 00 00 	tdnei   r3,0
>>       12d4:	4e 80 00 20 	blr
>>
>>
>> With the !! change you get:
>>
>> 00000000000012d0 <.test>:
>>       12d0:	31 23 ff ff 	addic   r9,r3,-1
>>       12d4:	7d 29 19 10 	subfe   r9,r9,r3
>>       12d8:	0b 09 00 00 	tdnei   r9,0
>>       12dc:	4e 80 00 20 	blr
> 
> Yeah that's a pity.
> 
> We could do something like below, which is ugly, but would be better
> than having to revert the whole thing.

Yes looks nice, we already had that kind of stuff in the past, even more ugly.

> 
> Although this doesn't fix the strange warning in drivers/net/ethernet/sfc.

What's the warning ?


> 
> So possibly we need a CLANG ifdef around the whole thing, and use the
> old style warn for clang.
> 

Christophe
