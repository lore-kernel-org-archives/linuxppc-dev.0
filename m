Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkKz72tj0zDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:19 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SZ7n012302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:17 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297nt71t54-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:16 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:36:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7a1i936962430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7ZZqK008989
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:35:36 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v5 00/13] IMC Instrumentation Support
Date: Thu, 16 Mar 2017 13:04:54 +0530
Message-Id: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power9 has In-Memory-Collection (IMC) infrastructure which contains
various Performance Monitoring Units (PMUs) at Nest level (these are
on-chip but off-core), Core level and Thread level.

The Nest PMU counters are handled by a Nest IMC microcode which runs
in the OCC (On-Chip Controller) complex. The microcode collects the
counter data and moves the nest IMC counter data to memory.

The Core and Thread IMC PMU counters are handled in the core. Core
level PMU counters give us the IMC counters' data per core and thread
level PMU counters give us the IMC counters' data per CPU thread.

This patchset enables the nest IMC, core IMC and thread IMC
PMUs and is based on the initial work done by Madhavan Srinivasan.
"Nest Instrumentation Support" :
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-August/132078.html

v1 for this patchset can be found here :
https://lwn.net/Articles/705475/

Nest events:
Per-chip nest instrumentation provides various per-chip metrics
such as memory, powerbus, Xlink and Alink bandwidth.

Core events:
Per-core IMC instrumentation provides various per-core metrics
such as non-idle cycles, non-idle instructions, various cache and
memory related metrics etc.

Thread events:
All the events for thread level are same as core level with the
difference being in the domain. These are per-cpu metrics.

PMU Events' Information:
OPAL obtains the IMC PMU and event information from the IMC Catalog
and passes on to the kernel via the device tree. The events' information
contains :
 - Event name
 - Event Offset
 - Event description
and, maybe :
 - Event scale
 - Event unit

Some PMUs may have a common scale and unit values for all their
supported events. For those cases, the scale and unit properties for
those events must be inherited from the PMU.

The event offset in the memory is where the counter data gets
accumulated.

The OPAL-side patches are posted upstream :
https://lists.ozlabs.org/pipermail/skiboot/2017-March/006531.html

The kernel discovers the IMC counters information in the device tree
at the "imc-counters" device node which has a compatible field
"ibm,opal-in-memory-counters".

Parsing of the Events' information:
To parse the IMC PMUs and events information, the kernel has to
discover the "imc-counters" node and walk through the pmu and event
nodes.

Here is an excerpt of the dt showing the imc-counters with
mcs0 (nest), core and thread node:

https://github.com/open-power/ima-catalog/blob/master/81E00612.4E0100.dts

/dts-v1/;

[...]

/dts-v1/;

/ {
        name = "";
        compatible = "ibm,opal-in-memory-counters";
        #address-cells = <0x1>;
        #size-cells = <0x1>;
        imc-nest-offset = <0x320000>;
        imc-nest-size = <0x30000>;
        version-id = "";

        NEST_MCS: nest-mcs-events {
                #address-cells = <0x1>;
                #size-cells = <0x1>;

                event@0 {
                        event-name = "RRTO_QFULL_NO_DISP" ;
                        reg = <0x0 0x8>;
                        desc = "RRTO not dispatched in MCS0 due to capacity - pulses once for each time a valid RRTO op is not dispatched due to a command list full condition" ;
                };
                event@8 {
                        event-name = "WRTO_QFULL_NO_DISP" ;
                        reg = <0x8 0x8>;
                        desc = "WRTO not dispatched in MCS0 due to capacity - pulses once for each time a valid WRTO op is not dispatched due to a command list full condition" ;
                };
		[...]
	mcs0 {
                compatible = "ibm,imc-counters-nest";
                events-prefix = "PM_MCS0_";
                unit = "";
                scale = "";
                reg = <0x118 0x8>;
                events = < &NEST_MCS >;
        };

        mcs1 {
                compatible = "ibm,imc-counters-nest";
                events-prefix = "PM_MCS1_";
                unit = "";
                scale = "";
                reg = <0x198 0x8>;
                events = < &NEST_MCS >;
        };
	[...]

	CORE_EVENTS: core-events {
                #address-cells = <0x1>;
                #size-cells = <0x1>;

                event@e0 {
                        event-name = "0THRD_NON_IDLE_PCYC" ;
                        reg = <0xe0 0x8>;
                        desc = "The number of processor cycles when all threads are idle" ;
                };
                event@120 {
                        event-name = "1THRD_NON_IDLE_PCYC" ;
                        reg = <0x120 0x8>;
                        desc = "The number of processor cycles when exactly one SMT thread is executing non-idle code" ;
                };
		[...]
       core {
                compatible = "ibm,imc-counters-core";
                events-prefix = "CPM_";
                unit = "";
                scale = "";
                reg = <0x0 0x8>;
                events = < &CORE_EVENTS >;
        };

        thread {
                compatible = "ibm,imc-counters-core";
                events-prefix = "CPM_";
                unit = "";
                scale = "";
                reg = <0x0 0x8>;
                events = < &CORE_EVENTS >;
        };
};

>From the device tree, the kernel parses the PMUs and their events'
information.

After parsing the IMC PMUs and their events, the PMUs and their
attributes are registered in the kernel.

This patchset (patches 9 and 10) configure the thread level IMC PMUs
to count for tasks, which give us the thread level metric values per
task.

Example Usage :
 # perf list

  [...]
  nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0/           [Kernel PMU event]
  nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0_LAST_SAMPLE/ [Kernel PMU event]
  [...]
  core_imc/CPM_NON_IDLE_INST/                        [Kernel PMU event]
  core_imc/CPM_NON_IDLE_PCYC/                        [Kernel PMU event]
  [...]
  thread_imc/CPM_NON_IDLE_INST/                      [Kernel PMU event]
  thread_imc/CPM_NON_IDLE_PCYC/                      [Kernel PMU event]

To see per chip data for nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0/ :
 # perf stat -e "nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0/" -a --per-socket

To see non-idle instructions for core 0 :
 # ./perf stat -e "core_imc/CPM_NON_IDLE_INST/" -C 0 -I 1000

To see non-idle instructions for a "make" :
 # ./perf stat -e "thread_imc/CPM_NON_IDLE_PCYC/" make

Comments/feedback/suggestions are welcome.

Changelog:
 v4 -> v5:
 - Updated opal call numbers
 - Added a patch to disable Core-IMC device using shutdown callback
 - Added patch to support cpuhotplug for thread-imc
 - Added patch to disable and enable core imc engine in cpuhot plug path
 v3 -> v4 :
 - Changed the events parser code to discover the PMU and events because
   of the changed format of the IMC DTS file (Patch 3).
 - Implemented the two TODOs to include core and thread IMC support with
   this patchset (Patches 7 through 10).
 - Changed the CPU hotplug code of Nest IMC PMUs to include a new state
   CPUHP_AP_PERF_POWERPC_NEST_ONLINE (Patch 6).
 v2 -> v3 :
 - Changed all references for IMA (In-Memory Accumulation) to IMC (In-Memory
   Collection).
 v1 -> v2 :
 - Account for the cases where a PMU can have a common scale and unit
   values for all its supported events (Patch 3/6).
 - Fixed a Build error (for maple_defconfig) by enabling imc_pmu.o
   only for CONFIG_PPC_POWERNV=y (Patch 4/6)
 - Read from the "event-name" property instead of "name" for an event
   node (Patch 3/6).

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Anju T Sudhakar (2):
  powerpc/perf: Thread imc cpuhotplug support
  powerpc/perf: Enable/disable core engine during cpuhotplug

Hemant Kumar (10):
  powerpc/powernv: Data structure and macros definitions
  powerpc/powernv: Autoload IMC device driver module
  powerpc/powernv: Detect supported IMC units and its events
  powerpc/perf: Add event attribute and group to IMC pmus
  powerpc/perf: Generic imc pmu event functions
  powerpc/perf: IMC pmu cpumask and cpu hotplug support
  powerpc/powernv: Core IMC events detection
  powerpc/perf: PMU functions for Core IMC and hotplugging
  powerpc/powernv: Thread IMC events detection
  powerpc/perf: Thread IMC PMU functions

Madhavan Srinivasan (1):
  powerpc/powernv: Add device shutdown function for Core IMC

 arch/powerpc/include/asm/imc-pmu.h             |  85 +++
 arch/powerpc/include/asm/opal-api.h            |  11 +-
 arch/powerpc/include/asm/opal.h                |   5 +
 arch/powerpc/perf/Makefile                     |   6 +-
 arch/powerpc/perf/imc-pmu.c                    | 811 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c      | 560 +++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/opal.c          |  13 +
 include/linux/cpuhotplug.h                     |   3 +
 10 files changed, 1495 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/imc-pmu.h
 create mode 100644 arch/powerpc/perf/imc-pmu.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

-- 
2.7.4
