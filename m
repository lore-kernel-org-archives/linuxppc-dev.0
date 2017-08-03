Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN9Dy58zNzDrHX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 10:00:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH 3/3] powerpc/mm/hash64: Make vmalloc 56T on hash
In-Reply-To: <874ltq1iwe.fsf@linux.vnet.ibm.com>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
 <1501583364-14909-3-git-send-email-mpe@ellerman.id.au>
 <874ltq1iwe.fsf@linux.vnet.ibm.com>
Date: Thu, 03 Aug 2017 10:00:48 +1000
Message-ID: <87tw1pr03z.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> On 64-bit book3s, with the hash MMU, we currently define the kernel
>> virtual space (vmalloc, ioremap etc.), to be 16T in size. This is a
>> leftover from pre v3.7 when our user VM was also 16T.
>>
>> Of that 16T we split it 50/50, with half used for PCI IO and ioremap
>> and the other 8T for vmalloc.
>>
>> We never bothered to make it any bigger because 8T of vmalloc ought to
>> be enough for anybody. But it turns out that's not true, the per cpu
>> allocator wants large amounts of vmalloc space, not to make large
>> allocations, but to allow a large stride between allocations, because
>> we use pcpu_embed_first_chunk().
>>
>> With a bit of juggling we can keep 8T for the IO etc. and make the
>> vmalloc space 56T. The only complication is the check of the address
>
> What is the significance of 56T number ? Can you add a comment regarding
> why 56TB was selected ?

Yeah good point. Currently we have 16T, 8T for vmalloc, 8T for IO mappings. We
don't seem to have any need for more IO mappings, so we keep that as 8T,
giving us 64T - 8T = 56T for vmalloc.

Will update the change log.

cheers
