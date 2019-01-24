Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F6C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AE321872
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AWXy66uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AE321872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43llm43DvLzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 02:03:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="AWXy66uF"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43llk52qrpzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 02:02:04 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43lljz0rgNz9txl5;
 Thu, 24 Jan 2019 16:01:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=AWXy66uF; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id svVl3c25HCxp; Thu, 24 Jan 2019 16:01:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43lljy6KpJz9txl1;
 Thu, 24 Jan 2019 16:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548342118; bh=8/nTswzcnLkOu6savh5/oxVwW7VmvzVbzz91aQOIlG0=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=AWXy66uF7UqUvu7z9+OHB74HZriF9v0227onlwMRQGJXepIzn7KqNw4ye+66mN+FR
 Kp4q0ztaW4Bh1oOy7gAujoxfru3I9UWmCW03FSey5l2k7qvp7PunWieL6S3KAqMaLC
 k+IVDge8SbVoYDntTfFjkcEhVQcJp23ah/SPjISM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D9EA8B85C;
 Thu, 24 Jan 2019 16:02:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OgiZWwENdL3N; Thu, 24 Jan 2019 16:02:00 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DF1798B850;
 Thu, 24 Jan 2019 16:01:59 +0100 (CET)
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
 <87y37ax3ru.fsf@concordia.ellerman.id.au>
 <9b4dab64-6a6b-a599-4676-bf891473ada7@c-s.fr>
Message-ID: <c5b86b5b-1f38-39bf-0458-3c6572b3b35c@c-s.fr>
Date: Thu, 24 Jan 2019 16:01:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9b4dab64-6a6b-a599-4676-bf891473ada7@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/01/2019 à 10:43, Christophe Leroy a écrit :
> 
> 
> On 01/24/2019 01:06 AM, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Le 12/01/2019 à 10:55, Christophe Leroy a écrit :
>>>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK 
>>>> which
>>>> moves the thread_info into task_struct.
>>>>
>>>> Moving thread_info into task_struct has the following advantages:
>>>> - It protects thread_info from corruption in the case of stack
>>>> overflows.
>>>> - Its address is harder to determine if stack addresses are
>>>> leaked, making a number of attacks more difficult.
>>>
>>> I ran null_syscall and context_switch benchmark selftests and the result
>>> is surprising. There is slight degradation in context_switch and a
>>> significant one on null_syscall:
>>>
>>> Without the serie:
>>>
>>> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
>>> 55542
>>> 55562
>>> 55564
>>> 55562
>>> 55568
>>> ...
>>>
>>> ~# ./null_syscall
>>>      2546.71 ns     336.17 cycles
>>>
>>>
>>> With the serie:
>>>
>>> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
>>> 55138
>>> 55142
>>> 55152
>>> 55144
>>> 55142
>>>
>>> ~# ./null_syscall
>>>      3479.54 ns     459.30 cycles
>>>
>>> So 0,8% less context switches per second and 37% more time for one 
>>> syscall ?
>>>
>>> Any idea ?
>>
>> What platform is that on?
> 
> It is on the 8xx
> 
>>
>> On 64-bit we have to turn one mtmsrd into two and that's obviously a
>> slow down. But I don't see that you've done anything similar in 32-bit
>> code.
>>
>> I assume it's patch 8 that causes the slow down?
> 
> I have not digged into it yet, but why patch 8 ?
> 

The increase of null_syscall duration happens with patch 5 when we 
activate CONFIG_THREAD_INFO_IN_TASK.

Christophe
