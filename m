Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C37C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA8021852
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA8021852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K1Zv4NqCzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 02:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K1XG41YhzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 02:04:46 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43K1X93cMnz9v13J;
 Tue, 18 Dec 2018 16:04:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0BvmFGjwrw8m; Tue, 18 Dec 2018 16:04:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43K1X92vb5z9v136;
 Tue, 18 Dec 2018 16:04:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D95F78B852;
 Tue, 18 Dec 2018 16:04:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9Db4sQfaWZbV; Tue, 18 Dec 2018 16:04:42 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 669108B754;
 Tue, 18 Dec 2018 16:04:42 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
 <20181218030538.GA24278@latitude>
 <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
 <20181218140714.GC24278@latitude>
 <96539c09-ea57-43d6-bae9-7371235b175f@c-s.fr>
 <ee4322c4-60e1-94c5-1e55-5d4c3e4de03b@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c1ee5c7f-d683-924f-68cb-43e1fe14363a@c-s.fr>
Date: Tue, 18 Dec 2018 16:04:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <ee4322c4-60e1-94c5-1e55-5d4c3e4de03b@c-s.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/12/2018 à 15:55, Christophe Leroy a écrit :
> 
> 
> Le 18/12/2018 à 15:15, Christophe Leroy a écrit :
>>
>>
>> Le 18/12/2018 à 15:07, Jonathan Neuschäfer a écrit :
>>> On Tue, Dec 18, 2018 at 09:18:42AM +0000, Christophe Leroy wrote:
>>>> The only difference I see then are the flags. Everything else is seems
>>>> identical.
>>>>
>>>> I know you tried already, but would you mind trying once more with the
>>>> following change ?
>>>>
>>> [...]
>>>> -        setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
>>>> +        setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>>>
>>> Good call, with this workaround on top of patches 1-3, it boots again:
>>>
>>>     # mount -t debugfs d /sys/kernel/debug
>>>     # cat /sys/kernel/debug/powerpc/block_address_translation
>>>     ---[ Instruction Block Address Translation ]---
>>>     0: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC
>>>     1:         -
>>>     2: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC
>>>     3:         -
>>>     4: 0xd0000000-0xd1ffffff 0x10000000 Kernel EXEC
>>>     5:         -
>>>     6:         -
>>>     7:         -
>>>
>>>     ---[ Data Block Address Translation ]---
>>>     0: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW
>>>     1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
>>>     2: 0xc1000000-0xc17fffff 0x01000000 Kernel RW
>>>     3:         -
>>>     4: 0xd0000000-0xd1ffffff 0x10000000 Kernel RW
>>>     5:         -
>>>     6:         -
>>>     7:         -
>>>
>>>> I think we may have some code trying to modify the kernel text 
>>>> without using
>>>> code patching functions.
>>>
>>> Is there any faster way than to sprinkle some printks in setup_kernel
>>> and try to find the guilty piece of code this way?
>>
>> Can you start with the serie 
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=75072 ?
> 
> Ok, the thing I was thinking about was the MMU_init_hw() but it is 
> called before mapin_ram() so it should not be a problem. Not sure that 
> serie improves anything at all here.
> 
> So there must be something else, pretty early (before the system is able 
> to properly handle and display an Oops for write to RO area.)
> 
> Does anybody have an idea of what it can be ?


Stupid of me. In fact at the time being, BATS cover both RO and RW data 
areas, so it can definitly not be mapped with PAGE_KERNEL_ROX.

In fact, as I have CONFIG_BDI_SWITCH in my setup, PAGE_KERNEL_TEXT is 
PAGE_KERNEL_X on my side. That's the reason why I missed it.

With this change being done to patch 3, does the overall serie works for 
you ?

Thanks
Christophe



> 
> Christophe
> 
>>
>> Christophe
>>
>>>
>>>
>>> Jonathan
>>>
