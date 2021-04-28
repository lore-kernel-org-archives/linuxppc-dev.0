Return-Path: <SRS0=n52k=JZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26F5C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 10:21:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7F261107
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 10:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7F261107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVZRH2K96z30Cs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 20:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVZQt3Nmjz2yS0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Apr 2021 20:20:50 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4FVZQk5S63z9tWv;
 Wed, 28 Apr 2021 12:20:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KF_MRN7mc2b; Wed, 28 Apr 2021 12:20:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FVX4B50rWz9wBD;
 Wed, 28 Apr 2021 10:34:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 802658B800;
 Wed, 28 Apr 2021 10:34:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Gx7tFBR7ujua; Wed, 28 Apr 2021 10:34:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 56CED8B799;
 Wed, 28 Apr 2021 10:34:33 +0200 (CEST)
Subject: Re: [PATCH v13 06/14] mm: HUGE_VMAP arch support cleanup
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20210317062402.533919-1-npiggin@gmail.com>
 <20210317062402.533919-7-npiggin@gmail.com>
 <303a93df-6b32-1b3e-d293-b569e1a4b03e@csgroup.eu>
Message-ID: <ad8138dd-3b99-bb76-3257-2d959f770d4b@csgroup.eu>
Date: Wed, 28 Apr 2021 10:34:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <303a93df-6b32-1b3e-d293-b569e1a4b03e@csgroup.eu>
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Ding Tianhong <dingtianhong@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 28/04/2021 à 10:32, Christophe Leroy a écrit :
> 
> 
> Le 17/03/2021 à 07:23, Nicholas Piggin a écrit :
>> This changes the awkward approach where architectures provide init
>> functions to determine which levels they can provide large mappings for,
>> to one where the arch is queried for each call.
>>
>> This removes code and indirection, and allows constant-folding of dead
>> code for unsupported levels.
>>
>> This also adds a prot argument to the arch query. This is unused
>> currently but could help with some architectures (e.g., some powerpc
>> processors can't map uncacheable memory with large pages).
>>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arm64]
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/arm64/include/asm/vmalloc.h         |  8 ++
>>   arch/arm64/mm/mmu.c                      | 10 +--
>>   arch/powerpc/include/asm/vmalloc.h       |  8 ++
>>   arch/powerpc/mm/book3s64/radix_pgtable.c |  8 +-
>>   arch/x86/include/asm/vmalloc.h           |  7 ++
>>   arch/x86/mm/ioremap.c                    | 12 +--
>>   include/linux/io.h                       |  9 ---
>>   include/linux/vmalloc.h                  |  6 ++
>>   init/main.c                              |  1 -
>>   mm/debug_vm_pgtable.c                    |  4 +-
>>   mm/ioremap.c                             | 94 ++++++++++--------------
>>   11 files changed, 87 insertions(+), 80 deletions(-)
>>
> 
>> diff --git a/mm/ioremap.c b/mm/ioremap.c
>> index 3f4d36f9745a..3264d0203785 100644
>> --- a/mm/ioremap.c
>> +++ b/mm/ioremap.c
>> @@ -16,49 +16,16 @@
>>   #include "pgalloc-track.h"
>>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> -static int __read_mostly ioremap_p4d_capable;
>> -static int __read_mostly ioremap_pud_capable;
>> -static int __read_mostly ioremap_pmd_capable;
>> -static int __read_mostly ioremap_huge_disabled;
>> +static bool __ro_after_init iomap_max_page_shift = PAGE_SHIFT;
> 
> Must be an int, not a bool.

And the initial value seems wrong. Should be P4D_SHIFT ?

> 
>>   static int __init set_nohugeiomap(char *str)
>>   {
>> -    ioremap_huge_disabled = 1;
>> +    iomap_max_page_shift = P4D_SHIFT;

And PAGE_SHIFT here when NO hugeiomap ?

>>       return 0;
>>   }
>>   early_param("nohugeiomap", set_nohugeiomap);

Christophe
