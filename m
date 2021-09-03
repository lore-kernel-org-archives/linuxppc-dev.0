Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07482C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 05:05:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAF360FDC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 05:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BAF360FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H15Mx1yL8z2ymg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 15:05:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H15MR4WVgz2xnf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 15:05:03 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H15MG6r0mz9sT1;
 Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKafY1p_Mhvd; Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H15MG5gtfz9sSx;
 Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A53798B8B1;
 Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MvFhAuvcaVQx; Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 45E9F8B764;
 Fri,  3 Sep 2021 07:04:58 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] powerpc/64s: system call scv tabort fix for
 corrupt irq soft-mask state
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20210901165418.1412891-1-npiggin@gmail.com>
 <65ed1ac8-f4af-742a-1d2a-e5db7e71a920@csgroup.eu>
 <1630553233.5hjr91skvz.astroid@bobo.none>
 <20210902215203.GM1583@gate.crashing.org>
 <20210902222002.GN1583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <02971218-d669-8ab5-bf65-12c4227bd740@csgroup.eu>
Date: Fri, 3 Sep 2021 07:04:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902222002.GN1583@gate.crashing.org>
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
Cc: Eirik Fuller <efuller@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 03/09/2021 à 00:20, Segher Boessenkool a écrit :
> On Thu, Sep 02, 2021 at 04:52:03PM -0500, Segher Boessenkool wrote:
>> On Thu, Sep 02, 2021 at 01:33:10PM +1000, Nicholas Piggin wrote:
>>> Excerpts from Christophe Leroy's message of September 2, 2021 3:21 am:
>>>>> -	/* Firstly we need to enable TM in the kernel */
>>>>> +	/* We need to enable TM in the kernel, and disable EE (for scv) */
>>>>>    	mfmsr	r10
>>>>>    	li	r9, 1
>>>>>    	rldimi	r10, r9, MSR_TM_LG, 63-MSR_TM_LG
>>>>> +	LOAD_REG_IMMEDIATE(r9, MSR_EE)
>>>>> +	andc	r10, r10, r9
>>>>
>>>> Why not use 'rlwinm' to mask out MSR_EE ?
>>>>
>>>> Something like
>>>>
>>>> 	rlwinm	r10, r10, 0, ~MSR_EE
>>>
>>> Mainly because I'm bad at powerpc assembly. Why do you think I'm trying
>>> to change as much as possible to C?
>>
>> The actual bit (bit 31, i.e. with value 1UL << 32) cannot be cleared
>> with rlwinm (only the low 32 bits can).  There are many ways to do it
>> using two insns of course.
> 
> Wow I misread that, you want to clear MSR[EE] really, not MSR[TM].
> 
> You cannot use rlwinm and keep the high 32 bits of the target register
> intact.  You either clear all to 0 or set them to a copy of the rotated
> value in the low 32 bits.
> 

Oops, my mistake. When I tested it in C to see what was generated by GCC I forgot the ~ so I got 
rlwinm r3,r3,0,16,16 and didn't realise it was different from rlwinm r3,r3,0,~(1<<15)

By the way it would be more explicit if objdump could display the mask instead of the mask 
boundaries. Is there a way to do that ?

Christophe
