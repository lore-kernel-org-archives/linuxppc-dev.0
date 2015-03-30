Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 398E01A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:01:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 31 Mar 2015 03:01:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 78CAE2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:01:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2UH1YEl46727390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:01:42 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2UH18kj018876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:01:09 +1100
Message-ID: <55198143.8010609@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 22:30:51 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [v3, 1/3] powerpc: Fix cpu_online_cores_map to return only online
 threads mask
References: <20150330093617.CDFA8140140@ozlabs.org>
In-Reply-To: <20150330093617.CDFA8140140@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 30 March 2015 03:06 PM, Michael Ellerman wrote:
> On Sun, 2015-22-03 at 04:42:57 UTC, "Shreyas B. Prabhu" wrote:
>> Currently, cpu_online_cores_map returns a mask, which for every core
>> that has atleast one online thread, has the first-cpu-of-that-core's bit
>> set. 
> 
>   ... which for every core with at least one online thread, has the bit for
>   thread 0 of the core set to 1, and the bits for all other threads of the core
>   set to 0.
> 
> Maybe that's clearer?
> 
>> But the first cpu itself may not be online always. In such cases, if
>                    ^
> 		   of the core
> 
>> the returned mask is used for IPI, then it'll cause IPIs to be skipped
>> on cores where the first thread is offline.
> 
>   .. because the IPI code refuses to send IPIs to offline threads, right?

Yes.
> 
>> Fix this by setting first-online-cpu-of-the-core's bit in the mask.
> 
>   .. by setting the bit of the first online thread in the core.
> 
>> This is done by fixing this in the underlying function
>> cpu_thread_mask_to_cores.
> 
> 
> The result has the property that for all cores with online threads, there is
> one bit set in the returned map. And further, all bits that are set in the
> returned map correspond to online threads.
> 
> 
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>> This patch is new in v3
>>
>> In an example scenario where all the threads of 1st core are offline
>> and argument to cpu_thread_mask_to_cores is cpu_possible_mask,
>> with this implementation, return value will not have any bit
>> corresponding to 1st core set. I think that should be okay. Any thoughts?
> 
> Looking at linux-next:
> 
>   $ git grep cpu_thread_mask_to_cores
>   arch/powerpc/include/asm/cputhreads.h:/* cpu_thread_mask_to_cores - Return a cpumask of one per cores
>   arch/powerpc/include/asm/cputhreads.h:static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *threads)
>   arch/powerpc/include/asm/cputhreads.h:  return cpu_thread_mask_to_cores(cpu_online_mask);
>   $ git grep cpu_online_cores_map
>   arch/powerpc/include/asm/cputhreads.h:static inline cpumask_t cpu_online_cores_map(void)
> 
> ie. There are no users.
> 
> So yeah I think we can change the semantics of this, and the semantics you
> describe make sense.
> 
> If you agree with my changelog comments I'm happy to fix that up and merge
> this, or you can send a v4 if you like.
> 

I'll fix the changelog in v4.
> cheers
> 
