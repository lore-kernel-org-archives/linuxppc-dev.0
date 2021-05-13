Return-Path: <SRS0=7n8X=KI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 17:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8822C61442
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 17:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8822C61442
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fgyc00dxpz3bsC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 03:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgybY6byqz2yYN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 03:00:53 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FgybQ0MW3z9sbh;
 Thu, 13 May 2021 19:00:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgPpNA9m2k1Z; Thu, 13 May 2021 19:00:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FgybP6MmNz9sbZ;
 Thu, 13 May 2021 19:00:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E6988B7F5;
 Thu, 13 May 2021 19:00:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1RvUGlWTGzbA; Thu, 13 May 2021 19:00:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 150D68B76C;
 Thu, 13 May 2021 19:00:49 +0200 (CEST)
Subject: Re: [FSL P50x0] Xorg always restarts again and again after the the
 PowerPC updates 5.13-1
To: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <72e138cd-5201-a059-e8aa-cebc3db4029c@csgroup.eu>
 <65116250-6EEB-4419-8A7D-B0882379A68B@xenosoft.de>
 <c90ba856-1ef2-c010-17ac-a091c5252a5c@csgroup.eu>
 <781a426e-8561-108f-0e5c-9393bc653e86@xenosoft.de>
 <56899373-f821-62e2-26ab-b1a98b3fe2e2@csgroup.eu>
 <4175f794-f8b8-d9fc-620d-408317e27eba@xenosoft.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ea99d32a-b544-e813-8e0f-1719f3600ba9@csgroup.eu>
Date: Thu, 13 May 2021 19:00:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4175f794-f8b8-d9fc-620d-408317e27eba@xenosoft.de>
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
Cc: Darren Stevens <darren@stevens-zone.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/05/2021 à 18:35, Christian Zigotzky a écrit :
> On 13 May 2021 at 5:51pm, Christophe Leroy wrote:
>>
>>
>> Le 13/05/2021 à 17:19, Christian Zigotzky a écrit :
>>> On 13 May 2021 at 12:01 pm, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 13/05/2021 à 08:47, Christian Zigotzky a écrit :
>>>>> Hi Christophe,
>>>>>
>>>>>> On 9. May 2021, at 19:37, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>>>>>>
>>>>>> Did I do an error in my analysis ?
>>>>>
>>>>> No, you didn’t. On the contrary you have found the issue. ;-) The issue is somewhere in the new 
>>>>> interrupt code.
>>>>
>>>> I'm not convinced, but let's give it a try.
>>>>
>>>>>
>>>>>> ZZ | * | ceff77efa4f8 powerpc/64e/interrupt: Use new interrupt context tracking scheme
>>>>>
>>>>> Could you please create a patch for reverting the new interrupt code? I would like to confirm 
>>>>> your result.
>>>>
>>>> Please fetch https://github.com/chleroy/linux.git and try the branch for_christian.
>>>>
>>>> This is a revert of approx a dozen of commits around the changes to 64e on top of v5.13-rc1.
>>>>
>>>> If the top of the branch works for you, it would be great if you can find out which one of the 
>>>> reverts fixes the problem for real.
>>>>
>>>> Thanks
>>>> Christophe
>>> It's working! Great! I can use the RC1 on my FSL P5040. Thank you! The issue is definitely 
>>> somewhere in the interrupt code. Please tell me the next steps.
>>>
>>
>> Can you bisect between 5.13-rc1 and the top of the 'for_christian' branch to find the first 'good' 
>> commit ?
>>
>> Take care it is an "up side down" bisect, a 'good' is one that does _not_ work and a 'bad' is a 
>> commit that works.
>>
>> git bisect start
>> git bisect bad 1c8f441f1485
>> git bisect good 6efb943b8616
>>
>> Christophe
> Hi Christophe,
> 
> Yes, I can. Shall I use the branch 'for_christian' or the default linux git for bisecting? I have 
> tried it already with the branch 'for_christian' but it doesn't compile.
> 
> git bisect start
> git bisect bad 1c8f441f1485
> git bisect good 6efb943b8616
> 
> Output: [d66b1d1aab0c1caad11eca417f515b86ec0bebe9] Revert "powerpc/64e/interrupt: Use new interrupt 
> context tracking scheme"
> 
> Result:
> 
> arch/powerpc/kernel/interrupt.o: In function `.syscall_exit_prepare':
> interrupt.c:(.text+0x278): undefined reference to `.schedule_user'
> arch/powerpc/kernel/interrupt.o: In function `.interrupt_exit_user_prepare':
> interrupt.c:(.text+0x340): undefined reference to `.schedule_user'
> Makefile:1191: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 

Ah yes, I remember this problem.

Can you select CONFIG_VIRT_CPU_ACCOUNTING_GEN in your configuration ?

Otherwise, I can try to fix the branch.

Christophe
