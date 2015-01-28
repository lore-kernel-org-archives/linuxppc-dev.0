Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DD461A0C46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 21:03:23 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 03:03:21 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BC13C1FF0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 02:54:31 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t0SA3iws9175136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 03:03:44 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0SA3HLP025383
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 03:03:19 -0700
Message-ID: <54C8B3D2.3070608@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2015 15:32:58 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
References: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501211243270.5526@nanos>
 <54C09391.9080202@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1501221209260.5526@nanos>
 <54C7068B.3050108@linux.vnet.ibm.com>
In-Reply-To: <54C7068B.3050108@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
 Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2015 09:01 AM, Preeti U Murthy wrote:
> On 01/22/2015 04:45 PM, Thomas Gleixner wrote:
>> On Thu, 22 Jan 2015, Preeti U Murthy wrote:
>>> On 01/21/2015 05:16 PM, Thomas Gleixner wrote:
>>> How about when the cpu that is going offline receives a timer interrupt
>>> just before setting its state to CPU_DEAD ? That is still possible right
>>> given that its clock devices may not have been shutdown and it is
>>> capable of receiving interrupts for a short duration. Even with the
>>> above patch, is the following scenario possible ?
>>>
>>>                 CPU0                                  CPU1
>>> t0         Receives timer interrupt
>>>
>>> t1         Sees that there are hrtimers
>>>            to be serviced (hrtimers are not yet migrated)
>>>
>>> t2         calls hrtimer_interrupt()
>>>
>>> t3         tick_program_event()                   CPU_DEAD notifiers
>>>                                                 CPU0's td->evtdev = NULL
>>>
>>> t4         clockevent_program_event()
>>>            references NULL tick device pointer
>>>
>>> So my concern is that since the CLOCK_EVT_NOTIFY_CPU_DEAD callback
>>> handles shutting down of devices besides moving tick related duties.
>>> it's functions may race with the hotplug cpu still handling tick events.
>>
>>   __cpu_disable() is supposed to block interrupts on the dying cpu.
>>
>> But I agree, we should make it more robust. So we want an explicit
>> call for disabling the cpu local stuff and an explicit takeover of the
>> broadcast duty. I'm anyway distangling the clockevents_notify() stuff,
>> so it should be simple to do so.

Thomas ping. Would you be posting this patch?
> 
> I noticed that tick_handover_do_timer() function also suffers from the
> issue that the patch I posted for moving the broadcast duty had, in that
> it relies on all cpus participating in stop_machine(). In a design where
> all cpus do not participate in stop_machine(), if the freshly nominated
> do_timer cpu is idle, there is no update of jiffies till that cpu gets
> back to being busy. So we must do an explicit take over of *both* the
> broadcast and do_timer duty just before the CPU_DEAD phase.

Regards
Preeti u Murthy
