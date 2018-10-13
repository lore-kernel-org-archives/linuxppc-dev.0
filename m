Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD9C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:49:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE79820835
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XKg03jT6zF12l
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 20:49:32 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XKcd69fhzF0dW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 20:47:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42XKcT0klRz9ttFt;
 Sat, 13 Oct 2018 11:47:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id s9BdzTF4u0Th; Sat, 13 Oct 2018 11:47:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42XKcT087tz9ttFr;
 Sat, 13 Oct 2018 11:47:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CA8F8B782;
 Sat, 13 Oct 2018 11:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xHPZMmd5vjqD; Sat, 13 Oct 2018 11:47:25 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BC768B74B;
 Sat, 13 Oct 2018 11:47:18 +0200 (CEST)
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
 <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
 <1539340304.17569.35.camel@abdul.in.ibm.com>
 <e711011c-9cba-5166-37e3-e228877cbea8@c-s.fr>
 <1539350620.17569.39.camel@abdul.in.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <31ea3f38-a741-34d7-9f5f-fa3f64990fe9@c-s.fr>
Date: Sat, 13 Oct 2018 11:47:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539350620.17569.39.camel@abdul.in.ibm.com>
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 manvanth <manvanth@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/10/2018 à 15:23, Abdul Haleem a écrit :
> On Fri, 2018-10-12 at 12:36 +0200, Christophe LEROY wrote:
>>
>> Le 12/10/2018 à 12:31, Abdul Haleem a écrit :
>>> On Fri, 2018-10-12 at 10:08 +0200, Christophe LEROY wrote:
>>>>
>>>> Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
>>>>> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
>>>>>> Greeting's
>>>>>>
>>>>>> Today's linux-next fails to boot on powerpc bare-metal with this error
>>>>>>
>>>>>> POWER8 performance monitor hardware support registered
>>>>>> rcu: Hierarchical SRCU implementation.
>>>>>> smp: Bringing up secondary CPUs ...
>>>>>> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
>>>>>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
>>>>>> Call Trace:
>>>>>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
>>>>>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
>>>>>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
>>>>>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
>>>>>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
>>>>>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
>>>>>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
>>>>>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
>>>>>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
>>>>>> Rebooting in 10 seconds..
>>>>>>
>>>>>> Machine: Power 8 bare-metal
>>>>>> kernel version: 4.19.0-rc7-next-20181010
>>>>>> gcc version: 4.8.5 20150623
>>>>>> config attach
>>>>>
>>>>> Attaching the kernel config file
>>>>>
>>>>
>>>> # Linux/powerpc 4.11.0-rc4 Kernel Configuration
>>>>
>>>> This is not the correct config file. Can you send the .config ?
>>>
>>> CONFIG_HAVE_STACKPROTECTOR=y
>>> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>>> CONFIG_STACKPROTECTOR=y
>>> CONFIG_STACKPROTECTOR_STRONG=y
>>>
>>> ah yes, I have attached the correct config now.
>>
>> Ok,
>>
>> Could you please try and add a call to function boot_init_stack_canary()
>> in function start_secondary() in arch/powerpc/kernel/smp.c just before
>> the call to cpu_startup_entry() ?
> 
> Yes, it works. kernel boots fine with above changes to arch/powerpc/kernel/smp.c
> 

Thanks,

Could you please test the patch I just sent ?
I that patch, I initialises the stack canary when preparing the idle 
tasks rather than doing it at its startup.

Christophe
