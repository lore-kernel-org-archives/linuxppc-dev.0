Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDCC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:48:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1002F21850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1002F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4497663VmjzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:48:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=virtuozzo.com
 (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=aryabinin@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44974G3MrkzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:46:52 +1100 (AEDT)
Received: from [172.16.25.12] by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1gzIHB-0003UF-GD; Thu, 28 Feb 2019 12:46:49 +0300
Subject: Re: BUG: KASAN: stack-out-of-bounds
To: Dmitry Vyukov <dvyukov@google.com>
References: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
 <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
 <15a40476-2852-cf5a-0982-d899dd79d9c1@c-s.fr>
 <7778f728-3ca2-7ad6-503f-72ca098863cb@virtuozzo.com>
 <CACT4Y+adjRarmcWTrQxotATzaHoFQ4TXbyiRXEpWozLPzjQBrQ@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <11314e32-6044-9207-a238-738e394ea2eb@virtuozzo.com>
Date: Thu, 28 Feb 2019 12:47:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+adjRarmcWTrQxotATzaHoFQ4TXbyiRXEpWozLPzjQBrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2/28/19 12:27 PM, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 10:22 AM Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>
>>
>>
>> On 2/27/19 4:11 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 27/02/2019 à 10:19, Andrey Ryabinin a écrit :
>>>>
>>>>
>>>> On 2/27/19 11:25 AM, Christophe Leroy wrote:
>>>>> With version v8 of the series implementing KASAN on 32 bits powerpc (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94309), I'm now able to activate KASAN on a mac99 is QEMU.
>>>>>
>>>>> Then I get the following reports at startup. Which of the two reports I get seems to depend on the option used to build the kernel, but for a given kernel I always get the same report.
>>>>>
>>>>> Is that a real bug, in which case how could I spot it ? Or is it something wrong in my implementation of KASAN ?
>>>>>
>>>>> I checked that after kasan_init(), the entire shadow memory is full of 0 only.
>>>>>
>>>>> I also made a try with the strong STACK_PROTECTOR compiled in, but no difference and nothing detected by the stack protector.
>>>>>
>>>>> ==================================================================
>>>>> BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
>>>>> Read of size 1 at addr c0ecdd40 by task swapper/0
>>>>>
>>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1133
>>>>> Call Trace:
>>>>> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
>>>>> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
>>>>> [c0e9dd10] [c089579c] memchr+0x24/0x74
>>>>> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
>>>>> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
>>>>> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
>>>>> --- interrupt: c0e9df00 at 0x400f330
>>>>>      LR = init_stack+0x1f00/0x2000
>>>>> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
>>>>> [c0e9df20] [c0c28e44] early_irq_init+0x38/0x108
>>>>> [c0e9df50] [c0c16434] start_kernel+0x310/0x488
>>>>> [c0e9dff0] [00003484] 0x3484
>>>>>
>>>>> The buggy address belongs to the variable:
>>>>>   __log_buf+0xec0/0x4020
>>>>> The buggy address belongs to the page:
>>>>> page:c6eac9a0 count:1 mapcount:0 mapping:00000000 index:0x0
>>>>> flags: 0x1000(reserved)
>>>>> raw: 00001000 c6eac9a4 c6eac9a4 00000000 00000000 00000000 ffffffff 00000001
>>>>> page dumped because: kasan: bad access detected
>>>>>
>>>>> Memory state around the buggy address:
>>>>>   c0ecdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>>   c0ecdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>>> c0ecdd00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>>>>>                                     ^
>>>>>   c0ecdd80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>>>>>   c0ecde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ==================================================================
>>>>>
>>>>
>>>> This one doesn't look good. Notice that it says stack-out-of-bounds, but at the same time there is
>>>>     "The buggy address belongs to the variable:  __log_buf+0xec0/0x4020"
>>>>   which is printed by following code:
>>>>     if (kernel_or_module_addr(addr) && !init_task_stack_addr(addr)) {
>>>>         pr_err("The buggy address belongs to the variable:\n");
>>>>         pr_err(" %pS\n", addr);
>>>>     }
>>>>
>>>> So the stack unrelated address got stack-related poisoning. This could be a stack overflow, did you increase THREAD_SHIFT?
>>>> KASAN with stack instrumentation significantly increases stack usage.
>>>>
>>>
>>> I get the above with THREAD_SHIFT set to 13 (default value).
>>> If increasing it to 14, I get the following instead. That means that in that case the problem arises a lot earlier in the boot process (but still after the final kasan shadow setup).
>>>
>>
>> We usually use 15 (with 4k pages), but I think 14 should be enough for the clean boot.
>>
>>> ==================================================================
>>> BUG: KASAN: stack-out-of-bounds in pmac_nvram_init+0x1f8/0x5d0
>>> Read of size 1 at addr f6f37de0 by task swapper/0
>>>
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1143
>>> Call Trace:
>>> [c0e9fd60] [c01c43c0] print_address_description+0x164/0x2bc (unreliable)
>>> [c0e9fd90] [c01c46a4] kasan_report+0xfc/0x180
>>> [c0e9fdd0] [c0c226d4] pmac_nvram_init+0x1f8/0x5d0
>>> [c0e9fef0] [c0c1f73c] pmac_setup_arch+0x298/0x314
>>> [c0e9ff20] [c0c1ac40] setup_arch+0x250/0x268
>>> [c0e9ff50] [c0c151dc] start_kernel+0xb8/0x488
>>> [c0e9fff0] [00003484] 0x3484
>>>
>>>
>>> Memory state around the buggy address:
>>>  f6f37c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>  f6f37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> f6f37d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>>>                                                ^
>>>  f6f37e00: 00 00 01 f4 f2 f2 f2 f2 00 00 00 00 f2 f2 f2 f2
>>>  f6f37e80: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
>>> ==================================================================
>>
>> Powerpc's show_stack() prints stack addresses, so we know that stack is something near 0xc0e9f... address.
>> f6f37de0 is definitely not stack address and it's to far for the stack overflow.
>> So it looks like shadow for stack  - kasan_mem_to_shadow(0xc0e9f...) and shadow for address in report - kasan_mem_to_shadow(0xf6f37de0)
>> point to the same physical page.
> 
> Shouldn't shadow start at 0xf8 for powerpc32? I did some math
> yesterday which I think lead me to 0xf8.

Dunno, maybe. How is this relevant? In case you referring to the 0xf6f* addresses in the report,
these are not shadow, but accessed addresses.

> This allows to cover at most 1GB of memory. Do you have more by any chance?
> 
