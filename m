Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 551971A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D0FF62CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:16 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD88kt20774922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD7gHH011505
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:07:43 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 0/7] powerpc/powernv: Nest Instrumentation support 
Date: Wed, 11 Mar 2015 18:37:06 +0530
Message-Id: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
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
per-chip utilisation metrics like memory bandwidth, IO bandwidth 
and many other component metrics.

Nest Instrumentation provides an interface (via PORE Engine)
to configure and move the nest counter data to memory. From
kernel side, OPAL Call interface is used to activate/deactivate
PORE Engine for nest data collection.

OPAL at boot, detects the feature, initializes it and pass on
the nest units and other related information such as memory
region, events supported so on, to kernel via device-tree. 

Patchset uses Intel's uncore framework to enable the consumption 
of Nest instrumentation data on powerpc. First three patches are
derived from arch/x86/kernel/cpu/perf_event_intel_uncore.[c/h].
But patches differ since "box" level abstration is not implemented
As a TODO, need to rework the code to reduce code duplication. 

Fourth patch in the series adds the OPAL call interface to kernel.
Fifth patch defines a generic pmu functions to be shared by all
nest pmu units. And sixth patch defines the Device-tree parsing
functions to populate various structures to aid the pmu registration.
Patch also explains the device-tree layout for nest counter units.

Here is sample perf usage to explain the interface and
values represeneted here are bogus, since platform enablement is
under-developement.

# ./perf list
....
  uncore_mcs_0/mcs_read/                             [Kernel PMU event]
  uncore_mcs_0/mcs_write/                            [Kernel PMU event]
  uncore_mcs_1/mcs_read/                             [Kernel PMU event]
  uncore_mcs_1/mcs_write/                            [Kernel PMU event]
  uncore_mcs_2/mcs_read/                             [Kernel PMU event]
  uncore_mcs_2/mcs_write/                            [Kernel PMU event]
  uncore_mcs_3/mcs_read/                             [Kernel PMU event]
  uncore_mcs_3/mcs_write/                            [Kernel PMU event]
...

[root@ltctul57a-p1 perf]# ./perf stat -e 'uncore_mcs_0/mcs_read/' -e 'uncore_mcs_0/mcs_write/' -a sleep 1

 Performance counter stats for 'system wide':

              64.00 MiB/s	 uncore_mcs_0/mcs_read/                                       [100.00%]
              64.00 MiB/s	 uncore_mcs_0/mcs_write/                                     

       1.000723515 seconds time elapsed

Kindly let me know you comments and feedback.

Madhavan Srinivasan (7):
  powerpc/powernv: Data structure and macros definition 
  powerpc/powernv: uncore foundation code
  powerpc/powernv: uncore cpumask and CPU hotplug
  powerpc/powernv: Add OPAL support for uncore pmu
  powerpc/powernv: Add POWER8 uncore pmu support
  powerpc/powernv: add support to parse dt for uncore pmu
  powerpc/powernv: enable uncore related file in Makefile

 arch/powerpc/include/asm/opal.h                |   3 +
 arch/powerpc/perf/Makefile                     |   2 +-
 arch/powerpc/perf/uncore_pmu.c                 | 260 ++++++++++++++++
 arch/powerpc/perf/uncore_pmu.h                 |  89 ++++++
 arch/powerpc/perf/uncore_pmu_p8.c              | 403 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 6 files changed, 757 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/uncore_pmu.c
 create mode 100644 arch/powerpc/perf/uncore_pmu.h
 create mode 100644 arch/powerpc/perf/uncore_pmu_p8.c

-- 
1.9.1
