Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4054z42jgZzF0QJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 18:57:20 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc/mm: Add missing tracepoint for tlbie
To: Balbir Singh <bsingharora@gmail.com>,
 Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
 <20180320093940.56144adf@balbir.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b619699e-319b-4c45-7dce-3c74d88d0379@c-s.fr>
Date: Tue, 20 Mar 2018 08:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180320093940.56144adf@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/03/2018 à 23:39, Balbir Singh a écrit :
> On Mon, 19 Mar 2018 11:32:38 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
>> added tracepoints for tlbie calls, but _tlbil_va() was forgotten
>>
>> Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/mmu_decl.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
>> index 57fbc554c785..b9991e0c61a2 100644
>> --- a/arch/powerpc/mm/mmu_decl.h
>> +++ b/arch/powerpc/mm/mmu_decl.h
>> @@ -21,6 +21,7 @@
>>   #include <linux/mm.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/mmu.h>
>> +#include <asm/trace.h>
>>   
>>   #ifdef CONFIG_PPC_MMU_NOHASH
>>   
>> @@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
>>   			     unsigned int tsize, unsigned int ind)
>>   {
>>   	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
>> +	trace_tlbie(pid, 0, address, 0, 0, 0, 0);
> 
> 
> I did not really cover a whole lot of NOHASH, any idea why its
> called tlbil_va and not _tlbie_va?

Seems it comes from 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ba3418b8b1c85ee1771c63f1dd12041614e56ff

Kumar ?

> 
> The first field is really the lpid and should be 0 for non-virtualized
> systems. Can I recommend that we rs field for pid and the rb field for
> address? so effectively something like

Yes having the address in rb is expected since it is the name of the 
only field tlbie has in the 32bits instruction set.

Yes I can use rb for the pid.

Christophe
