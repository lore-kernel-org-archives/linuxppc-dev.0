Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC5TD2mVLzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 03:38:56 +1000 (AEST)
Subject: Re: [PATCH 6/6] powerpc/8xx: implementation of huge pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <15e0fa7a312245e681cb9ca18ffb875c7820e5fc.1471020647.git.christophe.leroy@c-s.fr>
 <8760r3a0md.fsf@skywalker.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <55f9f338-a098-96e0-c753-2e83045bedab@c-s.fr>
Date: Sun, 14 Aug 2016 19:38:47 +0200
MIME-Version: 1.0
In-Reply-To: <8760r3a0md.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/08/2016 à 16:25, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> The 8xx has 512k and 8M pages. This patch implements hugepages using
>> those sizes.
>>
>> On the 8xx, the size of pages is in the PGD entry,
>> using PS field (bits 28-29):
>> 00 : Small pages (4k or 16k)
>> 01 : 512k pages
>> 10 : reserved
>> 11 : 8M pages
>>
>> The implementation uses a mix of what is used on BOOKS and BOOKE,
>> as 512k pages are in HUGEPTE tables while for 8M pages we have
>> several PGD entries pointing on a leaf HUGEPTE entry
>>
>> For the time being, we do not support CPU15 ERRATA if HUGETLB is
>> selected
>
> Can you also document here the format for linux page table with different
> huge page size. ?

Euh ... isn't it what I do when explaining the use of the PS field in 
the PGD entry ? That's the thing, that's how the 8xx knows how it is a 
huge page, and that's how Linux will know it is one. On the 8xx, the 
Linux PGD entry (almost) match the L1 MMU entry and the Linux PTE almost 
match the L2 MMU entry (some bits are copied from the PTE to the L1 
entry and then removed from the value writen to the L2 MMU entry)

Christophe

>
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
