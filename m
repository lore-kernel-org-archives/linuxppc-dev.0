Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9yPC5bhgzDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:16:15 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 20 May 2016 11:46:11 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 650CA1258063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 11:48:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6G7ee47644854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 11:46:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6G5J5020130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 11:46:06 +0530
Message-ID: <573EABA2.8000300@linux.vnet.ibm.com>
Date: Fri, 20 May 2016 11:46:02 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@ozlabs.org>
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "ego >> Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/9] powerpc/powernv: Add platform support for stop
 instruction
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160520052503.GB27460@oak.ozlabs.ibm.com>
In-Reply-To: <20160520052503.GB27460@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/20/2016 10:55 AM, Paul Mackerras wrote:
> On Tue, May 03, 2016 at 01:54:36PM +0530, Shreyas B. Prabhu wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>  a) new instruction named stop is added. This instruction replaces
>> 	instructions like nap, sleep, rvwinkle.
>>  b) new per thread SPR named PSSCR is added which controls the behavior
>> 	of stop instruction.
>>
>> PSSCR has following key fields
>> 	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
>> 	power-saving state the thread entered since stop instruction was last
>> 	executed.
>>
>> 	Bit 42 - Enable State Loss
>> 	0 - No state is lost irrespective of other fields
>> 	1 - Allows state loss
>>
>> 	Bits 44:47 - Power-Saving Level Limit
>> 	This limits the power-saving level that can be entered into.
>>
>> 	Bits 60:63 - Requested Level
>> 	Used to specify which power-saving level must be entered on executing
>> 	stop instruction
>>
>> This patch adds support for stop instruction and PSSCR handling.
> 
> I notice that you have duplicated a whole lot of assembly code
> relating to synchronizing between threads going into and out of
> power-saving modes, saving/restoring SPRs, resyncing the timebase, and
> so on.
> 
> Two questions arise:
> 
> - Are we really going to have to do all of that in the same way for
>   POWER9 as we did for POWER8?  You even copied over a comment about
>   the fastsleep workaround, which I really hope we won't have to do on
>   POWER9.  Also, on POWER9, the threads are much more independent, so
>   I was not expecting that there would still be shared registers.

Copying of comment regarding fastsleep workaround was an oversight. It
will not be necessary in POWER9. I'll fix that in the next version.

The need for synchronizing between threads going into and out of
power-saving modes still exists. Resyncing timebase and restoring few
registers still have to be done once per core.
> 
> - If we do have to do all that, could we use the same code as on
>   POWER8 rather than having another copy of all that code?
> 

While we could use the same code I felt that handling POWER8 and POWER9
cases in the same file might make the code more complicated.
Gautham suggested we can use the same POWER8 code and use FTR sections
wherever POWER8 and POWER9 deviate. If you feel that is better I can
implement that in the next version.

Thanks,
Shreyas
