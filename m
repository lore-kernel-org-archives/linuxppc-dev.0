Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDhN5fPpzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:31:32 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55CSxEf039919
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 08:31:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw444r6g1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 08:31:30 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 22:31:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55CVGBR50331718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:31:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55CUirA004718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:30:44 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v9 00/10] IMC Instrumentation Support 
Date: Mon,  5 Jun 2017 18:00:11 +0530
Message-Id: <1496665818-543-1-git-send-email-anju@linux.vnet.ibm.com>
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
https://lists.ozlabs.org/pipermail/skiboot/2017-May/007360.html

The kernel discovers the IMC counters information in the device tree
at the "imc-counters" device node which has a compatible field
"ibm,opal-in-memory-counters".

Parsing of the Events' information:
To parse the IMC PMUs and events information, the kernel has to
discover the "imc-counters" node and walk through the pmu and event
nodes.

Here is an excerpt of the dt showing the imc-counters with
mcs0 (nest), core and thread node:

/dts-v1/;

/ {
        name = "";
        compatible = "ibm,opal-in-memory-counters";
        #address-cells = <0x1>;
        #size-cells = <0x1>;
        version-id = "";

        NEST_MCS: nest-mcs-events {
                #address-cells = <0x1>;
                #size-cells = <0x1>;

                event at 0 {
                        event-name = "RRTO_QFULL_NO_DISP" ;
                        reg = <0x0 0x8>;
                        desc = "RRTO not dispatched in MCS0 due to capacity - pulses once for each time a valid RRTO op is not dispatched due to a command list full condition" ;
                };
                event at 8 {
                        event-name = "WRTO_QFULL_NO_DISP" ;
                        reg = <0x8 0x8>;
                        desc = "WRTO not dispatched in MCS0 due to capacity - pulses once for each time a valid WRTO op is not dispatched due to a command list full condition" ;
                };
		[...]
        mcs0 {
                compatible = "ibm,imc-counters";
                events-prefix = "PM_MCS0_";
                unit = "";
                scale = "";
                reg = <0x118 0x8>;
                events = < &NEST_MCS >;
		type = <0x10>;
        };
       mcs1 {
                compatible = "ibm,imc-counters";
                events-prefix = "PM_MCS1_";
                unit = "";
                scale = "";
                reg = <0x198 0x8>;
                events = < &NEST_MCS >;
		type = <0x10>;
        };
	[...]

	CORE_EVENTS: core-events {
                #address-cells = <0x1>;
                #size-cells = <0x1>;

                event at e0 {
                        event-name = "0THRD_NON_IDLE_PCYC" ;
                        reg = <0xe0 0x8>;
                        desc = "The number of processor cycles when all threads are idle" ;
                };
                event at 120 {
                        event-name = "1THRD_NON_IDLE_PCYC" ;
                        reg = <0x120 0x8>;
                        desc = "The number of processor cycles when exactly one SMT thread is executing non-idle code" ;
                };
		[...]
        core {
                compatible = "ibm,imc-counters";
                events-prefix = "CPM_";
                unit = "";
                scale = "";
                reg = <0x0 0x8>;
                events = < &CORE_EVENTS >;
		type = <0x4>;
        };

        thread {
                compatible = "ibm,imc-counters";
                events-prefix = "CPM_";
                unit = "";
                scale = "";
                reg = <0x0 0x8>;
                events = < &CORE_EVENTS >;
		type = <0x1>;
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


TODO:
1)Add a sysfs interface to disable the Core imc (both for ldbar and pdbar)


Changelog:

v8 -> v9
 - Updated nest, core, thread cpuhotplug functions.
 - PMU node parsing logic is changed as there is change in
   the ima-catalog file. PMU nodes are identified based on the 
   "type" property.
 - Since imc-counters subtree accomodates the memory base
   address and offset for nest counter data, logic to get
   memory address for nest counters data is updated.
 - Memory allocation functions for core and thread are updated.
 - Data structures for imc instrumentation are updated.
 - pmu reserve/release functions for nest,core,thread are
   moved to *_imc_event_init.
 - Updated the comments.
 - Included necessary checks in core_imc_change_cpu_context()

v7 -> v8:
 - opal-call API for nest and core is changed.
   OPAL_NEST_IMC_COUNTERS_CONTROL and
   OPAL_CORE_IMC_COUNTERS_CONTROL  is replaced with
   OPAL_IMC_COUNTERS_INIT, OPAL_IMC_COUNTERS_START and
   OPAL_IMC_COUNTERS_STOP.
 - thread_ima doesn't have CPUMASK_ATTR, hence added a
   fix in patch 09/10, which will swap the IMC_EVENT_ATTR
   slot with IMC_CPUMASK_ATTR.

v6 -> v7:
 - Updated the commit message and code comments.
 - Changed the counter init code to disable the
   nest/core counters by default and enable only 
   when it is used.
 - Updated the pmu-setup code to register the
   PMUs which doesn't have events.
 - replaced imc_event_info_val() to imc_event_prop_update()
 - Updated the imc_pmu_setup() code, by checking for the "value"
   of compatible property instead of merely checking for compatible.
 - removed imc_get_domain().
 - init_imc_pmu() and imc_pmu_setup() are made  __init.
 - update_max_val() is invoked immediately after updating the offset value.
v5 -> v6:
 - merged few patches for the readability and code flow
 - Updated the commit message and code comments.
 - updated cpuhotplug code and added checks for perf migration context
 - Added READ_ONCE() when reading the counter data.
 - replaced of_property_read_u32() with of_get_address() for "reg" property read
 - replaced UNKNOWN_DOMAIN with IMC_DOMAIN_UNKNOWN
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

Anju T Sudhakar (6):
  powerpc/powernv: Autoload IMC device driver module
  powerpc/perf: Add generic IMC pmu group and event functions
  powerpc/perf: IMC pmu cpumask and cpuhotplug support
  powerpc/powernv: Thread IMC events detection
  powerpc/perf: Thread IMC PMU functions
  powerpc/perf: Thread imc cpuhotplug support

Madhavan Srinivasan (4):
  powerpc/powernv: Data structure and macros definitions for IMC
  powerpc/powernv: Detect supported IMC units and its events
  powerpc/powernv: Core IMC events detection
  powerpc/perf: PMU functions for Core IMC and hotplugging

 arch/powerpc/include/asm/imc-pmu.h             |  113 +++
 arch/powerpc/include/asm/opal-api.h            |   22 +-
 arch/powerpc/include/asm/opal.h                |    4 +
 arch/powerpc/perf/Makefile                     |    3 +
 arch/powerpc/perf/imc-pmu.c                    | 1023 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/Kconfig         |   10 +
 arch/powerpc/platforms/powernv/Makefile        |    1 +
 arch/powerpc/platforms/powernv/opal-imc.c      |  567 +++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +
 arch/powerpc/platforms/powernv/opal.c          |   18 +
 include/linux/cpuhotplug.h                     |    3 +
 11 files changed, 1766 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/imc-pmu.h
 create mode 100644 arch/powerpc/perf/imc-pmu.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c

-- 
2.7.4
