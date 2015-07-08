Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88D6D1A364A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 23:03:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 23:03:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9A6BF2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 23:02:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68D2h9q59899996
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 23:02:51 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68D2KGW011052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 23:02:21 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v4 0/7]powerpc/powernv: Nest Instrumentation support
Date: Wed,  8 Jul 2015 18:31:39 +0530
Message-Id: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset enables Nest Instrumentation support on powerpc.
POWER8 has per-chip Nest Intrumentation which provides various
per-chip metrics like memory, powerbus, Xlink and Alink
bandwidth.

Nest Instrumentation provides an interface (via PORE Engine)
to configure and move the nest counter data to memory. From
kernel side, OPAL Call interface is used to activate/deactivate
PORE Engine for nest data collection.

OPAL at boot, detects the feature, initializes it and pass on
the nest units and other related information such as memory
region, events supported so on, to kernel via device-tree.

Kernel code then, parses the device-tree for nest pmu support
and registers nest pmu with the events available. PORE Engine collects
and accumulate nest counter data in per-chip reserved memory region, hence
device-tree also exports per-chip nest accumulation memory region.
And individual event offset are used as event configuration values.

Here is sample perf usage to explain the interface.

#./perf list
....
  iTLB-load-misses                                   [Hardware cache event]

  Nest_Alink_BW/Alink0/                              [Kernel PMU event]
  Nest_Alink_BW/Alink1/                              [Kernel PMU event]
  Nest_Alink_BW/Alink2/                              [Kernel PMU event]
  Nest_MCS_Read_BW/MCS_00/                           [Kernel PMU event]
  Nest_MCS_Read_BW/MCS_01/                           [Kernel PMU event]
  Nest_MCS_Read_BW/MCS_02/                           [Kernel PMU event]
  Nest_MCS_Read_BW/MCS_03/                           [Kernel PMU event]
  Nest_MCS_Write_BW/MCS_00/                          [Kernel PMU event]
  Nest_MCS_Write_BW/MCS_01/                          [Kernel PMU event]
  Nest_MCS_Write_BW/MCS_02/                          [Kernel PMU event]
  Nest_MCS_Write_BW/MCS_03/                          [Kernel PMU event]
  Nest_PowerBus_BW/External/                         [Kernel PMU event]
  Nest_PowerBus_BW/Internal/                         [Kernel PMU event]
  Nest_Xlink_BW/Xlink0/                              [Kernel PMU event]
  Nest_Xlink_BW/Xlink1/                              [Kernel PMU event]
  Nest_Xlink_BW/Xlink2/                              [Kernel PMU event]

  rNNN                                               [Raw hardware event descriptor]
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
.....

# ./perf stat -e 'Nest_Xlink_BW/Xlink1/' -a -A sleep 1

 Performance counter stats for 'system wide':

CPU0             15,913.18 MiB  Nest_Xlink_BW/Xlink1/
CPU32            11,955.88 MiB  Nest_Xlink_BW/Xlink1/
CPU64            11,042.43 MiB  Nest_Xlink_BW/Xlink1/
CPU96            14,065.27 MiB  Nest_Xlink_BW/Xlink1/

       1.001062038 seconds time elapsed

# ./perf stat -e 'Nest_Alink_BW/Alink0/,Nest_Alink_BW/Alink1/,Nest_Alink_BW/Alink2/' -a -A -I 1000 sleep 5

 Performance counter stats for 'system wide':

CPU0                  0.00 MiB  Nest_Alink_BW/Alink0/                                         (100.00%)
CPU32                 0.00 MiB  Nest_Alink_BW/Alink0/                                         (100.00%)
CPU64                 0.00 MiB  Nest_Alink_BW/Alink0/                                         (100.00%)
CPU96                 0.00 MiB  Nest_Alink_BW/Alink0/                                         (100.00%)
CPU0              1,430.43 MiB  Nest_Alink_BW/Alink1/                                         (100.00%)
CPU32               320.99 MiB  Nest_Alink_BW/Alink1/                                         (100.00%)
CPU64             3,443.83 MiB  Nest_Alink_BW/Alink1/                                         (100.00%)
CPU96             1,904.41 MiB  Nest_Alink_BW/Alink1/                                         (100.00%)
CPU0              2,856.85 MiB  Nest_Alink_BW/Alink2/
CPU32                 7.50 MiB  Nest_Alink_BW/Alink2/
CPU64             4,034.29 MiB  Nest_Alink_BW/Alink2/
CPU96               288.49 MiB  Nest_Alink_BW/Alink2/
.....

OPAL side patches are posted in the skiboot mailing list.

Changelog from v3:

No logic change, just a rebase to latest upstream kernel.

Changelog from v2:

1) Changed variable and macro names to be consistent.
2) Made changes to commit message and code comment messages
3) Moved "format attribute" related code from patch 6 to 5
4) Added check for pmu register function
5) Changed cpu_init and cpu_exit functions to use first online
   cpu of the chip, there by making code lot simplier.

Changelog from v1:

1) No logic changes, re-ordered patches make each patch compile
   without errors
2) Added comments based on the review feedback.
3) removed perf_event_del function and replaced it with perf_event_stop.
4) Moved Nest feature detection code out of parser function.
5) Optimized functions and removed some variables.
6) squashed the makefile changes, instead of the separate patch
7) squashed the cpumask and hotplug patches as single patch
8) Added cpu checks in nest_change_cpu_context and nest_exit_cpu functions
9) Made changes to commit messages.

Changelog from RFC:

1) Removed "uncore" code and made each Nest Unit a separate PMU.
2) Removed uncore type abstraction and uncore related functions.
3) Added simple cpumask function since these are per-chip counters
4) Redesigned device-tree parser based on the latest platform enablement code
5) Made changes to commit message

Thanks to input from Sukadev Bhattiprolu, Preeti Murthy, Daniel Axtens,
Suzuki Poulose and Michael Ellerman

Kindly let me know you comments and feedback.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Madhavan Srinivasan (7):
  powerpc/powernv: Data structure and macros definition
  powerpc/powernv: Add OPAL support for Nest PMU
  powerpc/powernv: Nest PMU detection and device tree parser
  powerpc/powernv: detect supported nest pmus and its events
  powerpc/powernv: add event attribute and group to nest pmu
  powerpc/powernv: generic nest pmu event functions
  powerpc/powernv: nest pmu cpumask and cpu hotplug support

 arch/powerpc/include/asm/opal-api.h            |   3 +-
 arch/powerpc/include/asm/opal.h                |   1 +
 arch/powerpc/perf/Makefile                     |   2 +-
 arch/powerpc/perf/nest-pmu.c                   | 514 +++++++++++++++++++++++++
 arch/powerpc/perf/nest-pmu.h                   |  53 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 6 files changed, 572 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/perf/nest-pmu.c
 create mode 100644 arch/powerpc/perf/nest-pmu.h

--
1.9.1
