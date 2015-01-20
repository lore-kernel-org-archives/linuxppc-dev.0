Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC5401A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 17:58:54 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 23:58:52 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 38C8938C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 01:58:50 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0K6woYr28966984
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 06:58:50 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0K6wnkZ016869
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 01:58:49 -0500
Message-ID: <54BDFC9C.3020308@linux.vnet.ibm.com>
Date: Tue, 20 Jan 2015 12:28:36 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, tglx@linutronix.de
Subject: Re: tick/broadcast: Make movement of broadcast hrtimer robust against
 hotplug
References: <20150120060913.A5EF31402DE@ozlabs.org>
In-Reply-To: <20150120060913.A5EF31402DE@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-6
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/20/2015 11:39 AM, Michael Ellerman wrote:
> On Mon, 2015-19-01 at 10:26:48 UTC, Preeti U Murthy wrote:
>> Today if a cpu handling broadcasting of wakeups goes offline, it hands over
> 
> It's *the* cpu handling broadcasting of wakeups right? ie. there's only ever
> one at a time.

Right, thanks for pointing this.

> 
>> the job of broadcasting to another cpu in the CPU_DEAD phase. 
> 
> I think that would be clearer as "to another cpu, when the cpu going offline
> reaches the CPU_DEAD state."
> 
> Otherwise it can read as "another cpu (which is) in the CPU_DEAD phase", which
> is not what you mean - I think.

Yes I will word this better.
> 
>> The CPU_DEAD notifiers are run only after the offline cpu sets its state as
>> CPU_DEAD. Meanwhile, the kthread doing the offline is scheduled out while
> 
> The kthread which is running on a different cpu from either of the first two
> cpus you've mentioned.

It could be running on any cpu other than the offline one. The next line
clarifies this - "This is fatal if the cpu on which this kthread was
running". I also say "Meanwhile, the kthread doing the offline" above so
as to clarify that the offline cpu has nothing to do with this kthread.

> 
>> waiting for this transition by queuing a timer. This is fatal because if the
>> cpu on which this kthread was running has no other work queued on it, it can
>> re-enter deep idle state, since it sees that a broadcast cpu still exists.
>> However the broadcast wakeup will never come since the cpu which was handling
>> it is offline, and this cpu never wakes up to see this because its in deep
>> idle state.
> 
> Which cpu is "this cpu"? I think you mean the one running the kthread which is
> doing the offline, but it's not 100% clear.

Right, I will make this correction as well, its ambiguous.

> 
>> Fix this by setting the broadcast timer to a max value so as to force the cpus
>> entering deep idle states henceforth to freshly nominate the broadcast cpu. More
>> importantly this has to be done in the CPU_DYING phase so that it is visible to
>> all cpus right after exiting stop_machine, which is when they can re-enter idle.
>> This ensures that handover of the broadcast duty falls in place on offline, without
>> having to do it explicitly.
> 
> OK, I don't know the code well enough to say if that's the right fix.
> 
> You say:
> 
> +	/* This allows fresh nomination of broadcast cpu */
> +	bc->next_event.tv64 = KTIME_MAX;
> 
> Is that all it does? I see that check in several places in the code.

This change does not affect those parts of the tick broadcast code,
which do not depend on the hrtimer broadcast framework. And for those
parts that do depend on this framework, this plays a critical role in
handing over the broadcast duty.

> 
> 
> I assume we're expecting Thomas to merge this?

Yes, Thomas can you please take this into the next 3.19 rc release ? I
will send out a new patch with the modified changelog. If you find this
acceptable I will port it to the relevant stable kernels.
> 
> If so it's probably worth mentioning that it fixes a bug we are seeing on

I will mention this in the changelog by pointing to the bug report.

Regards
Preeti U Murthy
> machines in the wild. So it'd be nice if it went into 3.19 and/or gets sent to
> stable.
> 
> cheers
> 
