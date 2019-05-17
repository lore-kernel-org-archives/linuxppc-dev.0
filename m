Return-Path: <SRS0=79up=TR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110CC04AB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 11:13:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9567B20879
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 11:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9567B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4555JP32QlzDqXZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 21:13:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4555Gy6S0ZzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2019 21:12:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4555Gy1kMKz9sB3;
 Fri, 17 May 2019 21:12:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org
Subject: Re: [RFC PATCH 3/3] powerpc/mm/hugetlb: Don't enable HugeTLB if we
 don't have a page table cache
In-Reply-To: <04403623-d4ae-1d91-d3f4-16bd09e94d34@linux.ibm.com>
References: <20190514145041.7836-1-aneesh.kumar@linux.ibm.com>
 <20190514145041.7836-3-aneesh.kumar@linux.ibm.com>
 <87imuaihi3.fsf@concordia.ellerman.id.au>
 <04403623-d4ae-1d91-d3f4-16bd09e94d34@linux.ibm.com>
Date: Fri, 17 May 2019 21:12:25 +1000
Message-ID: <87k1ep8hd2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 5/16/19 8:17 PM, Michael Ellerman wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>> This makes sure we don't enable HugeTLB if the cache is not configured.
>>> I am still not sure about this. IMHO hugetlb support should be a hardware
>>> support derivative and any cache allocation failure should be handled as I did
>>> in the earlier patch. But then if we were not able to create hugetlb page table
>>> cache, we can as well declare hugetlb support disabled thereby avoiding calling
>>> into allocation routines.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>   arch/powerpc/mm/hugetlbpage.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>>> index ee16a3fb788a..4bf8bc659cc7 100644
>>> --- a/arch/powerpc/mm/hugetlbpage.c
>>> +++ b/arch/powerpc/mm/hugetlbpage.c
>>> @@ -602,6 +602,7 @@ __setup("hugepagesz=", hugepage_setup_sz);
>>>   static int __init hugetlbpage_init(void)
>>>   {
>>>   	int psize;
>>> +	bool configured = false;
>> 
>> Where's my reverse Christmas tree! :)
>
> Will fix that :)

Thanks.

>>> @@ -651,10 +652,16 @@ static int __init hugetlbpage_init(void)
>>>   
>>> -	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_SIZE_VARIABLE))
>>> -		hugetlbpage_init_default();
>>> +	if (configured) {
>>> +		if (IS_ENABLED(CONFIG_HUGETLB_PAGE_SIZE_VARIABLE))
>>> +			hugetlbpage_init_default();
>>> +	} else
>>> +		pr_info("Disabling HugeTLB");
>> 
>> We're not actually doing anything to disable it in the
>> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=n case, but I guess the print is still
>> correct because we didn't enable a size in the for loop above?
>> 
>> Can we make it a bit more explicit? Maybe like:
>> 
>>    "Disabling HugeTLB, no usable page sizes found."
>> 
>
> That would confuse when they find in the dmesg
>
> [    0.000000] hash-mmu: Page sizes from device-tree: 
> [    0.000000] hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0 
> [    0.000000] hash-mmu: base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7 
> [    0.000000] hash-mmu: base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56 
> [    0.000000] hash-mmu: base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1 
> [    0.000000] hash-mmu: base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8 
> [    0.000000] hash-mmu: base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0 
> [    0.000000] hash-mmu: base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3

But aren't they going to be even more confused when all we print is
"Disabling HugeTLB" with no explanation?

cheers
