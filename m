Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNFLf4mPLzDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 20:06:34 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0J961OJ072597
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 04:06:32 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkd0t1txc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 04:06:31 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 02:06:30 -0700
Subject: Re: [PATCH v2 3/5] powerpc/mm: Allow more than 16 low slices
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <1c9752ac98fd3278ef448e2553053c287af42b3f.1516179904.git.christophe.leroy@c-s.fr>
 <87po66z1w2.fsf@linux.vnet.ibm.com>
 <baf3a2db-3522-8419-0eda-ef62ad13d76e@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 14:36:22 +0530
MIME-Version: 1.0
In-Reply-To: <baf3a2db-3522-8419-0eda-ef62ad13d76e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <26a6d845-cf38-d8c6-5f54-a57ddb2a5a77@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/19/2018 02:29 PM, Christophe LEROY wrote:
> 
> 
> Le 19/01/2018 à 09:30, Aneesh Kumar K.V a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> While the implementation of the "slices" address space allows
>>> a significant amount of high slices, it limits the number of
>>> low slices to 16 due to the use of a single u64 low_slices_psize
>>> element in struct mm_context_t
>>>
>>> On the 8xx, the minimum slice size is the size of the area
>>> covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
>>> 16K pages mode. This means we could have resp. up to 1024 and 64
>>> slices.
>>>
>>> In order to override this limitation, this patch switches the
>>> handling of low_slices to BITMAPs as done already for high_slices.
>>
>> Does it have a performance impact. When we switched high_slices
>> that was one of the question asked. Now with a topdown search we should
>> mostly be using the high_slices. But it will good to get numbers for
>> ppc64 for this change.
> 
> It should have almost no performance impact at all, because all bitmap 
> functions used a simplified way when the number of bits is small and 
> constant:
> 
> -    ret->low_slices = 0;
> +    slice_bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
> 
> 
> static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> {
>      if (small_const_nbits(nbits))
>          *dst = 0UL;
>      else {
>          unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
>          memset(dst, 0, len);
>      }
> }
> 
> 
> 
> -    dst->low_slices |= src->low_slices;
> +    slice_bitmap_or(dst->low_slices, dst->low_slices, src->low_slices,
> +            SLICE_NUM_LOW);
> 
> 
> static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
>              const unsigned long *src2, unsigned int nbits)
> {
>      if (small_const_nbits(nbits))
>          *dst = *src1 | *src2;
>      else
>          __bitmap_or(dst, src1, src2, nbits);
> }
> 
> 
>

may be capture that in commit message saying since we are 64 bit on 
ppc64 there is no impact there?

-aneesh
