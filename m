Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53AC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 12:10:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099722086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 12:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099722086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wmqs3kd7zF3Ss
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 23:10:17 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wmlf4g81zDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 23:06:38 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42WmlT4Kglz9ttwT;
 Fri, 12 Oct 2018 14:06:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0X8qnAkFmApG; Fri, 12 Oct 2018 14:06:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42WmlT3ZxVz9ttwJ;
 Fri, 12 Oct 2018 14:06:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E53A8B8D9;
 Fri, 12 Oct 2018 14:06:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2r3cVPuvdW0d; Fri, 12 Oct 2018 14:06:33 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 322DB8B8D5;
 Fri, 12 Oct 2018 14:06:32 +0200 (CEST)
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
To: "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
 <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
 <da8634b4-77ae-90e3-b6b4-fa1284ed8d85@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fc53fa1c-e7b1-dc84-1b5d-d66870aad4e3@c-s.fr>
Date: Fri, 12 Oct 2018 14:06:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da8634b4-77ae-90e3-b6b4-fa1284ed8d85@linux.ibm.com>
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
 linux-kernel <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 linux-next <linux-next@vger.kernel.org>,
 manvanth <manvanth@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/10/2018 à 11:02, Aneesh Kumar K.V a écrit :
> On 10/12/18 1:38 PM, Christophe LEROY wrote:
>>
>>
>> Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
>>> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
>>>> Greeting's
>>>>
>>>> Today's linux-next fails to boot on powerpc bare-metal with this error
>>>>
>>>> POWER8 performance monitor hardware support registered
>>>> rcu: Hierarchical SRCU implementation.
>>>> smp: Bringing up secondary CPUs ...
>>>> Kernel panic - not syncing: stack-protector: Kernel stack is 
>>>> corrupted in: __schedule+0x978/0xa80
>>>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
>>>> 4.19.0-rc7-next-20181010-autotest-autotest #1
>>>> Call Trace:
>>>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
>>>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
>>>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
>>>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
>>>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
>>>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
>>>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
>>>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
>>>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
>>>> Rebooting in 10 seconds..
>>>>
>>>> Machine: Power 8 bare-metal
>>>> kernel version: 4.19.0-rc7-next-20181010
>>>> gcc version: 4.8.5 20150623
>>>> config attach
>>>
>>> Attaching the kernel config file
>>>
>>
>> # Linux/powerpc 4.11.0-rc4 Kernel Configuration
>>
>> This is not the correct config file. Can you send the .config ?
>>
>> Christophe
> 
> modified   kernel/sched/idle.c
> @@ -352,7 +352,6 @@ void cpu_startup_entry(enum cpuhp_state state)
>        * make this generic (ARM and SH have never invoked the canary
>        * init for the non boot CPUs!). Will be fixed in 3.11
>        */
> -#ifdef CONFIG_X86
>       /*
>        * If we're the non-boot CPU, nothing set the stack canary up
>        * for us. The boot CPU already has it initialized but no harm
> @@ -361,7 +360,6 @@ void cpu_startup_entry(enum cpuhp_state state)
>        * canaries already on the stack wont ever trigger).
>        */
>       boot_init_stack_canary();
> -#endif
>       arch_cpu_idle_prepare();
>       cpuhp_online_idle(state);
>       while (1)
> 
> 
> This fixes it for me. But we may have to look at the other arch details 
> mentioned there.

I think calling again boot_init_stack_canary() will be an issue for all 
arches using global canary.

As far as I can see, PPC and X86 are the only arches using non global.

Christophe
