Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 371CE1A0DE5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jan 2015 00:39:34 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sat, 17 Jan 2015 06:39:32 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 97FE319D801C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:30:40 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0HDdf9P40501328
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:39:41 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0HDdSkV018969
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:39:28 -0700
Message-ID: <54BA660B.7050609@linux.vnet.ibm.com>
Date: Sat, 17 Jan 2015 19:09:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: offlining cpus breakage
References: <54ACFE6D.3070308@ozlabs.ru> <54B7BEF9.8090603@linux.vnet.ibm.com>
 <54B85B3C.1030000@ozlabs.ru> <1421377482.18166.5.camel@ellerman.id.au>
In-Reply-To: <1421377482.18166.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2015 08:34 AM, Michael Ellerman wrote:
> On Fri, 2015-01-16 at 13:28 +1300, Alexey Kardashevskiy wrote:
>> On 01/16/2015 02:22 AM, Preeti U Murthy wrote:
>>> Hi Alexey,
>>>
>>> Can you let me know if the following patch fixes the issue for you ?
>>> It did for us on one of our machines that we were investigating on.
>>
>> This fixes the issue for me as well, thanks!
>>
>> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>	
> 
> OK, that's great.
> 
> But, I really don't think we can ask upstream to merge this patch to generic
> code when we don't have a good explanation for why it's necessary. At least I'm
> not going to ask anyone to do that :)
> 
> So Pretti can you either write a 100% convincing explanation of why this patch
> is correct in the general case, or (preferably) do some more investigating to
> work out what Alexey's bug actually is.

On further investigation, I found that the issue lies in the latency of
cpu hotplug operation, specifically the time taken for the offline cpu
to enter powersave mode.

The time between the beginning of the cpu hotplug operation and the
beginning of __cpu_die() operation (which is one of the last stages of
cpu hotplug) takes around a maximum of 40ms. Although this is not
causing softlockups, it is quite a large duration.

The more serious issue is the time taken for __cpu_die() operation to
complete. The __cpu_die() operation waits for the offline cpu to set its
state to CPU_DEAD before entering powersave state. This time varies from
4s to a maximum of 200s! It is not this bad always but it does happen
quite a few times. It is during these times that we observe softlockups.
I added trace prints throughout the cpu hotplug code to measure these
numbers. This delay is causing the softlockup and here is why.

If the cpu going offline is the one broadcasting wakeups to cpus in
fastsleep, it queues the broadcast timer on another cpu during the
CPU_DEAD phase. The CPU_DEAD notifiers are run only after the
__cpu_die() operation completes, which is taking a long time as
mentioned above. So between the time irqs are migrated off the about to
go offline cpu and CPU_DEAD stage, no cpu can be woken up. The above
numbers show that this can be a horridly long time. Hence the next time
that they get woken up the unnatural idle time is detected and
softlockup triggers.

The patch on this thread that I proposed covered up the problem by
allowing the remaining cpus to freshly reevaluate their wakeups after
the stop machine phase without having to depend on the previous
broadcast state.So it did not matter what the previously appointed
broadcast cpu was upto.However there are still corner cases which cannot
get solved with this patch. And understandably because it is not
addressing the core issue, which is how to get around the latency issue
of cpu hotplug.

There can be ways in which the broadcast timer be migrated in time
during hotplug to get around the softlockups, but the latency of the cpu
hotplug operation looks like a serious issue. Has anybody observed or
explicitly instrumented cpu hotplug operation before and happened to
notice the large time duration required for its completion?

Ccing Paul.

Thanks

Regards
Preeti U Murthy
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
