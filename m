Return-Path: <SRS0=qWQb=4B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24337C352A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 02:18:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F3206DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 02:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F3206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48J0Xn5RmzzDqTd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 13:18:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 48J0Vg5YHhzDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2020 13:16:09 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0600030E;
 Wed, 12 Feb 2020 18:16:07 -0800 (PST)
Received: from [192.168.0.129] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017A33F68E;
 Wed, 12 Feb 2020 18:15:52 -0800 (PST)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page
 table helpers
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
References: <1580174873-18117-1-git-send-email-anshuman.khandual@arm.com>
 <20200210153716.GB9283@E121110.arm.com>
 <b169ff9d-7b87-91f4-b3d0-e97f86680d0c@arm.com>
 <20200212185548.3274ec2e@thinkpad>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <085cdec7-1759-82c6-7a65-9b7d28c1c458@arm.com>
Date: Thu, 13 Feb 2020 07:45:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200212185548.3274ec2e@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Vlastimil Babka <vbabka@suse.cz>, James Hogan <jhogan@kernel.org>,
 linux-snps-arc@lists.infradead.org, Kees Cook <keescook@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sri Krishna chowdary <schowdary@nvidia.com>,
 Dave Hansen <dave.hansen@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 02/12/2020 11:25 PM, Gerald Schaefer wrote:
> On Wed, 12 Feb 2020 15:12:54 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>>> +/*
>>>> + * On s390 platform, the lower 12 bits are used to identify given page table
>>>> + * entry type and for other arch specific requirements. But these bits might
>>>> + * affect the ability to clear entries with pxx_clear(). So while loading up
>>>> + * the entries skip all lower 12 bits in order to accommodate s390 platform.
>>>> + * It does not have affect any other platform.
>>>> + */
>>>> +#define RANDOM_ORVALUE	(0xfffffffffffff000UL)  
>>>
>>> I'd suggest you generate this mask with something like
>>> GENMASK(BITS_PER_LONG, PAGE_SHIFT).  
>>
>> IIRC the lower 12 bits constrains on s390 platform might not be really related
>> to it's PAGE_SHIFT which can be a variable, but instead just a constant number.
>> But can definitely use GENMASK or it's variants here.
>>
>> https://lkml.org/lkml/2019/9/5/862
> 
> PAGE_SHIFT would be fine, it is 12 on s390. However, in order to be
> more precise, we do not really need all 12 bits, only the last 4 bits.
> So, something like this would work:
> 
> #define RANDOM_ORVALUE GENMASK(BITS_PER_LONG - 1, 4)
> 
> The text in the comment could then also be changed from 12 to 4, and
> be a bit more specific on the fact that the impact on pxx_clear()
> results from the dynamic page table folding logic on s390:
> 
> /*
>  * On s390 platform, the lower 4 bits are used to identify given page table
>  * entry type. But these bits might affect the ability to clear entries with
>  * pxx_clear() because of how dynamic page table folding works on s390. So
>  * while loading up the entries do not change the lower 4 bits.
>  * It does not have affect any other platform.
>  */

Sure, will update accordingly.
