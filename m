Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F1B81A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:00:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:00:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B0C182BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:00:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G0R7I65142796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:35 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0260018115
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:02 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v1 0/9]powerpc/powernv: Nest Instrumentation support
Date: Tue,  2 Jun 2015 21:29:29 +0530
Message-Id: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
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

Kernel code then, parses the device-tree for nest pmu supports
and registers nest pmu with the events available. PORE Engine collects
and accumulate nest counter data in per-chip HOMER region, hence
device-tree also exports per-chip HOMER nest accumulation region.
And individual event offset are used as event values.

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

Changelog from RFC:

1) Removed "uncore" code and made each Nest Unit a separate PMU.
2) Removed uncore type abstraction and uncore related functions.
3) Added simple cpumask function since these are per-chip counters
4) Redesigned device-tree parser based on the latest platform enablement code
5) Made changes to commit message

Kindly let me know you comments and feedback.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Madhavan Srinivasan (9):
 powerpc/powernv: Data structure and macros definition
 powerpc/powernv: nest pmu init function with cpumask attr
 powerpc/powernv: Add cpu hotplug support
 powerpc/powernv: Add generic nest pmu ops
 powerpc/powernv: nest pmu feature detection support
 powerpc/powernv: dt parser function for nest pmu and its events
 powerpc/powernv: Event attr creation and PMU registration
 powerpc/powernv: Add OPAL support for Nest PMU
 powerpc/powernv: Makefile changes to include nest pmu

 arch/powerpc/include/asm/opal-api.h            |   3 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/perf/Makefile                     |   2 +-
 arch/powerpc/perf/nest-pmu.c                   | 489 +++++++++++++++++++++++++
 arch/powerpc/perf/nest-pmu.h                   |  55 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 6 files changed, 550 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/perf/nest-pmu.c
 create mode 100644 arch/powerpc/perf/nest-pmu.h

-- 
1.9.1
