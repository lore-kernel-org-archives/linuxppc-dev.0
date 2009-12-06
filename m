Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32B3FB7BE4
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2009 14:05:26 +1100 (EST)
Subject: Re: using different format for hugetlbfs
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1259961942.2076.1277.camel@pasglop>
Date: Sat, 5 Dec 2009 21:05:01 -0600
Message-Id: <5034AAE3-CCF9-446D-AC4B-B3F59C81D507@kernel.crashing.org>
References: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
	<1259917136.2076.1264.camel@pasglop>
	<90D0766D-30A2-4ABE-9707-C7F64A697BFE@kernel.crashing.org>
	<1259961942.2076.1277.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 4, 2009, at 3:25 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-12-04 at 08:09 -0600, Kumar Gala wrote:
>> On Dec 4, 2009, at 2:58 AM, Benjamin Herrenschmidt wrote:
>>
>>> On Fri, 2009-12-04 at 01:18 -0600, Kumar Gala wrote:
>>>> Ben, David,
>>>>
>>>> If we want to support true 4G/4G split on ppc32 using the MSB of  
>>>> the
>>>> address to determine of the pgd_t is for hugetlbfs isn't going to
>>>> work.  Since every pointer in the pgd_t -> pud_t -> pmd_t is  
>>>> point to
>>>> at least a 4K page I would think the low order 12-bits should  
>>>> always
>>>> be 0.
>>>
>>> On 32 bit maybe. On 64, the pg/u/md's can be smaller. I don't really
>>> want to have a different encoding for both types though.
>>
>> What do you mean they can be smaller?  We have some scenario when we
>> dont allocate a full page?  I agree having the encodings be different
>> would be bad.  I'm trying to avoid having it be different between 32
>> bit and 64 (but maybe that will be impossible).
>
> Yes. The intermediary levels are smaller on 64-bit. Also, with  
> hugetlbfs
> it can create special levels of various sizes depending on the
> requirements to fit a given huge page size. And that would be true of
> both 32 and 64-bit in fact.

Even than, does that preclude the format I suggested?  I'm assuming  
that pgd_t/pud_t/pmd_t are always a double word so the low order 4- 
bits should be 0 (on 64-bit), so using the lsb as the flag between  
hugetlb and normal pointer should still work.

- k
