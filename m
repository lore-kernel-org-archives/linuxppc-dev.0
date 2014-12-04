Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE6781A0B7C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 18:28:59 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 02:28:57 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9035238C8039
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 02:28:49 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB47SnMY27721760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 07:28:49 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB47Sm7o007230
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 02:28:49 -0500
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] powernv: cpuidle: Redesign idle states management
Date: Thu,  4 Dec 2014 12:58:19 +0530
Message-Id: <1417678103-32571-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

TBD:
----
- Remove duplication of branching to kvm code. 

Changes in v3:
-------------
- Added barriers after lock
- Added a paca field to that stores thread mask. 
- Changed code structure around fastsleep workaround, to allow for manual
  patching out if the platform does not require it. 
- Threads waiting on core_idle_state lock now loop in HMT_LOW
- Using NV CRs to avoid save/restore of CR while making OPAL calls.
- Fixed couple of flow issues in path where fastsleep workaround was not needed
- Using PPC_LR_STKOFF instead of _LINK in opal_call_realmode
- Restoring WORT and WORC

Changes in v2:
--------------
-Using PNV_THREAD_NAP/SLEEP defines while calling power7_powersave_common
-Comment changes based on review
-Rebased on top of 3.18-rc6


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
 arch/powerpc/include/asm/reg.h                 |   4 +
 arch/powerpc/kernel/asm-offsets.c              |   6 +
 arch/powerpc/kernel/cpu_setup_power.S          |   4 +
 arch/powerpc/kernel/exceptions-64s.S           |  30 ++-
 arch/powerpc/kernel/idle_power7.S              | 332 +++++++++++++++++++++----
 arch/powerpc/platforms/powernv/opal-wrappers.S |  39 +++
 arch/powerpc/platforms/powernv/powernv.h       |   2 +
 arch/powerpc/platforms/powernv/setup.c         | 160 ++++++++++++
 arch/powerpc/platforms/powernv/smp.c           |  10 +-
 arch/powerpc/platforms/powernv/subcore.c       |  34 +++
 arch/powerpc/platforms/powernv/subcore.h       |   1 +
 drivers/cpuidle/cpuidle-powernv.c              |  10 +-
 17 files changed, 608 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpuidle.h

-- 
1.9.3
