Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D28C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:13:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E10213A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wNStUyAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E10213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447P711PjwzDq7N
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 01:13:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="wNStUyAz"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447Nt00WJ4zDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 01:02:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 447Nsq5CbTzB09Zt;
 Mon, 25 Feb 2019 15:01:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=wNStUyAz; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id K6r7CYWXi1XA; Mon, 25 Feb 2019 15:01:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 447Nsq46gjzB09Zw;
 Mon, 25 Feb 2019 15:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551103311; bh=wfAJ8QShWEmOH3XS16ZyQ7K+CmfzLAglSCSsaJI0IHo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=wNStUyAzK899cmWduaTDj9IfvLTtJVSBiYx5YdQDiBxstIXp9m/bIXYWvJ3fP/IuS
 dPQUSC/jtJA/Si7Tby3A3b41t38/kLxyc8zxEWZFc4D4DlOIRweevzx21/wuu5Jitq
 HuQpDvQ684SeC0G6IfcoFUmvZ//vgWQP6zuC88v4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 750908B845;
 Mon, 25 Feb 2019 15:01:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VOp_2IjsXtAn; Mon, 25 Feb 2019 15:01:56 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C69F8B81D;
 Mon, 25 Feb 2019 15:01:56 +0100 (CET)
Subject: Re: [RFC PATCH 3/5] kasan: allow architectures to provide an outline
 readiness check
To: Daniel Axtens <dja@axtens.net>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-4-dja@axtens.net>
 <dd65d283-5f6b-8e07-37ba-8ebc24cd5294@c-s.fr>
 <87zhqt39pl.fsf@dja-thinkpad.axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4ff60641-684a-8e86-0193-ef5380602096@c-s.fr>
Date: Mon, 25 Feb 2019 15:01:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87zhqt39pl.fsf@dja-thinkpad.axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

Le 18/02/2019 à 07:13, Daniel Axtens a écrit :
> christophe leroy <christophe.leroy@c-s.fr> writes:
> 
>> Le 15/02/2019 à 01:04, Daniel Axtens a écrit :
>>> In powerpc (as I understand it), we spend a lot of time in boot
>>> running in real mode before MMU paging is initalised. During
>>> this time we call a lot of generic code, including printk(). If
>>> we try to access the shadow region during this time, things fail.
>>>
>>> My attempts to move early init before the first printk have not
>>> been successful. (Both previous RFCs for ppc64 - by 2 different
>>> people - have needed this trick too!)
>>>
>>> So, allow architectures to define a check_return_arch_not_ready()
>>> hook that bails out of check_memory_region_inline() unless the
>>> arch has done all of the init.
>>>
>>> Link: https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>>> Link: https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
>>> Originally-by: Balbir Singh <bsingharora@gmail.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>>> ---
>>>    include/linux/kasan.h | 4 ++++
>>>    mm/kasan/generic.c    | 2 ++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>>> index f6261840f94c..83edc5e2b6a0 100644
>>> --- a/include/linux/kasan.h
>>> +++ b/include/linux/kasan.h
>>> @@ -14,6 +14,10 @@ struct task_struct;
>>>    #include <asm/kasan.h>
>>>    #include <asm/pgtable.h>
>>>    
>>> +#ifndef check_return_arch_not_ready
>>> +#define check_return_arch_not_ready()	do { } while (0)
>>> +#endif
>>
>> A static inline would be better I believe.
>>
>> Something like
>>
>> #ifndef kasan_arch_is_ready
>> static inline bool kasan_arch_is_ready {return true;}
>> #endif
>>
>>> +
>>>    extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>>>    extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>>>    extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
>>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>>> index bafa2f986660..4c18bbd09a20 100644
>>> --- a/mm/kasan/generic.c
>>> +++ b/mm/kasan/generic.c
>>> @@ -170,6 +170,8 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
>>>    						size_t size, bool write,
>>>    						unsigned long ret_ip)
>>>    {
>>> +	check_return_arch_not_ready();
>>> +
>>
>> Not good for readibility that the above macro embeds a return, something
>> like below would be better I think:
>>
>> 	if (!kasan_arch_is_ready())
>> 		return;
>>
>> Unless somebody minds, I'll do the change and take this patch in my
>> series in order to handle the case of book3s/32 hash.
> 
> Please do; feel free to take as many of the patches as you would like
> and I'll rebase whatever is left on the next version of your series.

I have now done a big step with v7: works on both nohash and hash ppc32 
without any special feature in the core of kasan. Have to do more tests 
on the hash version, but it seems promissing.

I have kept your patches on sync on top of it (allthough totally 
untested), you can find them in 
https://github.com/chleroy/linux/commits/kasan

> 
> The idea with the macro magic was to take advantage of the speed of
> static keys (I think, I borrowed it from Balbir's patch). Perhaps an
> inline function will achieve this anyway, but given that KASAN with
> outline instrumentation is inevitably slow, I guess it doesn't matter
> much either way.

You'll see in the modifications I've done to your patches, we can still 
use static keys while using static inline functions.

Christophe
