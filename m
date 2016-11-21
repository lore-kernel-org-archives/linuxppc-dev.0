Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdW21H1mzDvWk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68XhU057638
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:19 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26usb2c8hf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:19 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF867357805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:12 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6ACfr53149922
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:12 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6ABu0030119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:12 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] IMA Instrumentation Support
Date: Mon, 21 Nov 2016 11:39:59 +0530
Message-Id: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power 9 has In-Memory-Accumulation (IMA) infrastructure which contains
various Performance Monitoring Units (PMUs) at Nest level (these are
on-chip but off-core). These Nest PMU counters are handled by a Nest
IMA microcode. This microcode runs in the OCC (On-Chip Controller)
complex and its purpose is to program the nest counters, collect the
counter data and move the counter data to memory. 

The IMA infrastructure encapsulates nest (per-chip), core and thread
level counters. While the nest IMA PMUs are handled by the nest IMA
microcode, the core and thread level PMUs are handled by the Core-HPMC
engine. This patchset enables the nest IMA PMUs and is based on the
initial work done by Madhavan Srinivasan.
"Nest Instrumentation Support" : https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-August/132078.html

v1 for this patchset can be found here :
https://lwn.net/Articles/705475/

Nest events:
Per-chip nest instrumentation provides various per-chip metrics
such as memory, powerbus, Xlink and Alink bandwidth.

PMU Events' Information:
OPAL obtains the Nest PMU and event information from the IMA Catalog
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
https://lists.ozlabs.org/pipermail/skiboot/2016-November/005552.html

The kernel discovers the IMA counters information in the device tree
at the "ima-counters" device node which has a compatible field
"ibm,opal-in-memory-counters".

Parsing of the Events' information:
To parse the IMA PMUs and events information, the kernel has to
discover the "ima-counters" node and walk through the pmu and event
nodes.

Here is an excerpt of the dt showing the ima-counters and mcs node:
/dts-v1/;

[...]
        ima-counters {                                                   
                ima-nest-offset = <0x320000>;
                compatible = "ibm,opal-in-memory-counters";
                ima-nest-size = <0x30000>;
                #address-cells = <0x1>;
                #size-cells = <0x1>;
                phandle = <0x10000238>;
                version-id = [00];

		mcs0 {                                                    
                        compatible = "ibm,ima-counters-chip";
                        ranges;
                        #address-cells = <0x1>;
                        #size-cells = <0x1>;
                        phandle = <0x10000279>;
			scale = "1.2207e-4";
			unit = "MiB";

			event@528 {
				event-name = "PM_MCS_UP_128B_DATA_XFER_MC0" ;
                       		desc = "Total Read Bandwidth seen on both MCS of MC0";
                                phandle = <0x1000028c>;
                                reg = <0x118 0x8>;
                        };
[...]

>From the device tree, the kernel parses the PMUs and their events'
information.

After parsing the nest IMA PMUs and their events, the PMUs and their
attributes are registered in the kernel.

Example Usage :
 # perf list

  [...]
  nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0/           [Kernel PMU event]
  nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0_LAST_SAMPLE/ [Kernel PMU event]
  [...]

 # perf stat -e "nest_mcs0/PM_MCS_DOWN_128B_DATA_XFER_MC0/" -a --per-socket

TODOs:
 - Add support for Core IMA.
 - Add support for thread IMA.

Comments/feedback/suggestions are welcome.

Changelog:
 v1 -> v2 :
 - Account for the cases where a PMU can have a common scale and unit
   values for all its supported events (Patch 3/6).
 - Fixed a Build error (for maple_defconfig) by enabling ima_pmu.o
   only for CONFIG_PPC_POWERNV=y (Patch 4/6)
 - Read from the "event-name" property instead of "name" for an event
   node (Patch 3/6).

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>

Hemant Kumar (6):
  powerpc/powernv: Data structure and macros definitions
  powerpc/powernv: Autoload IMA device driver module
  powerpc/powernv: Detect supported IMA units and its events
  powerpc/perf: Add event attribute and group to IMA pmus
  powerpc/perf: Generic ima pmu event functions
  powerpc/perf: IMA pmu cpumask and cpu hotplug support

 arch/powerpc/include/asm/ima-pmu.h             |  75 ++++
 arch/powerpc/include/asm/opal-api.h            |   3 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/perf/Makefile                     |   6 +-
 arch/powerpc/perf/ima-pmu.c                    | 383 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-ima.c      | 480 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |  13 +
 9 files changed, 962 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ima-pmu.h
 create mode 100644 arch/powerpc/perf/ima-pmu.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-ima.c

-- 
2.7.4
