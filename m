Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42F4DB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 09:30:59 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB1M7gxK030351
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 17:08:37 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4EEFF728049
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 17:30:54 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB1MUseC094680
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 17:30:54 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB1MUrRZ005660
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 20:30:53 -0200
Date: Wed, 1 Dec 2010 20:30:52 -0200
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101201223052.15119.61473.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH V3 0/3][RFC] Add Support for Virtual Processor Home Node (VPHN)
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

The SPLPAR option allows the platform to dispatch virtual processors on
physical processors that, due to the variable nature of work loads, are
temporarily free, thus improving the utilization of computing resources.
However, SPLPAR implies inconsistent mapping of virtual to physical
processors, thus defeating resource allocation software that attempts to
optimize performance on platforms that implement the NUMA option.

To bridge the gap between these two options, the VPHN option maintains a
substantially consistent mapping of a given virtual processor to a physical
processor or set of processors within a given associativity domain. When
allocating computing resources, the kernel can take advantage of this
statistically consistent mapping to improve processing performance.

VPHN mappings are substantially consistent but not static. For any given
dispatch cycle, a best effort is made by the hypervisor to dispatch the
virtual processor on a physical processor within a targeted associativity
domain (the virtual processor's home node). However, if processing capacity
within the home node is not available, some other physical processor is
assigned to meet the processing capacity entitlement. From time to time,
to optimize the total platform performance, it may be necessary for the
platform to change the home node of a given virtual processor.

The Virtual Processor Home Node feature addresses this by adding the
H_HOME_NODE_ASSOCIATIVITY hcall to retrieve the current associativity
domain information directly from the hypervisor for a given virtual
processor's home node. It also exposes a set of associativity change
counters in the Virtual Processor Area (VPA) of each processor to indicate
when associativity changes occur.

This patch set sets a timer during boot that will periodically poll the
associativity change counters. When a change in associativity is detected,
it retrieves the new associativity domain information via the
H_HOME_NODE_ASSOCIATIVITY hcall and updates the NUMA node maps and sysfs
entries accordingly. The polling mechanism is also tied into the
ibm,suspend-me rtas call to stop/restart polling before/after a suspend,
hibernate, migrate, or checkpoint restart operation.

This patch set applies to v2.6.37-rc4 and includes the following:

[PATCH 1/3] powerpc: Add VPHN firmware feature
[PATCH 2/3] powerpc: Poll VPA for topology changes and update NUMA maps
[PATCH 3/3] powerpc: Disable VPHN polling during a suspend operation

Changes since V2:

* Rebased on 2.6.37-rc4.
* Rearranged work declarations and timer initializations to eliminate
  unnecessary function declarations.
* Eliminated redundant cpumask operations in 
  update_cpu_associativity_changes_mask().
* Eliminated unnecessary return statments from functions with void
  return types.
* Coding-style cleanups.
* Replaced del_timer() with del_timer_sync() in stop_topology_update(),
  and added the "vphn_enabled" flag to prevent the timer function from
  reinstalling itself.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    3 +-
 arch/powerpc/include/asm/hvcall.h         |    3 +-
 arch/powerpc/include/asm/lppaca.h         |    5 +-
 arch/powerpc/include/asm/topology.h       |   10 +
 arch/powerpc/kernel/rtas.c                |    3 +
 arch/powerpc/mm/numa.c                    |  274 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 7 files changed, 286 insertions(+), 13 deletions(-)
