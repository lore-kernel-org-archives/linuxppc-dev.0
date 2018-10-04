Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50774C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 08:22:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22802098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 08:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22802098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qm9B4MR3zF3J0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 18:22:54 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qm6s0gdYzF37M
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 18:20:52 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Qm6k0clfz9ttCM;
 Thu,  4 Oct 2018 10:20:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2Wnz-K94dzA7; Thu,  4 Oct 2018 10:20:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Qm6k05Dpz9ttBv;
 Thu,  4 Oct 2018 10:20:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C3458B90B;
 Thu,  4 Oct 2018 10:20:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 99vJ-2qz5Eka; Thu,  4 Oct 2018 10:20:48 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8393E8B907;
 Thu,  4 Oct 2018 10:20:47 +0200 (CEST)
Subject: Re: [RFC PATCH v3 1/7] book3s/64: avoid circular header inclusion in
 mmu-hash.h
To: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
 <20181003142400.490fd38a@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <bed3d788-6633-6eef-30ea-bdfa374e0216@c-s.fr>
Date: Thu, 4 Oct 2018 10:20:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003142400.490fd38a@roar.ozlabs.ibm.com>
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



Le 03/10/2018 à 06:24, Nicholas Piggin a écrit :
> On Mon,  1 Oct 2018 12:30:19 +0000 (UTC)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
>> includes asm/current.h. This generates a circular dependency.
>> To avoid that, asm/processor.h shall not be included in mmu-hash.h
>>
>> In order to do that, this patch moves into a new header called
>> asm/task_size.h the information from asm/processor.h requires by
>> mmu-hash.h
> 
> Doesn't look like you use this header in 32-bit code. Put task_size.h
> in asm/64/ maybe?

There is no asm/64/ dir at the time being, only book3s/64/ and nohash/64/

I'm thinking about leaving it in asm/ but renaming it task_size_user64.h

Christophe

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>>   arch/powerpc/include/asm/processor.h          | 34 +---------------------
>>   arch/powerpc/include/asm/task_size.h          | 42 +++++++++++++++++++++++++++
>>   arch/powerpc/kvm/book3s_hv_hmi.c              |  1 +
>>   4 files changed, 45 insertions(+), 34 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/task_size.h
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> index bbeaf6adf93c..7788e35f19f0 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -23,7 +23,7 @@
>>    */
>>   #include <asm/book3s/64/pgtable.h>
>>   #include <asm/bug.h>
>> -#include <asm/processor.h>
>> +#include <asm/task_size.h>
>>   #include <asm/cpu_has_feature.h>
>>   
>>   /*
>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>> index 350c584ca179..353879db3e98 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -101,40 +101,8 @@ void release_thread(struct task_struct *);
>>   #endif
>>   
>>   #ifdef CONFIG_PPC64
>> -/*
>> - * 64-bit user address space can have multiple limits
>> - * For now supported values are:
>> - */
>> -#define TASK_SIZE_64TB  (0x0000400000000000UL)
>> -#define TASK_SIZE_128TB (0x0000800000000000UL)
>> -#define TASK_SIZE_512TB (0x0002000000000000UL)
>> -#define TASK_SIZE_1PB   (0x0004000000000000UL)
>> -#define TASK_SIZE_2PB   (0x0008000000000000UL)
>> -/*
>> - * With 52 bits in the address we can support
>> - * upto 4PB of range.
>> - */
>> -#define TASK_SIZE_4PB   (0x0010000000000000UL)
>>   
>> -/*
>> - * For now 512TB is only supported with book3s and 64K linux page size.
>> - */
>> -#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
>> -/*
>> - * Max value currently used:
>> - */
>> -#define TASK_SIZE_USER64		TASK_SIZE_4PB
>> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
>> -#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
>> -#else
>> -#define TASK_SIZE_USER64		TASK_SIZE_64TB
>> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
>> -/*
>> - * We don't need to allocate extended context ids for 4K page size, because
>> - * we limit the max effective address on this config to 64TB.
>> - */
>> -#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
>> -#endif
>> +#include <asm/task_size.h>
>>   
>>   /*
>>    * 32-bit user address space is 4GB - 1 page
>> diff --git a/arch/powerpc/include/asm/task_size.h b/arch/powerpc/include/asm/task_size.h
>> new file mode 100644
>> index 000000000000..ca45638617b0
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/task_size.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_TASK_SIZE_H
>> +#define _ASM_POWERPC_TASK_SIZE_H
>> +
>> +#ifdef CONFIG_PPC64
>> +/*
>> + * 64-bit user address space can have multiple limits
>> + * For now supported values are:
>> + */
>> +#define TASK_SIZE_64TB  (0x0000400000000000UL)
>> +#define TASK_SIZE_128TB (0x0000800000000000UL)
>> +#define TASK_SIZE_512TB (0x0002000000000000UL)
>> +#define TASK_SIZE_1PB   (0x0004000000000000UL)
>> +#define TASK_SIZE_2PB   (0x0008000000000000UL)
>> +/*
>> + * With 52 bits in the address we can support
>> + * upto 4PB of range.
>> + */
>> +#define TASK_SIZE_4PB   (0x0010000000000000UL)
>> +
>> +/*
>> + * For now 512TB is only supported with book3s and 64K linux page size.
>> + */
>> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
>> +/*
>> + * Max value currently used:
>> + */
>> +#define TASK_SIZE_USER64		TASK_SIZE_4PB
>> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
>> +#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
>> +#else
>> +#define TASK_SIZE_USER64		TASK_SIZE_64TB
>> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
>> +/*
>> + * We don't need to allocate extended context ids for 4K page size, because
>> + * we limit the max effective address on this config to 64TB.
>> + */
>> +#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
>> +#endif
>> +
>> +#endif /* CONFIG_PPC64 */
>> +#endif /* _ASM_POWERPC_TASK_SIZE_H */
>> diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
>> index e3f738eb1cac..64b5011475c7 100644
>> --- a/arch/powerpc/kvm/book3s_hv_hmi.c
>> +++ b/arch/powerpc/kvm/book3s_hv_hmi.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/compiler.h>
>>   #include <asm/paca.h>
>>   #include <asm/hmi.h>
>> +#include <asm/processor.h>
>>   
>>   void wait_for_subcore_guest_exit(void)
>>   {
>> -- 
>> 2.13.3
>>
