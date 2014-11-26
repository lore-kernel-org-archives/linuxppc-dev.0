Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 159B01A0035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 16:15:30 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 22:15:29 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5134CC90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 00:07:29 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ5FPK326542156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:15:25 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ5FOPF014783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 00:15:25 -0500
Message-ID: <547561D7.1050605@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 10:45:03 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 0/4] powernv: cpuidle: Redesign idle states management
References: <1416914279-30384-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1416914279-30384-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I ran hackbench to evaluate this patchset and found good improvements in
the results.

I modified hackbench to take in a 'loops' parameter along with
num_groups which ensures that the test runs long enough to observe and
debug issues. The idea was to find out how latency sensitive workloads
can get affected by modification in cpuidle heuristics since it is easy
to measure the impact on these workloads.

The experiment was conducted on a Power8 system with 1 socket and 6
cores on it.

The first experiment was carried out by pinning hackbench to the first
thread in each core while the rest of the smt threads were idle and
below are the results. This would ensure the core entered deep idle
states more often.

num_grps     %improvement with patchset
3                    3.6
6                   10.6
12                   5.0
24                   5.0

The second experiment was carried out by allowing hackbench to run on
the smt threads of two cores and % improvement with the patchset was in
range of 4-7%.

I ran the experiments on the vanilla kernel. This means the performance
improvements is primarily due to avoiding having to do a timebase sync
by every thread in the core. The power numbers have very little
variation between the runs with and without the patchset.

Thanks

Regards
Preeti U Murthy

On 11/25/2014 04:47 PM, Shreyas B. Prabhu wrote:
> Deep idle states like sleep and winkle are per core idle states. A core
> enters these states only when all the threads enter either the particular
> idle state or a deeper one. There are tasks like fastsleep hardware bug
> workaround and hypervisor core state save which have to be done only by
> the last thread of the core entering deep idle state and similarly tasks
> like timebase resync, hypervisor core register restore that have to be
> done only by the first thread waking up from these states. 
> 
> The current idle state management does not have a way to distinguish the
> first/last thread of the core waking/entering idle states. Tasks like
> timebase resync are done for all the threads. This is not only is suboptimal,
> but can cause functionality issues when subcores are involved.
> 
> Winkle is deeper idle state compared to fastsleep. In this state the power
> supply to the chiplet, i.e core, private L2 and private L3 is turned off.
> This results in a total hypervisor state loss. This patch set adds support
> for winkle and provides a way to track the idle states of the threads of the
> core and use it for idle state management of idle states sleep and winkle.
> 
> 
> Changes in v2:
> --------------
> -Using PNV_THREAD_NAP/SLEEP defines while calling power7_powersave_common
> -Comment changes based on review
> -Rebased on top of 3.18-rc6
> 
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> Paul Mackerras (1):
>   powerpc: powernv: Switch off MMU before entering nap/sleep/rvwinkle
>     mode
> 
> Preeti U. Murthy (1):
>   powerpc/powernv: Enable Offline CPUs to enter deep idle states
> 
> Shreyas B. Prabhu (2):
>   powernv: cpuidle: Redesign idle states management
>   powernv: powerpc: Add winkle support for offline cpus
> 
>  arch/powerpc/include/asm/cpuidle.h             |  14 ++
>  arch/powerpc/include/asm/opal.h                |  13 +
>  arch/powerpc/include/asm/paca.h                |   6 +
>  arch/powerpc/include/asm/ppc-opcode.h          |   2 +
>  arch/powerpc/include/asm/processor.h           |   1 +
>  arch/powerpc/include/asm/reg.h                 |   4 +
>  arch/powerpc/kernel/asm-offsets.c              |   6 +
>  arch/powerpc/kernel/cpu_setup_power.S          |   4 +
>  arch/powerpc/kernel/exceptions-64s.S           |  30 ++-
>  arch/powerpc/kernel/idle_power7.S              | 332 +++++++++++++++++++++----
>  arch/powerpc/platforms/powernv/opal-wrappers.S |  39 +++
>  arch/powerpc/platforms/powernv/powernv.h       |   2 +
>  arch/powerpc/platforms/powernv/setup.c         | 160 ++++++++++++
>  arch/powerpc/platforms/powernv/smp.c           |  10 +-
>  arch/powerpc/platforms/powernv/subcore.c       |  34 +++
>  arch/powerpc/platforms/powernv/subcore.h       |   1 +
>  drivers/cpuidle/cpuidle-powernv.c              |  10 +-
>  17 files changed, 608 insertions(+), 60 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/cpuidle.h
> 
