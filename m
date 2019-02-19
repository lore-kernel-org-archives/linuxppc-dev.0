Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D0E208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b2GCTC3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D0E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443pYT59MwzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 05:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="b2GCTC3x"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443pWg3qNRzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 05:03:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 443pWZ2F8mz9v4wf;
 Tue, 19 Feb 2019 19:03:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=b2GCTC3x; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eQrEmwqWTBU2; Tue, 19 Feb 2019 19:03:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 443pWZ0rg0z9v4wc;
 Tue, 19 Feb 2019 19:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550599418; bh=LNCXwSviXkWBvTddFJgcavOW7yBNAyJmLfKdg/qHe68=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=b2GCTC3x+1ebV4kjmNBe4K2VSwG9YLP9usH79S0UkAn7UGWF/y176Exd0PiDDf6On
 LC/NVSccjWdc1nyRfliH2uwaIFZ6fRkXXohRjhEh2JRMWF71YFqWI96w2JcO5Vona3
 XTV1cSws4JrvGLs/oYJnlmdaoWq/AKqVCBholtlE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C84A38B7FE;
 Tue, 19 Feb 2019 19:03:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kUrM2n6LmiuF; Tue, 19 Feb 2019 19:03:39 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 010C88B7F9;
 Tue, 19 Feb 2019 19:03:38 +0100 (CET)
Subject: Re: [PATCH v5 3/3] powerpc/32: Add KASAN support
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
References: <cover.1549935247.git.christophe.leroy@c-s.fr>
 <3429fe33b68206ecc2a725a740937bbaef2d1ac8.1549935251.git.christophe.leroy@c-s.fr>
 <87a7itqwdo.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8654376c-2c55-89b0-cd79-0bcf02338519@c-s.fr>
Date: Tue, 19 Feb 2019 19:03:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87a7itqwdo.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/02/2019 à 10:27, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
>> index e0637730a8e7..dba2c1038363 100644
>> --- a/arch/powerpc/include/asm/ppc_asm.h
>> +++ b/arch/powerpc/include/asm/ppc_asm.h
>> @@ -251,6 +251,10 @@ GLUE(.,name):
>>   
>>   #define _GLOBAL_TOC(name) _GLOBAL(name)
>>   
>> +#define KASAN_OVERRIDE(x, y) \
>> +	.weak x;	     \
>> +	.set x, y
>> +
> 
> Can you add a comment describing what that does and why?

It's gone. Hope the new approach is more clear. It's now in a dedicated 
patch.

> 
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index 879b36602748..fc4c42262694 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -16,8 +16,9 @@ CFLAGS_prom_init.o      += -fPIC
>>   CFLAGS_btext.o		+= -fPIC
>>   endif
>>   
>> -CFLAGS_cputable.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>> -CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>> +CFLAGS_early_32.o += -DDISABLE_BRANCH_PROFILING
>> +CFLAGS_cputable.o += $(DISABLE_LATENT_ENTROPY_PLUGIN) -DDISABLE_BRANCH_PROFILING
>> +CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN) -DDISABLE_BRANCH_PROFILING
> 
> Why do we need to disable branch profiling now?

Recommended by Andrey, see https://patchwork.ozlabs.org/patch/1023887/

Maybe it should be only when KASAN is active ? For prom_init it should 
probably be all the time, for the others I don't know. Can't remember 
why I did it that way.

> 
> I'd probably be happier if all the CFLAGS changes were done in a leadup
> patch to make them more obvious.

Oops, I forgot to read your mail entirely before sending out v6. Indeed 
I only read first part. Anyway, that's probably not the last run.

> 
>> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
>> index 667df97d2595..da6bb16e0876 100644
>> --- a/arch/powerpc/kernel/prom_init_check.sh
>> +++ b/arch/powerpc/kernel/prom_init_check.sh
>> @@ -16,8 +16,16 @@
>>   # If you really need to reference something from prom_init.o add
>>   # it to the list below:
>>   
>> +grep CONFIG_KASAN=y .config >/dev/null
> 
> Just to be safe "^CONFIG_KASAN=y$" ?

ok

> 
>> +if [ $? -eq 0 ]
>> +then
>> +	MEMFCT="__memcpy __memset"
>> +else
>> +	MEMFCT="memcpy memset"
>> +fi
> 
> MEM_FUNCS ?

Yes, I change it now before I forget.

> 
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 3bf9fc6fd36c..ce8d4a9f810a 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -8,6 +8,14 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>>   CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
>>   CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
>>   
>> +KASAN_SANITIZE_code-patching.o := n
>> +KASAN_SANITIZE_feature-fixups.o := n
>> +
>> +ifdef CONFIG_KASAN
>> +CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
>> +CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
>> +endif
> 
> There's that branch profiling again, though here it's only if KASAN is enabled.
> 
>> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init.c
>> new file mode 100644
>> index 000000000000..bd8e0a263e12
>> --- /dev/null
>> +++ b/arch/powerpc/mm/kasan_init.c
>> @@ -0,0 +1,114 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define DISABLE_BRANCH_PROFILING
>> +
>> +#include <linux/kasan.h>
>> +#include <linux/printk.h>
>> +#include <linux/memblock.h>
>> +#include <linux/sched/task.h>
>> +#include <asm/pgalloc.h>
>> +
>> +void __init kasan_early_init(void)
>> +{
>> +	unsigned long addr = KASAN_SHADOW_START;
>> +	unsigned long end = KASAN_SHADOW_END;
>> +	unsigned long next;
>> +	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> 
> Can none of those fail?

map_kernel_page() in pgtable_32.c does exactly the same.

pud_offset() and pmd_offset() are no-ops and only serve as type 
modifiers, so pmd will get the value returned by pgd_offset_k() which 
should always be valid unless init_mm->pgd is bad.

Christophe

> 
> 
> cheers
> 
