Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPcLJ0nGrzDqbd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 03:25:11 +1000 (AEST)
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
To: David Miller <davem@davemloft.net>
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
References: <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
 <9088ad7e-8b3b-8eba-2fdf-7b0e36e4582e@oracle.com>
 <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
 <20170512.125708.475573831936972365.davem@davemloft.net>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <6da8d4a6-3332-8331-c329-b05efd88a70d@oracle.com>
Date: Fri, 12 May 2017 13:24:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170512.125708.475573831936972365.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/12/2017 12:57 PM, David Miller wrote:
> From: Pasha Tatashin <pasha.tatashin@oracle.com>
> Date: Thu, 11 May 2017 16:59:33 -0400
> 
>> We should either keep memset() only for deferred struct pages as what
>> I have in my patches.
>>
>> Another option is to add a new function struct_page_clear() which
>> would default to memset() and to something else on platforms that
>> decide to optimize it.
>>
>> On SPARC it would call STBIs, and we would do one membar call after
>> all "struct pages" are initialized.
> 
> No membars will be performed for single individual page struct clear,
> the cutoff to use the STBI is larger than that.
> 

Right now it is larger, but what I suggested is to add a new optimized 
routine just for this case, which would do STBI for 64-bytes but without 
membar (do membar at the end of memmap_init_zone() and 
deferred_init_memmap()

#define struct_page_clear(page)                                 \
         __asm__ __volatile__(                                   \
         "stxa   %%g0, [%0]%2\n"                                 \
         "stxa   %%xg0, [%0 + %1]%2\n"                           \
         : /* No output */                                       \
         : "r" (page), "r" (0x20), "i"(ASI_BLK_INIT_QUAD_LDD_P))

And insert it into __init_single_page() instead of memset()

The final result is 4.01s/T which is even faster compared to current 4.97s/T



Pasha
