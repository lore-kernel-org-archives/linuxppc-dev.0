Return-Path: <pc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDD721A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 04:06:45 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Wed, 5 Nov 2014 10:06:43 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5A74519D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 09:55:22 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA5H6er455443636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Nov 2014 18:06:40 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 sA5HBSr4013564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Nov 2014 10:11:28 -0700
Message-ID: <545A591F.3080400@us.ibm.com>
Date: Wed, 05 Nov 2014 11:06:39 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: mitigate impact of decrementer reset
References: <20141008025210.AF949140144@ozlabs.org>
In-Reply-To: <20141008025210.AF949140144@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry it took me so long to get back to this...

On 10/07/2014 09:52 PM, Michael Ellerman wrote:
> On Tue, 2014-07-10 at 19:13:24 UTC, Paul Clarke wrote:
>> The POWER ISA defines an always-running decrementer which can be used
>> to schedule interrupts after a certain time interval has elapsed.
>> The decrementer counts down at the same frequency as the Time Base,
>> which is 512 MHz.  The maximum value of the decrementer is 0x7fffffff.
>> This works out to a maximum interval of about 4.19 seconds.
>>
>> If a larger interval is desired, the kernel will set the decrementer
>> to its maximum value and reset it after it expires (underflows)
>> a sufficient number of times until the desired interval has elapsed.
>>
>> The negative effect of this is that an unwanted latency spike will
>> impact normal processing at most every 4.19 seconds.  On an IBM
>> POWER8-based system, this spike was measured at about 25-30
>> microseconds, much of which was basic, opportunistic housekeeping
>> tasks that could otherwise have waited.
>>
>> This patch short-circuits the reset of the decrementer, exiting after
>> the decrementer reset, but before the housekeeping tasks if the only
>> need for the interrupt is simply to reset it.  After this patch,
>> the latency spike was measured at about 150 nanoseconds.

> Thanks for the excellent changelog. But this patch makes me a bit nervous :)
>
> Do you know where the latency is coming from? Is it primarily the irq work?

Yes, it is all under irq_enter (measured at ~10us) and irq_exit (~12us).

> If so I'd prefer if we could move the short circuit into __timer_interrupt()
> itself. That way we'd still have the trace points usable, and it would
> hopefully result in less duplicated logic.

But irq_enter and irq_exit are called in timer_interrupt, before 
__timer_interrupt is called.  I don't see how that helps.  The time 
spent in __timer_interrupt is minuscule by comparison.

Are you suggesting that irq_enter/exit be moved into __timer_interrupt 
as well?  (I'm not sure how that would impact the existing call to 
__timer_interrupt from tick_broadcast_ipi_handler?  And if there is no 
impact, what's the point of separating timer_interrupt and 
__timer_interrupt?)

Regards,
PC
