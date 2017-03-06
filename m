Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc5j837c0zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 15:02:36 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id j5so16214243pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 20:02:36 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too many
 TCE levels requested
To: benh@au1.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20170222044359.3663-1-aik@ozlabs.ru>
 <87innvrj9h.fsf@concordia.ellerman.id.au>
 <1488755034.2870.114.camel@au1.ibm.com>
 <cd84399e-73d6-72dd-8509-f45db5e47d31@ozlabs.ru>
 <1488771369.2870.123.camel@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8b4cac2a-5c1b-141c-9cc0-997a87b4201e@ozlabs.ru>
Date: Mon, 6 Mar 2017 15:02:29 +1100
MIME-Version: 1.0
In-Reply-To: <1488771369.2870.123.camel@au1.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/17 14:36, Benjamin Herrenschmidt wrote:
> On Mon, 2017-03-06 at 12:28 +1100, Alexey Kardashevskiy wrote:
>> 8192*8192*8192*65536>>40 = 32768TB of addressable memory (but there is no
>> good reason not to use huge pages);
> 
> No, 39 bits is half a TB. That's not enough.

Ah. My bad. 55 bits it is. It is 2 "indirect" levels + 1 "direct" level,
each 8192 entries. So 13*3+16=55.


> 
>> 8192*8192*8192*4096>>40 = 2048TB or addressable memory (even with 2
>> indirect levels but we can have all 5 levels with 4K IOMMU pages).
>>
>> Looks enough to me...
>>
>> And in this particular patch I am not limiting anything, I just replace
>> already existing EEH condition with -EINVAL. If it is this important to
>> have all 5 levels, then we can switch from alloc_pages_node() to
>> kmem_cache_alloc_node(), in a separate patch.
>>
>>
>> -- 
> 


-- 
Alexey
