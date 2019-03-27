Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F415C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:57:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A44A20449
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A44A20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tp1Y26b5zDqQX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 23:57:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.232; helo=relay12.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tnyc4dfdzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:54:45 +1100 (AEDT)
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr
 [81.250.144.103]) (Authenticated sender: alex@ghiti.fr)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4CC6A20000A;
 Wed, 27 Mar 2019 12:54:35 +0000 (UTC)
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
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
 <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
 <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
 <87pnqcws2u.fsf@linux.ibm.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <95819dc9-7910-f273-681c-a241fee62dd2@ghiti.fr>
Date: Wed, 27 Mar 2019 13:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87pnqcws2u.fsf@linux.ibm.com>
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

On 03/27/2019 11:05 AM, Aneesh Kumar K.V wrote:
> Alexandre Ghiti <alex@ghiti.fr> writes:
>
>> On 03/27/2019 09:55 AM, Aneesh Kumar K.V wrote:
>>> On 3/27/19 2:14 PM, Alexandre Ghiti wrote:
>>>>
>>>> On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
>>>>> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
> .....
>
>>> This is now
>>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>>> static inline bool gigantic_page_runtime_supported(void)
>>> {
>>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>>          return false;
>>>
>>>      return true;
>>> }
>>>
>>>
>>> I am wondering whether it should be
>>>
>>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>>> static inline bool gigantic_page_runtime_supported(void)
>>> {
>>>
>>>     if (!IS_ENABLED(CONFIG_CONTIG_ALLOC))
>>>          return false;
>> I don't think this test should happen here, CONFIG_CONTIG_ALLOC only allows
>> to allocate gigantic pages, doing that check here would prevent powerpc
>> to free boottime gigantic pages when not a guest. Note that this check
>> is actually done in set_max_huge_pages.
>>
>>
>>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>>          return false;
>> Maybe I did not understand this check: I understood that, in the case
>> the system
>> is virtualized, we do not want it to hand back gigantic pages. Does this
>> check
>> test if the system is currently being virtualized ?
>> If yes, I think the patch is correct: it prevents freeing gigantic pages
>> when the system
>> is virtualized but allows a 'normal' system to free gigantic pages.
>>
>>
> Ok double checked the patch applying the the tree. I got confused by the
> removal of that #ifdef. So we now disallow the runtime free by checking
> for gigantic_page_runtime_supported() in  __nr_hugepages_store_common.
> Now if we allow and if CONFIG_CONTIG_ALLOC is disabled, we still should
> allow to free the boot time allocated pages back to buddy.
>
> The patch looks good. You can add for the series
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> -aneesh
>

Thanks for your time Aneesh,

Alex
