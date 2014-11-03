Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B5A11A0183
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 03:08:53 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 09:08:50 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DED7D1FF0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 08:57:30 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA3G8k4K54984712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 17:08:46 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA3G8inc026113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 09:08:44 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] powernv: cpuidle: Redesign idle states management
Date: Mon,  3 Nov 2014 21:38:26 +0530
Message-Id: <1415030910-5799-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Deep idle states like sleep and winkle are per core idle states. A core
enters these states only when all the threads enter either the particular
idle state or a deeper one. There are tasks like fastsleep hardware bug
workaround and hypervisor core state save which have to be done only by
the last thread of the core entering deep idle state and similarly tasks
like timebase resync, hypervisor core register restore that have to be
done only by the first thread waking up from these states. 

The current idle state management does not have a way to distinguish the
first/last thread of the core waking/entering idle states. Tasks like
timebase resync are done for all the threads. This is not only is suboptimal,
but can cause functionality issues when subcores are involved.

Winkle is deeper idle state compared to fastsleep. In this state the power
supply to the chiplet, i.e core, private L2 and private L3 is turned off.
This results in a total hypervisor state loss. This patch set adds support
for winkle and provides a way to track the idle states of the threads of the
core and use it for idle state management of idle states sleep and winkle.

TODO:
-----
Handle the case where a thread enters nap and wakes up with supervisor/
hypervisor state loss. This can only happen due to a bug in the
hardware or the kernel. One way to handle this can be restore the state,
switch to the kernel process context and trigger a panic or a warning.


Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Paul Mackerras (1):
  powerpc: powernv: Switch off MMU before entering nap/sleep/rvwinkle
    mode

Preeti U. Murthy (1):
  powerpc/powernv: Enable Offline CPUs to enter deep idle states

Shreyas B. Prabhu (2):
  powernv: cpuidle: Redesign idle states management
  powernv: powerpc: Add winkle support for offline cpus

 arch/powerpc/include/asm/cpuidle.h             |  14 ++
 arch/powerpc/include/asm/opal.h                |  13 +
 arch/powerpc/include/asm/paca.h                |   6 +
 arch/powerpc/include/asm/ppc-opcode.h          |   2 +
 arch/powerpc/include/asm/processor.h           |   1 +
 arch/powerpc/include/asm/reg.h                 |   2 +
 arch/powerpc/kernel/asm-offsets.c              |   6 +
 arch/powerpc/kernel/cpu_setup_power.S          |   4 +
 arch/powerpc/kernel/exceptions-64s.S           |  30 ++-
 arch/powerpc/kernel/idle_power7.S              | 326 +++++++++++++++++++++----
 arch/powerpc/platforms/powernv/opal-wrappers.S |  39 +++
 arch/powerpc/platforms/powernv/powernv.h       |   2 +
 arch/powerpc/platforms/powernv/setup.c         | 170 +++++++++++++
 arch/powerpc/platforms/powernv/smp.c           |  10 +-
 arch/powerpc/platforms/powernv/subcore.c       |  35 +++
 arch/powerpc/platforms/powernv/subcore.h       |   1 +
 drivers/cpuidle/cpuidle-powernv.c              |  10 +-
 17 files changed, 611 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpuidle.h

-- 
1.9.3
