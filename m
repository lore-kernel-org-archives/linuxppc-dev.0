Return-Path: <SRS0=qtOt=D7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC47C4363A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 11:19:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C564724641
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 11:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C564724641
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJJXp0dNzzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 22:19:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJJTC4zmszDqTD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 22:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CJJTC2FCXz8tFl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 22:16:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CJJTC1872z9sV7; Sat, 24 Oct 2020 22:16:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CJJT8555Bz9sV0
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2020 22:16:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CJJSv6r9dz9tyWt;
 Sat, 24 Oct 2020 13:16:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HJ8MCfGbOvBC; Sat, 24 Oct 2020 13:16:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CJJSv57hSz9tyWs;
 Sat, 24 Oct 2020 13:16:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FA6C8B78E;
 Sat, 24 Oct 2020 13:16:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 70EkutQL3fPr; Sat, 24 Oct 2020 13:16:32 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 95EC38B75E;
 Sat, 24 Oct 2020 13:16:32 +0200 (CEST)
Subject: Re: C vdso
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20200916165516.Horde.uocmo3irPb7BMg__NUSqRA9@messagerie.si.c-s.fr>
 <87r1r0oa4o.fsf@mpe.ellerman.id.au>
 <cc532aa8-a9e0-a105-b7b1-ee8d723b7ed6@csgroup.eu>
 <be21c7c8-6828-b757-064d-20f74e5c1a31@csgroup.eu>
 <877drhxeg8.fsf@mpe.ellerman.id.au> <874kmkx7gi.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <521fae8b-7c43-a87c-ab02-f4d027cff7fa@csgroup.eu>
Date: Sat, 24 Oct 2020 13:16:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <874kmkx7gi.fsf@mpe.ellerman.id.au>
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/10/2020 à 12:07, Michael Ellerman a écrit :
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 24/09/2020 à 15:17, Christophe Leroy a écrit :
>>>> Le 17/09/2020 à 14:33, Michael Ellerman a écrit :
>>>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>>>>
>>>>>> What is the status with the generic C vdso merge ?
>>>>>> In some mail, you mentionned having difficulties getting it working on
>>>>>> ppc64, any progress ? What's the problem ? Can I help ?
>>>>>
>>>>> Yeah sorry I was hoping to get time to work on it but haven't been able
>>>>> to.
>>>>>
>>>>> It's causing crashes on ppc64 ie. big endian.
>> ...
>>>>
>>>> Can you tell what defconfig you are using ? I have been able to setup a full glibc PPC64 cross
>>>> compilation chain and been able to test it under QEMU with success, using Nathan's vdsotest tool.
>>>
>>> What config are you using ?
>>
>> ppc64_defconfig + guest.config
>>
>> Or pseries_defconfig.
>>
>> I'm using Ubuntu GCC 9.3.0 mostly, but it happens with other toolchains too.
> 
> I'm also seeing warnings because of the feature fixups:
> 
> 
> That's happening because the 32-bit VDSO is built with CONFIG_PPC32=y,
> due to config-fake32.h, and that causes the feature fixup entries to be
> the wrong size.
> 
> See the logic in feature-fixup.h:
> 
> 
> 
> We expect the fixup entries to still use 64-bit values, even for the
> 32-bit VDSO in a 64-bit kernel.
> 
> TBH I'm not sure how config-fake32.h can work long term, it's so fragile
> to be defining/redefining a handful of CONFIG symbols like that.

I took the idea from mips (arch/mips/vdso/config-n32-o32-env.c) after struggling in different 
direction. At that time the generic VDSO code was far less careful and was including several linux 
headers IIRC.
I agree with you that it's rather fragile.

> 
> The generic VDSO code is fairly careful to only include uapi and vdso
> headers, not linux ones. So I think we need to better split our headers
> so that we can build the VDSO code with few or no linux headers, and so
> avoid the need to define any (or most) CONFIG symbols.
> 

I'll revisit it when I'm back from vacation (I'm leaving now for two weeks).

Christophe
