Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19C351A0B6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 21:27:28 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 8 Oct 2014 06:27:26 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1428D6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 06:16:08 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s98ARNhZ3801596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 10:27:23 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s98ARMeA015794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 06:27:23 -0400
Message-ID: <54351185.2020005@linux.vnet.ibm.com>
Date: Wed, 08 Oct 2014 15:57:17 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Clarke <pc@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: mitigate impact of decrementer reset
References: <20141008025210.AF949140144@ozlabs.org>
In-Reply-To: <20141008025210.AF949140144@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/2014 08:22 AM, Michael Ellerman wrote:
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
> 
> Hi Paul,
> 
> Thanks for the excellent changelog. But this patch makes me a bit nervous :)
> 
> Do you know where the latency is coming from? Is it primarily the irq work?
> 
> If so I'd prefer if we could move the short circuit into __timer_interrupt()
> itself. That way we'd still have the trace points usable, and it would
> hopefully result in less duplicated logic.

I agree, this is perhaps the better approach.

Regards
Preeti U Murthy
> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
