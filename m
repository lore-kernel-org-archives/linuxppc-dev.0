Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E49C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 17:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF5820854
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Oc3VaVNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF5820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LXF30XdxzDqVK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 04:12:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Oc3VaVNu"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LXCH2hB8zDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 04:10:32 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44LXC53qPQz9vRZ6;
 Fri, 15 Mar 2019 18:10:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Oc3VaVNu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OzzGINJKl5bb; Fri, 15 Mar 2019 18:10:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44LXC52PCxz9vRZ4;
 Fri, 15 Mar 2019 18:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552669825; bh=DTpkMMnmyCbch9WEaOwGg3QC2RDJmW8WfDx/v6uiciw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Oc3VaVNuEDMncYSYltoif0ICV83+rMperfRrgJ0VV4qL/LperHnV4u+5WAVi8MLff
 7SmvgxCovcueIJw15FgNHORwUdAUxP72eYuYexx/+iFM/a5tkWenSsqipLJ7W3k+8T
 mEU9kLC4G499zSvW09PWA5JRS5biH99sNIl0Ysi0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F13268BF64;
 Fri, 15 Mar 2019 18:10:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZUCd-WtY_sPc; Fri, 15 Mar 2019 18:10:26 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB18E8BF48;
 Fri, 15 Mar 2019 18:10:26 +0100 (CET)
Subject: Re: [RFC/WIP] powerpc: Fix 32-bit handling of MSR_EE on exceptions
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
 <cbce315b-82f9-c748-92e4-97bb819c9098@c-s.fr>
 <ab9139902a64f8d0b187f7db0f8a16a5b85791ac.camel@kernel.crashing.org>
 <5a97253c-0ec4-d61f-fa9e-ea5da8590f32@c-s.fr>
 <87pns6mtqe.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c4c52790-db87-49e2-40c0-1a8ad1daa027@c-s.fr>
Date: Fri, 15 Mar 2019 17:10:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87pns6mtqe.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Diana Craciun <diana.craciun@nxp.com>, Scott Wood <oss@buserror.net>,
 Nick Piggin <npiggin@au1.ibm.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 02/05/2019 10:10 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 20/12/2018 à 23:35, Benjamin Herrenschmidt a écrit :
>>>
>>>>>     /*
>>>>>      * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
>>>>> @@ -205,20 +208,46 @@ transfer_to_handler_cont:
>>>>>     	mflr	r9
>>>>>     	lwz	r11,0(r9)		/* virtual address of handler */
>>>>>     	lwz	r9,4(r9)		/* where to go when done */
>>>>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
>>>>> +	mtspr	SPRN_NRI, r0
>>>>> +#endif
>>>>
>>>> That's not part of your patch, it's already in the tree.
>>>
>>> Yup rebase glitch.
>>>
>>>    .../...
>>>
>>>> I tested it on the 8xx with the below changes in addition. No issue seen
>>>> so far.
>>>
>>> Thanks !
>>>
>>> I'll merge that in.
>>
>> I'm currently working on a refactorisation and simplification of
>> exception and syscall entry on ppc32.
>>
>> I plan to take your patch in my serie as it helps quite a bit. I hope
>> you don't mind. I expect to come out with a series this week.
> 
> Ben's AFK so go ahead and pull it in to your series if that helps you.
>   
>>> The main obscure area is that business with the irqsoff tracer and thus
>>> the need to create stack frames around calls to trace_hardirqs_* ... we
>>> do it in some places and not others, but I've not managed to make it
>>> crash either. I need to get to the bottom of that, and possibly provide
>>> proper macro helpers like ppc64 has to do it.
>>
>> I can't see anything special around this in ppc32 code. As far as I
>> understand, a stack frame is put in place when there is a need to
>> save and restore some volatile registers. At the places where nothing
>> needs to be saved, nothing is done. I think that's the normal way for
>> any function call, isn't it ?
> 
> The concern was that the irqsoff tracer was doing
> __builtin_return_address(1) (or some number > 0) and that crashes if
> there aren't sufficiently many stack frames available.
> 
> See ftrace_return_address.
> 
> Possibly the answer is that we don't have CONFIG_FRAME_POINTER and so we
> get the empty version of that.
> 

Yes indeed, ftrace_return_address(1) is not __builtin_return_address(1) 
but 0ul as CONFIG_FRAME_POINTER is not defined. So the crash can't be 
due to that as it would then crash regardless of whether we set a stack 
frame or not.
And anyway, as far as I understand, if the stack is properly 
initialised, __builtin_return_address(X) returns NULL and don't crash 
when the top of backtrace is reached.

Do you have more details about the said crash ? I think we should file 
an issue for it in our issue databse.

For the time being, I'll get rid of that unneccessary stack frame in 
entry_32.S as part of my syscall prolog optimising series.

Christophe
