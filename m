Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A36C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 16:14:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54FE20786
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 16:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54FE20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B24B0471TzDqX3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 02:14:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B247l55dmzDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 02:12:00 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4B247Y0nLBz9ttd3;
 Wed,  8 Jul 2020 18:11:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id W3CukLAJrHpH; Wed,  8 Jul 2020 18:11:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4B247X6Fj6z9ttcy;
 Wed,  8 Jul 2020 18:11:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C89F78B803;
 Wed,  8 Jul 2020 18:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7OV6tqRKoiBf; Wed,  8 Jul 2020 18:11:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98D6F8B804;
 Wed,  8 Jul 2020 18:11:51 +0200 (CEST)
Subject: Re: Failure to build librseq on ppc
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
 <20200708005922.GW3598@gate.crashing.org>
 <841816533.1735.1594211583710.JavaMail.zimbra@efficios.com>
 <1623833219.1877.1594216801865.JavaMail.zimbra@efficios.com>
 <96994487-ae4a-3bfb-b0f1-34228e51bea2@csgroup.eu>
 <1137155888.2676.1594218740683.JavaMail.zimbra@efficios.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cb425728-bb8f-7e53-2321-e397bc374934@csgroup.eu>
Date: Wed, 8 Jul 2020 18:11:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1137155888.2676.1594218740683.JavaMail.zimbra@efficios.com>
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
Cc: Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Jeanson <mjeanson@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/07/2020 à 16:32, Mathieu Desnoyers a écrit :
> ----- On Jul 8, 2020, at 10:21 AM, Christophe Leroy christophe.leroy@csgroup.eu wrote:
> 
>> Le 08/07/2020 à 16:00, Mathieu Desnoyers a écrit :
>>> ----- On Jul 8, 2020, at 8:33 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>>
>>>> ----- On Jul 7, 2020, at 8:59 PM, Segher Boessenkool segher@kernel.crashing.org
>>>> wrote:
>>> [...]
>>>>>
>>>>> So perhaps you have code like
>>>>>
>>>>>    int *p;
>>>>>    int x;
>>>>>    ...
>>>>>    asm ("lwz %0,%1" : "=r"(x) : "m"(*p));
>>>>
>>>> We indeed have explicit "lwz" and "stw" instructions in there.
>>>>
>>>>>
>>>>> where that last line should actually read
>>>>>
>>>>>    asm ("lwz%X1 %0,%1" : "=r"(x) : "m"(*p));
>>>>
>>>> Indeed, turning those into "lwzx" and "stwx" seems to fix the issue.
>>>>
>>>> There has been some level of extra CPP macro coating around those instructions
>>>> to
>>>> support both ppc32 and ppc64 with the same assembly. So adding %X[arg] is not
>>>> trivial.
>>>> Let me see what can be done here.
>>>
>>> I did the following changes which appear to generate valid asm.
>>> See attached corresponding .S output.
>>>
>>> I grepped for uses of "m" asm operand in Linux powerpc code and noticed it's
>>> pretty much
>>> always used with e.g. "lwz%U1%X1". I could find one blog post discussing that %U
>>> is about
>>> update flag, and nothing about %X. Are those documented ?
>>
>> As far as I can see, %U is mentioned in
>> https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html in the
>> powerpc subpart, at the "m" constraint.
> 
> Yep, I did notice it, but mistakenly thought it was only needed for "m<>" operand,
> not "m".

You are right, AFAIU on recent versions of GCC, %U has no effect without m<>

Christophe

> 
> Thanks,
> 
> Mathieu
> 
>>
>> For the %X I don't know.
>>
>> Christophe
>>
>>>
>>> Although it appears to generate valid asm, I have the feeling I'm relying on
>>> undocumented
>>> features here. :-/
> 
