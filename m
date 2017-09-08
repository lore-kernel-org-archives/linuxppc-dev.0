Return-Path: <laurent.du4@free.fr>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpT1c1VX4zDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 17:08:20 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: Fix missing mmap_sem release
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1504801529-15113-1-git-send-email-laurent.du4@free.fr>
 <20170907205146.GG17982@linux-80c1.suse>
From: Laurent Dufour <laurent.du4@free.fr>
Message-ID: <a4026b4a-3525-fc9e-d6d2-3fc5d9de6bf7@free.fr>
Date: Fri, 8 Sep 2017 09:08:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170907205146.GG17982@linux-80c1.suse>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2017 22:51, Davidlohr Bueso wrote:
> On Thu, 07 Sep 2017, Laurent Dufour wrote:
> 
>> The commit b5c8f0fd595d ("powerpc/mm: Rework mm_fault_error()") reviewed
>> the way the error path is managed in __do_page_fault() but it was a bit too
>> agressive when handling a case by returning without releasing the mmap_sem.
>>
>> By the way, replacing current->mm->mmap_sem by mm->mmap_sem as mm is set to
>> current->mm.
>>
>> Fixes: b5c8f0fd595d ("powerpc/mm: Rework mm_fault_error()")
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Laurent Dufour <laurent.du4@free.fr>
>> ---
>> arch/powerpc/mm/fault.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 4797d08581ce..f799ccf37d27 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
> 
> But... here:
> 
>     /*
>      * If we need to retry the mmap_sem has already been released,
>      * and if there is a fatal signal pending there is no guarantee
>      * that we made any progress. Handle this case first.
>      */
> 
>> @@ -521,10 +521,11 @@ static int __do_page_fault(struct pt_regs *regs,
>> unsigned long address,
>>          * User mode? Just return to handle the fatal exception otherwise
>>          * return to bad_page_fault
>>          */
>> +        up_read(&mm->mmap_sem);
>>         return is_user ? 0 : SIGBUS;
>>     }
> 
> Per the above comment, for that case handle_mm_fault()
> has already released mmap_sem. The same occurs in x86,
> for example.

Oops, my bad.

Please forget about this stupid patch...
