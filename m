Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 06:34:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2737619A0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 06:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2737619A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4M5t3dz5z30HP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 17:34:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4M5V42fNz304R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 17:33:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F4M5N417Mz9tyJF;
 Tue, 23 Mar 2021 07:33:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Hy_Tb1Itzt4f; Tue, 23 Mar 2021 07:33:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F4M5N1S7Jz9tyJC;
 Tue, 23 Mar 2021 07:33:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EB2008B7B8;
 Tue, 23 Mar 2021 07:33:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jaXII43iy5Qf; Tue, 23 Mar 2021 07:33:44 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 306718B7B4;
 Tue, 23 Mar 2021 07:33:44 +0100 (CET)
Subject: Re: [PATCH -next] powerpc: kernel/time.c - cleanup warnings
To: "heying (H)" <heying24@huawei.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 msuchanek@suse.de, peterz@infradead.org, geert+renesas@glider.be,
 kernelfans@gmail.com, frederic@kernel.org
References: <20210317103438.177428-1-heying24@huawei.com>
 <3f4d196b-0a8e-d4c9-cabe-591f5916a2b9@csgroup.eu>
 <5ee06736-7fc4-7993-a8b5-042e1890a6de@huawei.com>
 <c6908c07-1814-a7f8-5f48-a4c316fb567c@huawei.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5f4ec5e0-af9c-ba47-4a01-589b1b724cb9@csgroup.eu>
Date: Tue, 23 Mar 2021 07:33:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c6908c07-1814-a7f8-5f48-a4c316fb567c@huawei.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 23/03/2021 à 07:21, heying (H) a écrit :
> Dear Christophe,
> 
> 
> 在 2021/3/18 10:28, heying (H) 写道:
>>
>> 在 2021/3/17 19:16, Christophe Leroy 写道:
>>>
>>>
>>> Le 17/03/2021 à 11:34, He Ying a écrit :
>>>> We found these warnings in arch/powerpc/kernel/time.c as follows:
>>>> warning: symbol 'decrementer_max' was not declared. Should it be static?
>>>> warning: symbol 'rtc_lock' was not declared. Should it be static?
>>>> warning: symbol 'dtl_consumer' was not declared. Should it be static?
>>>>
>>>> Declare 'decrementer_max' in arch/powerpc/include/asm/time.h. And include
>>>> proper header in which 'rtc_lock' is declared. Move 'dtl_consumer'
>>>> definition behind "include <asm/dtl.h>" because 'dtl_consumer' is declared
>>>> there.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: He Ying <heying24@huawei.com>
>>>> ---
>>>>   arch/powerpc/include/asm/time.h | 1 +
>>>>   arch/powerpc/kernel/time.c      | 7 +++----
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
>>>> index 8dd3cdb25338..2cd2b50bedda 100644
>>>> --- a/arch/powerpc/include/asm/time.h
>>>> +++ b/arch/powerpc/include/asm/time.h
>>>> @@ -22,6 +22,7 @@ extern unsigned long tb_ticks_per_jiffy;
>>>>   extern unsigned long tb_ticks_per_usec;
>>>>   extern unsigned long tb_ticks_per_sec;
>>>>   extern struct clock_event_device decrementer_clockevent;
>>>> +extern u64 decrementer_max;
>>>>       extern void generic_calibrate_decr(void);
>>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>>> index b67d93a609a2..409967713ca6 100644
>>>> --- a/arch/powerpc/kernel/time.c
>>>> +++ b/arch/powerpc/kernel/time.c
>>>> @@ -55,6 +55,7 @@
>>>>   #include <linux/sched/cputime.h>
>>>>   #include <linux/sched/clock.h>
>>>>   #include <linux/processor.h>
>>>> +#include <linux/mc146818rtc.h>
>>>
>>> I don't think that's the good place. It has no link to powerpc, it is only by chance that it has 
>>> the same name.
>>>
>>> As rtc_lock is defined in powerpc time.c, I think you should declare it in powerpc asm/time.h
>>
>> My first thought was the same as yours. I tried to add declaration in powerpc asm/time.h, but got 
>> a compiling error:
>>
>> drivers/rtc/rtc-vr41xx.c:75:24: error: static declaration of ‘rtc_lock’ follows non-static 
>> declaration
>>  static DEFINE_SPINLOCK(rtc_lock);
>>
>> In file included from ./arch/powerpc/include/asm/delay.h:7:0,
>>                  from ./arch/powerpc/include/asm/io.h:33,
>>                  from ./include/linux/io.h:13,
>>                  from drivers/rtc/rtc-vr41xx.c:11:
>> ./arch/powerpc/include/asm/time.h:25:19: note: previous declaration of ‘rtc_lock’ was here
>>  extern spinlock_t rtc_lock;
>>
>> There's a conflict. Perhaps I can rename it in drivers/rtc/rtc-vr41xx.c.
>>
>>
>> But I find an existing declaration in linux/mc146818rtc.h and there's only one definition for 
>> 'rtc_lock' in powerpc.
>>
>> There's some includes of mc146818rtc.h in powperc. I wonder they point to the same thing. But I'm 
>> not very sure
>>
>> because the header's name looks a bit strange.
> 
> How about including mc146818rtc.h in powperpc kernel/time.c? May I have your opinions please?
> 

As I said, mc146818rtc.h is not related to powerpc, and if it works that's just chance, and there is 
no certainty that it will still work in the future.

If you can't find a clean solution, it is better to leave the warning.

Christophe
