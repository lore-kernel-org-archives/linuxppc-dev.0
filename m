Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gySs6DknzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 14:51:57 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w724kPeX145835
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2018 00:51:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkr31pkcv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 00:51:55 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 2 Aug 2018 05:51:53 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/3] New device-tree format and Opal based idle
 save-restore
Date: Thu,  2 Aug 2018 10:21:29 +0530
Message-Id: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
New device tree format adds a compatible flag, so that only kernel
which has the capability to handle the version of stop state will enable
it.

Older kernel will still see stop0 and stop0_lite in older format and we
will depricate it after some time.

1) Idea is to bump up the version string in firmware if we find a bug or
regression in stop states. A fix will be provided in linux which would
now know about the bumped up version of stop states, where as kernel
without fixes would ignore the states.

2) Slowly deprecate cpuidle/cpuhotplug threshold which is hard-coded
into cpuidle-powernv driver. Instead use compatible strings to indicate
if idle state is suitable for cpuidle and hotplug.

New idle state device tree format :
       power-mgt {
            ...
         ibm,enabled-stop-levels = <0xec000000>;
         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
         ibm,idle-states {
                     stop4 {
                         flags = <0x207000>;
                         compatible = "ibm,state-v1",
				      "cpuidle",
				      "opal-supported";
                         psscr-mask = <0x0 0x3003ff>;
                         handle = <0x102>;
                         latency-ns = <0x186a0>;
                         residency-ns = <0x989680>;
                         psscr = <0x0 0x300374>;
                  };
                    ...
                    stop11 {
                     ...
                         compatible = "ibm,state-v1",
				      "cpuoffline",
				      "opal-supported";
                         ...
                  };
             };

Skiboot patch-set for device-tree is posted here :
https://patchwork.ozlabs.org/project/skiboot/list/?series=58934

High-level parsing algorithm :

Say Known version string = "ibm,state-v1"

for each stop state node in device tree:
	if (compatible has known version string)
		kernel takes care of stop-transitions
	else if (compatible has "opal-supported")
		OPAL takes care of stop-transitions
	else
		Skip All deeper states

When a state does not have both version support and opal support,
Its possible to exit from a shallower state. Hence skipping all
deeper states.

How does it work ?
-------------------

Consider a case that stop4 has a bug. We take the following steps to
mitigate the problem.

1) Change compatible string for stop4 in OPAL to "ibm-state-v2" and
remove "opal-supported". ship the new firmware.
The kernel ignores stop4 and all deeper states. But we will still have
shallower states. Prevents from completely disabling stop states.

2) Implement workaround in OPAL and add "opal-supported". Ship new firmware
The kernel uses opal for stop-transtion , which has workaround implemented.
We get stop4 and deeper states working without kernel changes and backports.
(and considerably less time)

3) Implement workaround in kernel and add "ibm-state-v2" as known versions
The kernel will now be able to handle stop4 and deeper states.

Also includes Abhishek's RFC which was posted there :
 https://patchwork.ozlabs.org/patch/947568/

This patch-set is on top of mpe-next



Abhishek Goel (1):
  cpuidle/powernv: Conditionally save-restore sprs using opal

Akshay Adiga (2):
  cpuidle/powernv: Add support for states with ibm,cpuidle-state-v1
  powernv/cpuidle: Pass pointers instead of values to stop loop

 arch/powerpc/include/asm/cpuidle.h            |  12 +
 arch/powerpc/include/asm/opal-api.h           |   4 +-
 arch/powerpc/include/asm/opal.h               |   3 +
 arch/powerpc/include/asm/paca.h               |   5 +-
 arch/powerpc/include/asm/processor.h          |   9 +-
 arch/powerpc/kernel/asm-offsets.c             |   3 +
 arch/powerpc/kernel/idle_book3s.S             |  55 ++++-
 arch/powerpc/platforms/powernv/idle.c         | 214 +++++++++++++++---
 .../powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/xmon/xmon.c                      |  14 +-
 drivers/cpuidle/cpuidle-powernv.c             |  66 +++---
 11 files changed, 304 insertions(+), 83 deletions(-)

-- 
2.18.0.rc2.85.g1fb9df7
