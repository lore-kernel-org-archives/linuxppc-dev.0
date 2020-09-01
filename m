Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB6C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 07:49:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DABF2068E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 07:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DABF2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgfNG5CFtzDqV6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 17:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BgfKJ01FQzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2020 17:46:43 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67F51FB;
 Tue,  1 Sep 2020 00:46:41 -0700 (PDT)
Received: from [10.163.69.134] (unknown [10.163.69.134])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587ED3F71F;
 Tue,  1 Sep 2020 00:46:37 -0700 (PDT)
Subject: Re: [PATCH v3 03/13] mm/debug_vm_pgtable/ppc64: Avoid setting top
 bits in radom value
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-4-aneesh.kumar@linux.ibm.com>
 <3a0b0101-e6ec-26c5-e104-5b0bb95c3e51@arm.com>
 <1a8abe92-032b-f60f-1df1-52bb409b35a3@linux.ibm.com>
 <75771782-734b-69f6-4a07-2d3542458319@arm.com>
 <e5d32d12-d904-ed8c-8963-d43d2c3744d9@linux.ibm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c371e316-7533-62c7-a1c6-9b6745d8d1ea@arm.com>
Date: Tue, 1 Sep 2020 13:16:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5d32d12-d904-ed8c-8963-d43d2c3744d9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 09/01/2020 01:06 PM, Aneesh Kumar K.V wrote:
> On 9/1/20 1:02 PM, Anshuman Khandual wrote:
>>
>>
>> On 09/01/2020 11:51 AM, Aneesh Kumar K.V wrote:
>>> On 9/1/20 8:45 AM, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>>> ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
>>>>> random value.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>    mm/debug_vm_pgtable.c | 13 ++++++++++---
>>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>> index 086309fb9b6f..bbf9df0e64c6 100644
>>>>> --- a/mm/debug_vm_pgtable.c
>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>> @@ -44,10 +44,17 @@
>>>>>     * entry type. But these bits might affect the ability to clear entries with
>>>>>     * pxx_clear() because of how dynamic page table folding works on s390. So
>>>>>     * while loading up the entries do not change the lower 4 bits. It does not
>>>>> - * have affect any other platform.
>>>>> + * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
>>>>> + * used to mark a pte entry.
>>>>>     */
>>>>> -#define S390_MASK_BITS    4
>>>>> -#define RANDOM_ORVALUE    GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
>>>>> +#define S390_SKIP_MASK        GENMASK(3, 0)
>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>> +#define PPC64_SKIP_MASK        GENMASK(62, 62)
>>>>> +#else
>>>>> +#define PPC64_SKIP_MASK        0x0
>>>>> +#endif
>>>>
>>>> Please drop the #ifdef CONFIG_PPC_BOOK3S_64 here. We already accommodate skip
>>>> bits for a s390 platform requirement and can also do so for ppc64 as well. As
>>>> mentioned before, please avoid adding any platform specific constructs in the
>>>> test.
>>>>
>>>
>>>
>>> that is needed so that it can be built on 32 bit architectures.I did face build errors with arch-linux
>>
>> Could not (#if __BITS_PER_LONG == 32) be used instead or something like
>> that. But should be a generic conditional check identifying 32 bit arch
>> not anything platform specific.
>>
> 
> that _PAGE_PTE bit is pretty much specific to PPC BOOK3S_64.  Not sure why other architectures need to bothered about ignoring bit 62.

Thats okay as long it does not adversely affect other architectures, ignoring
some more bits is acceptable. Like existing S390_MASK_BITS gets ignored on all
other platforms even if it is a s390 specific constraint. Not having platform
specific #ifdef here, is essential.
