Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC5Lg1tFmzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 03:33:15 +1000 (AEST)
Subject: Re: [PATCH 0/6] powerpc/8xx: implementation of huge pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <8737m7a0j7.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <a86b0ad2-3a9f-c782-735d-da8072d7b0e1@c-s.fr>
Date: Sun, 14 Aug 2016 19:33:05 +0200
MIME-Version: 1.0
In-Reply-To: <8737m7a0j7.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/08/2016 à 16:27, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> This set provides implementation of huge pages on the 8xx
>>
>> Christophe Leroy (6):
>>   powerpc: port 64 bits pgtable_cache to 32 bits
>>   powerpc: fix usage of _PAGE_RO in hugepage
>>   powerpc/8xx: use r3 to scratch CR in ITLBmiss
>>   powerpc/8xx: Move additional DTLBMiss handlers out of exception area
>>   powerpc/8xx: make user addr DTLB miss the short path
>>   powerpc/8xx: implementation of huge pages
>
> Patch 2,3,4,5 are not really related to hugepage implementation right ?
> May be that can be sent as a separate series ?
>

Patch 2 is a lack in gup_hugepte: on 8xx, _PAGE_RW (hence _PAGE_WRITE) 
is defined as 0 and _PAGE_RO must be set when the page in not writeable. 
So that's a prerequisite to implementation of huge page

Patch 3, 4, 5 are prerequisits for the implementation of huge page 
handling in the TLB miss handlers:
* 3: for huge pages implementation we need to branch base of value of 
bit 28 and 29 of the PGD entry. For this we need to preserve CR.
* 4: With the instructions related to hugepages, there is not enough 
space anymore in the TLB Exception areas, so part of the it has to be 
moved away.
* 5: That one might be seen as not directly related to hugepages, but it 
requires patch 3.

Maybe I should reorder into 3, 4, 5, 2, 1, 6 ?

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
