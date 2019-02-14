Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B4DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 11:01:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEB8222A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 11:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEB8222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440YNM6h3HzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:01:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.183.193; helo=relay1-d.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440YLW0RcPzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 21:59:29 +1100 (AEDT)
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr
 [81.250.144.103]) (Authenticated sender: alex@ghiti.fr)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 87261240005;
 Thu, 14 Feb 2019 10:59:18 +0000 (UTC)
Subject: Re: [PATCH v2] hugetlb: allow to free gigantic pages regardless of
 the configuration
To: Vlastimil Babka <vbabka@suse.cz>, Dave Hansen <dave.hansen@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190213192610.17265-1-alex@ghiti.fr>
 <d367b5c7-eb05-6d0b-f9bf-5b3fc3f392a9@intel.com>
 <bcffa37e-22cd-f0d7-ee85-769c0d54520a@suse.cz>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <3f694efe-c8d4-d0b0-a3eb-127d1a6b0fd0@ghiti.fr>
Date: Thu, 14 Feb 2019 11:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <bcffa37e-22cd-f0d7-ee85-769c0d54520a@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

On 02/14/2019 10:52 AM, Vlastimil Babka wrote:
> On 2/13/19 8:30 PM, Dave Hansen wrote:
>>> -#if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
>>> +#ifdef CONFIG_COMPACTION_CORE
>>>   static __init int gigantic_pages_init(void)
>>>   {
>>>   	/* With compaction or CMA we can allocate gigantic pages at runtime */
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index ac474a61be37..8fecd3ea5563 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -207,8 +207,9 @@ config HUGETLB_PAGE
>>>   config MEMFD_CREATE
>>>   	def_bool TMPFS || HUGETLBFS
>>>   
>>> -config ARCH_HAS_GIGANTIC_PAGE
>>> +config COMPACTION_CORE
>>>   	bool
>>> +	default y if (MEMORY_ISOLATION && MIGRATION) || CMA
>> This takes a hard dependency (#if) and turns it into a Kconfig *default*
>> that can be overridden.  That seems like trouble.
>>
>> Shouldn't it be:
>>
>> config COMPACTION_CORE
>> 	def_bool y
>> 	depends on (MEMORY_ISOLATION && MIGRATION) || CMA
> Agreed. Also I noticed that it now depends on MIGRATION instead of
> COMPACTION. That intention is correct IMHO, but will fail to
> compile/link when both COMPACTION and CMA are disabled, and would need
> more changes in mm/internal.h and mm/compaction.c (possibly just
> replacing CMA in all "if defined CONFIG_COMPACTION || defined
> CONFIG_CMA" instances with COMPACTION_CORE, but there might be more
> problems, wanna try? :)

Let's be honest, that's a "typo" :) Migration is logical to me but
that's because I don't know much about compaction. Thanks for
noticing it.
I'll take a look at what you propose to do too.

>
> Also, I realized that COMPACTION_CORE is a wrong name, sorry about that.
> What the config really provides is alloc_contig_range(), so it should be
> named either CONFIG_CMA_CORE (as it provides contiguous memory
> allocation, but not the related reservation and accounting), or
> something like CONFIG_CONTIG_ALLOC. I would also move it from fs/Kconfig
> to mm/Kconfig.

No problem, I was not inspired either. I'll send a v3 with the renaming
you propose.

> Thanks!

Thank you.

Alex

