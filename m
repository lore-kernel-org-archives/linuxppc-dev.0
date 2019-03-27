Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C4EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:47:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FED2075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FED2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ThTX2vWdzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 19:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.183.197; helo=relay5-d.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ThQz0jpvzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 19:45:26 +1100 (AEDT)
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr
 [81.250.144.103]) (Authenticated sender: alex@ghiti.fr)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8DB451C0004;
 Wed, 27 Mar 2019 08:45:15 +0000 (UTC)
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
Date: Wed, 27 Mar 2019 09:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
>> On systems without CONTIG_ALLOC activated but that support gigantic 
>> pages,
>> boottime reserved gigantic pages can not be freed at all. This patch
>> simply enables the possibility to hand back those pages to memory
>> allocator.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h 
>> b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index ec2a55a553c7..7013284f0f1b 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -36,8 +36,8 @@ static inline int hstate_get_psize(struct hstate 
>> *hstate)
>>       }
>>   }
>>   -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void)
>> +#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> +static inline bool gigantic_page_runtime_supported(void)
>>   {
>>       /*
>>        * We used gigantic page reservation with hypervisor assist in 
>> some case.
>> @@ -49,7 +49,6 @@ static inline bool gigantic_page_supported(void)
>>         return true;
>>   }
>> -#endif
>>     /* hugepd entry valid bit */
>>   #define HUGEPD_VAL_BITS        (0x8000000000000000UL)
>
> Is that correct when CONTIG_ALLOC is not enabled? I guess we want
>
> gigantic_page_runtime_supported to return false when CONTIG_ALLOC is 
> not enabled on all architectures and on POWER when it is enabled we 
> want it to be conditional as it is now.
>
> -aneesh
>

CONFIG_ARCH_HAS_GIGANTIC_PAGE is set by default when an architecture 
supports gigantic
pages: on its own, it allows to allocate boottime gigantic pages AND to 
free them at runtime
(this is the goal of this series), but not to allocate runtime gigantic 
pages.
If CONTIG_ALLOC is set, it allows in addition to allocate runtime 
gigantic pages.

I re-introduced the runtime checks because we can't know at compile time 
if powerpc can
or not support gigantic pages.

So for all architectures, gigantic_page_runtime_supported only depends on
CONFIG_ARCH_HAS_GIGANTIC_PAGE enabled or not. The possibility to 
allocate runtime
gigantic pages is dealt with after those runtime checks.

By the way, I forgot to ask you why you think that if an arch cannot 
allocate runtime gigantic
pages, it should not be able to free boottime gigantic pages ?
