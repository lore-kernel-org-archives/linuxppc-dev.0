Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28D10B7BD9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 01:09:49 +1100 (EST)
Subject: Re: using different format for hugetlbfs
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1259917136.2076.1264.camel@pasglop>
Date: Fri, 4 Dec 2009 08:09:32 -0600
Message-Id: <90D0766D-30A2-4ABE-9707-C7F64A697BFE@kernel.crashing.org>
References: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
	<1259917136.2076.1264.camel@pasglop>
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


On Dec 4, 2009, at 2:58 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-12-04 at 01:18 -0600, Kumar Gala wrote:
>> Ben, David,
>>
>> If we want to support true 4G/4G split on ppc32 using the MSB of the
>> address to determine of the pgd_t is for hugetlbfs isn't going to
>> work.  Since every pointer in the pgd_t -> pud_t -> pmd_t is point to
>> at least a 4K page I would think the low order 12-bits should always
>> be 0.
>
> On 32 bit maybe. On 64, the pg/u/md's can be smaller. I don't really
> want to have a different encoding for both types though.

What do you mean they can be smaller?  We have some scenario when we  
dont allocate a full page?  I agree having the encodings be different  
would be bad.  I'm trying to avoid having it be different between 32  
bit and 64 (but maybe that will be impossible).

>> Could we use something like:
>>
>> addr[0:51] || shift [52:59] || flags [60:63]
>>
>> with the LSB flag being 'normal pointer' vs 'hugetlbfs mangled
>> pointer'.  Seems like shift will at most be 64 so 8-bits should cover
>> it.
>
> Cheers,
> Ben.
>

- k
