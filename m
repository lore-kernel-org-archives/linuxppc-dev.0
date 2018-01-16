Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLbrT0qXzzDqqP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:53:13 +1100 (AEDT)
Subject: Re: [PATCH 1/3] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <876081by7g.fsf@linux.vnet.ibm.com>
 <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
 <cc2106e9-6ba1-e937-3e19-99572fa014d2@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <003fc691-074a-9226-3ab2-69ff4a76f871@c-s.fr>
Date: Tue, 16 Jan 2018 17:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <cc2106e9-6ba1-e937-3e19-99572fa014d2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/01/2018 à 17:43, Aneesh Kumar K.V a écrit :
> 
> 
> On 01/16/2018 10:01 PM, Christophe LEROY wrote:
>>
>>
>> Le 16/01/2018 à 16:49, Aneesh Kumar K.V a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> When an app has some regular pages allocated (e.g. see below) and tries
>>>> to mmap() a huge page at a hint address covered by the same PMD entry,
>>>> the kernel accepts the hint allthough the 8xx cannot handle different
>>>> page sizes in the same PMD entry.
>>>
>>>
>>> So that is a bug in get_unmapped_area function that you are using and
>>> you want to fix that by using the slice code. Can you describe here what
>>> the allocation restrictions are w.r.t 8xx? Do they have segments and
>>> base page size like hash64?
>>
>> I don't think it is a bug in get_unmapped_area() that is used by 
>> default. It is that some HW do support mixing any page size in the 
>> same page table (eg BOOK3E ?), but the 8xx doesn't.
>> In the 8xx, the page size is defined in the PGD entry, then all pages 
>> defined in a given page table pointed by a PGD entry have the same size.
>>
>> So it is similar to segments if you consider each PGD entry as a kind 
>> of segment
>>
> 
> so IIUC, hugepd format encodes the page size details and that require us 
> to ensure that all the address range mapped at that hupge_pd entry is of 
> same page size? Hence we want to avoid mmap handing over an address in 
> that range when we already have a hugetlb mapping in that range?

Exactly

And also avoid hugetlb_get_unmapped_area() accepting an hint address in 
that range when we already have a regular mapping in that range.

Christophe
