Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZvgx68tWzDsXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 09:26:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: santhosh <santhog4@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: manvanth@linux.vnet.ibm.com
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
In-Reply-To: <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
 <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
Date: Fri, 16 Sep 2016 09:26:50 +1000
Message-ID: <877facoibp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

santhosh <santhog4@linux.vnet.ibm.com> writes:

>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>
>>> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>>>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>>>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>>>
>>> ...
>>>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>>>> and from 13-64 to 9-13 for 4K pages.
>>>
>>> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>>>
>> HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
>> size. We do have the below constraint w.r.t hugetlb pages
>>
>> static inline bool hstate_is_gigantic(struct hstate *h)
>> {
>> 	return huge_page_order(h) >= MAX_ORDER;
>> }
>>
>> That require MAX_ORDER to be greater than 12.

So have you tried that fix?

cheers
