Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A37DC282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:10:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FCF21872
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nFBsDqJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FCF21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43llvy1rvfzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 02:10:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nFBsDqJG"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43llt25J77zDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 02:08:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43llsx4Khnz9txl4;
 Thu, 24 Jan 2019 16:08:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nFBsDqJG; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IDxXMoYdTEJl; Thu, 24 Jan 2019 16:08:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43llsx39Flz9txl3;
 Thu, 24 Jan 2019 16:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548342533; bh=j1yriyyEcyhV3H8Bqa9QLPy2gDxrWpbiN4C8VH523lo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nFBsDqJG67jyxO6p4m9vWb4aTTLOlRt+zOrp/F2leBb8E8fJNXoEpXaXxZ2wkpWpT
 b6ULBmRTnTs8x+M7BKAn3axxkeAvpwDm2RqXPOzWJqF2aCdhj1dyeqbvoDs48V1uhI
 ViLgyXmZFane/qGCXtas0gbocdJwr25CTns6rbYY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBC948B85D;
 Thu, 24 Jan 2019 16:08:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GW0J63uLUxTz; Thu, 24 Jan 2019 16:08:54 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57BC58B85C;
 Thu, 24 Jan 2019 16:08:54 +0100 (CET)
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <87zhrx2bf1.fsf@concordia.ellerman.id.au>
 <07e60b5a-611c-9863-f300-68a4f9ad2efd@c-s.fr>
 <871s52yins.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0c4cb50d-696b-bd9c-9745-aa19b08aa723@c-s.fr>
Date: Thu, 24 Jan 2019 16:08:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <871s52yins.fsf@concordia.ellerman.id.au>
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



Le 24/01/2019 à 01:59, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 19/01/2019 à 11:23, Michael Ellerman a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>>>> moves the thread_info into task_struct.
>>>>
>>>> Moving thread_info into task_struct has the following advantages:
>>>> - It protects thread_info from corruption in the case of stack
>>>> overflows.
>>>> - Its address is harder to determine if stack addresses are
>>>> leaked, making a number of attacks more difficult.
>>>>
>>>> Changes since v12:
>>>>    - Patch 1: Taken comment from Mike (re-introduced the 'panic' in case memblock allocation fails in setup_64.c
>>>>    - Patch 1: Added alloc_stack() function in setup_32.c to also panic in case of allocation failure.
>>>
>>> Hi Christophe,
>>>
>>> I can't get this series to boot on qemu mac99. I'm getting eg:
>>>
>>> [    0.981514] NFS: Registering the id_resolver key type
>>> [    0.981752] Key type id_resolver registered
>>> [    0.981868] Key type id_legacy registered
>>> [    0.995711] Unrecoverable exception 0 at 0 (msr=0)
>>> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
>>> [    0.996314] BE PAGE_SIZE=4K MMU=Hash PowerMac
>>> [    0.996617] Modules linked in:
>>> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342
>>> [    0.997138] NIP:  00000000 LR: 00000000 CTR: 00000000
>>> [    0.997309] REGS: ef237f50 TRAP: 0000   Not tainted  (5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792)
>>> [    0.997508] MSR:  00000000 <>  CR: 00000000  XER: 00000000
>>> [    0.997712]
>>> [    0.997712] GPR00: 00000000 ef238000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    0.997712] GPR08: 00000000 00000000 00000000 00000000 00000000 00000000 c006477c ef13d8c0
>>> [    0.997712] GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    0.997712] GPR24: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    0.998671] NIP [00000000]   (null)
>>> [    0.998774] LR [00000000]   (null)
>>> [    0.998895] Call Trace:
>>> [    0.999030] Instruction dump:
>>> [    0.999320] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>>> [    0.999546] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 XXXXXXXX XXXXXXXX XXXXXXXX
>>> [    1.000023] ---[ end trace 925ea3419844fe68 ]---
>>
>> No such issue on my side. Do you have a ramdisk with anythink special or
>> a special config ? I see your kernel is modprobing something, know what
>> it is ?
> 
> It's just a debian installer image, nothing special AFAIK.
> 
>> Especially, what is the amount of memory in your config ? On my side
>> there is 128M:
> 
> I have 1G.
> 
> But today I can't reproduce the crash :/
> 
> So I guess it must have been something else in my config.

Or it could be because I didn't protect stack walks ? See

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bbd4c56b0b642f04396da378296e68096d5afca

Anyway, I'll soon send out v14 including a patch for that.

Christophe
