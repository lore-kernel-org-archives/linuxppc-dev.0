Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28D161A0479
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 15:09:50 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 21:09:49 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6FDE13E40047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:06:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H49cni21037236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:09:48 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H49CqM028779
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:09:13 -0700
Message-ID: <54E2BECD.3050301@linux.vnet.ibm.com>
Date: Tue, 17 Feb 2015 09:38:45 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4] tick/hotplug: Handover time related duties before
 cpu offline
References: <20150131041342.17103.30020.stgit@preeti.in.ibm.com>
 <1424138284.1808.5.camel@ellerman.id.au>
In-Reply-To: <1424138284.1808.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 anton@samba.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2015 07:28 AM, Michael Ellerman wrote:
> On Sat, 2015-01-31 at 09:44 +0530, Preeti U Murthy wrote:
>> These duties include do_timer to update jiffies and broadcast wakeups on those
>> platforms which do not have an external device to handle wakeup of cpus from deep
>> idle states. The handover of these duties is not robust against a cpu offline
>> operation today.
>>
>> The do_timer duty is handed over in the CPU_DYING phase today to one of the online
>> cpus. This relies on the fact that *all* cpus participate in stop_machine phase.
>> But if this design is to change in the future, i.e. if all cpus are not
>> required to participate in stop_machine, the freshly nominated do_timer cpu
>> could be idle at the time of handover. In that case, unless its interrupted,
>> it will not wakeup to update jiffies and timekeeping will hang.
>>
>> With regard to broadcast wakeups, today if the cpu handling broadcast of wakeups
>> goes offline, the job of broadcasting is handed over to another cpu in the CPU_DEAD
>> phase. The CPU_DEAD notifiers are run only after the offline cpu sets its state as
>> CPU_DEAD. Meanwhile, the kthread doing the offline is scheduled out while waiting for
>> this transition by queuing a timer. This is fatal because if the cpu on which
>> this kthread was running has no other work queued on it, it can re-enter deep
>> idle state, since it sees that a broadcast cpu still exists. However the broadcast
>> wakeup will never come since the cpu which was handling it is offline, and the cpu
>> on which the kthread doing the hotplug operation was running never wakes up to see
>> this because its in deep idle state.
>>
>> Fix these issues by handing over the do_timer and broadcast wakeup duties just before
>> the offline cpu kills itself, to the cpu performing the hotplug operation. Since the
>> cpu performing the hotplug operation is up and running, it becomes aware of the handover
>> of do_timer duty and queues the broadcast timer upon itself so as to seamlessly
>> continue both these operations.
>>
>> It fixes the bug reported here:
>> http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>> Changes from V3: https://lkml.org/lkml/2015/1/20/236
>> 1. Move handover of broadcast duty away from CPU_DYING phase to just before
>> the cpu kills itself.
>> 2. Club the handover of timekeeping duty along with broadcast duty to make
>> timekeeping robust against hotplug.
> 
> Hi Preeti,
> 
> This bug is still causing breakage for people on Power8 machines.
> 
> Are we just waiting for Thomas to take the patch?

Hi mpe,

Thomas has included the patch for fixing this issue in a recent patchset
that he posted for cleaning up tick/clockevents related code.

https://lkml.org/lkml/2015/2/16/213. I think it will go into this
merge-window. There are a couple of issues there, once that is fixed I
will remind him to mark it for stable.

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
