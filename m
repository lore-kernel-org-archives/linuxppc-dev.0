Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DA041A0156
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 12:58:05 +1100 (AEDT)
Message-ID: <1424138284.1808.5.camel@ellerman.id.au>
Subject: Re: [PATCH V4] tick/hotplug: Handover time related duties before
 cpu offline
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Tue, 17 Feb 2015 12:58:04 +1100
In-Reply-To: <20150131041342.17103.30020.stgit@preeti.in.ibm.com>
References: <20150131041342.17103.30020.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Sat, 2015-01-31 at 09:44 +0530, Preeti U Murthy wrote:
> These duties include do_timer to update jiffies and broadcast wakeups on those
> platforms which do not have an external device to handle wakeup of cpus from deep
> idle states. The handover of these duties is not robust against a cpu offline
> operation today.
> 
> The do_timer duty is handed over in the CPU_DYING phase today to one of the online
> cpus. This relies on the fact that *all* cpus participate in stop_machine phase.
> But if this design is to change in the future, i.e. if all cpus are not
> required to participate in stop_machine, the freshly nominated do_timer cpu
> could be idle at the time of handover. In that case, unless its interrupted,
> it will not wakeup to update jiffies and timekeeping will hang.
> 
> With regard to broadcast wakeups, today if the cpu handling broadcast of wakeups
> goes offline, the job of broadcasting is handed over to another cpu in the CPU_DEAD
> phase. The CPU_DEAD notifiers are run only after the offline cpu sets its state as
> CPU_DEAD. Meanwhile, the kthread doing the offline is scheduled out while waiting for
> this transition by queuing a timer. This is fatal because if the cpu on which
> this kthread was running has no other work queued on it, it can re-enter deep
> idle state, since it sees that a broadcast cpu still exists. However the broadcast
> wakeup will never come since the cpu which was handling it is offline, and the cpu
> on which the kthread doing the hotplug operation was running never wakes up to see
> this because its in deep idle state.
> 
> Fix these issues by handing over the do_timer and broadcast wakeup duties just before
> the offline cpu kills itself, to the cpu performing the hotplug operation. Since the
> cpu performing the hotplug operation is up and running, it becomes aware of the handover
> of do_timer duty and queues the broadcast timer upon itself so as to seamlessly
> continue both these operations.
> 
> It fixes the bug reported here:
> http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes from V3: https://lkml.org/lkml/2015/1/20/236
> 1. Move handover of broadcast duty away from CPU_DYING phase to just before
> the cpu kills itself.
> 2. Club the handover of timekeeping duty along with broadcast duty to make
> timekeeping robust against hotplug.

Hi Preeti,

This bug is still causing breakage for people on Power8 machines.

Are we just waiting for Thomas to take the patch?

cheers
