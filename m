Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 519911A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 22:57:43 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so14284546pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 05:57:41 -0700 (PDT)
Subject: Re: [PATCH v6 05/42] powerpc/powernv: Track IO/M32/M64 segments from
 PE
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-6-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C84FD8.302@ozlabs.ru> <20150811000342.GB10753@gwshan>
 <55C95CAE.1090908@ozlabs.ru> <20150812104502.GB7690@gwshan>
 <55CB2865.4090402@ozlabs.ru> <20150812112019.GA14309@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55CB42BD.3070809@ozlabs.ru>
Date: Wed, 12 Aug 2015 22:57:33 +1000
MIME-Version: 1.0
In-Reply-To: <20150812112019.GA14309@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2015 09:20 PM, Gavin Shan wrote:
> On Wed, Aug 12, 2015 at 09:05:09PM +1000, Alexey Kardashevskiy wrote:
>> On 08/12/2015 08:45 PM, Gavin Shan wrote:
>>> On Tue, Aug 11, 2015 at 12:23:42PM +1000, Alexey Kardashevskiy wrote:
>>>> On 08/11/2015 10:03 AM, Gavin Shan wrote:
>>>>> On Mon, Aug 10, 2015 at 05:16:40PM +1000, Alexey Kardashevskiy wrote:
>>>>>> On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>>>>>> The patch is adding 6 bitmaps, three to PE and three to PHB, to track
>>>>>>
>>>>>> The patch is also removing 2 arrays (io_segmap and m32_segmap), what is that
>>>>>> all about? Also, there was no m64_segmap, now there is, needs an explanation
>>>>>> may be.
>>>>>>
>>>>>
>>>>> Originally, the bitmaps (io_segmap and m32_segmap) are allocated dynamically.
>>>>> Now, they have fixed sizes - 512 bits.
>>>>>
>>>>> The subject "powerpc/powernv: Track IO/M32/M64 segments from PE" indicates
>>>>> why m64_segmap is added.
>>>>
>>>>
>>>> But before this patch, you somehow managed to keep it working without a map
>>>> for M64, by the same time you needed map for IO and M32. It seems you are
>>>> making things consistent in this patch but it also feels like you do not have
>>>> to do so as M64 did not need a map before and I cannot see why it needs one
>>>> now.
>>>>
>>>
>>> The M64 map is used by [PATCH v6 23/42] powerpc/powernv: Release PEs dynamically
>>> where the M64 segments consumed by one particular PE will be released.
>>
>>
>> Then add it where it is really started being used. It is really hard to
>> review a patch which is actually spread between patches. Do not count that
>> reviewers will just trust you.
>>
>
> Ok. I'll try.
>
>>
>>>>>>
>>>>>>> the consumed by one particular PE, which can be released once the PE
>>>>>>> is destroyed during PCI unplugging time. Also, we're using fixed
>>>>>>> quantity of bits to trace the used IO, M32 and M64 segments by PEs
>>>>>>> in one particular PHB.
>>>>>>>
>>>>>>
>>>>>> Out of curiosity - have you considered having just 3 arrays, in PHB, storing
>>>>>> PE numbers, and ditching PE's arrays? Does PE itself need to know what PEs it
>>>>>> is using? Not sure about this master/slave PEs though.
>>>>>>
>>>>>
>>>>> I don't follow your suggestion. Can you rephrase and explain it a bit more?
>>>>
>>>>
>>>> Please explains in what situations you need same map in both PHB and PE and
>>>> how you are going to use them. For example, pe::m64_segmap and
>>>> phb::m64_segmap.
>>>>
>>>> I believe you need to know what segment is used by what PE and that's it and
>>>> having 2 bitmaps is overcomplicated hard to follow. Is there anything else
>>>> what I am missing?
>>>>
>>>
>>> The situation is same to all (IO, M32 and M64) segment maps. Taking m64_segmap
>>> as an example, it will be used when creating or destroying the PE who consumes
>>> M64 segments. phb::m64_segmap is recording the M64 segment usage in PHB's domain.
>>> It's used to check same M64 segment won't be used for towice. pe::m64_segmap tracks
>>> the M64 segments consumed by the PE.
>>
>>
>> You could have a single map in PHB, key would be a segment number and value
>> would be PE number. No need to have a map in PE. At all. No need to
>> initialize bitmaps, etc.
>>
>
> So it would be arrays for various segmant maps if I understood your suggestion
> as below. Please confirm:
>
> #define PNV_IODA_MAX_SEG_NUM	512
>
> 	int struct pnv_phb::io_segmap[PNV_IODA_MAX_SEG_NUM];
> 			    m32_segmap[PNV_IODA_MAX_SEG_NUM];
> 			    m64_segmap[PNV_IODA_MAX_SEG_NUM];
> - Initially, they are initialize to IODA_INVALID_PE;
> - When one segment is assigned to one PE, the corresponding entry
>    of the array is set to PE number.
> - When one segment is relased, the corresponding entry of the array
>    is set to IODA_INVALID_PE;


No, not arrays, I meant DEFINE_HASHTABLE(), hash_add(), etc from 
include/linux/hashtable.h.

http://kernelnewbies.org/FAQ/Hashtables is a good place to start :)



-- 
Alexey
