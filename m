Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C2FF1A0997
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 02:40:54 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 02:40:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B06B2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 02:40:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s92Ggfjv32964782
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 02:42:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s92Geosj026474
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 02:40:50 +1000
Message-ID: <542D800F.60200@linux.vnet.ibm.com>
Date: Thu, 02 Oct 2014 22:10:47 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] powernv/cpuidle: Fastsleep workaround and fixes
References: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <2978842.I7Hdqv7lNe@vostro.rjw.lan>
In-Reply-To: <2978842.I7Hdqv7lNe@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 02 October 2014 02:16 AM, Rafael J. Wysocki wrote:
> On Wednesday, October 01, 2014 01:15:57 PM Shreyas B. Prabhu wrote:
>> Fast sleep is an idle state, where the core and the L1 and L2
>> caches are brought down to a threshold voltage. This also means that
>> the communication between L2 and L3 caches have to be fenced. However
>> the current P8 chips have a bug wherein this fencing between L2 and
>> L3 caches get delayed by a cpu cycle. This can delay L3 response to
>> the other cpus if they request for data during this time. Thus they
>> would fetch the same data from the memory which could lead to data
>> corruption if L3 cache is not flushed. 
>>
>> This series overcomes above problem in kernel.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Srivatsa S. Bhat <srivatsa@mit.edu>
>> Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
>> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
>>
>> v2:
>> Rebased on 3.17-rc7
>> Split from 'powerpc/powernv: Support for fastsleep and winkle'
>>
>> v1:
>> https://lkml.org/lkml/2014/8/25/446
>>
>> Preeti U Murthy (1):
>>   powerpc/powernv/cpuidle: Add workaround to enable fastsleep
>>
>> Shreyas B. Prabhu (1):
>>   powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
>>     fast-sleep
>>
>> Srivatsa S. Bhat (1):
>>   powerpc/powernv: Enable Offline CPUs to enter deep idle states
>>
>>  arch/powerpc/include/asm/machdep.h             |   3 +
>>  arch/powerpc/include/asm/opal.h                |   7 ++
>>  arch/powerpc/include/asm/processor.h           |   4 +-
>>  arch/powerpc/kernel/exceptions-64s.S           |  35 ++++----
>>  arch/powerpc/kernel/idle.c                     |  19 ++++
>>  arch/powerpc/kernel/idle_power7.S              |   2 +-
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>>  arch/powerpc/platforms/powernv/powernv.h       |   7 ++
>>  arch/powerpc/platforms/powernv/setup.c         | 118 +++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/smp.c           |  11 ++-
>>  drivers/cpuidle/cpuidle-powernv.c              |  13 ++-
>>  11 files changed, 194 insertions(+), 26 deletions(-)
> 
> [2/3] seems to be missig from the series.
> 
> Also, since that mostly modifies arch/powerpc, I think it should go through
> that tree.  I'm fine with the cpuidle-powernv changes in [1/3] and [3/3].
> 
Hi Rafael, 

Thanks for looking into this. The second patch is an independent fix in the 
powerpc exception handler. To be safe I am ccing you and linux-pm list on that
patch now. 


Thanks, 
Shreyas
