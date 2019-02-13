Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86640C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:32:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303B222CF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303B222CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4408mx0FH2zDqTX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 06:32:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.242; helo=mslow2.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4408hY4dMKzDqSs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 06:28:45 +1100 (AEDT)
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 017603A58BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 20:23:03 +0100 (CET)
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0F08B100005;
 Wed, 13 Feb 2019 19:22:21 +0000 (UTC)
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
To: Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190117183953.5990-1-aghiti@upmem.com>
 <16a6209c-868b-8fd5-a70a-6e0e1ecb62d4@suse.cz>
From: Alex Ghiti <alex@ghiti.fr>
Message-ID: <7801de9c-9a8c-fb56-442a-6e530e52e0d8@ghiti.fr>
Date: Wed, 13 Feb 2019 14:22:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <16a6209c-868b-8fd5-a70a-6e0e1ecb62d4@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
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
Cc: hch@infradead.org, linux-riscv@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 2/13/19 6:27 AM, Vlastimil Babka wrote:
> On 1/17/19 7:39 PM, Alexandre Ghiti wrote:
>> From: Alexandre Ghiti <alex@ghiti.fr>
>>
>> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
>> that support gigantic pages, boottime reserved gigantic pages can not be
>> freed at all. This patchs simply enables the possibility to hand back
>> those pages to memory allocator.
>>
>> This commit then renames gigantic_page_supported and
>> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
>> being false does not mean that the system cannot use gigantic pages: it
>> just means that runtime allocation of gigantic pages is not supported,
>> one can still allocate boottime gigantic pages if the architecture supports
>> it.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> I'm fine with the change, but wonder if this can be structured better in a way
> which would remove the duplicated "if (MEMORY_ISOLATION && COMPACTION) || CMA"
> from all arches, as well as the duplicated
> gigantic_page_runtime_allocation_supported()


Yeah, totally, we can factorize more than what I did. I prepared a v2 of 
this
patch that does exactly that: remove the triplet from arch specific code
and the duplicated gigantic_page_runtime_allocation_supported.


> something like:
>
> - "select ARCH_HAS_GIGANTIC_PAGE" has no conditions, it just says the arch can
> support them either at boottime or runtime (but runtime is usable only if other
> conditions are met)


And the v2 gets rid of ARCH_HAS_GIGANTIC_PAGE totally since it
is not needed by arch to advertise the fact they support gigantic page,
actually, when selected, it really just means that an arch has the means
to allocate runtime gigantic page: it is equivalent to
(MEMORY_ISOLATION && COMPACTION) || CMA.


> - gigantic_page_runtime_allocation_supported() is a function that returns true
> if ARCH_HAS_GIGANTIC_PAGE && ((MEMORY_ISOLATION && COMPACTION) || CMA) and
> there's a single instance, not per-arch.
> - code for freeing gigantic pages can probably still be conditional on
> ARCH_HAS_GIGANTIC_PAGE
>
> BTW I wanted also to do something about the "(MEMORY_ISOLATION && COMPACTION) ||
> CMA" ugliness itself, i.e. put the common parts behind some new kconfig
> (COMPACTION_CORE ?) and expose it better to users, but I can take a stab on that
> once the above part is settled.
> Vlastimil


I send the v2 right away, if you can take a look Vlastimil, that would 
be great.
Note that Andrew already picked this patch in its tree, I'm not sure how to
proceed.


Thanks for your remarks !


Alex

