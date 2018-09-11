Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428YNb4QC7zF37x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 15:28:30 +1000 (AEST)
Subject: Re: How to handle PTE tables with non contiguous entries ?
To: Dan Malek <dan.malek@konsulko.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
 <98C61C92-0D24-41C6-B9DA-8335B34D3B07@konsulko.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7e78d550-abd3-e263-cc34-5b55adaabfa5@c-s.fr>
Date: Tue, 11 Sep 2018 07:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <98C61C92-0D24-41C6-B9DA-8335B34D3B07@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/09/2018 à 22:05, Dan Malek a écrit :
> 
> Hello Cristophe.
> 
>> On Sep 10, 2018, at 7:34 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>> On the powerpc8xx, handling 16k size pages requires to have page tables with 4 identical entries.
> 
> Do you think a 16k page is useful?  Back in the day, the goal was to keep the fault handling and management overhead as simple and generic as possible, as you know this affects the system performance.  I understand there would be fewer page faults and more efficient use of the MMU resources with 16k, but if this comes at an overhead cost, is it really worth it?

Yes that's definitly usefull, the current 16k implementation already 
provides nice results, but it is based on the Linux structure, which 
implies not being able to use the 8xx HW assistance in TLBmiss handlers.

That's the reason why I'm trying to alter the Linux structure to match 
the 8xx page layout, hence the need to have 4 entries in the PTE for 
each 16k page.

> 
> In addition to the normal 4k mapping, I had thought about using 512k mapping, which could be easily detected at level 2 (PMD), with a single entry loaded into the MMU.  We would need an aux header or something from the executable/library to assist with knowing when this could be done.  I never got around to it. :)

Yes, 512k and 8M hugepages are implemented as well, but they are based 
on Linux structure, hence requiring some time consuming handling like 
checking the page size on every miss in order to run the appropriate 
part of the handler.

With the HW layout, the 512k entries are spread every 128 bytes in the 
PTE table but with those I don't have much problem because the hugepage 
code uses huge_pte_offset() and never increase the pte pointer directly.


> 
> The 8xx platforms tended to have smaller memory resources, so the 4k granularity was also useful in making better use of the available space.

Well, on my boards I have 128Mbytes, 16k page and hugepages have shown 
their benefit.

> 
>> Would someone have an idea of an elegent way to handle that ?
> 
> My suggestion would be to not change the PTE table, but have the fault handler detect a 16k page and load any one of the four entries based upon miss offset.  Kinda use the same 4k miss hander, but with 16k knowledge.  You wouldn’t save any PTE table space, but the MMU efficiency may be worth it.  As I recall, the hardware may ignore/mask any LS bits, and there is PMD level information to utilize as well.

That's exactly what I want to do, which means that everytime pte++ is 
encountered in some mm/memory.c file needs to push the index to the next 
16k page ie increase the pointer by 4 entries.

> 
> It’s been a long time since I’ve investigated how things have evolved, glad it’s still in use, and I hope you at least have some fun with the development :)

Thanks
Christophe
