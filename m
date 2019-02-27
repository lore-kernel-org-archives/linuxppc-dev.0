Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C5DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0242133D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="O+kFrJ0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0242133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448blT2hnVzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:15:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="O+kFrJ0q"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448bgG5nrKzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:11:53 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 448bg80zq1z9v0G5;
 Wed, 27 Feb 2019 14:11:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=O+kFrJ0q; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Bn9FE8sDU_m0; Wed, 27 Feb 2019 14:11:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 448bg76r1Rz9v0G4;
 Wed, 27 Feb 2019 14:11:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551273108; bh=eeD0A1ztSsVPgv1RXvJd9clgBtGzg/Xb1OyUlK3ASMM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O+kFrJ0ql/gtdlWvLbkSXJ8v6SZAseclFls76nVC0fgaHsN4BplxkjES/xQLTIOzL
 f3NbqLW7qta5pJ92xTP9rClAAInbNLde8Pcvn75ydRMumxWHx1zP9pR//rqW9NBTo+
 6rZfPP82uXXL1xamtpZJa4AJ+LXq7j2TKskeG9dg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C47D8B8D3;
 Wed, 27 Feb 2019 14:11:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GnU3oP8ckzIa; Wed, 27 Feb 2019 14:11:49 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 200298B8D2;
 Wed, 27 Feb 2019 14:11:49 +0100 (CET)
Subject: Re: BUG: KASAN: stack-out-of-bounds
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
References: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
 <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <15a40476-2852-cf5a-0982-d899dd79d9c1@c-s.fr>
Date: Wed, 27 Feb 2019 14:11:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/02/2019 à 10:19, Andrey Ryabinin a écrit :
> 
> 
> On 2/27/19 11:25 AM, Christophe Leroy wrote:
>> With version v8 of the series implementing KASAN on 32 bits powerpc (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94309), I'm now able to activate KASAN on a mac99 is QEMU.
>>
>> Then I get the following reports at startup. Which of the two reports I get seems to depend on the option used to build the kernel, but for a given kernel I always get the same report.
>>
>> Is that a real bug, in which case how could I spot it ? Or is it something wrong in my implementation of KASAN ?
>>
>> I checked that after kasan_init(), the entire shadow memory is full of 0 only.
>>
>> I also made a try with the strong STACK_PROTECTOR compiled in, but no difference and nothing detected by the stack protector.
>>
>> ==================================================================
>> BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
>> Read of size 1 at addr c0ecdd40 by task swapper/0
>>
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1133
>> Call Trace:
>> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
>> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
>> [c0e9dd10] [c089579c] memchr+0x24/0x74
>> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
>> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
>> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
>> --- interrupt: c0e9df00 at 0x400f330
>>      LR = init_stack+0x1f00/0x2000
>> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
>> [c0e9df20] [c0c28e44] early_irq_init+0x38/0x108
>> [c0e9df50] [c0c16434] start_kernel+0x310/0x488
>> [c0e9dff0] [00003484] 0x3484
>>
>> The buggy address belongs to the variable:
>>   __log_buf+0xec0/0x4020
>> The buggy address belongs to the page:
>> page:c6eac9a0 count:1 mapcount:0 mapping:00000000 index:0x0
>> flags: 0x1000(reserved)
>> raw: 00001000 c6eac9a4 c6eac9a4 00000000 00000000 00000000 ffffffff 00000001
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   c0ecdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   c0ecdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> c0ecdd00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>>                                     ^
>>   c0ecdd80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>>   c0ecde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ==================================================================
>>
> 
> This one doesn't look good. Notice that it says stack-out-of-bounds, but at the same time there is
> 	"The buggy address belongs to the variable:  __log_buf+0xec0/0x4020"
>   which is printed by following code:
> 	if (kernel_or_module_addr(addr) && !init_task_stack_addr(addr)) {
> 		pr_err("The buggy address belongs to the variable:\n");
> 		pr_err(" %pS\n", addr);
> 	}
> 
> So the stack unrelated address got stack-related poisoning. This could be a stack overflow, did you increase THREAD_SHIFT?
> KASAN with stack instrumentation significantly increases stack usage.
> 

I get the above with THREAD_SHIFT set to 13 (default value).
If increasing it to 14, I get the following instead. That means that in 
that case the problem arises a lot earlier in the boot process (but 
still after the final kasan shadow setup).

==================================================================
BUG: KASAN: stack-out-of-bounds in pmac_nvram_init+0x1f8/0x5d0
Read of size 1 at addr f6f37de0 by task swapper/0

CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1143
Call Trace:
[c0e9fd60] [c01c43c0] print_address_description+0x164/0x2bc (unreliable)
[c0e9fd90] [c01c46a4] kasan_report+0xfc/0x180
[c0e9fdd0] [c0c226d4] pmac_nvram_init+0x1f8/0x5d0
[c0e9fef0] [c0c1f73c] pmac_setup_arch+0x298/0x314
[c0e9ff20] [c0c1ac40] setup_arch+0x250/0x268
[c0e9ff50] [c0c151dc] start_kernel+0xb8/0x488
[c0e9fff0] [00003484] 0x3484


Memory state around the buggy address:
  f6f37c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f6f37d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >f6f37d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
                                                ^
  f6f37e00: 00 00 01 f4 f2 f2 f2 f2 00 00 00 00 f2 f2 f2 f2
  f6f37e80: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
==================================================================

Christophe
