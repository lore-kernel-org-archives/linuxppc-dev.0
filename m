Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJV302RzjzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 19:24:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/2] powerpc/mm: Add marker for contexts requiring global
 TLB invalidations
In-Reply-To: <1493882745.7934.3.camel@gmail.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
 <1493882745.7934.3.camel@gmail.com>
Date: Thu, 04 May 2017 19:24:06 +1000
Message-ID: <87h911ynyh.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, 2017-05-03 at 16:29 +0200, Frederic Barrat wrote:
>> Introduce a new 'flags' attribute per context and define its first bit
>> to be a marker requiring all TLBIs for that context to be broadcasted
>> globally. Once that marker is set on a context, it cannot be removed.
>> 
>> Such a marker is useful for memory contexts used by devices behind the
>> NPU and CAPP/PSL. The NPU and the PSL keep their own
>> translation cache so they need to see all the TLBIs for those
>> contexts.
>> 
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/mmu.h |  9 +++++++++
>>  arch/powerpc/include/asm/tlb.h           | 10 ++++++++--
>>  arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
>> index 77529a3e3811..7b640ab1cbeb 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -78,8 +78,12 @@ struct spinlock;
>>  /* Maximum possible number of NPUs in a system. */
>>  #define NV_MAX_NPUS 8
>>  
>> +/* Bits definition for the context flags */
>> +#define MM_CONTEXT_GLOBAL_TLBI	1	/* TLBI must be global */
>> +
>>  typedef struct {
>>  	mm_context_id_t id;
>> +	unsigned long flags;
>
> Should these flags be under #ifdef PPC_BOOK3S_64 as well? Not sure.

They shouldn't need to be, the whole file is Book3s 64 only.

cheers
