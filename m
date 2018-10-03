Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE6C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:06:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A6D20684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A6D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5Bd3FpfzF3C1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:06:49 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q58Q00vhzDqNF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:04:53 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Q58L1Ln8z9ttBf;
 Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id II4M8NEYNdxy; Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Q58L0nLZz9ttBW;
 Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 630A58B8B5;
 Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 8sU21jiBjep0; Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C2CE8B74C;
 Wed,  3 Oct 2018 08:04:50 +0200 (CEST)
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
 <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
 <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
 <20181003155243.70806497@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <210d5ce2-1f62-2458-617b-fe604b95919e@c-s.fr>
Date: Wed, 3 Oct 2018 08:04:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003155243.70806497@roar.ozlabs.ibm.com>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 03/10/2018 à 07:52, Nicholas Piggin a écrit :
> On Wed, 3 Oct 2018 07:47:05 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 03/10/2018 à 07:30, Nicholas Piggin a écrit :
>>> On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> This patch activates CONFIG_THREAD_INFO_IN_TASK which
>>>> moves the thread_info into task_struct.
>>>>
>>>> Moving thread_info into task_struct has the following advantages:
>>>> - It protects thread_info from corruption in the case of stack
>>>> overflows.
>>>> - Its address is harder to determine if stack addresses are
>>>> leaked, making a number of attacks more difficult.
>>>>
>>>> This has the following consequences:
>>>> - thread_info is now located at the top of task_struct.
>>>
>>> "top"... I got confused for a minute thinking high address and
>>> wondering how you can change CURRENT_THREAD_INFO just to point
>>> to current :)
>>
>> Would 'beginning' be less confusing ?
> 
> Yes, good idea.
> 
>>>> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
>>>>    /* 32-bit */
>>>>    extern int smp_hw_index[];
>>>>    
>>>> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
>>>> +/*
>>>> + * This is particularly ugly: it appears we can't actually get the definition
>>>> + * of task_struct here, but we need access to the CPU this task is running on.
>>>> + * Instead of using task_struct we're using _TASK_CPU which is extracted from
>>>> + * asm-offsets.h by kbuild to get the current processor ID.
>>>> + */
>>>> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + _TASK_CPU))
>>>
>>> This is clever but yes ugly. Can't you include asm-offsets.h? riscv
>>> seems to.
>>
>> riscv has a clean asm-offsets.h . Our's defines constant with the same
>> name as those defined in other headers which are included in C files. So
>> including asm-offsets in C files does create conflicts like:
>>
>> ./include/generated/asm-offsets.h:71:0: warning: "TASK_SIZE" redefined
>>    #define TASK_SIZE -2147483648 /* TASK_SIZE */
>> ./arch/powerpc/include/asm/processor.h:95:0: note: this is the location
>> of the previous definition
>>    #define TASK_SIZE (CONFIG_TASK_SIZE)
>>
>> ./include/generated/asm-offsets.h:98:0: warning: "NSEC_PER_SEC" redefined
>>    #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC */
>> ./include/linux/time64.h:36:0: note: this is the location of the
>> previous definition
>>    #define NSEC_PER_SEC 1000000000L
>>
>> ./arch/powerpc/include/asm/nohash/32/pgtable.h:34:0: warning:
>> "PGD_TABLE_SIZE" redefined
>>    #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
>> ./include/generated/asm-offsets.h:101:0: note: this is the location of
>> the previous definition
>>    #define PGD_TABLE_SIZE 256 /* PGD_TABLE_SIZE */
>>
>> ...
> 
> Okay.
> 
>>
>> In v2, I had a patch to fix those redundancies
>> (https://patchwork.ozlabs.org/patch/974363/) but I found it unconvenient.
> 
> Because of merge conflicts, or you did not like the new names?

Both, because of the amount of changes it implies, and also because of 
the new names. I find it quite convenient to be able to use same names 
both in C and ASM. And I didn't want my serie to imply big-bangs in 
unrelated or not directly related topics.

Christophe

> 
> Thanks,
> Nick
> 
