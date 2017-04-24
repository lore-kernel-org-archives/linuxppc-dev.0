Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBMvD3xY8zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 20:26:16 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <20170424082832.C0E8C6EAF5@localhost.localdomain>
 <87d1c2rwt3.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a41ff27c-fedc-6621-01ed-d25f4d0813d1@c-s.fr>
Date: Mon, 24 Apr 2017 12:26:11 +0200
MIME-Version: 1.0
In-Reply-To: <87d1c2rwt3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/04/2017 à 11:15, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 400f2d0d42f8..3d506589236c 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -356,8 +348,22 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>>  		 * between the last mapped region and the stack will
>>  		 * expand the stack rather than segfaulting.
>>  		 */
>> -		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
>> -			goto bad_area;
>> +		if (address + 2048 < uregs->gpr[1]) {
>> +			if (!inst) {
>
> That looks like it could lead to an infinite loop, if the instruction
> that caused the fault has been overwritten with NULL by another thread.

If the inst is NULL, store_updates_sp(inst) returns false so it jumps to 
bad_area_nosemaphore

Christophe

>
> Or did I miss something? (I only read the diff)
>
>> +				/*
>> +				 * We want to do this outside mmap_sem, because
>> +				 * reading code around nip can result in fault,
>> +				 * which will cause a deadlock when called with
>> +				 * mmap_sem held
>> +				 */
>> +				up_read(&mm->mmap_sem);
>> +				__get_user(inst,
>> +					   (unsigned int __user *)regs->nip);
>> +				if (!store_updates_sp(inst))
>> +					goto bad_area_nosemaphore;
>> +				goto retry;
>> +			}
>
>
> cheers
>
